import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:poc_r/features/user/models/token_model.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final TokenModel token;

  AuthenticationAuthenticated({@required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'TodosLoadSuccess { todos: $token }';
}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}
