import 'package:chatting_app/data/vos/user_vo.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ChattingAppDataAgent {
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password);

  Future<void> singOut();

  Future<UserCredential> singUpUser(String email, String password, String name);

  Stream<List<UserVO>?> getUserListStream();
}
