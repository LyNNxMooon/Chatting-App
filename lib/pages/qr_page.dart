import 'package:chatting_app/constants/colors.dart';
import 'package:chatting_app/constants/dimension.dart';
import 'package:chatting_app/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRPage extends StatelessWidget {
  const QRPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        floatingActionButton: FloatingActionButton(
          backgroundColor: kSecondaryColor,
          onPressed: () {},
          child: Icon(Icons.qr_code_scanner, color: kComponentColor),
        ),
        drawer: DrawerWidget(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 1,
          backgroundColor: kPrimaryColor,
          title: Text(
            "QR",
            style: TextStyle(
                color: kAppBarComponentColor,
                fontWeight: FontWeight.bold,
                fontSize: kFontSize24x),
          ),
          toolbarHeight: kSP70x,
          actions: [
            Builder(builder: (buttonContext) {
              return GestureDetector(
                onTap: () {
                  Scaffold.of(buttonContext).openDrawer();
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: kSP10x),
                  child: Icon(
                    Icons.menu_outlined,
                    color: kAppBarComponentColor,
                  ),
                ),
              );
            }),
          ],
        ),
        body: Center(
            child: QrImageView(
          data: '1234567890',
          version: QrVersions.auto,
          size: kQRCodeSquareLength,
        )),
      ),
    );
  }
}
