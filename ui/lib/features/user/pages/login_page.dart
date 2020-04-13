import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poc_r/features/user/bloc/authentication_bloc.dart';
import 'package:poc_r/features/user/bloc/login_bloc.dart';
import 'package:poc_r/features/user/data/repositories/interfaces/authentication_repository_interface.dart';
import 'package:poc_r/features/user/widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  final AuthenticationRepositoryInterface authenticationRepository;

  LoginPage({Key key, @required this.authenticationRepository})
      : assert(authenticationRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            authenticationRepository: authenticationRepository,
          );
        },
        child: LoginForm(),
      ),
    );
  }
}
