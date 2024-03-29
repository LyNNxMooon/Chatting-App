import 'package:chatting_app/data/vos/chatted_user_vo.dart';
import 'package:chatting_app/data/vos/user_vo.dart';
import 'package:chatting_app/network/data_agent/chatting_app_data_agent.dart';
import 'package:chatting_app/network/data_agent/chatting_app_data_agent_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChattingAppModel {
  ChattingAppModel._();
  static final ChattingAppModel _singleton = ChattingAppModel._();
  factory ChattingAppModel() => _singleton;

  final ChattingAppDataAgent _chattingAppDataAgent = ChattingAppDataAgentImpl();

  Future<UserCredential> signInWithEmailAndPassword(
          String email, String password) =>
      _chattingAppDataAgent.signInWithEmailAndPassword(email, password);

  Future<void> singOut() => _chattingAppDataAgent.singOut();

  Future<UserCredential> singUpUser(
          String email, String password, String name, String profileURL) =>
      _chattingAppDataAgent.singUpUser(email, password, name, profileURL);

  Stream<List<UserVO>?> getUserListStream() =>
      _chattingAppDataAgent.getUserListStream();

  Stream<List<ChattedUserVO>?> getChatListStream() =>
      _chattingAppDataAgent.getChatListStream();

  Future<UserVO> getUserByID(String uid) =>
      _chattingAppDataAgent.getUserByID(uid);

  void addFriendToCollection(UserVO otherUser) =>
      _chattingAppDataAgent.addFriendToCollection(otherUser);

  void addCurrentUserToOtherUserCollection(UserVO otherUser) =>
      _chattingAppDataAgent.addCurrentUserToOtherUserCollection(otherUser);

  Future<void> sendMessages(String receiverID, String message,
          String receiverName, String receiverProfile) =>
      _chattingAppDataAgent.sendMessages(
          receiverID, message, receiverName, receiverProfile);

  Stream<QuerySnapshot> getMessages(String userID, String otherUserID) =>
      _chattingAppDataAgent.getMessages(userID, otherUserID);

  void addUserWithUpdatedProfile(UserVO user, String profileURL) =>
      _chattingAppDataAgent.addUserWithUpdatedProfile(user, profileURL);
}
