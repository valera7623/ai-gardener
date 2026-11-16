import 'dart:math' as math;
import 'dart:typed_data';

import 'package:image/image.dart' as img;

import '../../../core/errors/app_exception.dart';
import 'http_recognition_api.dart';

class PreparedRecognitionImage {
  const PreparedRecognitionImage({required this.bytes, this.mimeType});

  final Uint8List bytes;

  /// Null means the original file format is still valid for the request.
  final String? mimeType;
}

const recognitionImageMaxSide = 1600;

PreparedRecognitionImage prepareRecognitionImage(
  Uint8List bytes, {
  int maxSide = recognitionImageMaxSide,
  int maxBytes = HttpRecognitionApi.maxImageBytes,
}) {
  if (bytes.isEmpty) {
    throw const AppException('Фото пустое. Снимите его ещё раз.');
  }

  img.Image? decoded;
  try {
    decoded = img.decodeImage(bytes);
  } catch (_) {
    decoded = null;
  }
  if (decoded == null) {
    if (bytes.length <= maxBytes) {
      return PreparedRecognitionImage(bytes: bytes);
    }
    throw const AppException(
      'Не удалось уменьшить фото. Выберите другой снимок.',
    );
  }

  final longest = math.max(decoded.width, decoded.height);
  if (longest <= maxSide && bytes.length <= maxBytes && _isJpeg(bytes)) {
    return PreparedRecognitionImage(bytes: bytes, mimeType: 'image/jpeg');
  }

  var image = longest <= maxSide
      ? _upright(decoded)
      : img.copyResize(
          decoded,
          width: decoded.width >= decoded.height
              ? maxSide
              : math.max(1, (decoded.width * maxSide / decoded.height).round()),
          interpolation: img.Interpolation.linear,
        );

  var quality = 80;
  var encoded = _jpeg(image, quality);
  while (encoded.length > maxBytes && quality > 45) {
    quality -= 15;
    encoded = _jpeg(image, quality);
  }
  var guard = 0;
  while (encoded.length > maxBytes && image.width > 480 && guard < 3) {
    image = img.copyResize(
      image,
      width: math.max(480, image.width ~/ 2),
      interpolation: img.Interpolation.linear,
    );
    encoded = _jpeg(image, 60);
    guard++;
  }
  if (encoded.length > maxBytes) {
    throw const AppException(
      'Не удалось уменьшить фото. Выберите другой снимок.',
    );
  }
  return PreparedRecognitionImage(bytes: encoded, mimeType: 'image/jpeg');
}

img.Image _upright(img.Image image) {
  if (!image.exif.imageIfd.hasOrientation ||
      image.exif.imageIfd.orientation == 1) {
    return image;
  }
  return img.bakeOrientation(image);
}

Uint8List _jpeg(img.Image image, int quality) {
  return img.encodeJpg(image, quality: quality, chroma: img.JpegChroma.yuv420);
}

bool _isJpeg(Uint8List bytes) {
  return bytes.length > 2 &&
      bytes[0] == 0xFF &&
      bytes[1] == 0xD8 &&
      bytes[2] == 0xFF;
}
