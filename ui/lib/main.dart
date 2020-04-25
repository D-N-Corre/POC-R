import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_stetho/flutter_stetho.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poc_r/config/graphql_configuration.dart';
import 'package:poc_r/features/authentication/data/repositories/authentication_repository.dart';
import 'package:poc_r/features/authentication/data/repositories/interfaces/authentication_repository_interface.dart';

import 'package:poc_r/features/authentication/blocs/authentication/barrel.dart';

import 'package:poc_r/features/core/pages/spash_page.dart';
import 'package:poc_r/features/core/widgets/layout_navigation_widget.dart';
import 'package:poc_r/features/core/blocs/tab/tab_bloc.dart';

import 'package:poc_r/features/profile/pages/profile_page.dart';

import 'routes.dart';
// import 'package:poc_r/features/core/widgets/loading_indicator_widget.dart';

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
          child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) {
              return AuthenticationBloc(
                  authenticationRepository: authenticationRepository)
                ..add(AppStarted());
            },
          ),
          BlocProvider<TabBloc>(
            create: (context) => TabBloc(),
          ),
        ],
        child: App(authenticationRepository: authenticationRepository),
      )),
    ),
  );
}

class App extends StatelessWidget {
  final AuthenticationRepositoryInterface authenticationRepository;

  App({Key key, @required this.authenticationRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],

        // Define the default font family.
        fontFamily: 'Georgia',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      routes: {
        Routes.home: (context) {
          return BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationUninitialized) {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(LoginAnonymously());
              }
              if (state is AuthenticationAuthenticated) {
                return LayoutNavigation();
              }
              if (state is AuthenticationUnauthenticated) {
                // FIXME implémenter une page d'erreur
                return null;
              }
              if (state is AuthenticationLoading) {
                return SplashPage();
                // return LoadingIndicator();
              }
              return null;
            },
          );
        },
        Routes.explore: (context) {
          return Container();
        },
        Routes.stats: (context) {
          return Container();
        },
        Routes.account: (context) {
          return ProfilePage();
        },
      },
    );
  }
}
