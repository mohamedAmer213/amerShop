import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

// import 'package:image_picker/image_picker.dart';
class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController productTitleController = TextEditingController();
  TextEditingController productDescController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  CollectionReference productCollection =
      FirebaseFirestore.instance.collection('products');
  bool isLoading = false;
  int response = 0;
  String chooseCategory = 'select_category';
  bool isSelect = false;
  bool allDone = false;
  File image1, image2, image3, cameraImage;
  bool isSelected1 = false;
  bool isSelected2 = false;
  bool isSelected3 = false;
  bool isSelected4 = false;

  @override
  void dispose() {
    productDescController.dispose();
    productTitleController.dispose();
    productPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add product'),
      ),
      body: isLoading ? _loading(context) : addProductForm(context),
    );
  }

  SingleChildScrollView addProductForm(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    buildProductTitleField(),
                    SizedBox(
                      height: 10,
                    ),
                    buildProductDescField(),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Fill this field';
                        }
                        return null;
                      },
                      controller: productPriceController,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        hintText: 'Product Price',
//                      border: OutlineInputBorder(
//                        borderSide: BorderSide(color: Colors.teal),
//                      ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            buildDropCategoriesMenu(),
            Text(
              'Required',
              style: TextStyle(color: Colors.red),
              textAlign: TextAlign.start,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildAddImageButton1(image1),
                buildAddImageButton2(image2),
                buildAddImageButton3(image3),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Optional',
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.start,
                ),
                buildAddImageButton4(cameraImage),
              ],
            ),
            RaisedButton(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  // here we need to check if the firestore contains the same Product or not contains this Product
                  response = await isContainsProduct();
                  // print(response.documents.length);

                  if (!isSelect && isSelected1 && isSelected2 && isSelected3) {
                    if (response >= 1) {
                      // this means the product exists ua_amer
                      print('we have ${response} of this product ua_amer');
                      setState(() {
                        isLoading = false;
                      });
                    } else {
                      setState(() {
                        isLoading = true;
                      });
                      // print(response);
                      String imageOneUrl = await uploadImage(image1);
                      String imageTwoUrl = await uploadImage(image2);
                      String imageThreeUrl = await uploadImage(image3);
                      print(imageOneUrl);
                      List<String>images=[imageOneUrl,imageTwoUrl,imageThreeUrl];
                      productCollection.add({
                        'product_title': productTitleController.text,
                        'product_desc': productDescController.text,
                        'product_price': productPriceController.text,
                        'category_title': chooseCategory,
                        'images':images,
                      }).then((value) {
                        /// this is very Important part of our Application
                        setState(() {
                          isLoading = false;
                          // here we need to set the initial values for the controllers to be empty for the coming back ... after Loading
                          productPriceController.text = '';
                          productDescController.text = '';
                          productTitleController.text = '';
                          chooseCategory = 'select_category';
                          isSelected1 = false;
                          isSelected2 = false;
                          isSelected3 = false;
                          isSelected4 = false;
                        });
                      });
                    }
                  }

                  ///*******************This is the old one Used by lessons ***********
                  // Firestore.instance.collection('users').document().setData({
                  //   'product_title': productTitleController.text,
                  //   'product_desc': productDescController.text,
                  //   'product_price': productPriceController.text,
                  // });
                }
              },
              child: Text('Add Product'),
            ),
            SizedBox(
              height: 20,
            ),
            isSelect
                ? Container(
                    width: double.infinity,
                    height: 20,
                    child: Center(
                      child: Text(
                        'This is not a Category',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  )
                : Container(),
            _creatingErrorMessage(response),
          ],
        ),
      ),
    );
  }

  // build Method for getting image from the gallery or camera ua_amer
  Future getImage(File requiredImage) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      requiredImage = image;
    });
  }

  /// now we need to upload this image that we took
  Future<String> uploadImage(File image) async {
    String name = Random().nextInt(1000).toString() + '_product';
    final StorageReference storageReference =
        FirebaseStorage.instance.ref().child(name);

    final StorageUploadTask storageUploadTask = storageReference.putFile(image);
    StorageTaskSnapshot completed = await storageUploadTask.onComplete;
    String imageUrl = await completed.ref.getDownloadURL();
    return imageUrl;
  }

  RaisedButton buildAddImageButton1(File image) {
    return RaisedButton(
      onPressed: () async {
        var image = await ImagePicker.pickImage(source: ImageSource.gallery);
        setState(() {
          image1 = image;
          isSelected1 = true;
        });
      },
      child: isSelected1 ? Text('Done') : Text('Select_image'),
    );
  }

  RaisedButton buildAddImageButton2(File image) {
    return RaisedButton(
      onPressed: () async {
        var image = await ImagePicker.pickImage(source: ImageSource.gallery);
        setState(() {
          image2 = image;
          isSelected2 = true;
        });
      },
      child: isSelected2 ? Text('Done') : Text('Select_image'),
    );
  }

  RaisedButton buildAddImageButton3(File image) {
    return RaisedButton(
      onPressed: () async {
        var image = await ImagePicker.pickImage(source: ImageSource.gallery);
        setState(() {
          image3 = image;
          isSelected3 = true;
        });
      },
      child: isSelected3 ? Text('Done') : Text('Select_image'),
    );
  }

  RaisedButton buildAddImageButton4(File image) {
    return RaisedButton(
      onPressed: () async {
        var image = await ImagePicker.pickImage(source: ImageSource.camera);
        setState(() {
          cameraImage = image;
          isSelected4 = true;
        });
      },
      child: isSelected4 ? Text('Done') : Text('Camera_image'),
    );
  }

  TextFormField buildProductDescField() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Fill this field';
        }
        return null;
      },
      controller: productDescController,
      maxLines: 5,
      // keyboardType: TextInputType.numberWithOptions(
      //   decimal: false,
      // ),
      decoration: InputDecoration(
        hintText: 'Product Desc',
//                      border: OutlineInputBorder(
//                        borderSide: BorderSide(color: Colors.teal),
//                      ),
      ),
    );
  }

  TextFormField buildProductTitleField() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Fill this field';
        }
        return null;
      },
      controller: productTitleController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'ProductTitle',
//                      border: OutlineInputBorder(
//                        borderSide: BorderSide(color: Colors.teal),
//                      ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget buildDropCategoriesMenu() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('categories').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> amer) {
        // some code to test the connection for not causing null ua_amer solved
        switch (amer.connectionState) {
          case ConnectionState.waiting:
            return Center(child: Text('Waiting'));
          case ConnectionState.none:
            return Center(child: Text('None Data Found'));
          case ConnectionState.done:
          case ConnectionState.active:
          default:
            return DropdownButton<String>(
              isExpanded: true,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                // setState(() {
                //   chooseCategory=newValue;
                // });
                //this code is used for checking if you choose the correct Category or not
                if (newValue == 'select_category') {
                  setState(() {
                    isSelect = true;
                    chooseCategory = newValue;
                  });
                } else {
                  setState(() {
                    isSelect = false;
                    chooseCategory = newValue;
                  });
                }
              },
              value: chooseCategory,
              items: amer.data.documents
                  .map((DocumentSnapshot amerDocumentSnapshot) {
                return DropdownMenuItem<String>(
                  value: amerDocumentSnapshot.data()['category_title'],
                  child: Text(
                      amerDocumentSnapshot.data()['category_title'].toString()),
                );
              }).toList(),
            );
        }
      },
    );
  }

  Container _creatingErrorMessage(int response) {
    return Container(
        child: (response > 0)
            ? Text(
                'we have $response of this product',
                style: TextStyle(color: Colors.red),
              )
            : Text(''));
  }

/*
* Now we need to check if the ProductDocument contains the sameProduct or not contains
* this product
*************** so here we will make Method that uses the Stream And StreamBuilder and returns bool Variable
*  */

  Future<int> isContainsProduct() async {
    var response = await FirebaseFirestore.instance
        .collection('products')
        .where('product_title', isEqualTo: productTitleController.text)
        .snapshots()
        .first;
    // print(response.documents.length);
    return response.documents.length;
  }

  Widget _loading(BuildContext context) {
    // this is for waiting until the data loaded to the firebase ua_Amer
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Center(
          child: CircularProgressIndicator(
        backgroundColor: Colors.amber,
      )),
    );
  }
} // the end of this class ua_amer
// we have to make someThing to Make loading for.. For the page solved
