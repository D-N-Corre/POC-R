import "package:flutter/material.dart";
import "package:graphql_flutter/graphql_flutter.dart";

class GraphqlConfiguration {
  static HttpLink httpLink = HttpLink(
    uri: "http://10.0.2.2:3000/graphql",
  );

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
      link: httpLink,
    );
  }
}
