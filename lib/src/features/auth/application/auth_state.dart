import 'package:equatable/equatable.dart';

import '../../../core/errors/failures.dart';
import '../../../domain/entities/user_profile.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthAuthenticated extends AuthState {
  const AuthAuthenticated(this.user);

  final UserProfile user;

  @override
  List<Object?> get props => [user];
}

class AuthFailureState extends AuthState {
  const AuthFailureState(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
