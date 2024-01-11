import 'package:chatting_app/data/vos/user_vo.dart';
import 'package:chatting_app/network/data_agent/chatting_app_data_agent.dart';
import 'package:chatting_app/network/data_agent/chatting_app_data_agent_impl.dart';
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

  Future<UserCredential> singUpUser(String email, String password) =>
      _chattingAppDataAgent.singUpUser(email, password);

  Stream<List<UserVO>?> getUserListStream() =>
      _chattingAppDataAgent.getUserListStream();
}
