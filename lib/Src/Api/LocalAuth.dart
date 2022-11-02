import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

class LocalAuthApi {
  static final _auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics || await _auth.isDeviceSupported();
    } on PlatformException catch (e) {
      return false;
    }
  }

  static Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) return false;

    try {
      return await _auth.authenticate(
        authMessages: const [
          AndroidAuthMessages(
            signInTitle: 'Sign In',
            cancelButton: 'No Thanks'
          ),
          IOSAuthMessages(
            cancelButton: 'No Thanks',
          )
        ],
        localizedReason: 'Use Face ID to Authenticate',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true
        )
      );
    } on PlatformException catch (e) {
      return false;
    }
  }

  /*
    static Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) return false;

    try {
      return await _auth.authenticate(
        localizedReason: 'Scan Face to Authenticate',
        options: const AuthenticationOptions(biometricOnly: true)
      );
    } on PlatformException catch (e) {
      return false;
    }
  }
   */
}