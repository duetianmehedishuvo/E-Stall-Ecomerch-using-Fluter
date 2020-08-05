import 'package:estallecomerch/helpers/authentication_service.dart';
import 'package:estallecomerch/helpers/cart_service.dart';
import 'package:estallecomerch/helpers/products_db_service.dart';
import 'package:estallecomerch/helpers/provider/products_provider.dart';
import 'package:estallecomerch/helpers/user_utils.dart';
import 'package:estallecomerch/models/choose_products_models.dart';
import 'package:estallecomerch/models/products_models_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ChooseProductWidget extends StatefulWidget {
  final ChooseProductModels chooseProductModels;
  ChooseProductWidget(this.chooseProductModels);



  @override
  _ChooseProductWidgetState createState() => _ChooseProductWidgetState();
}

class _ChooseProductWidgetState extends State<ChooseProductWidget> {

  int countNumber;
  AuthenticationService authenticationService;
  String email;
  ProductsUserId productsUserId;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authenticationService=AuthenticationService();
    productsUserId=ProductsUserId();
    AuthenticationService.getUserPhoneNumberByPreference().then((getEmail){
      setState(() {
        email=getEmail;
      });
    });
    countNumber=widget.chooseProductModels.count;

    UserUtils.getUserSessionUsingPref().then((value) {
      print(value.toString());
      if(value==false){
        //CartService.removetocartProduct(widget.chooseProductModels, email);
      }
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    authenticationService=null;
  }


  @override
  Widget build(BuildContext context) {
    return _center(context);
  }


  Widget _center(BuildContext context){
    return GestureDetector(
      onTap: (){

      },
      child: Card(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                    child:  Image.asset('images/no-img.jpg',
                      width:   double.infinity,
                      height: 150,
                      fit: BoxFit.cover,)),

                Container(
                    child:  Image.network(widget.chooseProductModels.imageUrl==null?'https://www.publicdomainpictures.net/pictures/280000/velka/not-found-image-15383864787lu.jpg':widget.chooseProductModels.imageUrl,
                      width:   double.infinity,
                      height: 150,
                      fit: BoxFit.cover,)),



              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(flex:3,child: Text('${widget.chooseProductModels.name}',style:const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,)),
                  Expanded(
                    child: IconButton(
                      icon: const Icon(Icons.favorite_border,color: Colors.grey,),
                      onPressed: (){},
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: 8),
                    child: Text('BDT ${widget.chooseProductModels.current_price}',style:const TextStyle(fontSize: 15,color: Colors.green),)),
                Container(
                    padding: EdgeInsets.only(right: 8),
                    child: Text(widget.chooseProductModels.last_price==0?'':'BDT ${widget.chooseProductModels.last_price}',style:const TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.lineThrough
                    ),),),
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
                              margin:const EdgeInsets.only(left: 4,top: 5,bottom: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.lightBlue
                              ),
                              height: 40,
                              child: IconButton(
                                icon: const Icon(Icons.keyboard_arrow_left,color: Colors.white,),
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
                              child: Text('${widget.chooseProductModels.count}'))),
                          Expanded(
                            child: Container(
                              margin:const EdgeInsets.only(right: 4,top: 5,bottom: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.lightBlue
                              ),
                              height: 40,
                              child: IconButton(
                                icon:const Icon(Icons.keyboard_arrow_right,color: Colors.white,),
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
                    child: FittedBox(child: Text(widget.chooseProductModels.quantity,style:const TextStyle(fontSize: 15),))))
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding:const EdgeInsets.all(8),
              alignment: Alignment.center,
              color: widget.chooseProductModels.condition=='Add To Cart'?Colors.blue:Colors.red,
              child: Text("৳ ${widget.chooseProductModels.totalPrice}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,letterSpacing: .7),),
            ),
          ],
        ),
      ),
    );
  }


  void initializationUserProductsScreen(String email,num price) {
      productsUserId.name=widget.chooseProductModels.name;
      productsUserId.nameKey=widget.chooseProductModels.nameKey;
      productsUserId.imageUrl=widget.chooseProductModels.imageUrl;
      productsUserId.imageUrl2=widget.chooseProductModels.imageUrl2;
      productsUserId.imageUrl3=widget.chooseProductModels.imageUrl3;
      productsUserId.current_price=widget.chooseProductModels.current_price;
      productsUserId.last_price=widget.chooseProductModels.last_price;
      productsUserId.category=widget.chooseProductModels.category;
      productsUserId.description=widget.chooseProductModels.description;
      productsUserId.condition=widget.chooseProductModels.condition;
      productsUserId.quantity=widget.chooseProductModels.quantity;
      productsUserId.authorName=widget.chooseProductModels.authorName;
      productsUserId.count=widget.chooseProductModels.count;
      productsUserId.price=price;

      ProductsDBService.addProductWithUSER(productsUserId, email);

  }
  void _rightArrowClick() {

    widget.chooseProductModels.count=countNumber;
    num price=countNumber*widget.chooseProductModels.current_price;
    widget.chooseProductModels.totalPrice=price;

    CartService.addtocartProduct(widget.chooseProductModels, email).then((_){
      Toast.show('${widget.chooseProductModels.totalPrice} ৳', context);
      print('${widget.chooseProductModels.totalPrice}');
    });

    initializationUserProductsScreen(email,price);
    Provider.of<ProductsProvider>(context,listen: false).getCount(email);
    Provider.of<ProductsProvider>(context,listen: false).getTotalprice(email);

  }

  void _leftArrowClick() {

    widget.chooseProductModels.count=countNumber;
    num price=countNumber*widget.chooseProductModels.current_price;
    widget.chooseProductModels.totalPrice=price;

    if(countNumber==0){
      CartService.removetocartProduct(widget.chooseProductModels, email);
    }else{
      CartService.addtocartProduct(widget.chooseProductModels, email).then((_){
        Toast.show('${widget.chooseProductModels.totalPrice} ৳', context);
      });
    }

    initializationUserProductsScreen(email,price);
    Provider.of<ProductsProvider>(context,listen: false).getCount(email);
    Provider.of<ProductsProvider>(context,listen: false).getTotalprice(email);
  }

}
