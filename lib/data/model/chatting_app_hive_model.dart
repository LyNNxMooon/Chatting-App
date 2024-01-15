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

  //get data

  UserVO? get getCurrentUserVO => _chattingAppDAO.getCurrentUserVO;

  //remove data

  void removeCurrentUserVO() => _chattingAppDAO.removeCurrentUserVO();
}
