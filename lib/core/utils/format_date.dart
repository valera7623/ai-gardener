String formatDateTime(DateTime value) {
  final local = value.toLocal();
  String two(int number) => number.toString().padLeft(2, '0');
  return '${two(local.day)}.${two(local.month)}.${local.year}, '
      '${two(local.hour)}:${two(local.minute)}';
}

const _monthNames = <String>[
  'января',
  'февраля',
  'марта',
  'апреля',
  'мая',
  'июня',
  'июля',
  'августа',
  'сентября',
  'октября',
  'ноября',
  'декабря',
];

String formatCareDate(DateTime value, {DateTime? now}) {
  final local = value.toLocal();
  final today = now ?? DateTime.now();
  final text = '${local.day} ${_monthNames[local.month - 1]}';
  if (local.year == today.year) {
    return text;
  }
  return '$text ${local.year}';
}
