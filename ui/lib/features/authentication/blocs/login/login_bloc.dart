import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import './../../constants/authentication_provider_enum.dart';

import './../../data/repositories/interfaces/authentication_repository_interface.dart';

import './../../blocs/authentication/barrel.dart';
import './../../blocs/login/barrel.dart';

import './../../models/token_details_model.dart';

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
    if (event is LoginAnonymously) {
      yield LoginLoading();
      await authenticationRepository.authenticate(
          provider: AuthenticationProviderEnum.anonymous);

      yield LoginInitial();
    }

    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        await authenticationRepository.authenticate(
            provider: AuthenticationProviderEnum.google);

        TokenDetailsModel tokenDetailsModel =
            await authenticationRepository.getTokenDetails();

        authenticationBloc.add(LoggedIn(token: tokenDetailsModel));

        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
