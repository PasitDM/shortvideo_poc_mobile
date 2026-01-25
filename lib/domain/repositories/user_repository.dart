import '../../data/models/user.dart';
import '../core/result.dart';

abstract class UserRepository {
  Future<Result<User>> me();
}
