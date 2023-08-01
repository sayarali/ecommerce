
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Sign In
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

  //Sign Up
  Future<User> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
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

  //Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
  }


  // Kullanıcı oturum açmış mı kontrolü
  Stream<User> get authStateChanges => _auth.authStateChanges();


}