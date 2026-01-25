import '../../data/models/version_status.dart';

abstract class StoreVersionRepository {
  Future<VersionStatus?> getVersionStatus();
}
