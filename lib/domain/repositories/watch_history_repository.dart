import '../../data/models/watch_history_model.dart';
import '../core/result.dart';

abstract class WatchHistoryRepository {
  Future<Result<List<WatchHistoryModel>>> getWatchHistory();
  Future<Result<Unit>> deleteWatchHistory(Set<String> ids);
  Future<Result<Unit>> addToWatchHistory(WatchHistoryModel item);
}
