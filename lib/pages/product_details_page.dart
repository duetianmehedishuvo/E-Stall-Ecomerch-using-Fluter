import 'package:estallecomerch/helpers/authentication_service.dart';
import 'package:estallecomerch/helpers/cart_service.dart';
import 'package:estallecomerch/helpers/products_db_service.dart';
import 'package:estallecomerch/helpers/provider/products_provider.dart';
import 'package:estallecomerch/models/choose_products_models.dart';
import 'package:estallecomerch/models/products_models.dart';
import 'package:estallecomerch/models/products_models_user.dart';
import 'package:estallecomerch/pages/homeScreen.dart';
import 'package:estallecomerch/pages/my_order_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductsUserId products;
  int countNumber;
  ProductDetailsPage(this.products,this.countNumber);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {

  int countNumber;
  AuthenticationService authenticationService;
  String email;
  int productprice;
  CartService cartService;
  int cnt;
  int mainPrice;

  bool isFavourite=false;

  ChooseProductModels chooseProductModels=ChooseProductModels();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartService=CartService();
    authenticationService=AuthenticationService();
    AuthenticationService.getUserPhoneNumberByPreference().then((getEmail){
      setState(() {
        email=getEmail;
      });
    });

    widget.products.count==0?countNumber=0:countNumber=widget.products.count;
    productprice=widget.products.price;
    mainPrice=countNumber*widget.products.current_price;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    authenticationService=null;
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('${widget.products.name}'),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Expanded(child: ListView(
                children: <Widget>[
                  Container(
                    color: Colors.blue.withOpacity(.1),
                    child: Stack(
                      children: <Widget>[
                        Image.network(widget.products.imageUrl,width: double.infinity,height: 200,fit: BoxFit.cover,),
                        Positioned(
                          right: 13,
                          top: 2,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          child: IconButton(
                            icon: Icon(Icons.favorite_border,color: Colors.blue,),
                            onPressed: (){},
                          ),
                        ),

                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('BDT ${widget.products.current_price}',style: TextStyle(
                              fontSize: 16
                            ),),
                            Text(widget.products.condition=='Add To Cart'?'In Stock':'Out Of Stock',style: TextStyle(
                              color: widget.products.condition=='Add To Cart'?Colors.black:Colors.red,
                              fontSize: 16,
                            ),)
                          ],
                        ),
                        Container(
                            child: Text(widget.products.name,style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                            ),)),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.grey.withOpacity(.2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Text('Quantity',style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500
                              ),),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 4,top: 5,bottom: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.lightBlue
                                  ),
                                  height: 30,
                                  width: 30,
                                  child: IconButton(
                                    icon: Icon(Icons.keyboard_arrow_left,color: Colors.white,),
                                    onPressed: (){
                                      setState(() {
                                        if(countNumber>0){
                                          countNumber--;
                                          _leftArrowClick();
                                        }else{
                                          Toast.show('0 Out Of Bound', context);
                                        }
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                    height: 30,
                                    width: 30,
                                    color: Colors.blue.withOpacity(.1),
                                    alignment: Alignment.center,
                                    child: Text('${widget.products.count}')),
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(right: 4,top: 5,bottom: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.lightBlue
                                  ),
                                  height: 30,
                                  width: 30,
                                  child: IconButton(
                                    icon: Icon(Icons.keyboard_arrow_right,color: Colors.white,),
                                    onPressed: (){
                                      setState(() {
                                        countNumber++;
                                        _rightArrowClick();
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text('Total Price',style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),),
                            Text('BDT ${widget.products.price}',style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700
                            ),),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                      padding: EdgeInsets.all(8),
                      child: Text("Description: \n\nConfectionery Drinks-Dessert Cosmetic Cookeries Electronics Fish-Meat Fruits-Vegetable Medicine Study Tools Quran Hades Gas Snacks",style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                      ),))
                ],
              )),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 50,
                color: Colors.blue,
                child: FlatButton.icon(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=>MyOrderPage()
                  ));
                }, icon: Icon(Icons.card_travel,color: Colors.white.withOpacity(.5),), label: Text('Go To My Order Screen',style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),)),
              )
            ],
          ),
        ),
      ),
    );
  }


  void variableValueInitialization(){
    chooseProductModels.name=widget.products.name;
    chooseProductModels.nameKey=widget.products.nameKey;
    chooseProductModels.authorName=widget.products.authorName;
    chooseProductModels.current_price=widget.products.current_price;
    chooseProductModels.last_price=widget.products.last_price;
    chooseProductModels.imageUrl=widget.products.imageUrl;
    chooseProductModels.description=widget.products.description;
    chooseProductModels.condition=widget.products.condition;
    chooseProductModels.quantity=widget.products.quantity;
    chooseProductModels.category=widget.products.category;
  }

  void _rightArrowClick() {

    variableValueInitialization();

    chooseProductModels.count=countNumber;
    setState(() {
      num price=countNumber*(widget.products.current_price);
      chooseProductModels.totalPrice=price;

      widget.products.count=countNumber;
      widget.products.price=price;

      ProductsDBService.addProductWithUSER(widget.products,email);

      CartService.addtocartProduct(chooseProductModels, email).then((_){
        Toast.show('${chooseProductModels.totalPrice} \$', context);
        print('${chooseProductModels.totalPrice}');
      });



      ProductsDBService.addProductBYCategoryWithUser(widget.products, email);
      ProductsDBService.addProductByAuthorWithUser(widget.products, email);
      Provider.of<ProductsProvider>(context,listen: false).getCount(email);

    });



  }

  void _leftArrowClick() {
    variableValueInitialization();

    chooseProductModels.count=countNumber;
    setState(() {
      num price=countNumber*(widget.products.current_price);
      chooseProductModels.totalPrice=price;

      widget.products.count=countNumber;
      widget.products.price=price;



      if(countNumber==0){
        CartService.removetocartProduct(chooseProductModels, email);
        ProductsDBService.addProductWithUSER(widget.products,email);

        ProductsDBService.addProductBYCategoryWithUser(widget.products, email);
        ProductsDBService.addProductByAuthorWithUser(widget.products, email);
        Provider.of<ProductsProvider>(context,listen: false).getCount(email);
      }else{

        ProductsDBService.addProductWithUSER(widget.products,email);

        ProductsDBService.addProductBYCategoryWithUser(widget.products, email);
        ProductsDBService.addProductByAuthorWithUser(widget.products, email);

        CartService.addtocartProduct(chooseProductModels, email).then((_){
          Toast.show('${chooseProductModels.totalPrice} \$', context);
        });
        Provider.of<ProductsProvider>(context,listen: false).getCount(email);
      }

    });


  }

}
