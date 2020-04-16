import 'package:bloc/bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';
import 'package:poc_r/config/graphql_configuration.dart';
import 'package:poc_r/features/user/data/repositories/interfaces/authentication_repository_interface.dart';

import 'package:poc_r/features/user/bloc/authentication_event.dart';
import 'package:poc_r/features/user/bloc/authentication_state.dart';
import 'package:poc_r/features/user/models/token_details_model.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepositoryInterface authenticationRepository;
  GraphqlConfiguration graphQLConfiguration = GraphqlConfiguration();

  AuthenticationBloc({@required this.authenticationRepository})
      : assert(authenticationRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final String token = await authenticationRepository?.getToken();

      if (token != null) {
        final TokenDetailsModel tokenDetailsModel =
            await authenticationRepository?.getTokenDetails();
        yield AuthenticationAuthenticated(tokenDetails: tokenDetailsModel);
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      GraphQLClient _client = await graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(''),
          variables: {
            'id': 10,
          },
        ),
      );
      yield AuthenticationAuthenticated(tokenDetails: event.token);
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await authenticationRepository.signOut();
      yield AuthenticationUnauthenticated();
    }
  }
}
