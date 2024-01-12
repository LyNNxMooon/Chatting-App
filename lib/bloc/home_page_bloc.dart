import 'package:chatting_app/bloc/base_bloc.dart';
import 'package:chatting_app/constants/strings.dart';
import 'package:chatting_app/data/model/chatting_app_model.dart';
import 'package:chatting_app/data/vos/user_vo.dart';
import 'package:chatting_app/utils/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePageBloc extends BaseBloc {
  List<UserVO>? _userList;

  List<UserVO>? get getUserList => _userList;

  final ChattingAppModel _chattingAppModel = ChattingAppModel();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
        bool isUser = false;
        UserVO? currentUser;
        for (UserVO user in event ?? []) {
          if (_firebaseAuth.currentUser!.email == user.email) {
            currentUser = user;
            isUser = true;
          }
        }
        if (isUser) {
          event?.remove(currentUser);
        }
        _userList = event;
        notifyListeners();
      }
    }, onError: (error) {
      setErrorMessage = error;
      notifyListeners();
    });
  }
}
