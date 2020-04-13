import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:poc_r/constants/authentication_provide_enum.dart';
import 'package:poc_r/features/user/data/repositories/interfaces/authentication_repository_interface.dart';
import 'package:poc_r/features/user/bloc/authentication_bloc.dart';
import 'package:poc_r/features/user/bloc/authentication_event.dart';
import 'package:poc_r/features/user/bloc/login_event.dart';
import 'package:poc_r/features/user/bloc/login_state.dart';
import 'package:poc_r/features/user/models/token_model.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepositoryInterface authenticationRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.authenticationRepository,
    @required this.authenticationBloc,
  })  : assert(authenticationRepository != null),
        assert(authenticationBloc != null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        await authenticationRepository.authenticate(
            provider: AuthenticationProviderEnum.google);
        TokenModel tokenModel = await authenticationRepository.getToken();

        authenticationBloc.add(LoggedIn(token: tokenModel));

        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
