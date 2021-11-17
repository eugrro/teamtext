// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
//import 'package:klip/currentUser.dart' as currentUser;
import 'constants.dart' as Constants;
import 'package:qr_flutter/qr_flutter.dart';

class QRPreview extends StatefulWidget {
  const QRPreview({Key? key}) : super(key: key);

  @override
  _QRPreviewState createState() => _QRPreviewState();
}

class _QRPreviewState extends State<QRPreview> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        body: Container(
          color: Constants.theme.background,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              QrImage(
                data: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
                version: QrVersions.auto,
                size: MediaQuery.of(context).size.width,
                gapless: true,
              ),
              Text(
                "Double tap on the screen to exit",
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
