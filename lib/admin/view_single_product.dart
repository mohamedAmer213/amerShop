import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewSingleProduct extends StatefulWidget {
  @override
  _ViewSingleProductState createState() => _ViewSingleProductState();
}

class _ViewSingleProductState extends State<ViewSingleProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: oldSliverScrollView(),
    );
  }

  CustomScrollView oldSliverScrollView() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 200,
          centerTitle: true,
          flexibleSpace: Container(
            // height: 45,
            // child: TextField(
            //   decoration: InputDecoration(
            //     contentPadding: EdgeInsets.only(top: 5, left: 15),
            //     suffixIcon: IconButton(
            //       icon: Icon(Icons.search),
            //       onPressed: () {
            //         print('sesarch');
            //       },
            //     ),
            //     filled: true,
            //     fillColor: Colors.white,
            //     hintText: "What are you looking for ?",
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(5),
            //     ),
            //   ),
            // ),
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('products').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> amerSnapshot) {
                List<String> urls =
                    amerSnapshot.data.docs.map((DocumentSnapshot amerDocument) {
                  return (amerDocument.data()['images']).toString();
                }).toList();
                print(urls[0]);
                print(urls[0].substring(1, urls[0].length - 1));// this will remove the [ after and the ] before the text
                return SizedBox(
                  child: Image(
                    image:
                        NetworkImage((urls[2]).substring(1, urls[0].length - 1)),
                    // this is required to get ride of the last and First character
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                height: 100,
                child: Center(
                  child: Text('SomeThing ua_amer'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildStreamBuilderContainer() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> amerSnapshot) {
          List<String> urls =
              amerSnapshot.data.docs.map((DocumentSnapshot amerDocument) {
            return (amerDocument.data()['images']).toString();
          }).toList();
          print(urls[0]);
          return Image(
            image: NetworkImage(urls[1].substring(1, urls[0].length - 1)),
            // this is required to get ride of the last and First character
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
