import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../recognition/domain/recognition_connection.dart';
import '../providers/app_settings_provider.dart';

class RecognitionConnectionForm extends ConsumerStatefulWidget {
  const RecognitionConnectionForm({super.key});

  @override
  ConsumerState<RecognitionConnectionForm> createState() =>
      _RecognitionConnectionFormState();
}

class _RecognitionConnectionFormState
    extends ConsumerState<RecognitionConnectionForm> {
  late final TextEditingController _keyController;
  late final TextEditingController _endpointController;
  late final TextEditingController _modelController;
  late final TextEditingController _folderController;
  late RecognitionBackend _backend;
  var _obscureKey = true;
  var _saving = false;

  @override
  void initState() {
    super.initState();
    final connection = ref.read(appSettingsProvider).connection;
    _backend = connection.backend;
    _keyController = TextEditingController(text: connection.apiKey);
    _endpointController = TextEditingController(text: connection.endpoint);
    _modelController = TextEditingController(text: connection.model);
    _folderController = TextEditingController(text: connection.folderId);
  }

  @override
  void dispose() {
    _keyController.dispose();
    _endpointController.dispose();
    _modelController.dispose();
    _folderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _BackendTile(
          title: RecognitionBackend.custom.label,
          subtitle: 'Ключ Yandex остаётся на сервере',
          selected: _backend == RecognitionBackend.custom,
          onTap: () => setState(() => _backend = RecognitionBackend.custom),
        ),
        _BackendTile(
          title: RecognitionBackend.yandex.label,
          subtitle: 'Ключ хранится на телефоне, для личной сборки',
          selected: _backend == RecognitionBackend.yandex,
          onTap: () => setState(() => _backend = RecognitionBackend.yandex),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _keyController,
          obscureText: _obscureKey,
          autocorrect: false,
          enableSuggestions: false,
          decoration: InputDecoration(
            labelText: _backend == RecognitionBackend.yandex
                ? 'Ключ Yandex'
                : 'Ключ доступа к серверу',
            helperText: _backend == RecognitionBackend.yandex
                ? 'Останется на этом телефоне'
                : 'Это не ключ Yandex. Его задаёт ваш сервер',
            suffixIcon: IconButton(
              tooltip: _obscureKey ? 'Показать ключ' : 'Скрыть ключ',
              onPressed: () => setState(() => _obscureKey = !_obscureKey),
              icon: Icon(
                _obscureKey
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
            ),
          ),
        ),
        if (_backend == RecognitionBackend.yandex) ...[
          const SizedBox(height: 8),
          TextField(
            controller: _modelController,
            autocorrect: false,
            decoration: const InputDecoration(
              labelText: 'Модель',
              helperText: 'По умолчанию Qwen, она принимает фото',
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _folderController,
            autocorrect: false,
            decoration: const InputDecoration(
              labelText: 'Идентификатор каталога',
              helperText: 'Нужен, если ключ привязан к каталогу Yandex Cloud',
            ),
          ),
        ] else ...[
          const SizedBox(height: 8),
          TextField(
            controller: _endpointController,
            keyboardType: TextInputType.url,
            autocorrect: false,
            decoration: const InputDecoration(
              labelText: 'Адрес сервера',
              hintText: 'https://example.ru',
              helperText:
                  'Только https. Сервер из проекта ждёт ключ доступа выше.',
            ),
          ),
        ],
        const SizedBox(height: 12),
        FilledButton(
          onPressed: _saving ? null : _save,
          child: Text(_saving ? 'Сохраняем…' : 'Сохранить подключение'),
        ),
        const SizedBox(height: 8),
        Text(
          'Свой сервер получает imageBase64 и mimeType, сам вызывает Yandex и отвечает полями title, summary, confidence, plantId и recommendations.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    final model = _modelController.text.trim();
    await ref
        .read(appSettingsProvider.notifier)
        .setRecognition(
          RecognitionConnection(
            backend: _backend,
            apiKey: _keyController.text.trim(),
            endpoint: _endpointController.text.trim(),
            model: model.isEmpty ? RecognitionConnection.defaultModel : model,
            folderId: _folderController.text.trim(),
          ),
        );
    if (!mounted) {
      return;
    }
    setState(() => _saving = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Подключение сохранено на этом телефоне')),
    );
  }
}

class _BackendTile extends StatelessWidget {
  const _BackendTile({
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: selected ? scheme.primaryContainer : scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: selected ? scheme.primary : scheme.outlineVariant,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                if (selected) Icon(Icons.check, color: scheme.primary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
