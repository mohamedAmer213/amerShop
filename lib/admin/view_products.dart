/*so this class will be used to get all the products from FireStore solve */
import 'package:amershop/admin/add_categories.dart';
import 'package:amershop/admin/add_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewProduct extends StatefulWidget {
  @override
  _ViewProductState createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('products');
    return Scaffold(
      drawer: buildDrawer(context),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('ViewProducts'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white70,
        child: StreamBuilder<QuerySnapshot>(
          stream: users.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return new ListView(
              children: snapshot.data.documents.map((DocumentSnapshot amer) {
                return ListTile(
                  title: Text(amer.data()['product_title']),
                  subtitle: Text(" ${amer.data()['product_desc']} \n ${amer.data()['product_price']} "),

                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('products')
                          .document(amer.documentID)
                          .delete();
                    },
                  ),
                  // subtitle: Text(document.data()['company']),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        buildSingleListTile(context,
            title: 'AddProduct', routeName: 'add_product'),
        buildSingleListTile(context,
            title: 'AddCategory', routeName: 'add_category'),
        buildSingleListTile(context,
            title: 'ViewCategory', routeName: 'view_categories'),
      ]),
    );
  }

  ListTile buildSingleListTile(BuildContext context,
      {String title, String routeName}) {
    return ListTile(
        // focusColor: Colors.yellow,
        // hoverColor: Colors.red,
        trailing: Icon(Icons.arrow_forward_ios),
        title: GestureDetector(
          onTap: () {
            Navigator.pop(
                context); // small hint this is required for closing the drawer after going back again
            Navigator.of(context).pushNamed(routeName);
          },
          child: Text(title),
        ));
  }
}

/*now we need to make revision for stream and streamBuilder*/
Widget firebaseData(QuerySnapshot snapshots) {
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  return StreamBuilder<QuerySnapshot>(
    stream: products.snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
      return ListView(
          children: snapshot.data.documents.map((DocumentSnapshot document) {
        return ListTile(
          title: Text(document.data()['price_tile']),
        );
      }).toList());
    },
  );
}

Widget firebaseDataView(QuerySnapshot snapshot) {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  return StreamBuilder(
    stream: users.snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> amerSnapshot) {
      return ListView(
        children: amerSnapshot.data.docs.map((DocumentSnapshot document) {
          return ListTile(
            title: document.data()['product_price'],
          );
        }).toList(),
      );
    },
  );
}

// now we need to make revision for this map function......final
/*
we are using map when we have to implement function that returns list
 */
