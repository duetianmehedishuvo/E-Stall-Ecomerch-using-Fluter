import 'package:estallecomerch/helpers/authentication_service.dart';
import 'package:estallecomerch/helpers/cart_service.dart';
import 'package:estallecomerch/helpers/products_db_service.dart';
import 'package:estallecomerch/helpers/provider/products_provider.dart';
import 'package:estallecomerch/models/choose_products_models.dart';
import 'package:estallecomerch/models/products_models_user.dart';
import 'package:estallecomerch/pages/product_details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ProductsWidgets extends StatefulWidget {
  final ProductsUserId products;
  ProductsWidgets(this.products);

  @override
  _ProductsWidgetsState createState() => _ProductsWidgetsState();
}

class _ProductsWidgetsState extends State<ProductsWidgets> {

  int countNumber;
  AuthenticationService authenticationService;
  String email;
  int productprice;
  CartService cartService;
  int cnt;
  int mainPrice;

  bool isFavourite=false;

  ChooseProductModels chooseProductModels=ChooseProductModels();
  ProductsProvider productsProvider=ProductsProvider();


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

    Provider.of<ProductsProvider>(context,listen: false).count;

    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context)=>ProductDetailsPage(widget.products,countNumber)
        )).then((_){
          setState(() {
            widget.products.count==0?countNumber=0:countNumber=widget.products.count;
          });
        });
      },
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
                color: Colors.blue.withOpacity(.1),
                child: Image.network(widget.products.imageUrl,width: double.infinity,height: 150,fit: BoxFit.cover,)),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('${widget.products.name}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  IconButton(
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
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: 8),
                    child: Text('BDT ${widget.products.current_price}',style: TextStyle(fontSize: 15,color: Colors.green),)),
                Container(
                    padding: EdgeInsets.only(right: 8),
                    child: Text('',style: TextStyle(fontSize: 15,color: Colors.green),)),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 4,top: 5,bottom: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.lightBlue
                              ),
                              height: 40,
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
                          ),
                          Expanded(child: Container(
                            height: 40,
                            color: Colors.blue.withOpacity(.1),
                              alignment: Alignment.center,
                              child: Text('${widget.products.count}'))),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 4,top: 5,bottom: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.lightBlue
                              ),
                              height: 40,
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
                          ),
                        ],
                      ),
                    )),
                Expanded(child: Container(
                    alignment: Alignment.center,
                    child: FittedBox(child: Text(widget.products.quantity,style: TextStyle(fontSize: 15),))))
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              color: widget.products.condition=='Add To Cart'?Colors.blue:Colors.red,
              child: Text(widget.products.price==null?'0':"৳ ${widget.products.price}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,letterSpacing: .7),),
            ),
          ],
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
    chooseProductModels.imageUrl2=widget.products.imageUrl2;
    chooseProductModels.imageUrl3=widget.products.imageUrl3;
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
      Provider.of<ProductsProvider>(context,listen: false).getTotalprice(email);

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
        Provider.of<ProductsProvider>(context,listen: false).getTotalprice(email);
      }else{

        ProductsDBService.addProductWithUSER(widget.products,email);

        ProductsDBService.addProductBYCategoryWithUser(widget.products, email);
        ProductsDBService.addProductByAuthorWithUser(widget.products, email);
        Provider.of<ProductsProvider>(context,listen: false).getCount(email);
        Provider.of<ProductsProvider>(context,listen: false).getTotalprice(email);

        CartService.addtocartProduct(chooseProductModels, email).then((_){
          Toast.show('${chooseProductModels.totalPrice} \$', context);
        });
      }

    });

  }

}
