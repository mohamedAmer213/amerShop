//import 'package:firebase_auth/firebase_auth.dart';

import 'package:amershop/admin/add_product.dart';
import 'package:amershop/admin/view_products.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:amershop/authentication/Authentication.dart';
import 'package:amershop/authentication/authenticatable.dart';
import 'package:amershop/authentication/firebase_authentication.dart';
import 'package:amershop/authentication/firestore_authentication.dart';
import 'package:amershop/user/user.dart';

import 'admin/add_categories.dart';
import 'admin/view_categories.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AuthView());


  /*underStanding using of map ua_amer
  *
  *  List<int> numbers=[1,2,3,4]; /// now we need to return this map *5
  List<int> newNumbers=numbers.map(
          (value){
        return value*5 ;
      }
  ).toList();
  print(newNumbers);
  *
  *
  * */
}



class AuthView extends StatefulWidget {
  @override
  _AuthViewState createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'view_categories':(context)=> ViewCategories(),
        'add_product':(context) {return AddProduct();},
        'add_category':(context) => AddCategories(),
        'view_products':(context)=> ViewProduct(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.teal,
      ),
      home: AuthTest(),);
  }
}

class AuthTest extends StatefulWidget {
  @override
  _AuthTestState createState() => _AuthTestState();
}

class _AuthTestState extends State<AuthTest> {
  ShopFirebaseAuthentication _shopfirebaseAuthentication =
  ShopFirebaseAuthentication();
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _passwordTextEditingController =
  TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        title: Text('Auth'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  validator: (value){
                    if(value.isEmpty){
                      return 'This is required';
                    }
                  return null;
                    },
                  controller: _emailTextEditingController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'email',
//                      border: OutlineInputBorder(
//                        borderSide: BorderSide(color: Colors.teal),
//                      ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value){
                    if(value.isEmpty){
                      return 'This is required';
                    }
                    return null;
                  },
                  controller: _passwordTextEditingController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'password',
//                      border: OutlineInputBorder(
//                        borderSide: BorderSide(color: Colors.teal),
//                      ),
                  ),
                ),
                RaisedButton(
                  onPressed: ()async{
                    if(_formKey.currentState.validate()){
                      var user= await _shopfirebaseAuthentication.signIn(_emailTextEditingController.text,
                          _passwordTextEditingController.text);
                      Navigator.pop(context);
                      Navigator.pushNamed(context, 'view_products');
                    }
                  },
                  child: Text('signIn'),
                ),
                RaisedButton(
                  onPressed: ()async{
                    var user= await _shopfirebaseAuthentication.signOut();
                    print(user);

                  },
                  child: Text('signOut'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




















class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


class MyApp extends StatelessWidget {
  //Here we will test our interface ua_amer
  Authenticatable authentication = FireStoreAuthentication();

//this is the importance of using interfaces ua_Amer solved and we will build some thing
  @override
  Widget build(BuildContext context) {
    authentication.register('email', 'password');
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          body: Container(
            color: Colors.teal,),
        ));
  }
}