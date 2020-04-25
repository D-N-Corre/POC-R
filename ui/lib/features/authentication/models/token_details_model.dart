import 'package:meta/meta.dart';

class TokenDetailsModel {
  final String token;
  final DateTime expirationTime;
  final DateTime authTime;
  final DateTime issuedAtTime;
  final String signInProvider;

  final Map<dynamic, dynamic> claims;

  TokenDetailsModel(
      {@required this.token,
      this.expirationTime,
      this.authTime,
      this.issuedAtTime,
      this.signInProvider,
      this.claims});
}
