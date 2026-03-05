import '../../data/models/history1_model.dart';
import '../core/result.dart';

abstract class History1Repository {
  Future<Result<List<History1Model>>> getHistory1();
  Future<Result<Unit>> deleteHistory1(Set<String> ids);
  Future<Result<Unit>> addToHistory1(History1Model item);
}
