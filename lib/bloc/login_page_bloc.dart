import 'package:chatting_app/bloc/base_bloc.dart';
import 'package:chatting_app/data/model/chatting_app_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPageBloc extends BaseBloc {
  String userEmail = '';
  String userPassword = '';

  set setUserEmail(String email) {
    userEmail = email;
    notifyListeners();
  }

  set setUserPassword(String password) {
    userPassword = password;
    notifyListeners();
  }

  final ChattingAppModel _chattingAppModel = ChattingAppModel();

  Future<UserCredential> signInWithEmailAndPassword() =>
      _chattingAppModel.signInWithEmailAndPassword(userEmail, userPassword);
}
