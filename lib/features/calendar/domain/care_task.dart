class CareTask {
  const CareTask({
    required this.id,
    required this.notificationId,
    required this.title,
    required this.detail,
    required this.month,
    required this.day,
  });

  final String id;
  final int notificationId;
  final String title;
  final String detail;
  final int month;
  final int day;
}

const careTasks = <CareTask>[
  CareTask(
    id: 'tomato-sow',
    notificationId: 1,
    title: 'Посейте томаты на рассаду',
    detail:
        'Для средней полосы это середина марта. В вашей зоне срок уже сдвинут.',
    month: 3,
    day: 15,
  ),
  CareTask(
    id: 'apple-prune',
    notificationId: 2,
    title: 'Обрежьте яблоню',
    detail: 'Успейте до набухания почек: уберите сухие ветки и побеги внутрь кроны.',
    month: 3,
    day: 25,
  ),
  CareTask(
    id: 'indoor-repot',
    notificationId: 3,
    title: 'Проверьте комнатные растения',
    detail:
        'Если корни заполнили горшок, весна — спокойное время для пересадки.',
    month: 4,
    day: 15,
  ),
  CareTask(
    id: 'potato-plant',
    notificationId: 4,
    title: 'Посадите картофель',
    detail: 'Клубни сажают, когда почва прогрелась примерно до 8 °C и не липнет к лопате.',
    month: 5,
    day: 10,
  ),
  CareTask(
    id: 'cucumber-water',
    notificationId: 5,
    title: 'Огурцы: полив и сбор',
    detail: 'Поливайте тёплой водой и снимайте зеленцы часто, чтобы куст не останавливался.',
    month: 6,
    day: 20,
  ),
  CareTask(
    id: 'strawberry-runners',
    notificationId: 6,
    title: 'Клубника: лишние усы',
    detail: 'Удалите усы, если не нужны новые розетки. Так куст отдаст силу ягодам.',
    month: 7,
    day: 1,
  ),
  CareTask(
    id: 'tomato-check',
    notificationId: 7,
    title: 'Осмотрите томаты снизу',
    detail: 'В сырую погоду фитофтороз начинается с нижних листьев. Больные листья уберите с грядки.',
    month: 7,
    day: 10,
  ),
  CareTask(
    id: 'garden-cleanup',
    notificationId: 8,
    title: 'Уберите больные листья с грядки',
    detail: 'Листья томатов и картофеля с пятнами не кладите в компост.',
    month: 9,
    day: 20,
  ),
  CareTask(
    id: 'indoor-less-water',
    notificationId: 9,
    title: 'Сократите полив комнатных',
    detail: 'Световой день короче, и фикус, драцена и спатифиллум пьют меньше.',
    month: 10,
    day: 5,
  ),
  CareTask(
    id: 'rose-cover',
    notificationId: 10,
    title: 'Подготовьте розы к холоду',
    detail: 'Укрывайте после устойчивого похолодания, а не при первых ночных заморозках.',
    month: 10,
    day: 15,
  ),
  CareTask(
    id: 'cold-window',
    notificationId: 11,
    title: 'Отодвиньте растения от стекла',
    detail: 'Фиалкам и фикусу вредно стоять вплотную к ледяному окну.',
    month: 12,
    day: 5,
  ),
  CareTask(
    id: 'succulent-winter',
    notificationId: 12,
    title: 'Почти не поливайте суккуленты',
    detail: 'Кактусы, алоэ и замиокулькас зимой держат в сухости.',
    month: 1,
    day: 15,
  ),
  CareTask(
    id: 'dust-leaves',
    notificationId: 13,
    title: 'Протрите крупные листья',
    detail: 'Пыль на монстере и драцене мешает слабому зимнему свету.',
    month: 2,
    day: 1,
  ),
];

CareTask? careTaskById(String id) {
  for (final task in careTasks) {
    if (task.id == id) {
      return task;
    }
  }
  return null;
}
