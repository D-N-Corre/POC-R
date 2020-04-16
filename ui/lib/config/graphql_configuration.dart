import "package:flutter/material.dart";
import "package:graphql_flutter/graphql_flutter.dart";
import 'package:poc_r/features/user/data/repositories/authentication_repository.dart';
import 'package:poc_r/features/user/data/repositories/interfaces/authentication_repository_interface.dart';

class GraphqlConfiguration {
  final AuthenticationRepositoryInterface authRepository =
      AuthenticationRepository();

  static HttpLink httpLink = HttpLink(
    uri: "http://10.0.2.2:3000/graphql",
  );

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
    ),
  );

  Future<GraphQLClient> clientToQuery() async {
    Link link = httpLink;

    String authToken = await authRepository.getToken();
    if (authToken != null && authToken.isNotEmpty) {
      AuthLink _authLink = AuthLink(
        getToken: () async => "Bearer $authToken",
      );
      link = _authLink.concat(httpLink);
    }

    return GraphQLClient(
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
      link: link,
    );
  }
}
