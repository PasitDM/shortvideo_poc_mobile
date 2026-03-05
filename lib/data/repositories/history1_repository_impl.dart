import '../../domain/core/app_error.dart';
import '../../domain/core/result.dart';
import '../../domain/repositories/history1_repository.dart';
import '../data_sources/history1_local_data_source.dart';
import '../models/history1_model.dart';

class History1RepositoryImpl implements History1Repository {
  final History1LocalDataSource _localDataSource;

  History1RepositoryImpl(this._localDataSource);

  @override
  Future<Result<List<History1Model>>> getHistory1() async {
    try {
      final items = await _localDataSource.getAll();
      return Success(items);
    } catch (e) {
      return Failure(AppError.from(e));
    }
  }

  @override
  Future<Result<Unit>> deleteHistory1(Set<String> ids) async {
    try {
      await _localDataSource.deleteByIds(ids);
      return Success(Unit());
    } catch (e) {
      return Failure(AppError.from(e));
    }
  }

  @override
  Future<Result<Unit>> addToHistory1(History1Model item) async {
    try {
      await _localDataSource.addItem(item);
      return Success(Unit());
    } catch (e) {
      return Failure(AppError.from(e));
    }
  }
}
