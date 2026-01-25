import '../../data/models/auth.dart';
import '../../data/models/requests/login_with_email_request.dart';
import '../core/result.dart';

abstract class AuthRepository {
  Future<Result<Auth>> loginWithEmail({
    required LoginWithEmailRequest request,
  });
}
