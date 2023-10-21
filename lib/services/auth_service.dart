import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static Future<void> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      if (gUser == null) {
        throw FirebaseAuthException(
          code: 'operation-cancelled',
          message: 'Operation has been cancelled',
        );
      }

      final GoogleSignInAuthentication gAuth = await gUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<void> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.status == LoginStatus.cancelled) {
        throw FirebaseAuthException(
          code: 'operation-cancelled',
          message: 'Operation has been cancelled',
        );
      }

      final OAuthCredential credential = FacebookAuthProvider.credential(
        loginResult.accessToken!.token,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<void> signUp(String email, String password, String userName) async {
    try {
      final firebaseAuth = FirebaseAuth.instance;
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await credential.user?.updateDisplayName(userName);
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<void> forgotPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      return Future.error(e);
    }
  }

  static User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  static String parseError(FirebaseAuthException error) {
    debugPrint(error.code);

    return switch (error.code) {
      'user-not-found' => 'error.user_not_found'.tr(),
      'INVALID_LOGIN_CREDENTIALS' => 'error.wrong_password'.tr(),
      'wrong-password' => 'error.wrong_password'.tr(),
      'user-disabled' => 'error.user_disabled'.tr(),
      'too-many-requests' => 'error.user_disabled'.tr(),
      'account-exists-with-different-credential' => 'error.email_already_exists'.tr(),
      'operation-cancelled' => 'error.cancelled'.tr(),
      _ => error.message!
    };
  }
}
