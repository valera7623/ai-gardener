import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_constants.dart';

class DataPolicyScreen extends StatelessWidget {
  const DataPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasUrl = AppConstants.privacyPolicyUrl.trim().isNotEmpty;
    return Scaffold(
      appBar: AppBar(title: const Text('Политика данных')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          Text(
            'Актуально на ${AppConstants.privacyPolicyUpdated}',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          for (final section in dataPolicySections) ...[
            Text(section.title, style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(section.body, style: theme.textTheme.bodyLarge),
            const SizedBox(height: 20),
          ],
          Text('Контакт', style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          SelectableText(
            AppConstants.privacyContactEmail,
            style: theme.textTheme.bodyLarge,
          ),
          if (hasUrl) ...[
            const SizedBox(height: 16),
            FilledButton.tonal(
              key: const Key('open-privacy-url'),
              onPressed: () async {
                final uri = Uri.parse(AppConstants.privacyPolicyUrl);
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              },
              child: const Text('Открыть в браузере'),
            ),
          ],
        ],
      ),
    );
  }
}

class DataPolicySection {
  const DataPolicySection(this.title, this.body);

  final String title;
  final String body;
}

const dataPolicySections = <DataPolicySection>[
  DataPolicySection(
    'Кто обрабатывает данные',
    'Приложение «ИИ-садовник», пакет ru.aigardener.ai_gardener. Учётной записи нет. По вопросам обработки данных напишите на valera7623@gmail.com.',
  ),
  DataPolicySection(
    'Какие данные обрабатываются',
    'Фото растения вы делаете камерой или выбираете из галереи. Если интернет есть и вы нажали «Распознать», сжатое фото отправляется на сервер приложения https://aegisai.fun. Сервер передаёт его в Yandex Cloud, чтобы вернуть текстовую подсказку. Без интернета фото остаётся на телефоне: его оценивает модель в приложении и наружу оно не уходит. История хранит на телефоне копию снимка, название, описание и рекомендации. Свайп влево удаляет запись и эту копию. Исходный файл в галерее не удаляется. На телефоне также сохраняются тема, климатическая зона и включённые вами напоминания календаря. Напоминание приходит около 9:00 с самого телефона, не с сервера.',
  ),
  DataPolicySection(
    'Зачем нужны разрешения',
    'Камера нужна, чтобы снять растение. Уведомления нужны только для напоминаний календаря, которые вы включаете сами. После перезагрузки телефона приложение восстанавливает уже включённые напоминания. Интернет нужен для облачной подсказки. Справочник, история и календарь открываются без сети.',
  ),
  DataPolicySection(
    'Передача третьим лицам',
    'Рекламных и аналитических сервисов в приложении нет. Фото передаётся дальше только в момент онлайн-распознавания: на сервер приложения и затем в Yandex Cloud для текста ответа. Галерея, история и настройки сами по себе на сервер не отправляются. Резервную копию приложения система телефона не делает: резервное копирование данных приложения отключено.',
  ),
  DataPolicySection(
    'Срок хранения и удаление',
    'История и настройки хранятся на телефоне, пока вы их не удалите или не удалите приложение. Удаление приложения стирает его данные с устройства. Срок хранения фото на стороне Yandex Cloud определяется правилами этого сервиса.',
  ),
  DataPolicySection(
    'Ограничение',
    'Подсказка по фото не является диагнозом, заключением агронома и основанием для обработки растения. Сверьте её с листом. При сомнении не обрабатывайте растение наугад.',
  ),
];
