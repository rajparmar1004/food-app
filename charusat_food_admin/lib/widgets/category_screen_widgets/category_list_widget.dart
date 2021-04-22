import 'package:charusat_food_admin/services/firebase_services.dart';
import 'package:charusat_food_admin/widgets/category_screen_widgets/category_card_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseServices _services = FirebaseServices();
    return Container(
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder(
        stream: _services.category.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('something went wrong'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Wrap(
              direction: Axis.horizontal,
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return CategoryCard(document);
              }).toList());
        },
      ),
    );
  }
}
