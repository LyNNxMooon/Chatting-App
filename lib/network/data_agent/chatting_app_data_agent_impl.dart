import 'package:chatting_app/network/data_agent/chatting_app_data_agent.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChattingAppDataAgentImpl extends ChattingAppDataAgent {
  ChattingAppDataAgentImpl._();
  static final ChattingAppDataAgentImpl _singleton =
      ChattingAppDataAgentImpl._();
  factory ChattingAppDataAgentImpl() => _singleton;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  @override
  Future<void> singOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<UserCredential> singUpUser(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
}
