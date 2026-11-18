import 'dart:math' as math;

/// Русские названия классов PlantVillage. Ключ совпадает со строкой labels.txt.
const plantDiseaseTitles = <String, String>{
  'Apple___Apple_scab': 'Парша яблони',
  'Apple___Black_rot': 'Чёрная гниль яблони',
  'Apple___Cedar_apple_rust': 'Ржавчина яблони',
  'Apple___healthy': 'Яблоня без видимой болезни',
  'Blueberry___healthy': 'Голубика без видимой болезни',
  'Cherry_(including_sour)___Powdery_mildew': 'Мучнистая роса вишни',
  'Cherry_(including_sour)___healthy': 'Вишня без видимой болезни',
  'Corn_(maize)___Cercospora_leaf_spot Gray_leaf_spot':
      'Серая пятнистость кукурузы',
  'Corn_(maize)___Common_rust_': 'Ржавчина кукурузы',
  'Corn_(maize)___Northern_Leaf_Blight': 'Северный гельминтоспориоз кукурузы',
  'Corn_(maize)___healthy': 'Кукуруза без видимой болезни',
  'Grape___Black_rot': 'Чёрная гниль винограда',
  'Grape___Esca_(Black_Measles)': 'Эска винограда',
  'Grape___Leaf_blight_(Isariopsis_Leaf_Spot)': 'Пятнистость листьев винограда',
  'Grape___healthy': 'Виноград без видимой болезни',
  'Orange___Haunglongbing_(Citrus_greening)': 'Позеленение цитрусовых',
  'Peach___Bacterial_spot': 'Бактериальная пятнистость персика',
  'Peach___healthy': 'Персик без видимой болезни',
  'Pepper,_bell___Bacterial_spot': 'Бактериальная пятнистость перца',
  'Pepper,_bell___healthy': 'Перец без видимой болезни',
  'Potato___Early_blight': 'Ранняя пятнистость картофеля',
  'Potato___Late_blight': 'Фитофтороз картофеля',
  'Potato___healthy': 'Картофель без видимой болезни',
  'Raspberry___healthy': 'Малина без видимой болезни',
  'Soybean___healthy': 'Соя без видимой болезни',
  'Squash___Powdery_mildew': 'Мучнистая роса тыквы',
  'Strawberry___Leaf_scorch': 'Ожог листьев клубники',
  'Strawberry___healthy': 'Клубника без видимой болезни',
  'Tomato___Bacterial_spot': 'Бактериальная пятнистость томата',
  'Tomato___Early_blight': 'Ранняя пятнистость томата',
  'Tomato___Late_blight': 'Фитофтороз томата',
  'Tomato___Leaf_Mold': 'Кладоспориоз (бурая пятнистость) томата',
  'Tomato___Septoria_leaf_spot': 'Септориоз томата',
  'Tomato___Spider_mites Two-spotted_spider_mite': 'Паутинный клещ на томате',
  'Tomato___Target_Spot': 'Альтернариоз томата',
  'Tomato___Tomato_Yellow_Leaf_Curl_Virus': 'Жёлтая курчавость листьев томата',
  'Tomato___Tomato_mosaic_virus': 'Мозаика томата',
  'Tomato___healthy': 'Томат без видимой болезни',
};

/// Идентификатор из справочника, если такая культура там есть.
const plantDiseaseCatalogIds = <String, String>{
  'Apple___Apple_scab': 'apple',
  'Apple___Black_rot': 'apple',
  'Apple___Cedar_apple_rust': 'apple',
  'Apple___healthy': 'apple',
  'Potato___Early_blight': 'potato',
  'Potato___Late_blight': 'potato',
  'Potato___healthy': 'potato',
  'Strawberry___Leaf_scorch': 'strawberry',
  'Strawberry___healthy': 'strawberry',
  'Tomato___Bacterial_spot': 'tomato',
  'Tomato___Early_blight': 'tomato',
  'Tomato___Late_blight': 'tomato',
  'Tomato___Leaf_Mold': 'tomato',
  'Tomato___Septoria_leaf_spot': 'tomato',
  'Tomato___Spider_mites Two-spotted_spider_mite': 'tomato',
  'Tomato___Target_Spot': 'tomato',
  'Tomato___Tomato_Yellow_Leaf_Curl_Virus': 'tomato',
  'Tomato___Tomato_mosaic_virus': 'tomato',
  'Tomato___healthy': 'tomato',
};

/// EfficientNetV2 ждёт пиксель в диапазоне примерно от -1 до 1.
double efficientNetV2Input(num channel) => channel / 127.5 - 1;

/// Если модель уже вернула вероятности, оставляем их. Иначе считаем softmax.
List<double> asProbabilities(List<double> scores) {
  if (scores.isEmpty) {
    return const [];
  }
  final sum = scores.fold<double>(0, (total, score) => total + score);
  final alreadyProbabilities =
      scores.every((score) => score >= 0 && score <= 1) &&
      (sum - 1).abs() < 0.05;
  if (alreadyProbabilities) {
    return scores;
  }
  var peak = scores.first;
  for (final score in scores.skip(1)) {
    if (score > peak) {
      peak = score;
    }
  }
  final shifted = [for (final score in scores) score - peak];
  final exponents = [for (final score in shifted) math.exp(score)];
  final total = exponents.fold<double>(0, (sum, value) => sum + value);
  if (total == 0) {
    return List<double>.filled(scores.length, 0);
  }
  return [for (final value in exponents) value / total];
}
