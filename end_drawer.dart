import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/Model/staticvariables.dart';
import 'package:foodapp/View/Model/sizeconfig.dart';
import 'package:foodapp/View/screens/order_history_screen.dart';

class EndDrawer extends StatelessWidget {
  Function() logoutTap;

  EndDrawer({Key? key, required this.logoutTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.width300,
      child: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Text(
                'User',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            Visibility(
              visible: StaticVariables.waiterMode,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: Theme.of(context).primaryColor,
                    child: ListTile(
                      title: Text(
                        "Today's Orders",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              OrderHistoryScreen(todayOnly: true),
                        ));
                      },
                    ),
                  ),
                  SizedBox(height: SizeConfig.height10),
                  Container(
                    color: Theme.of(context).primaryColor,
                    child: ListTile(
                      title: Text(
                        "Order History",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              OrderHistoryScreen(todayOnly: false),
                        ));
                      },
                    ),
                  ),
                  SizedBox(height: SizeConfig.height10),
                ],
              ),
            ),
            Container(
              color: Theme.of(context).primaryColor,
              child: ListTile(
                title: Text(
                  'LogOut',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                onTap: logoutTap,
              ),
            ),
          ],
        ), // Populate the Drawer in the next step.
      ),
    );
  }
}
