import '../../domain/api_client/api_client.dart';
import '../models/user.dart';

class UserRemoteDataSource {
  final ApiClient _apiClient;

  const UserRemoteDataSource(this._apiClient);

  Future<User> me() async {
    const path = '/api/user/me';
    final response = await _apiClient.get(path);
    return User.fromJson(response.data['data']);
  }
}
