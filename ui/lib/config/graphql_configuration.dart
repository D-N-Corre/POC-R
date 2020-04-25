import "package:flutter/material.dart";
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:graphql_flutter/graphql_flutter.dart";

class GraphqlConfiguration {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  static HttpLink httpLink = HttpLink(uri: "http://10.0.2.2:3000/graphql");

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
    ),
  );

  Future<GraphQLClient> clientToQuery() async {
    Link link = httpLink;

    String authToken = await _storage.read(key: 'token');
    if (authToken != null && authToken.isNotEmpty) {
      AuthLink _authLink = AuthLink(getToken: () async => "Bearer $authToken");
      link = _authLink.concat(httpLink);
    }

    return GraphQLClient(
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
      link: link,
    );
  }
}
