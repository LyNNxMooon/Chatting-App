import 'package:chatting_app/data/vos/user_vo.dart';
import 'package:chatting_app/persistent/hive_constant.dart';
import 'package:hive/hive.dart';

class ChattingAppDAO {
  ChattingAppDAO._();
  static final ChattingAppDAO _singleton = ChattingAppDAO._();

  factory ChattingAppDAO() => _singleton;

  Box<UserVO> getUserVOBox() => Hive.box<UserVO>(kHiveCurrentUserVOBox);

  //save data

  void savingUserVO(UserVO user) {
    getUserVOBox().put(KHiveUserVOTypeID, user);
  }

  //get data

  UserVO? get getCurrentUserVO => getUserVOBox().get(KHiveUserVOTypeID);

  //remove data

  void removeCurrentUserVO() => getUserVOBox().delete(KHiveUserVOTypeID);
}
