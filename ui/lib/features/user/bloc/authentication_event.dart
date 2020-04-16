import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:poc_r/features/user/models/token_details_model.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final TokenDetailsModel token;

  const LoggedIn({@required this.token});

  @override
  List<Object> get props => [token];
}

class LoggedOut extends AuthenticationEvent {}
