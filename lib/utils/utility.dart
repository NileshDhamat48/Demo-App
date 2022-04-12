import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utility {
  static String? showToast({required String msg}) {
    Fluttertoast.showToast(msg: msg);
    return null;
  }

  static Widget progress(BuildContext context, {double? width, double? height}) {
    return Container(
      color: Colors.transparent,
      alignment: Alignment.center,
      child: Container(
        color: const Color(0xff34c2a8),
        width: width ?? MediaQuery.of(context).size.width / 4,
        child: const LinearProgressIndicator(
          color: Colors.black,
        ),
      ),
    );
  }
}