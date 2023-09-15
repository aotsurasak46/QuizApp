import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? _googleSignInAccount =
          await _googleSignIn.signIn();
      if (_googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await _googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);

        final UserCredential authResult =
            await _auth.signInWithCredential(authCredential);
        final User? user = authResult.user;
        if (user != null && user.email!.endsWith("@kmitl.ac.th")) {
          return user;
        } else {
          await _auth.signOut();
          await _googleSignIn.signOut();
          return null;
        }
      }
    } on FirebaseException catch (e) {
      print(e.message);
      throw e;
    }
  }


  signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
