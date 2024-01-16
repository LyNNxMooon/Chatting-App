import 'package:chatting_app/bloc/base_bloc.dart';
import 'package:chatting_app/data/model/chatting_app_hive_model.dart';
import 'package:chatting_app/data/model/chatting_app_model.dart';

import 'package:chatting_app/utils/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';

class QRPageBloc extends BaseBloc {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final ChattingAppModel _chattingAppModel = ChattingAppModel();
  final ChattingAppHiveModel _chattingAppHiveModel = ChattingAppHiveModel();

  QRPageBloc() {
    setLoadingState = LoadingState.loading;
    notifyListeners();

    _chattingAppModel
        .getUserByID(_firebaseAuth.currentUser?.uid ?? '')
        .then((value) {
      setLoadingState = LoadingState.complete;
      _chattingAppHiveModel.saveCurrentUserVO(value);
      notifyListeners();
    }).catchError((error) {
      setLoadingState = LoadingState.error;
      setErrorMessage = error.toString();
      notifyListeners();
    });
  }
}
