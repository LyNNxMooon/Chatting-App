import 'package:chatting_app/data/vos/user_vo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ChattingAppDataAgent {
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password);

  Future<void> singOut();

  Future<UserCredential> singUpUser(
      String email, String password, String name, String profileURL);

  Stream<List<UserVO>?> getUserListStream();

  Future<UserVO> getUserByID(String uid);

  //Chat Services

  Future<void> sendMessages(String receiverID, String message);

  Stream<QuerySnapshot> getMessages(String userID, String otherUserID);
}
