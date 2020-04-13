import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poc_r/features/user/data/repositories/interfaces/authentication_repository_interface.dart';

import 'package:poc_r/features/user/bloc/authentication_event.dart';
import 'package:poc_r/features/user/bloc/authentication_state.dart';
import 'package:poc_r/features/user/models/token_model.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepositoryInterface authenticationRepository;

  AuthenticationBloc({@required this.authenticationRepository})
      : assert(authenticationRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final TokenModel tokenModel = await authenticationRepository.getToken();

      if (tokenModel != null) {
        yield AuthenticationAuthenticated(token: tokenModel);
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationAuthenticated(token: event.token);
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await authenticationRepository.signOut();
      yield AuthenticationUnauthenticated();
    }
  }
}
