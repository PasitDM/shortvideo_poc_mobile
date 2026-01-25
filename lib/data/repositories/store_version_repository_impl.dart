import '../../domain/repositories/store_version_repository.dart';
import '../data_sources/store_version_remote_data_source.dart';
import '../models/version_status.dart';

class StoreVersionRepositoryImpl implements StoreVersionRepository {
  final StoreVersionRemoteDataSource _remote;

  const StoreVersionRepositoryImpl(this._remote);

  @override
  Future<VersionStatus?> getVersionStatus() {
    return _remote.getVersionStatus();
  }
}
