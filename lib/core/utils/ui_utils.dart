import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UIUtils {
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => PopScope(
        canPop: false,
        child: CupertinoAlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Center(child: CircularProgressIndicator())],
          ),
        ),
      ),
    );
  }

  static void hideLoadingDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        content: Text(
          message,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
    );
  }
}
