import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddCategories extends StatefulWidget {
  @override
  _AddCategoriesState createState() => _AddCategoriesState();
}

class _AddCategoriesState extends State<AddCategories> {
  bool isLoading = false;
  int errorNumber = 0;
  int responseNumber =
      0; // this is required for checking if the the category is already added not ......
  CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection('categories');
  TextEditingController categoryTextEditingController = TextEditingController();
  final _formKey = GlobalKey<
      FormState>(); // Hint this should be final or var inorder to be able to use validator() method

  @override
  void dispose() {
    categoryTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('AddCategory'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: isLoading ? _loading(context) : buildAddCategoryView(),
      ),
    );
  }

  Column buildAddCategoryView() {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'This is required';
                  }
                  return null;
                },
                controller: categoryTextEditingController,
                decoration: InputDecoration(
                    // labelText: 'Enter category',
                    hintText: 'add_new_category'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        RaisedButton(
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              var responseNumber = await checkCategory();

              if (responseNumber >= 1) {
                setState(() {
                  errorNumber = responseNumber;
                });
                print(
                    'We have ${responseNumber} items of this product ua_amer ');
              } else {
                setState(() {
                  isLoading = true;
                });
                addCategory(); // and inside this method after completing its work the isLoading variable will be false again

              }
            }
          },
          child: Text('Add Category'),
        ),
        SizedBox(height: 50),
        (errorNumber >= 1) ? _creatingErrorMessage(errorNumber) : Container(),
      ],
    );
  }

// now we need to make some Methods to deal with the Firebase ua_amer
//***************method for adding data to Firebase*****************REQUIRED***********
  addCategory() {
    categoriesCollection.add(
        {'category_title': categoryTextEditingController.text}).then((value) {
      setState(() {
        isLoading = false;
        categoryTextEditingController.text = '';
      });
    });
  }

//making Method for checking if the field is already in the collection or not exists
  Future<int> checkCategory() async {
    var response = await FirebaseFirestore.instance
        .collection('categories')
        .where('category_title', isEqualTo: categoryTextEditingController.text)
        .snapshots()
        .first;
    return response.docs.length;
  }

//here we need to make function for circularProgressIndicator ua_amer
  Widget _loading(BuildContext context) {
    // this is for waiting until the data loaded to the firebase ua_Amer
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Center(
          child: CircularProgressIndicator(
              // backgroundColor: Colors.black,
              )),
    );
  }

  Widget _creatingErrorMessage(int response) {
    return Container(
      child: Text(
        'we have ${response} items of this product',
        style: TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }
}
