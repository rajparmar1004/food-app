import 'package:charusat_food_for_business/screens/dashboard_screen.dart';
import 'package:charusat_food_for_business/screens/login_screen.dart';
import 'package:charusat_food_for_business/services/drawer_services.dart';
import 'package:charusat_food_for_business/widgets/drawer_menu_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<SliderMenuContainerState> _key =
      new GlobalKey<SliderMenuContainerState>();

  String title;

  DrawerServices _services = DrawerServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliderMenuContainer(
          appBarColor: Colors.white,
          appBarHeight: 80,
          key: _key,
          sliderMenuOpenSize: 250,
          title: Text(
            '',
          ),
          trailing: Row(
            children: [
              IconButton(icon: Icon(Icons.search), onPressed: () {}),
              IconButton(icon: Icon(CupertinoIcons.bell), onPressed: () {})
            ],
          ),
          sliderMenu: MenuWidget(
            onItemClick: (title) {
              _key.currentState.closeDrawer();
              setState(() {
                this.title = title;
              });
            },
          ),
          sliderMain: _services.drawerScreen(title)),
    );
  }
}
