import 'package:chatting_app/data/model/chatting_app_hive_model.dart';
import 'package:chatting_app/data/vos/message_vo.dart';
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

  final ChattingAppHiveModel _chattingAppHiveModel = ChattingAppHiveModel();

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
      String email, String password, String name, String profileURL) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      _firebaseFirestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'name': name,
        'profile_url': profileURL
      }, SetOptions(merge: true));

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  @override
  Stream<List<UserVO>?> getUserListStream() => _firebaseFirestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('friends')
          .snapshots()
          .map((event) {
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

  //Chat services

  @override
  Future<void> sendMessages(String receiverID, String message) async {
    final String currentUserID = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timeStamp = Timestamp.now();

    MessageVO newMessage = MessageVO(
        senderID: currentUserID,
        senderEmail: currentUserEmail,
        receiverID: receiverID,
        message: message,
        timeStamp: timeStamp);

    //Chat Room

    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoomID = ids.join("_");

    //Add Message to Chat Room

    await _firebaseFirestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .add(newMessage.toJson());
  }

  @override
  Stream<QuerySnapshot> getMessages(String userID, String otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join("_");

    return _firebaseFirestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy('time_stamp', descending: true)
        .snapshots();
  }

  //End of Chat services

  @override
  Future addFriendToCollection(UserVO otherUser) => _firebaseFirestore
      .collection('users')
      .doc(_firebaseAuth.currentUser!.uid)
      .collection('friends')
      .doc(otherUser.uid)
      .set(otherUser.toJson());

  @override
  Future addCurrentUserToOtherUserCollection(UserVO otherUser) =>
      _firebaseFirestore
          .collection('users')
          .doc(otherUser.uid)
          .collection('friends')
          .doc(_firebaseAuth.currentUser!.uid)
          .set(_chattingAppHiveModel.getCurrentUserVO!.toJson());
}
