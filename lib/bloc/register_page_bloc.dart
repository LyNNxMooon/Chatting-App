import 'package:chatting_app/bloc/base_bloc.dart';
import 'package:chatting_app/data/model/chatting_app_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPageBloc extends BaseBloc {
  String userEmail = '';
  String userPassword = '';
  String userName = '';

  set setUserEmail(String email) {
    userEmail = email;
    notifyListeners();
  }

  set setUserPassword(String password) {
    userPassword = password;
    notifyListeners();
  }

  set setUserName(String name) {
    userName = name;
    notifyListeners();
  }

  final ChattingAppModel _chattingAppModel = ChattingAppModel();

  Future<UserCredential> singUpUser() =>
      _chattingAppModel.singUpUser(userEmail, userPassword, userName);
}
