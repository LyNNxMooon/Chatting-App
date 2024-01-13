import 'package:chatting_app/data/vos/user_vo.dart';
import 'package:chatting_app/network/data_agent/chatting_app_data_agent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChattingAppDataAgentImpl extends ChattingAppDataAgent {
  ChattingAppDataAgentImpl._();
  static final ChattingAppDataAgentImpl _singleton =
      ChattingAppDataAgentImpl._();
  factory ChattingAppDataAgentImpl() => _singleton;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

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
  Future<UserCredential> singUpUser(
      String email, String password, String name) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      _firebaseFirestore.collection('users').doc(userCredential.user!.uid).set(
          {'uid': userCredential.user!.uid, 'email': email, 'name': name},
          SetOptions(merge: true));

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  @override
  Stream<List<UserVO>?> getUserListStream() =>
      _firebaseFirestore.collection('users').snapshots().map((event) {
        return event.docs.map((e) {
          return UserVO.fromJson(e.data());
        }).toList();
      });

  @override
  Future<UserVO> getUserByID(String uid) async {
    return _firebaseFirestore.collection('users').doc(uid).get().then((value) {
      final rawData = value.data();
      return UserVO.fromJson(Map<String, dynamic>.from(rawData as Map));
    });
  }
}
