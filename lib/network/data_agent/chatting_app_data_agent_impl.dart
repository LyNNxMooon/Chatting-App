import 'package:chatting_app/data/model/chatting_app_hive_model.dart';
import 'package:chatting_app/data/vos/chatted_user_vo.dart';
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

  //Authentication and Creating users Collection

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

  //Displaying Added Friends List on Contacts (Home Page)

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

  //Get Current user Profile

  @override
  Future<UserVO> getUserByID(String uid) async {
    return _firebaseFirestore.collection('users').doc(uid).get().then((value) {
      final rawData = value.data();
      return UserVO.fromJson(Map<String, dynamic>.from(rawData as Map));
    });
  }

  // Chat Services

  @override
  Future<void> sendMessages(String receiverID, String message,
      String receiverName, String receiverProfile) async {
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

    //Add Message and receiver to Chat Room

    await _firebaseFirestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .add(newMessage.toJson());

    await _firebaseFirestore
        .collection('users')
        .doc(currentUserID)
        .collection('chats')
        .doc(receiverID)
        .set({
      'name': receiverName,
      'chatted_user_uid': receiverID,
      'last_sender_uid': currentUserID,
      'profile_url': receiverProfile,
      'last_message': message,
      'date_time': "${DateTime.now()}",
    }, SetOptions(merge: true));

    await _firebaseFirestore
        .collection('users')
        .doc(receiverID)
        .collection('chats')
        .doc(currentUserID)
        .set({
      'name': _chattingAppHiveModel.getCurrentUserVO?.name,
      'chatted_user_uid': currentUserID,
      'last_sender_uid': currentUserID,
      'profile_url': _chattingAppHiveModel.getCurrentUserVO?.profileURL,
      'last_message': message,
      'date_time': "${DateTime.now()}",
    }, SetOptions(merge: true));
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

  //Adding users to friend List

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

  //Displaying Chatted Friend List

  @override
  Stream<List<ChattedUserVO>?> getChatListStream() => _firebaseFirestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('chats')
          .orderBy('date_time', descending: true)
          .snapshots()
          .map((event) {
        return event.docs.map((e) {
          return ChattedUserVO.fromJson(e.data());
        }).toList();
      });

  //Add user again with Updated profile pic

  @override
  Future addUserWithUpdatedProfile(UserVO user, String profileURL) =>
      _firebaseFirestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .set({
        'email': user.email,
        'name': user.name,
        'profile_url': profileURL,
        'uid': _firebaseAuth.currentUser!.uid
      }, SetOptions(merge: true));
}
