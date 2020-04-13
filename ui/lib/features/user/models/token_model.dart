import 'package:meta/meta.dart';

class TokenModel {
  final String token;
  final DateTime expirationTime;
  final DateTime authTime;
  final DateTime issuedAtTime;
  final String signInProvider;

  final Map<dynamic, dynamic> claims;

  TokenModel(
      {@required this.token,
      this.expirationTime,
      this.authTime,
      this.issuedAtTime,
      this.signInProvider,
      this.claims});
}
