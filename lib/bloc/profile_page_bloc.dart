import 'package:chatting_app/bloc/base_bloc.dart';
import 'package:chatting_app/data/model/chatting_app_model.dart';
import 'package:chatting_app/data/vos/user_vo.dart';
import 'package:chatting_app/utils/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePageBloc extends BaseBloc {
  UserVO? user;

  UserVO? get getUser => user;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final ChattingAppModel _chattingAppModel = ChattingAppModel();

  Future<void> singOut() => _chattingAppModel.singOut();

  ProfilePageBloc() {
    setLoadingState = LoadingState.loading;
    notifyListeners();

    _chattingAppModel
        .getUserByID(_firebaseAuth.currentUser?.uid ?? '')
        .then((value) {
      setLoadingState = LoadingState.complete;
      user = value;
      notifyListeners();
    }).catchError((error) {
      setLoadingState = LoadingState.error;
      setErrorMessage = error.toString();
      notifyListeners();
    });
  }
}
