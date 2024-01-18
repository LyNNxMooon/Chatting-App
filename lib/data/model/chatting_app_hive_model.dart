import 'package:chatting_app/data/vos/user_vo.dart';
import 'package:chatting_app/persistent/dao/chatting_app_hive_dao.dart';

class ChattingAppHiveModel {
  ChattingAppHiveModel._();
  static final ChattingAppHiveModel _singleton = ChattingAppHiveModel._();
  factory ChattingAppHiveModel() => _singleton;

  final ChattingAppDAO _chattingAppDAO = ChattingAppDAO();

  //save data

  void saveCurrentUserVO(UserVO user) {
    _chattingAppDAO.savingUserVO(user);
  }

  void saveThemeTrigger(bool trigger) {
    _chattingAppDAO.saveThemeTrigger(trigger);
  }

  //get data

  UserVO? get getCurrentUserVO => _chattingAppDAO.getCurrentUserVO;
  bool get getThemeTrigger => _chattingAppDAO.getThemeTrigger ?? false;

  //remove data

  void removeCurrentUserVO() => _chattingAppDAO.removeCurrentUserVO();
}
