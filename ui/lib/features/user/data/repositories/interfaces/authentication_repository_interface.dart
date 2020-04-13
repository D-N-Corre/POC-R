import 'package:meta/meta.dart';
import 'package:poc_r/constants/authentication_provide_enum.dart';
import 'package:poc_r/features/user/models/token_model.dart';
import 'package:poc_r/features/user/models/user_model.dart';

class AuthenticationRepositoryInterface {
  Future<bool> authenticate(
      {@required AuthenticationProviderEnum provider,
      String username,
      String password}) {
    throw UnimplementedError('authenticate() is not implemented');
  }

  Future<TokenModel> getToken() {
    throw UnimplementedError('getToken() is not implemented');
  }

  Future<bool> signOut() {
    throw UnimplementedError('signOut() is not implemented');
  }

  Future<UserModel> getCurrentUser() {
    throw UnimplementedError('getCurrentUser() is not implemented');
  }
}
