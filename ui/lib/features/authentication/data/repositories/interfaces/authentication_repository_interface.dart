import 'package:meta/meta.dart';

import './../../../constants/authentication_provider_enum.dart';
import './../../../models/token_details_model.dart';

class AuthenticationRepositoryInterface {
  Future<bool> authenticate(
      {@required AuthenticationProviderEnum provider,
      String username,
      String password}) {
    throw UnimplementedError('authenticate() is not implemented');
  }

  Future<TokenDetailsModel> getTokenDetails() {
    throw UnimplementedError('getToken() is not implemented');
  }

  Future<String> getToken() {
    throw UnimplementedError('getToken() is not implemented');
  }

  Future<bool> signOut() {
    throw UnimplementedError('signOut() is not implemented');
  }
}
