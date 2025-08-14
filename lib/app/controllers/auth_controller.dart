import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  String? uid; // cek kondisi auth atau tidak berdasarkan user id (uid)

  late FirebaseAuth auth;

  Future<Map<String, dynamic>> login(String email, String pass) async {
    try {
      return {
        'error': false,
        'messages':'Berhasil Login'
      };
    } on FirebaseAuthException catch (e){
      return {
        'error': false,
        'messages':'${e.message}'
      };
    }
    catch (e) {
      return {
        'error': true,
        'messages':'Tidak dapat Login'
      };
    }
  }

  @override
  void onInit() {

    auth = FirebaseAuth.instance;

    auth.authStateChanges().listen((event) {
      uid = event?.uid;
    });
    super.onInit();
  }
}
