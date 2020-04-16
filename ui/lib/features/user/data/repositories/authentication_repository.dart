import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:poc_r/config/graphql_configuration.dart';
import 'package:poc_r/constants/authentication_provide_enum.dart';
import 'package:poc_r/features/user/data/datasources/authentication_provider.dart';
import 'package:poc_r/features/user/data/datasources/queries/login_query.dart';

import 'package:poc_r/features/user/data/repositories/interfaces/authentication_repository_interface.dart';
import 'package:poc_r/features/user/models/token_details_model.dart';
import 'package:poc_r/features/user/models/user_model.dart';

class AuthenticationRepository implements AuthenticationRepositoryInterface {
  final AuthenticationProvider _authProvider = AuthenticationProvider();

  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final String _storageTokenKey = 'token';

  LoginQuery query = LoginQuery();

  // Future<String> authenticate({
  //   @required String username,
  //   @required String password,
  // }) async {
  // GraphQLClient _client = graphQLConfiguration.clientToQuery();
  // QueryResult result = await _client.query(
  //   QueryOptions(
  //     documentNode: gql(''),
  //     variables: {
  //       'id': 10,
  //     },
  //   ),
  // );
  // await http.get('http://10.0.2.2:3000/auth/google');
  // await Future.delayed(Duration(seconds: 1));

  //   Future<FirebaseUser> user = _userProvider.signInGoogle();
  //   return 'token';
  // }

  Future<void> _persistToken(String token) async {
    if (token != null) {
      return await _storage.write(key: _storageTokenKey, value: token);
    }
  }

  Future<void> _deleteToken() async {
    return await _storage.delete(key: _storageTokenKey);
  }

  @override
  Future<bool> authenticate(
      {@required AuthenticationProviderEnum provider,
      String username,
      String password}) async {
    bool success = false;
    switch (provider) {
      case AuthenticationProviderEnum.google:
        success = await _authProvider.signInGoogle();
        break;
      default:
        break;
    }
    if (success) {
      TokenDetailsModel tokenDetailsModel = await getTokenDetails();
      _persistToken(tokenDetailsModel?.token);
    }
    return success;
  }

  @override
  Future<UserModel> getCurrentUser() async {
    FirebaseUser currentUser = await _authProvider.getCurrentUser();

    if (currentUser == null) return null;

    return UserModel(
        displayName: currentUser.displayName,
        email: currentUser?.email,
        photoUrl: currentUser?.photoUrl,
        phoneNumber: currentUser?.phoneNumber);
  }

  @override
  Future<TokenDetailsModel> getTokenDetails() async {
    IdTokenResult token = await _authProvider.getToken();

    if (token == null) return null;

    return TokenDetailsModel(
        token: token.token,
        authTime: token?.authTime,
        expirationTime: token?.expirationTime,
        issuedAtTime: token?.issuedAtTime,
        claims: token?.claims,
        signInProvider: token?.signInProvider);
  }

  @override
  Future<String> getToken() async {
    return await _storage.read(key: _storageTokenKey);
  }

  @override
  Future<bool> signOut() async {
    try {
      bool success = await _authProvider.signOut();
      await _deleteToken();
      return success;
    } catch (e, callstack) {
      throw Exception('signOut error: $e, callstack: $callstack');
    }
  }
}
