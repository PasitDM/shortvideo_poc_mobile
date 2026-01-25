import 'package:equatable/equatable.dart';

import '../../../data/models/user.dart';

class SessionState extends Equatable {
  final User? user;

  const SessionState({
    this.user,
  });

  @override
  List<Object?> get props => [
    user,
  ];

  SessionState copyWith({
    User? user,
  }) {
    return SessionState(
      user: user ?? this.user,
    );
  }

  SessionState clearData() {
    return const SessionState();
  }

  bool isAuthenticated() {
    return user != null;
  }
}
