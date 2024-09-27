import 'package:flutter/material.dart';
import 'package:foodapp/Model/addons.dart';
import 'package:foodapp/View/Model/sizeconfig.dart';

import 'optiondialog.dart';

class AddOnDialog extends StatelessWidget {
  List<AddOns> aOns = [];

  AddOnDialog(this.aOns, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(SizeConfig.height25))),
      content: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: aOns.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return MaterialButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return OptionsDialog(aOns[index].options);
                    },
                  );
                },
                child: Text(aOns[index].title!));
          }),
      actions: [
        TextButton(
          child: const Text(
            "Cancel",
          ),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        TextButton(
          child: const Text(
            "Okay",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
