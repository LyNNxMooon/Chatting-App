import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatting_app/bloc/scanner_page_bloc.dart';
import 'package:chatting_app/constants/colors.dart';
import 'package:chatting_app/constants/dimension.dart';
import 'package:chatting_app/data/vos/user_vo.dart';
import 'package:chatting_app/utils/extension.dart';
import 'package:chatting_app/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({super.key, required this.user});

  final UserVO user;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ScannerPageBloc>(
      create: (context) => ScannerPageBloc(),
      child: AlertDialog(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: kSP20x),
              width: kProfilePageAvatarSquareLength,
              height: kProfilePageAvatarSquareLength,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(kSP40x)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(kSP40x),
                child: CachedNetworkImage(
                  imageUrl: user.profileURL,
                  placeholder: (context, url) => const LoadingWidget(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(CupertinoIcons.person),
                  Gap(kSP10x),
                  Text(
                    user.name,
                    style: TextStyle(
                        fontSize: kFontSize16x, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Gap(kSP10x),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(CupertinoIcons.mail),
                  Gap(kSP10x),
                  Text(
                    user.email,
                    style: TextStyle(
                        fontSize: kFontSize16x, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Gap(kSP35x),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Builder(builder: (buttonContext) {
                  final bloc = buttonContext.read<ScannerPageBloc>();
                  return ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => const LoadingWidget());
                      bloc.setOtherUserVO = user;
                      bloc.addFriendToCollection();
                      bloc.addCurrentUserToOtherUserCollection().then((value) {
                        context.navigateBack();
                        context.navigateBack();
                      });
                    },
                    child: Text(
                      "Add Friend",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(kSecondaryColor)),
                  );
                }),
                Gap(kSP10x),
                ElevatedButton(
                  onPressed: () {
                    context.navigateBack();
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: kPrimaryColor),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(kCancelColor)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
