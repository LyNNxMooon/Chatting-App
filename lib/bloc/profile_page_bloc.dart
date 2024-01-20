import 'dart:io';

import 'package:chatting_app/bloc/base_bloc.dart';

import 'package:chatting_app/data/model/chatting_app_model.dart';
import 'package:chatting_app/data/vos/user_vo.dart';
import 'package:chatting_app/utils/enums.dart';
import 'package:chatting_app/utils/file_upload_to_firebase_storage_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePageBloc extends BaseBloc {
  UserVO? user;
  File? _pickedFile;

  UserVO? get getUser => user;

  File? get getPickedFile => _pickedFile;

  set setPickedFile(File? file) {
    _pickedFile = file;
    notifyListeners();
  }

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

  Future addUserWithUpdatedProfile() async {
    final String profileURL = await _uploadFileToFirebaseStorage();

    return _chattingAppModel.addUserWithUpdatedProfile(getUser!, profileURL);
  }

  Future _uploadFileToFirebaseStorage() {
    if (_pickedFile == null) {
      return Future.error("Please pick a picture to upload");
    }
    return FileUploadToFirebaseStorageUtils.uploadToFirebaseStorage(
        _pickedFile!, 'image', 'image/jpg');
  }
}
