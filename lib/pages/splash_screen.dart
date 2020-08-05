import 'dart:async';
import 'package:estallecomerch/helpers/authentication_service.dart';
import 'package:estallecomerch/helpers/cart_service.dart';
import 'package:estallecomerch/helpers/products_db_service.dart';
import 'package:estallecomerch/helpers/user_utils.dart';
import 'package:estallecomerch/models/products_models_user.dart';
import 'package:estallecomerch/pages/launcher_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  ProductsUserId productsUserId;

  @override
  void initState() {
    super.initState();
    productsUserId=ProductsUserId();


    FirebaseDatabase database;
    database = FirebaseDatabase.instance;
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);

    AuthenticationService.getUserPhoneNumberByPreference().then((email){
      print(email);
      setState(() {
        UserUtils.getUserSessionUsingPref().then((value){
          if(value==false){
            print('False Form Home');
            ProductsDBService.getAllProducts().then((listOfProducts){
              listOfProducts.forEach((products) {
                print('Delete  Method Call');
                productsUserId.name=products.name;
                productsUserId.nameKey=products.nameKey;
                productsUserId.current_price=products.current_price;
                productsUserId.last_price=products.last_price;
                productsUserId.authorName=products.authorName;
                productsUserId.imageUrl=products.imageUrl;
                productsUserId.imageUrl2=products.imageUrl2;
                productsUserId.imageUrl3=products.imageUrl3;
                productsUserId.category=products.category;
                productsUserId.description=products.description;
                productsUserId.condition=products.condition;
                productsUserId.quantity=products.quantity;
                print(value.toString());
                productsUserId.count=0;
                productsUserId.favouriteCheck=false;
                CartService.addtocartProductDelete(products.nameKey, email);
                ProductsDBService.addProductWithUSER(productsUserId,email);
                ProductsDBService.addProductBYCategoryWithUser(productsUserId, email);
                ProductsDBService.addProductByAuthorWithUser(productsUserId, email);
              });
            });
          }
          if(value==true){
            ProductsDBService.getAllProducts().then((listOfProducts){
              listOfProducts.forEach((products) {
                productsUserId.name=products.name;
                productsUserId.nameKey=products.nameKey;
                productsUserId.current_price=products.current_price;
                productsUserId.last_price=products.last_price;
                productsUserId.authorName=products.authorName;
                productsUserId.imageUrl=products.imageUrl;
                productsUserId.imageUrl2=products.imageUrl2;
                productsUserId.imageUrl3=products.imageUrl3;
                productsUserId.category=products.category;
                productsUserId.description=products.description;
                productsUserId.condition=products.condition;
                productsUserId.quantity=products.quantity;

                ProductsDBService.getAllProductsWithUser(email).then((value1){
                  value1.forEach((element) {
                    print('True Method Declare');
                    element.count==null?productsUserId.count=0:productsUserId.count=element.count;
                    element.price==null?productsUserId.price=0:productsUserId.price=element.price;

                    ProductsDBService.addProductWithUSER(productsUserId,email);
                    ProductsDBService.addProductBYCategoryWithUser(productsUserId, email);
                    ProductsDBService.addProductByAuthorWithUser(productsUserId, email);

                  });
                });
              });
            });
          }
        });
      });
    });


    Timer(
        Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LauncherScreen())));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.center,
          children: <Widget>[
            Image.asset('images/splash screen.png',width: double.infinity,height: double.infinity,fit: BoxFit.cover,),
          ],
        ),
      ),
    );
  }
}