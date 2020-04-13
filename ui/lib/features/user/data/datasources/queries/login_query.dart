class LoginQuery {
  String login() {
    return """ 
      mutation Authenticate(\$usename: String!, \$password: String!) {
        authenticate(username: \$username, password: \$password) {
          token
        }
      }
    """;
  }
}
