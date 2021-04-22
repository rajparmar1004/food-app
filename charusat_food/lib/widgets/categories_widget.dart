import 'package:charusat_food/providers/store_provider.dart';
import 'package:charusat_food/services/product_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SellerCategories extends StatefulWidget {
  @override
  _SellerCategoriesState createState() => _SellerCategoriesState();
}

class _SellerCategoriesState extends State<SellerCategories> {
  ProductServices _services = ProductServices();
  List _catList = [];

  @override
  void didChangeDependencies() {
    var _store = Provider.of<StoreProvider>(context);

    FirebaseFirestore.instance
        .collection('products')
        .where('seller.sellerUid', isEqualTo: _store.storeDetails['uid'])
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        _catList.add(doc['category']['mainCategory']);
      });
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('cat : $_catList');
    return FutureBuilder(
      future: _services.category.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Something went wrong...'),
          );
        }

        if (_catList.length == 0) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData) {
          return Container();
        }

        return SingleChildScrollView(
          child: Wrap(
              direction: Axis.horizontal,
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return _catList.contains(document.data()['name'])
                    ? Container(
                        width: 120,
                        height: 150,
                        child: Card(
                          child: Column(
                            children: [
                              Center(),
                              Text(document.data()['name']),
                            ],
                          ),
                        ),
                      )
                    : Text('');
              }).toList()),
        );
      },
    );
  }
}
