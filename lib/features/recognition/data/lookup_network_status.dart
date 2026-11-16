import 'dart:async';
import 'dart:io';

class LookupNetworkStatus {
  const LookupNetworkStatus();

  /// Короткий DNS-запрос. Таймаут считаем отсутствием сети, а не ошибкой распознавания.
  Future<bool> isOnline() async {
    try {
      final addresses = await InternetAddress.lookup('ya.ru')
          .timeout(const Duration(seconds: 2));
      return addresses.isNotEmpty && addresses.first.rawAddress.isNotEmpty;
    } on TimeoutException {
      return false;
    } on SocketException {
      return false;
    }
  }
}
