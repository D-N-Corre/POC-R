import 'package:meta/meta.dart';

class UserModel {
  final displayName;
  final email;
  final photoUrl;
  final phoneNumber;

  UserModel(
      {@required this.displayName,
      this.email,
      this.photoUrl,
      this.phoneNumber});
}
