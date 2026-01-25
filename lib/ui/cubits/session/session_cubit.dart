import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/user.dart';
import 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit() : super(const SessionState());

  void setUser(User? newValue) {
    emit(state.copyWith(user: newValue));
  }

  void clearData() {
    emit(state.clearData());
  }
}
