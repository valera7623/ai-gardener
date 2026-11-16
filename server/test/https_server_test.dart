import 'dart:convert';
import 'dart:io';

import 'package:ai_gardener_server/recognize_server.dart';
import 'package:ai_gardener_server/recognize_service.dart';
import 'package:ai_gardener_server/server_config.dart';
import 'package:test/test.dart';

void main() {
  test('https accepts one photo with the local certificate', () async {
    final directory = await Directory.systemTemp.createTemp('ai_gardener_tls');
    addTearDown(() => directory.delete(recursive: true));
    final paths = await _issueCertificate(directory);

    final server = await startRecognizeServer(
      config: ServerConfig(
        yandexApiKey: 'yandex-secret',
        clientApiKey: 'client-secret',
        tlsCertificatePath: paths.certificate,
        tlsPrivateKeyPath: paths.privateKey,
      ),
      port: 0,
      callYandex: (call) async {
        expect(call.uri.scheme, 'https');
        return YandexReply(
          200,
          jsonEncode({
            'choices': [
              {
                'message': {
                  'content': '{"title":"Подсолнух","summary":"Лист на фото целый.","confidence":0.7,"plantId":null,"recommendations":[{"title":"Свет","description":"Оставьте растение на ярком свету.","topic":"light"}]}',
                },
              },
            ],
          }),
        );
      },
    );
    addTearDown(server.close);

    final client = HttpClient(
      context: SecurityContext(withTrustedRoots: false)
        ..setTrustedCertificates(paths.ca),
    );
    addTearDown(client.close);
    final request = await client.postUrl(
      Uri.parse('https://127.0.0.1:${server.port}/v1/recognize'),
    );
    request.headers.set(
      HttpHeaders.authorizationHeader,
      'Bearer client-secret',
    );
    request.headers.contentType = ContentType.json;
    request.add(
      utf8.encode(
        jsonEncode({
          'imageBase64': base64Encode([7, 8, 9]),
          'mimeType': 'image/jpeg',
        }),
      ),
    );
    final response = await request.close();
    final payload = jsonDecode(
      await response.transform(utf8.decoder).join(),
    ) as Map<String, dynamic>;

    expect(response.statusCode, 200);
    expect(payload['title'], 'Подсолнух');
  });
}

class _CertPaths {
  const _CertPaths(this.ca, this.certificate, this.privateKey);

  final String ca;
  final String certificate;
  final String privateKey;
}

Future<_CertPaths> _issueCertificate(Directory directory) async {
  final caKey = '${directory.path}/ca.key';
  final ca = '${directory.path}/ca.crt';
  final config = '${directory.path}/ca.cnf';
  final key = '${directory.path}/server.key';
  final csr = '${directory.path}/server.csr';
  final certificate = '${directory.path}/server.crt';
  await File(config).writeAsString('''
[req]
distinguished_name=dn
x509_extensions=v3_ca
prompt=no
[dn]
CN=AI Gardener Dev CA
[v3_ca]
basicConstraints=critical,CA:TRUE
keyUsage=critical,keyCertSign,cRLSign
''');
  await File('${directory.path}/san.cnf').writeAsString(
    'subjectAltName=DNS:localhost,IP:127.0.0.1\n'
    'basicConstraints=CA:FALSE\n'
    'keyUsage=digitalSignature,keyEncipherment\n'
    'extendedKeyUsage=serverAuth\n',
  );

  Future<void> run(List<String> args) async {
    final result = await Process.run('openssl', args);
    if (result.exitCode != 0) {
      throw Exception(result.stderr);
    }
  }

  await run([
    'req',
    '-x509',
    '-newkey',
    'rsa:2048',
    '-nodes',
    '-keyout',
    caKey,
    '-out',
    ca,
    '-days',
    '30',
    '-subj',
    '/CN=AI Gardener Dev CA',
    '-config',
    config,
  ]);
  await run([
    'req',
    '-newkey',
    'rsa:2048',
    '-nodes',
    '-keyout',
    key,
    '-out',
    csr,
    '-subj',
    '/CN=127.0.0.1',
  ]);
  await run([
    'x509',
    '-req',
    '-in',
    csr,
    '-CA',
    ca,
    '-CAkey',
    caKey,
    '-CAcreateserial',
    '-out',
    certificate,
    '-days',
    '30',
    '-extfile',
    '${directory.path}/san.cnf',
  ]);
  return _CertPaths(ca, certificate, key);
}
