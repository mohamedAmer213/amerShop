import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  int response=0;

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
      child: Column(
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
                  TextFormField(
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
                  ),
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
                    controller: productDescController,
                    maxLines: 10,
                    // keyboardType: TextInputType.numberWithOptions(
                    //   decimal: false,
                    // ),
                    decoration: InputDecoration(
                      hintText: 'Product Desc',
//                      border: OutlineInputBorder(
//                        borderSide: BorderSide(color: Colors.teal),
//                      ),
                    ),
                  ),
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
          RaisedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                // here we need to check if the firestore contains the same Product or not contains this Product
                response = await isContainsProduct();
                // print(response.documents.length);

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
                  productCollection.add({
                    'product_title': productTitleController.text,
                    'product_desc': productDescController.text,
                    'product_price': productPriceController.text,
                  }).then((value) {
                    /// this is very Important part of our Application
                    setState(() {
                      isLoading = false;
                      // here we need to set the initial values for the controllers to be empty for the coming back ... after Loading
                      productPriceController.text = '';
                      productDescController.text = '';
                      productTitleController.text = '';
                    });
                  });
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
          _creatingErrorMessage(response),
        ],
      ),
    );
  }

  Container _creatingErrorMessage(int response) {
    return Container(

            child: (response>0)
                ? Text('we have $response of this product',style: TextStyle(color: Colors.red),)
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
      child: Center(child: CircularProgressIndicator(
        backgroundColor: Colors.amber,
      )),
    );
  }
} // the end of this class ua_amer
// we have to make someThing to Make loading for.. For the page solved
