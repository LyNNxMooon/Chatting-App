import 'package:chatting_app/bloc/base_bloc.dart';
import 'package:chatting_app/constants/strings.dart';
import 'package:chatting_app/data/model/chatting_app_model.dart';
import 'package:chatting_app/data/vos/chatted_user_vo.dart';
import 'package:chatting_app/utils/enums.dart';

class ChatListPageBloc extends BaseBloc {
  List<ChattedUserVO>? _chatList;

  List<ChattedUserVO>? get getChatList => _chatList;

  final ChattingAppModel _chattingAppModel = ChattingAppModel();

  ChatListPageBloc() {
    setLoadingState = LoadingState.loading;
    notifyListeners();
    _chattingAppModel.getChatListStream().listen((event) {
      if (event?.isEmpty ?? true) {
        setLoadingState = LoadingState.error;
        setErrorMessage = kChatListErrorText;
        notifyListeners();
      } else {
        setLoadingState = LoadingState.complete;
        _chatList = event;
        notifyListeners();
      }
    }, onError: (error) {
      setErrorMessage = error;
      notifyListeners();
    });
  }
}
