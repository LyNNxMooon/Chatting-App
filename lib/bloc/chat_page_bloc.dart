import 'package:chatting_app/bloc/base_bloc.dart';
import 'package:chatting_app/data/model/chatting_app_model.dart';

class ChatPageBloc extends BaseBloc {
  String otherUserID = '';
  String sendingMessage = '';
  String otherUserName = '';
  String otherUserProfile = '';

  set setOtherUserID(String uid) {
    otherUserID = uid;
    notifyListeners();
  }

  set setMessage(String message) {
    sendingMessage = message;
    notifyListeners();
  }

  set setOtherUserName(String name) {
    otherUserName = name;
    notifyListeners();
  }

  set setOtherUserProfile(String profile) {
    otherUserProfile = profile;
    notifyListeners();
  }

  final ChattingAppModel _chattingAppModel = ChattingAppModel();

  Future sendMessages() => _chattingAppModel.sendMessages(
      otherUserID, sendingMessage, otherUserName, otherUserProfile);
}
