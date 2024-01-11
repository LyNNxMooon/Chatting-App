import 'package:chatting_app/bloc/base_bloc.dart';
import 'package:chatting_app/constants/strings.dart';
import 'package:chatting_app/data/model/chatting_app_model.dart';
import 'package:chatting_app/data/vos/user_vo.dart';
import 'package:chatting_app/utils/enums.dart';

class HomePageBloc extends BaseBloc {
  List<UserVO>? _userList;

  List<UserVO>? get getUserList => _userList;

  final ChattingAppModel _chattingAppModel = ChattingAppModel();

  Future<void> singOut() => _chattingAppModel.singOut();

  HomePageBloc() {
    setLoadingState = LoadingState.loading;
    notifyListeners();
    _chattingAppModel.getUserListStream().listen((event) {
      if (event?.isEmpty ?? true) {
        setLoadingState = LoadingState.error;
        setErrorMessage = kUserListErrorText;
        notifyListeners();
      } else {
        setLoadingState = LoadingState.complete;
        _userList = event;
        notifyListeners();
      }
    }, onError: (error) {
      setErrorMessage = error;
      notifyListeners();
    });
  }
}
