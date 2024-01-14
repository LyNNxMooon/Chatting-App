import 'dart:io';

import 'package:chatting_app/bloc/base_bloc.dart';
import 'package:chatting_app/data/model/chatting_app_model.dart';
import 'package:chatting_app/utils/file_upload_to_firebase_storage_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPageBloc extends BaseBloc {
  File? _pickedFile;
  String userEmail = '';
  String userPassword = '';
  String userName = '';

  File? get getPickedFile => _pickedFile;

  set setPickedFile(File? file) {
    _pickedFile = file;
    notifyListeners();
  }

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

  Future<UserCredential> singUpUser() async {
    String profileURL = await _uploadFileToFirebaseStorage();
    return _chattingAppModel.singUpUser(
        userEmail, userPassword, userName, profileURL);
  }

  Future _uploadFileToFirebaseStorage() {
    if (_pickedFile == null) {
      return Future.error("Please pick a picture to upload");
    }
    return FileUploadToFirebaseStorageUtils.uploadToFirebaseStorage(
        _pickedFile!, 'image', 'image/jpg');
  }
}
