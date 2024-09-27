import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/Model/addons.dart';
import 'package:foodapp/View/Model/sizeconfig.dart';

class AddOnTile extends StatefulWidget {
  AddOns aOns;

  AddOnTile(this.aOns, {Key? key}) : super(key: key);

  @override
  _AddOnTileState createState() => _AddOnTileState();
}

class _AddOnTileState extends State<AddOnTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).primaryColor,
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.symmetric(vertical: SizeConfig.height10),
          child: Center(
              child: Text(
            widget.aOns.title!,
            style: TextStyle(color: Theme.of(context).primaryColorLight),
          )),
        ),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: widget.aOns.options.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index2) {
              return CheckboxListTile(
                  value: widget.aOns.options[index2].status,
                  onChanged: (value) {
                    if (widget.aOns.title == "Flavour" ||
                        widget.aOns.title == "Size") {
                      if (value == true) {
                        for (int a = 0; a < widget.aOns.options.length; a++) {
                          widget.aOns.options[a].status = false;
                        }
                      }
                    }
                    setState(() {
                      widget.aOns.options[index2].status = value!;
                    });
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.aOns.options[index2].name!),
                      Text(widget.aOns.options[index2].price!)
                    ],
                  ));
            })
      ],
    );
    ;
  }
}
