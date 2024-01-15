import 'package:chatting_app/bloc/base_bloc.dart';
import 'package:chatting_app/data/vos/user_vo.dart';
import 'package:chatting_app/network/data_agent/chatting_app_data_agent.dart';
import 'package:chatting_app/network/data_agent/chatting_app_data_agent_impl.dart';

class ScannerPageBloc extends BaseBloc {
  UserVO? otherUser;

  set setOtherUserVO(UserVO otherUserVO) {
    otherUser = otherUserVO;
    notifyListeners();
  }

  final ChattingAppDataAgent _chattingAppDataAgent = ChattingAppDataAgentImpl();

  Future addFriendToCollection() =>
      _chattingAppDataAgent.addFriendToCollection(otherUser!);

  Future addCurrentUserToOtherUserCollection() =>
      _chattingAppDataAgent.addCurrentUserToOtherUserCollection(otherUser!);
}
