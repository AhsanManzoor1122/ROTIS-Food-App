import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/Model/option.dart';
import 'package:foodapp/View/Model/sizeconfig.dart';

class OptionsDialog extends StatefulWidget {
  List<Option> ops = [];

  OptionsDialog(this.ops, {Key? key}) : super(key: key);

  @override
  _OptionsDialogState createState() => _OptionsDialogState();
}

class _OptionsDialogState extends State<OptionsDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(SizeConfig.height25))),
      content: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: widget.ops.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Text(widget.ops[index].name!);
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
