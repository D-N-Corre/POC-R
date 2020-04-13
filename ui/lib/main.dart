import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_stetho/flutter_stetho.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poc_r/config/graphql_configuration.dart';
import 'package:poc_r/features/user/data/repositories/authentication_repository.dart';
import 'package:poc_r/features/user/data/repositories/interfaces/authentication_repository_interface.dart';

import 'package:poc_r/features/user/bloc/authentication_bloc.dart';
import 'package:poc_r/features/user/bloc/authentication_state.dart';
import 'package:poc_r/features/user/pages/login_page.dart';

import 'package:poc_r/features/home/pages/spash_page.dart';
import 'package:poc_r/features/home/pages/home_page.dart';
import 'package:poc_r/features/home/widgets/loading_indicator.dart';

import 'package:poc_r/features/user/bloc/authentication_event.dart';

GraphqlConfiguration graphqlConfiguration = GraphqlConfiguration();

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  Stetho.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final AuthenticationRepositoryInterface authenticationRepository =
      AuthenticationRepository();

  runApp(
    GraphQLProvider(
      client: graphqlConfiguration.client,
      child: CacheProvider(
        child: BlocProvider<AuthenticationBloc>(
          create: (context) {
            return AuthenticationBloc(
                authenticationRepository: authenticationRepository)
              ..add(AppStarted());
          },
          child: App(authenticationRepository: authenticationRepository),
        ),
      ),
    ),
  );
}

class App extends StatelessWidget {
  final AuthenticationRepositoryInterface authenticationRepository;

  App({Key key, @required this.authenticationRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUninitialized) {
            return SplashPage();
          }
          if (state is AuthenticationAuthenticated) {
            return HomePage();
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginPage(
                authenticationRepository: authenticationRepository);
          }
          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          }
          return null;
        },
      ),
    );
  }
}
