import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import './../../models/token_details_model.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final TokenDetailsModel tokenDetails;

  AuthenticationAuthenticated({@required this.tokenDetails});

  @override
  List<Object> get props => [tokenDetails];

  @override
  String toString() =>
      'AuthenticationAuthenticated { tokenDetails: $tokenDetails }';
}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}
