// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/Controller/apicalls.dart';
import 'package:foodapp/Model/allorders.dart';
import 'package:foodapp/Model/staticvariables.dart';
import 'package:foodapp/View/Model/Global.dart';
import 'package:foodapp/View/Model/sizeconfig.dart';
import 'package:foodapp/View/Model/staticviewvariables.dart';

class ExpandableButton extends StatefulWidget {
  bool enabled = false;
  int index = 0;
  Function? onSelected;
  Function? getOrderList;

  ExpandableButton(this.index, {Key? key, this.onSelected, this.getOrderList})
      : super(key: key);

  @override
  _ExpandableButtonState createState() => _ExpandableButtonState();
}

class _ExpandableButtonState extends State<ExpandableButton> {
  int? currentSelectedTableId;
  void initState() {
    super.initState();
    printedBillData();
  }

  void printedBillData() {
    Globals.clearOrders();
    // Storing the selected data globally
    List<Map<String, String>> items = [];
    AllOrders.listOrders[widget.index].itemsList.forEach((item) {
      items.add({'name': item.details.name!, 'totalValue': item.totalValue!});
    });

    // Convert totalValue to double
    double totalValue =
        double.parse(AllOrders.listOrders[widget.index].totalValue!);

    // Store in GlobalData
    Globals.setOrderData(
      AllOrders.listOrders[widget.index].orderNo!,
      totalValue,
      items,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            color: Theme.of(context).primaryColor,
            child: ListTile(
              leading: Visibility(
                visible: widget.onSelected != null,
                child: Checkbox(
                  value: AllOrders.listOrders[widget.index].isSelected,
                  onChanged: (value) {
                    setState(() {
                      widget.onSelected!(value!);
                    });
                  },
                ),
              ),
              title: Text(
                AllOrders.listOrders[widget.index].orderNo! +
                    " (Rs. ${AllOrders.listOrders[widget.index].totalValue})",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    widget.enabled = !widget.enabled;
                  });
                },
                icon: widget.enabled == false
                    ? Icon(
                        Icons.arrow_drop_down,
                        color: Theme.of(context).primaryColorLight,
                      )
                    : Icon(
                        Icons.arrow_drop_up,
                        color: Theme.of(context).primaryColorLight,
                      ),
              ),
            )),
        widget.enabled == true
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height:
                        AllOrders.listOrders[widget.index].itemsList.length *
                            25,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount:
                          AllOrders.listOrders[widget.index].itemsList.length,
                      itemBuilder: (BuildContext context, int index1) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AllOrders.listOrders[widget.index]
                                  .itemsList[index1].details.name!),
                              Text(AllOrders.listOrders[widget.index]
                                  .itemsList[index1].totalValue!),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        if (AllOrders.listOrders[widget.index].orderStatus!
                                .toLowerCase() ==
                            "confirmed") {
                          showDialog(
                            context: context,
                            builder: (dialogcontext) {
                              return AlertDialog(
                                title: Center(
                                  child: Text(
                                      'Are You Sure you want to Cancel this Order ?',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                      style: ButtonStyle(),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'No',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                      )),
                                  TextButton(
                                      style: ButtonStyle(),
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        setState(() {
                                          StaticViewVariables.showLoaderDialog(
                                              context);
                                        });

                                        bool? check =
                                            await ApiCalls.orderCancelMethod(
                                          id: AllOrders
                                              .listOrders[widget.index].id,
                                        );
                                        if (check) {
                                          setState(() {
                                            widget.getOrderList!();
                                          });
                                        }
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Yes',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                      )),
                                ],
                              );
                            },
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('We are Preparing your Order'),
                          ));
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            top: SizeConfig.height10, right: 50),
                        height: SizeConfig.height22,
                        width: SizeConfig.width65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Center(
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                                color: AllOrders.listOrders[widget.index]
                                            .orderStatus!
                                            .toLowerCase() ==
                                        "confirmed"
                                    ? Colors.white
                                    : Colors.grey,
                                fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink(),
        // widget.enabled==true?ListView.builder(
        //     scrollDirection: Axis.horizontal,
        //     itemCount: 10,
        //     itemBuilder: (BuildContext context, int index) {
        //       return const Padding(
        //         padding: EdgeInsets.symmetric(horizontal: 5),
        //         child: Text("Item Name"),
        //       );
        //     }
        // ):const SizedBox.shrink(),
      ],
    );
  }
}
