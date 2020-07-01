import 'package:carousel_slider/carousel_slider.dart';
import 'package:estallecomerch/helpers/authentication_service.dart';
import 'package:estallecomerch/helpers/cart_service.dart';
import 'package:estallecomerch/helpers/products_db_service.dart';
import 'package:estallecomerch/helpers/provider/products_provider.dart';
import 'package:estallecomerch/models/choose_products_models.dart';
import 'package:estallecomerch/models/products_models_user.dart';
import 'package:estallecomerch/pages/my_order_page.dart';
import 'package:estallecomerch/pages/payment_screen.dart';
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
  List<String>  imageUrl=[];
  String imageurl1;
  String imageurl2;
  String imageurl3;

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

        imageurl1=widget.products.imageUrl;
        imageurl2=widget.products.imageUrl2.isEmpty?widget.products.imageUrl:widget.products.imageUrl2;
        imageurl3=widget.products.imageUrl3.isEmpty?widget.products.imageUrl:widget.products.imageUrl3;

        imageUrl.add(imageurl1);
        imageUrl.add(imageurl2);
        imageUrl.add(imageurl3);

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
                        CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                            enlargeStrategy: CenterPageEnlargeStrategy.height,
                          ),
                          items: imageUrl.map((item) => Container(
                            child: Container(
                              margin: EdgeInsets.all(5.0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  child: Stack(
                                    children: <Widget>[
                                      Image.network(item, fit: BoxFit.cover, width: 1000.0),
                                      Positioned(
                                        bottom: 0.0,
                                        left: 0.0,
                                        right: 0.0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color.fromARGB(200, 0, 0, 0),
                                                Color.fromARGB(0, 0, 0, 0)
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                          child: Text(
                                            'No. ${imageUrl.indexOf(item)+1} image',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                            ),
                          )).toList(),
                        ),
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
                            icon: Icon(widget.products.favouriteCheck==false?Icons.favorite_border:Icons.favorite,color: Colors.red,),
                            onPressed: (){
                              setState(() {
                                widget.products.favouriteCheck=!widget.products.favouriteCheck;

                                if(widget.products.favouriteCheck==true){
                                  widget.products.favouriteCheck=='statusTrue';
                                  ProductsDBService.addProductWithUSER(widget.products,email).then((value){
                                    setState(() {
                                      print(('isFavourite True'));
                                    });
                                  });
                                  ProductsDBService.addProductBYCategoryWithUser(widget.products, email);
                                  ProductsDBService.addProductByAuthorWithUser(widget.products, email);
                                  ProductsDBService.addFavouriteProductsWithUser(widget.products, email);

                                }else{
                                  widget.products.favouriteCheck=='statusfalse';
                                  ProductsDBService.addProductWithUSER(widget.products,email).then((value){
                                    setState(() {
                                      print(('isFavourite False'));
                                    });
                                  });
                                  ProductsDBService.addProductBYCategoryWithUser(widget.products, email);
                                  ProductsDBService.addProductByAuthorWithUser(widget.products, email);
                                  ProductsDBService.removeAllFavouriteWithUser(widget.products,email);
                                }

                              });
                            },
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                                child: Text(widget.products.name,style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),)),

                            Text(widget.products.last_price==0?'':'BDT ${widget.products.last_price}',style: TextStyle(
                                fontSize: 16,
                              decoration: TextDecoration.lineThrough
                            ),),
                          ],
                        ),

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
                            Text(widget.products.price==null?'BDT 0':'BDT ${widget.products.price}',style: TextStyle(
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
                      child: Text("Description: \n\n${widget.products.description}",style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                      ),))
                ],
              )),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 60,
                color: Colors.green.withOpacity(.7),
                child: Consumer<ProductsProvider>(
                  builder: (context,cart,child){
                    return cart.count==0?Container():
                    Container(
                      width: double.infinity,
                      height: 60,
                      color: Colors.green.withOpacity(.7),
                      child: FlatButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Place Order',style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),),

                            Consumer<ProductsProvider>(
                              builder: (context,data,child){
                                return Container(
                                  padding: EdgeInsets.only(right: 15),
                                  child: Text('৳ ${data.totalPrice}',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),),
                                );
                              },
                            ),
                          ],
                        ),
                        onPressed: (){
                          if(cart.count==0){
                            Toast.show('Please select items', context);
                          }else if(cart.totalPrice<200){
                            Toast.show('Warning : আপনার অর্ডারটি সম্পূর্ণ করতে নূন্যতম ২০০ টাকার পণ্য লাগবে.', context);
                          }
                          else{
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context)=>PaymentScreen()
                            )).then((_){
                              setState(() {

                              });
                            });
                          }

                        },
                      ),
                    );
                  },
                ),


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
