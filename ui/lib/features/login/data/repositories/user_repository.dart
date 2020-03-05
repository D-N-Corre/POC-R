import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';
import 'package:poc_r/config/graphql_configuration.dart';
import 'package:poc_r/features/login/data/queries/login_query.dart';

import 'package:http/http.dart' as http;

class UserRepository {
  GraphqlConfiguration graphQLConfiguration = GraphqlConfiguration();
  LoginQuery query = LoginQuery();

  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(query.getTournament()),
        variables: {
          'id': 10,
        },
      ),
    );
    print(result.data);
    http.get('http://10.0.2.2:3000');
    await Future.delayed(Duration(seconds: 1));
    return 'token';
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return false;
  }
}
