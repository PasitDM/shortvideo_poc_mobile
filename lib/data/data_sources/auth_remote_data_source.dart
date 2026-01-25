import '../../domain/api_client/api_client.dart';
import '../models/auth.dart';
import '../models/requests/login_with_email_request.dart';

class AuthRemoteDataSource {
  final ApiClient _apiClient;

  const AuthRemoteDataSource(this._apiClient);

  Future<Auth> loginWithEmail({required LoginWithEmailRequest request}) async {
    const path = '/api/app/auth/credentials/signin';
    final response = await _apiClient.post(
      path,
      data: request.toJson(),
    );
    return Auth.fromJson(response.data['data']);
  }
}
