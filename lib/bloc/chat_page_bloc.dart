import 'package:chatting_app/bloc/base_bloc.dart';
import 'package:chatting_app/data/model/chatting_app_model.dart';

class ChatPageBloc extends BaseBloc {
  String otherUserID = '';
  String sendingMessage = '';

  set setOtherUserID(String uid) {
    otherUserID = uid;
    notifyListeners();
  }

  set setMessage(String message) {
    sendingMessage = message;
    notifyListeners();
  }

  final ChattingAppModel _chattingAppModel = ChattingAppModel();

  Future sendMessages() =>
      _chattingAppModel.sendMessages(otherUserID, sendingMessage);
}
