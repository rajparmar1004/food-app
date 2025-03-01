import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final DocumentSnapshot document;

  ProductCard(this.document);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        //height: 160,
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 8.0, bottom: 8, left: 10, right: 10),
          child: Row(
            children: [
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: 140,
                  width: 130,
                  child: Container(
                    child: Image.network(document.data()['productImage']),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            document.data()['brand'],
                            style: TextStyle(fontSize: 10),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            document.data()['productName'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width - 160,
                              padding:
                                  EdgeInsets.only(top: 10, bottom: 10, left: 6),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.grey[200]),
                              child: Text(
                                document.data()['weight'],
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600]),
                              )),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Text(
                                '\₹${document.data()['price'].toStringAsFixed(0)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              if (document.data()['comparedPrice'] > 0)
                                Text(
                                  '\₹${document.data()['comparedPrice'].toStringAsFixed(0)}',
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 160,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Card(
                                color: Theme.of(context).primaryColor,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30, top: 7, bottom: 7),
                                  child: Text(
                                    'Add',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
