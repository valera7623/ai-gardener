import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../shared/models/recognition_result.dart';
import '../../data/repositories/history_repository_impl.dart';
import '../../domain/history_repository.dart';

final historyRepositoryProvider = Provider<HistoryRepository>((ref) {
  return HistoryRepositoryImpl(ref.watch(isarProvider));
});

final historyProvider =
    AsyncNotifierProvider<HistoryController, List<RecognitionResult>>(
      HistoryController.new,
    );

class HistoryController extends AsyncNotifier<List<RecognitionResult>> {
  @override
  Future<List<RecognitionResult>> build() {
    return ref.read(historyRepositoryProvider).getAll();
  }

  Future<RecognitionResult> add(RecognitionResult result) async {
    final saved = await ref.read(historyRepositoryProvider).add(result);
    final existing = await future;
    state = AsyncData([
      saved,
      ...existing.where((item) => item.id != saved.id),
    ]);
    return saved;
  }

  Future<void> remove(String id) async {
    final current = state.value ?? await future;
    state = AsyncData([
      for (final item in current)
        if (item.id != id) item,
    ]);
    await ref.read(historyRepositoryProvider).delete(id);
  }
}
