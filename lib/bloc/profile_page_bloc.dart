import 'package:chatting_app/bloc/base_bloc.dart';
import 'package:chatting_app/data/model/chatting_app_model.dart';

class ProfilePageBloc extends BaseBloc {
  final ChattingAppModel _chattingAppModel = ChattingAppModel();

  Future<void> singOut() => _chattingAppModel.singOut();
}
