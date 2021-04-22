import 'package:charusat_food/providers/location_provider.dart';
import 'package:charusat_food/screens/main_screen.dart';
import 'package:charusat_food/screens/map_screen.dart';
import 'package:charusat_food/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppBar extends StatefulWidget {
  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  String _location = '';
  String _address = '';
  @override
  void initState() {
    getPrefs();
    super.initState();
  }

  getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String location = prefs.getString('location');
    String address = prefs.getString('address');

    setState(() {
      _location = location;
      _address = address;
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationData = Provider.of<LocationProvider>(context);

    return SliverAppBar(
      automaticallyImplyLeading: false,
      elevation: 0.0,
      floating: true,
      snap: true,
      //leading: Container(),
      title: TextButton(
        onPressed: () {
          locationData.getCurrentPosition();
          if (locationData.permissionAllowed == true) {
            pushNewScreenWithRouteSettings(
              context,
              settings: RouteSettings(name: MapScreen.id),
              screen: MapScreen(),
              withNavBar: false,
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          } else {
            print('Permission not allowed');
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    _location == null ? 'Address not set' : _location,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 15,
                )
              ],
            ),
            Flexible(
              child: Text(
                _address == null
                    ? 'Press Here to set Delivery Location'
                    : _address,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            )
          ],
        ),
      ),
      // actions: [
      //   IconButton(
      //       onPressed: () {
      //         FirebaseAuth.instance.signOut();
      //         Navigator.pushNamed(context, WelcomeScreen.id);
      //       },
      //       icon: Icon(
      //         Icons.power_settings_new,
      //         color: Colors.white,
      //       )),
      //   IconButton(
      //       onPressed: () {},
      //       icon: Icon(
      //         Icons.account_circle_outlined,
      //         color: Colors.white,
      //       ))
      // ],
      //centerTitle: true,
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none),
                  contentPadding: EdgeInsets.zero,
                  filled: true,
                  fillColor: Colors.white),
            ),
          )),
    );
  }
}
