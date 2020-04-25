import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<bool> signInAnonymously() async {
    try {
      final AuthResult anonymousUser = await _auth.signInAnonymously();
      final FirebaseUser user = anonymousUser.user;

      assert(user.isAnonymous);

      return user.isAnonymous;
    } catch (error) {
      throw AuthException(error.code, error.message);
    }
  }

  Future<bool> signInGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;

      assert(user.email != null);
      assert(user.displayName != null);
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final IdTokenResult token = await user.getIdToken();
      final bool success = user.email != null &&
          user.displayName != null &&
          !user.isAnonymous &&
          token != null;

      return success;
    } catch (error) {
      throw AuthException(error.code, error.message);
    }
  }

  Future<IdTokenResult> getToken() async {
    final FirebaseUser currentUser = await getCurrentUser();
    final IdTokenResult idToken = await currentUser?.getIdToken();

    return idToken;
  }

  Future<FirebaseUser> getCurrentUser() async {
    final FirebaseUser currentUser = await _auth.currentUser();
    return currentUser;
  }

  Future<bool> signOut() async {
    await _auth.signOut();
    final FirebaseUser currentUser = await _auth.currentUser();
    return currentUser == null;
  }
}
