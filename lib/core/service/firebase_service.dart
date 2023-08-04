import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/user_model.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final StreamController<User> _authStateController =
      StreamController<User>.broadcast();
  FirebaseService() {
    _auth.authStateChanges().listen((User newUser) {
      _authStateController.add(newUser);
    });
  }
  // Kullanıcı oturum açmış mı kontrolü
  Stream<User> authStateChanges() {
    return _authStateController.stream;
  }

  //Giriş
  Future<User> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'Kullanıcı bulunamadı.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Yanlış şifre.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Geçersiz e-posta adresi.';
      } else if (e.code == 'network-request-failed') {
        errorMessage = 'İnternet bağlantınızda bir sorun oluştu.';
      } else {
        errorMessage = 'Giriş yapılamadı. Hata kodu: ${e.code}';
      }
      throw errorMessage;
    } catch (e) {
      throw Exception('Giriş yapılamadı: $e');
    }
  }

  //Kayıt
  Future<User> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'email-already-in-use') {
        errorMessage = 'Bu e-posta adresi zaten kullanılıyor.';
      } else if (e.code == 'weak-password') {
        errorMessage = 'Zayıf bir şifre. Daha güçlü bir şifre seçin.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Geçersiz e-posta adresi.';
      } else if (e.code == 'network-request-failed') {
        errorMessage = 'İnternet bağlantınızda bir sorun oluştu.';
      } else {
        errorMessage = 'Kayıt oluşturulamadı. Hata kodu: ${e.code}';
      }
      throw errorMessage;
    } catch (e) {
      throw Exception('Kayıt oluşturulamadı: $e');
    }
  }

  //Çıkış
  Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }

  //Kullanıcıyı FireStore'a kaydetme
  Future<void> addUser(UserModel user) async {
    try {
      await usersCollection.doc(user.userId).set(user.toJson());
    } catch (e) {
      throw Exception('Kullanıcı eklenirken bir hata oluştu: $e');
    }
  }

  //E-posta Doğrulama
  Future<String> sendVerificationEmail() async {
    if (_auth.currentUser != null && !_auth.currentUser.emailVerified) {
      try {
        await _auth.currentUser.sendEmailVerification();
        return "Doğrulama e-postası gönderildi. Lütfen e-postanızı kontrol edin.";
      } catch (e) {
        throw Exception(
            "Doğrulama e-postası gönderilirken bir hata oluştu: $e");
      }
    } else {
      return "Kullanıcı zaten oturum açmış veya e-postası doğrulanmış.";
    }
  }

  //Parola Sıfırlama
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        throw 'Geçersiz e-posta adresi, lütfen doğru bir e-posta adresi girin.';
      } else if (e.code == 'user-not-found') {
        throw 'Bu e-posta adresine sahip bir kullanıcı bulunamadı.';
      } else {
        throw 'Parolamı sıfırlama e-postası gönderilemedi: $e';
      }
    } catch (e) {
      throw 'Bir hata oluştu: $e';
    }
  }

  Future<User> getCurrentUser() async {
    try {
      _auth.currentUser.reload();
      User user = _auth.currentUser;
      if (user != null) {
        return user;
      } else {
        print("Kullanıcı oturum açmamış.");
        return null;
      }
    } catch (e) {
      print("Kullanıcı alınırken bir hata oluştu: $e");
      return null;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      throw "Google ile giriş yapılamadı, lütfen tekrar deneyiniz.";
    }
  }

  Future<UserCredential> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken.token);

      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } catch (e) {
      throw "Facebook ile giriş yapılamadı, lütfen tekrar deneyiniz";
    }
  }

  final StreamController<String> _verificationIdController =
      StreamController<String>();
  Stream<String> get verificationIdStream => _verificationIdController.stream;
  void dispose() {
    _verificationIdController.close();
  }

  Future<void> sendCodeToPhoneNumber(String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          codeSent: (String verificationId, int resendToken) async {
            _verificationIdController.add(verificationId);
          },
          timeout: const Duration(minutes: 5),
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await FirebaseAuth.instance
                .signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (FirebaseAuthException error) {
            _verificationIdController.add(error.code);
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateEmail(String newEmail) async {
    try {
      User user = _auth.currentUser;
      if (user != null) {
        await user.updateEmail(newEmail);
        _auth.currentUser.reload();
        await usersCollection.doc(user.uid).update({"email": newEmail});
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        throw "Geçersiz e-posta adresi.";
      }
      print('E-posta güncellenirken hata oluştu: $e');
    }
  }

  Future<void> updateName(String displayName) async {
    try {
      User user = _auth.currentUser;
      List<String> nameList = displayName.split(" ");
      print(nameList);
      if (user != null) {
        await user.updateDisplayName(displayName);
        String name = "";
        String lastName = "";
        for (int i = 0; i < nameList.length; i++) {
          if (i < nameList.length - 1) {
            name += " ${nameList[i]}";
          } else {
            lastName = nameList[i];
          }
        }
        await usersCollection
            .doc(user.uid)
            .update({"name": name, "lastName": lastName});
      }
    } on FirebaseAuthException catch (e) {
      throw ('Kullanıcı adı güncellenirken bir hata oluştu: $e');
    }
  }
}
