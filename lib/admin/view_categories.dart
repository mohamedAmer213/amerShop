import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewCategories extends StatefulWidget {
  @override
  _ViewProductState createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewCategories> {
  // CollectionReference categoryCollection=FirebaseFirestore.instance.collection('categories');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('ViewCategories'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('categories').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> amer) {
          if (amer.connectionState == ConnectionState.waiting) {
            return Text('Loading');
          }
          if (amer.connectionState == ConnectionState.none) {
            return Text('None DataFound here');
          }
          if (amer.connectionState == ConnectionState.done ||
              amer.connectionState == ConnectionState.active) {
            return ListView(
                children: amer.data.documents.map((DocumentSnapshot amer) {
              return ListTile(
                title: Text(amer.data()['category_title']),
                trailing: IconButton(
                  color: Colors.red,
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('categories')
                        .document(amer.documentID)
                        .delete(); // this line is very Important ua_amer
                  },
                ),
              );
            }).toList());
          }
          return Container();
        },
      ),
    );
  }
}
