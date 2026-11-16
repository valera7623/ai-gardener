import '../../../../shared/models/care_recommendation.dart';
import '../../../../shared/models/plant.dart';

class PlantCatalogLocalDataSource {
  const PlantCatalogLocalDataSource();

  List<Plant> getAll() => _plants;

  Plant? findById(String id) {
    for (final plant in _plants) {
      if (plant.id == id) {
        return plant;
      }
    }
    return null;
  }
}

const _plants = <Plant>[
  Plant(
    id: 'ficus',
    name: 'Фикус Бенджамина',
    latinName: 'Ficus benjamina',
    category: PlantCategory.indoor,
    summary: 'Небольшое комнатное дерево с глянцевыми листьями. Хорошо живёт в гостиной, если его не переставлять с места на место.',
    care: [
      CareRecommendation(
        title: 'Свет',
        description: 'Яркий рассеянный свет. Прямое полуденное солнце оставляет на листьях ожоги.',
        topic: CareTopic.light,
      ),
      CareRecommendation(
        title: 'Полив',
        description: 'Поливайте, когда верхние 2–3 см почвы подсохли. Зимой воды нужно меньше.',
        topic: CareTopic.watering,
      ),
      CareRecommendation(
        title: 'Температура',
        description: 'Комфортно при 18–25 °C. Берегите от сквозняка и холодного подоконника.',
        topic: CareTopic.temperature,
      ),
    ],
    commonProblems: [
      'Сбрасывает листья после перестановки, перелива или сухого воздуха',
    ],
  ),
  Plant(
    id: 'monstera',
    name: 'Монстера',
    latinName: 'Monstera deliciosa',
    category: PlantCategory.indoor,
    summary: 'Крупные резные листья. Растение прощает небольшие промахи, но любит опору и простор.',
    care: [
      CareRecommendation(
        title: 'Свет',
        description: 'Полутень или рассеянный свет. В глухой тени новые листья растут без разрезов.',
        topic: CareTopic.light,
      ),
      CareRecommendation(
        title: 'Полив',
        description: 'Обильно, но только после подсыхания верхнего слоя. Воду из поддона сливайте.',
        topic: CareTopic.watering,
      ),
      CareRecommendation(
        title: 'Опора',
        description:
            'Стеблю нужна опора. Воздушные корни можно направлять в грунт.',
        topic: CareTopic.general,
      ),
    ],
    commonProblems: [
      'Жёлтые листья при переливе',
      'Сухие кончики при сухом воздухе',
    ],
  ),
  Plant(
    id: 'sansevieria',
    name: 'Сансевиерия',
    latinName: 'Sansevieria trifasciata',
    category: PlantCategory.indoor,
    summary: 'Жёсткие полосатые листья. Один из самых спокойных вариантов для тех, кто часто забывает про полив.',
    care: [
      CareRecommendation(
        title: 'Свет',
        description: 'Переносит и солнце, и тень. На свету окраска ярче.',
        topic: CareTopic.light,
      ),
      CareRecommendation(
        title: 'Полив',
        description: 'Редкий. Зимой достаточно одного раза в 3–4 недели. Лучше недолить, чем залить.',
        topic: CareTopic.watering,
      ),
      CareRecommendation(
        title: 'Горшок',
        description: 'Нужен дренаж. В тяжёлой мокрой почве корни загнивают.',
        topic: CareTopic.general,
      ),
    ],
    commonProblems: ['Мягкие листья у основания — признак перелива'],
  ),
  Plant(
    id: 'spathiphyllum',
    name: 'Спатифиллум',
    latinName: 'Spathiphyllum',
    category: PlantCategory.indoor,
    summary: '«Женское счастье» с белыми покрывалами. Само показывает жажду: листья заметно поникают.',
    care: [
      CareRecommendation(
        title: 'Свет',
        description:
            'Светлое место без прямого солнца. В глухой тени цветёт редко.',
        topic: CareTopic.light,
      ),
      CareRecommendation(
        title: 'Полив',
        description: 'Держите почву слегка влажной. Если листья опустились — полейте и слейте лишнюю воду.',
        topic: CareTopic.watering,
      ),
      CareRecommendation(
        title: 'Подкормка',
        description: 'Весной и летом раз в месяц достаточно слабого удобрения для цветущих.',
        topic: CareTopic.feeding,
      ),
    ],
    commonProblems: ['Коричневые кончики от сухого воздуха или застоя воды'],
  ),
  Plant(
    id: 'zamioculcas',
    name: 'Замиокулькас',
    latinName: 'Zamioculcas zamiifolia',
    category: PlantCategory.indoor,
    summary: 'Плотные глянцевые листья и клубни, которые запасают воду. Растёт медленно и не любит частый полив.',
    care: [
      CareRecommendation(
        title: 'Полив',
        description:
            'Только после полного просыхания грунта. Зимой паузы ещё длиннее.',
        topic: CareTopic.watering,
      ),
      CareRecommendation(
        title: 'Свет',
        description:
            'Мирится с тенью, но на рассеянном свету растёт заметно быстрее.',
        topic: CareTopic.light,
      ),
      CareRecommendation(
        title: 'Пересадка',
        description: 'Тесный горшок переносит спокойно. Пересаживайте, когда клубни деформируют горшок.',
        topic: CareTopic.general,
      ),
    ],
    commonProblems: ['Жёлтые стебли при постоянной сырости'],
  ),
  Plant(
    id: 'chlorophytum',
    name: 'Хлорофитум',
    latinName: 'Chlorophytum comosum',
    category: PlantCategory.indoor,
    summary: 'Полосатые листья и «детки» на длинных усах. Быстро растёт и подходит для кухни или полки.',
    care: [
      CareRecommendation(
        title: 'Полив',
        description: 'Летом регулярный, зимой умеренный. Короткое подсыхание переживает, застой — нет.',
        topic: CareTopic.watering,
      ),
      CareRecommendation(
        title: 'Свет',
        description: 'Светлое место. Прямое солнце выжигает белые полоски.',
        topic: CareTopic.light,
      ),
      CareRecommendation(
        title: 'Размножение',
        description: 'Детку с корешками можно посадить в отдельный горшок.',
        topic: CareTopic.planting,
      ),
    ],
    commonProblems: ['Сухие кончики при сухом воздухе и редком поливе'],
  ),
  Plant(
    id: 'pelargonium',
    name: 'Пеларгония',
    latinName: 'Pelargonium',
    category: PlantCategory.indoor,
    summary: 'Привычная «герань» с яркими шапками цветов. Любит солнце и не любит мокрые листья.',
    care: [
      CareRecommendation(
        title: 'Свет',
        description:
            'Солнечный подоконник. Чем больше света, тем обильнее цветение.',
        topic: CareTopic.light,
      ),
      CareRecommendation(
        title: 'Полив',
        description:
            'Когда почва просохла. Вода на листьях часто оставляет пятна.',
        topic: CareTopic.watering,
      ),
      CareRecommendation(
        title: 'Цветение',
        description: 'Удаляйте увядшие цветки. Избыток азота даёт листья вместо бутонов.',
        topic: CareTopic.feeding,
      ),
    ],
    commonProblems: ['Вытягивается и почти не цветёт в тени'],
  ),
  Plant(
    id: 'saintpaulia',
    name: 'Фиалка узамбарская',
    latinName: 'Saintpaulia',
    category: PlantCategory.indoor,
    summary: 'Компактная розетка с бархатными листьями. Цветёт долго, если не мочить листья и не держать в большом горшке.',
    care: [
      CareRecommendation(
        title: 'Свет',
        description:
            'Восточное или западное окно. Полуденное солнце оставляет ожоги.',
        topic: CareTopic.light,
      ),
      CareRecommendation(
        title: 'Полив',
        description:
            'Тёплой водой в поддон. На мокрых листьях появляются пятна.',
        topic: CareTopic.watering,
      ),
      CareRecommendation(
        title: 'Горшок',
        description: 'Небольшой. В просторном горшке фиалка наращивает листья и откладывает цветение.',
        topic: CareTopic.general,
      ),
    ],
    commonProblems: ['Гниль середины розетки при поливе сверху'],
  ),
  Plant(
    id: 'dracaena',
    name: 'Драцена маргината',
    latinName: 'Dracaena marginata',
    category: PlantCategory.indoor,
    summary: 'Тонкие стволы и узкие листья с красной каймой. Хорошо смотрится в углу комнаты.',
    care: [
      CareRecommendation(
        title: 'Свет',
        description:
            'Рассеянный свет. В глубокой тени ствол вытягивается и редеет.',
        topic: CareTopic.light,
      ),
      CareRecommendation(
        title: 'Полив',
        description: 'Умеренный, без застоя воды в поддоне.',
        topic: CareTopic.watering,
      ),
      CareRecommendation(
        title: 'Вода',
        description: 'Лучше отстоянная. От жёсткой воды и сухого воздуха буреют кончики.',
        topic: CareTopic.general,
      ),
    ],
    commonProblems: ['Коричневые кончики листьев'],
  ),
  Plant(
    id: 'aloe',
    name: 'Алоэ',
    latinName: 'Aloe vera',
    category: PlantCategory.indoor,
    summary: 'Мясистые листья с запасом влаги. Летом может стоять на балконе, зимой предпочитает прохладу и почти сухую почву.',
    care: [
      CareRecommendation(
        title: 'Свет',
        description: 'Много солнца. На северном окне вытягивается.',
        topic: CareTopic.light,
      ),
      CareRecommendation(
        title: 'Полив',
        description: 'Редкий, как у суккулента: полностью просушите грунт между поливами.',
        topic: CareTopic.watering,
      ),
      CareRecommendation(
        title: 'Зима',
        description: 'Прохлада около 12–16 °C и редкий полив помогают сохранить плотную розетку.',
        topic: CareTopic.temperature,
      ),
    ],
    commonProblems: ['Листья становятся мягкими и прозрачными от лишней воды'],
  ),
  Plant(
    id: 'phalaenopsis',
    name: 'Орхидея фаленопсис',
    latinName: 'Phalaenopsis',
    category: PlantCategory.indoor,
    summary: 'Самая привычная комнатная орхидея. Живёт в коре, а не в обычной земле, и показывает жажду цветом корней.',
    care: [
      CareRecommendation(
        title: 'Свет',
        description: 'Яркий свет без полуденного солнца.',
        topic: CareTopic.light,
      ),
      CareRecommendation(
        title: 'Полив',
        description: 'Когда корни стали серебристыми. Пролейте тёплой водой и дайте стечь.',
        topic: CareTopic.watering,
      ),
      CareRecommendation(
        title: 'Горшок',
        description:
            'Прозрачный, с корой. Обычная почва для орхидеи слишком плотная.',
        topic: CareTopic.general,
      ),
    ],
    commonProblems: ['Мягкие тёмные корни при постоянной сырости'],
  ),
  Plant(
    id: 'cactus',
    name: 'Кактус',
    latinName: 'Cactaceae',
    category: PlantCategory.indoor,
    summary: 'Общее имя для пустынных кактусов на подоконнике. Главное правило одно: много света и очень мало воды.',
    care: [
      CareRecommendation(
        title: 'Свет',
        description: 'Прямое солнце. Без него стебель бледнеет и тянется.',
        topic: CareTopic.light,
      ),
      CareRecommendation(
        title: 'Полив',
        description:
            'Летом после полного просыхания. Зимой почти не поливайте.',
        topic: CareTopic.watering,
      ),
      CareRecommendation(
        title: 'Зимовка',
        description: 'Прохладное светлое место помогает заложить цветение.',
        topic: CareTopic.temperature,
      ),
    ],
    commonProblems: ['Гниль от подоконника, где горшок стоит в холодной воде'],
  ),
  Plant(
    id: 'tomato',
    name: 'Томат',
    latinName: 'Solanum lycopersicum',
    category: PlantCategory.garden,
    summary: 'Теплолюбивая культура для теплицы и грядки. В средней полосе надёжнее начинать с рассады.',
    care: [
      CareRecommendation(
        title: 'Посев',
        description:
            'На рассаду — в марте. В грунт высаживают после устойчивого тепла.',
        topic: CareTopic.planting,
      ),
      CareRecommendation(
        title: 'Полив',
        description: 'Под корень, регулярно. Мокрые листья в прохладную погоду болеют чаще.',
        topic: CareTopic.watering,
      ),
      CareRecommendation(
        title: 'Формировка',
        description: 'Высокорослые сорта пасынкуют и подвязывают. Низкие можно вести свободнее.',
        topic: CareTopic.pruning,
      ),
    ],
    commonProblems: ['Фитофтороз во влажное прохладное лето'],
  ),
  Plant(
    id: 'cucumber',
    name: 'Огурец',
    latinName: 'Cucumis sativus',
    category: PlantCategory.garden,
    summary: 'Быстрая культура для тёплой грядки или теплицы. Не выносит холодной воды и заморозков.',
    care: [
      CareRecommendation(
        title: 'Посадка',
        description: 'Сейте или высаживайте, когда ночи уже тёплые. Холодная почва останавливает рост.',
        topic: CareTopic.planting,
      ),
      CareRecommendation(
        title: 'Полив',
        description: 'Частый и только тёплой водой, лучше утром.',
        topic: CareTopic.watering,
      ),
      CareRecommendation(
        title: 'Сбор',
        description:
            'Снимайте зеленцы часто. Переросшие плоды замедляют новые завязи.',
        topic: CareTopic.general,
      ),
    ],
    commonProblems: ['Горечь и пустоцвет при неравномерном поливе и холоде'],
  ),
  Plant(
    id: 'strawberry',
    name: 'Клубника',
    latinName: 'Fragaria × ananassa',
    category: PlantCategory.garden,
    summary: 'Садовая земляника для солнечной грядки. Ягоды крупнее, если кусту хватает воды и света.',
    care: [
      CareRecommendation(
        title: 'Место',
        description: 'Солнце и почва без застоя воды.',
        topic: CareTopic.light,
      ),
      CareRecommendation(
        title: 'Полив',
        description: 'Регулярный, особенно когда ягоды наливаются. Лейте под куст, не по ягодам.',
        topic: CareTopic.watering,
      ),
      CareRecommendation(
        title: 'Усы',
        description: 'Лишние усы удаляйте, если не нужны новые розетки. Они забирают силу у ягод.',
        topic: CareTopic.pruning,
      ),
    ],
    commonProblems: ['Серая гниль ягод в сырую погоду'],
  ),
  Plant(
    id: 'rose',
    name: 'Роза',
    latinName: 'Rosa',
    category: PlantCategory.garden,
    summary: 'Садовый кустарник, которому нужны солнце, воздух вокруг куста и глубокий полив под корень.',
    care: [
      CareRecommendation(
        title: 'Место',
        description: 'Солнце не меньше половины дня и свободное проветривание.',
        topic: CareTopic.light,
      ),
      CareRecommendation(
        title: 'Полив',
        description: 'Редкий, но глубокий, строго под корень. Дождевание провоцирует пятна на листьях.',
        topic: CareTopic.watering,
      ),
      CareRecommendation(
        title: 'Обрезка',
        description: 'Весной вырежьте сухие и слабые побеги, живые укоротите до здоровой почки.',
        topic: CareTopic.pruning,
      ),
    ],
    commonProblems: ['Тля на молодых побегах', 'Мучнистая роса'],
  ),
  Plant(
    id: 'apple',
    name: 'Яблоня',
    latinName: 'Malus domestica',
    category: PlantCategory.garden,
    summary: 'Плодовое дерево для солнечного участка. Молодому саженцу важны полив, опора и аккуратная обрезка.',
    care: [
      CareRecommendation(
        title: 'Место',
        description: 'Солнце и запас места: взрослой кроне нужна дистанция до соседних деревьев.',
        topic: CareTopic.planting,
      ),
      CareRecommendation(
        title: 'Полив',
        description: 'Особенно важен саженцу и в долгую засуху. Поливайте по приствольному кругу.',
        topic: CareTopic.watering,
      ),
      CareRecommendation(
        title: 'Обрезка',
        description: 'Ранней весной уберите сухие ветки и побеги, растущие внутрь кроны.',
        topic: CareTopic.pruning,
      ),
    ],
    commonProblems: ['Парша после сырой весны', 'Плодожорка летом'],
  ),
  Plant(
    id: 'currant',
    name: 'Смородина чёрная',
    latinName: 'Ribes nigrum',
    category: PlantCategory.garden,
    summary: 'Надёжный куст для большинства регионов. Хорошо плодоносит на свету и при влажной, но не болотистой почве.',
    care: [
      CareRecommendation(
        title: 'Место',
        description: 'Светлое место. В глухой тени ягод меньше и они кислее.',
        topic: CareTopic.light,
      ),
      CareRecommendation(
        title: 'Полив',
        description: 'Особенно после цветения и когда наливаются ягоды.',
        topic: CareTopic.watering,
      ),
      CareRecommendation(
        title: 'Обрезка',
        description: 'Старые тёмные ветки старше пяти лет вырезают у земли. Урожай дают более молодые.',
        topic: CareTopic.pruning,
      ),
    ],
    commonProblems: ['Тля скручивает молодые листья'],
  ),
  Plant(
    id: 'potato',
    name: 'Картофель',
    latinName: 'Solanum tuberosum',
    category: PlantCategory.garden,
    summary: 'Основная грядка огорода. Клубни не должны зеленеть на свету, поэтому куст окучивают.',
    care: [
      CareRecommendation(
        title: 'Посадка',
        description: 'Когда почва прогрелась примерно до 8 °C. В холодную сырую землю клубни загнивают.',
        topic: CareTopic.planting,
      ),
      CareRecommendation(
        title: 'Окучивание',
        description: 'Дважды за сезон, чтобы клубни были в темноте и куст не разваливался.',
        topic: CareTopic.general,
      ),
      CareRecommendation(
        title: 'Полив',
        description: 'Нужен в цветение, если давно нет дождей. До всходов обычно хватает весенней влаги.',
        topic: CareTopic.watering,
      ),
    ],
    commonProblems: ['Колорадский жук', 'Фитофтороз ботвы в сырое лето'],
  ),
  Plant(
    id: 'petunia',
    name: 'Петуния',
    latinName: 'Petunia',
    category: PlantCategory.garden,
    summary: 'Цветок для балконного ящика и клумбы. Цветёт всё лето, если есть солнце и нет полного пересыхания.',
    care: [
      CareRecommendation(
        title: 'Свет',
        description: 'Чем больше солнца, тем больше цветков.',
        topic: CareTopic.light,
      ),
      CareRecommendation(
        title: 'Полив',
        description: 'В ящике почва сохнет быстро. Не давайте кому превращаться в камень, но и не держите его мокрым.',
        topic: CareTopic.watering,
      ),
      CareRecommendation(
        title: 'Уход',
        description: 'Удаляйте семенные коробочки. В тесном ящике раз в две недели нужна подкормка для цветущих.',
        topic: CareTopic.feeding,
      ),
    ],
    commonProblems: ['Вытягивается и плохо цветёт в тени'],
  ),
];
