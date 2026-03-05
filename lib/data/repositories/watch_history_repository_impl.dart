import '../../domain/core/app_error.dart';
import '../../domain/core/result.dart';
import '../../domain/repositories/watch_history_repository.dart';
import '../data_sources/watch_history_local_data_source.dart';
import '../models/watch_history_model.dart';

class WatchHistoryRepositoryImpl implements WatchHistoryRepository {
  final WatchHistoryLocalDataSource _localDataSource;

  WatchHistoryRepositoryImpl(this._localDataSource);

  @override
  Future<Result<List<WatchHistoryModel>>> getWatchHistory() async {
    try {
      final items = await _localDataSource.getAll();
      return Success(items);
    } catch (e) {
      return Failure(AppError.from(e));
    }
  }

  @override
  Future<Result<Unit>> deleteWatchHistory(Set<String> ids) async {
    try {
      await _localDataSource.deleteByIds(ids);
      return Success(Unit());
    } catch (e) {
      return Failure(AppError.from(e));
    }
  }

  @override
  Future<Result<Unit>> addToWatchHistory(WatchHistoryModel item) async {
    try {
      await _localDataSource.addItem(item);
      return Success(Unit());
    } catch (e) {
      return Failure(AppError.from(e));
    }
  }
}
