import 'package:flutter/material.dart';
import 'package:foodapp/Model/allorders.dart';
import 'package:foodapp/Model/order.dart';
import 'package:foodapp/View/Model/sizeconfig.dart';
import 'package:foodapp/View/screens/homescreen.dart';
import 'package:foodapp/View/screens/loginpage.dart';
import 'package:flutter_share/flutter_share.dart';

class BillDialog extends StatelessWidget {
  const BillDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(SizeConfig.height25))),
      content: const Text("Your Printed Bill Is On Its Way"),
      actions: [
        // TextButton(
        //   child: const Text(
        //     "Cancel",
        //   ),
        //   onPressed: () {
        //     Navigator.of(context).pop(false);
        //   },
        // ),]

        TextButton(
          child: const Text(
            "Okay",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () async {
            // await Share.share('Check out my app: [Your App Link]');
            // FlutterShare.share(
            //   title: 'Share',
            //   text: 'Check this out!',
            //   linkUrl: 'https://example.com',
            //   chooserTitle: 'Share with',
            // );

            // AllOrders().clearList();
            // await
            //  //Navigator.of(context).pop(true);
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => LoginPage()));
          },
        ),
      ],
    );
  }
}
