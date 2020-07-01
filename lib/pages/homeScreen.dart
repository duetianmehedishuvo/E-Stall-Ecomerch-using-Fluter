import 'dart:io';

import 'package:deivao_drawer/deivao_drawer.dart';
import 'package:deivao_drawer/drawer_controller.dart';
import 'package:estallecomerch/helpers/authentication_service.dart';
import 'package:estallecomerch/helpers/cart_service.dart';
import 'package:estallecomerch/helpers/products_db_service.dart';
import 'package:estallecomerch/helpers/provider/products_provider.dart';
import 'package:estallecomerch/helpers/user_utils.dart';
import 'package:estallecomerch/models/products_models_user.dart';
import 'package:estallecomerch/pages/about_developer_page.dart';
import 'package:estallecomerch/pages/about_screen.dart';
import 'package:estallecomerch/pages/catagory_list_pages.dart';
import 'package:estallecomerch/pages/catagory_wise_product.dart';
import 'package:estallecomerch/pages/contact_pages.dart';
import 'package:estallecomerch/pages/login_page.dart';
import 'package:estallecomerch/pages/my_order_page.dart';
import 'package:estallecomerch/pages/payment_screen.dart';
import 'package:estallecomerch/pages/product_screen.dart';
import 'package:estallecomerch/pages/profile_page.dart';
import 'package:estallecomerch/pages/shop_page.dart';
import 'package:estallecomerch/pages/wish_list_page.dart';
import 'package:estallecomerch/widgets/products_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class HomeScreen extends StatefulWidget {
  static final route='/homeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final drawerController = DeivaoDrawerController();

  AuthenticationService authenticationService;
  String useremail;
  String name='';
  String address='';
  ProductsUserId productsUserId;
  int count=0;

  Future<bool> _onBackPressed() async {
    // Your back press code here...
    Toast.show('Back Pressed', context);
    showAlertDialog(context, 'Are you sure  want to Exit Now And Save Your Products in Cart ?', "E-stall" , "Exit", "Cancel",'Save & Exit');
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    authenticationService=AuthenticationService();
    productsUserId=ProductsUserId();
    AuthenticationService.getUserPhoneNumberByPreference().then((email){
      print(email);
      useremail=email;
      setState(() {

        authenticationService.getUserProfileByEmail(email).then((profile){
          setState(() {
            name=profile.name;
            address=profile.address;
          });
        });

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
  }
  

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    authenticationService=null;
  }


  @override
  Widget build(BuildContext context) {


    return DeivaoDrawer(
      controller: drawerController,
      drawer: _buildDrawer(context),
      child: DefaultTabController(
        length: 9,
        child: WillPopScope(
          onWillPop: _onBackPressed,
          child: Scaffold(
              appBar: AppBar(
                centerTitle: false,
                leading: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: drawerController.toggle,
                ),
                title: Text('Estall',style: TextStyle(fontSize: 18.0),),
                actions: <Widget>[

                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: (){
                      showSearch(context: context, delegate: ProductSearchDelegate(useremail)).then((value){
                        setState(() {

                        });
                      });
                    },
                  ),

                  Stack(
                    children: <Widget>[
                      Consumer<ProductsProvider>(
                        builder: (context,data,child){
                          return IconButton(
                            icon: Icon(Icons.shopping_cart,color: Colors.white,),
                            onPressed: (){
                              data.count==0?Toast.show('Please Select atleast One Product', context):
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context)=>MyOrderPage()
                              )).then((_){
                                setState(() {

                                });
                              });
                            },
                          );
                        },
                      ),
                      Positioned(
                        right: 10,
                        child: Consumer<ProductsProvider>(
                          builder: (context,cart,child){
                            return cart.count==0?Container():Container(
                              alignment: Alignment.center,
                              constraints: BoxConstraints(
                                maxHeight: 20,
                                maxWidth: 20,
                              ),
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white
                              ),
                                child: FittedBox(child: Text(cart.count.toString(),style: TextStyle(
                                  color: Colors.black,
                                ),)),
                            );
                          },
                        )
                      )
                    ],
                  ),
                ],
                bottom: PreferredSize(
                    child: TabBar(
                      labelColor: Colors.white,
                        isScrollable: true,
                        unselectedLabelColor: Colors.black.withOpacity(0.6),
                        indicatorColor: Colors.black,
                        tabs: [
                          Tab(
                            child: Text('All',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          ),
                          Tab(
                            child: Text('Grocery',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          ),
                          Tab(
                            child: Text('Drink & Dessert',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          ),
                          Tab(
                            child: Text('Gas Cylinder',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          ),
                          Tab(
                            child: Text('Mask & Sanitiser',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          ),
                          Tab(
                            child: Text('Fashion',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          ),
                          Tab(
                            child: Text('Cosmetics',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          ),
                          Tab(
                            child: Text('Electronic',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          ),
                          Tab(
                            child: Text('Furniture',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          ),
                        ]),
                    preferredSize: Size.fromHeight(45.0)),
              ),
              body: TabBarView(
                children: <Widget>[
                  ProductScreen(),
                  CategoryWiseProduct(categoryName:'groceries',isListPage: false,),
                  CategoryWiseProduct(categoryName:'drink_desert',isListPage: false,),
                  CategoryWiseProduct(categoryName:'gas_cylinder',isListPage: false,),
                  CategoryWiseProduct(categoryName:'mask_sanitiser',isListPage: false,),
                  CategoryWiseProduct(categoryName:'fashion',isListPage: false,),
                  CategoryWiseProduct(categoryName:'cosmetics',isListPage: false,),
                  CategoryWiseProduct(categoryName:'electronic',isListPage: false,),
                  CategoryWiseProduct(categoryName:'furniture',isListPage: false,),
                ],
              )),
        ),
      )
    );
  }

  ListView _buildDrawer(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(0),
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 50, bottom: 20),
          color: Colors.blue,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipOval(
                child: Image.asset(
                  "images/user.png",
                  width: 70,
                  height: 70,
                ),
              ),
              SizedBox(height: 15),
              Text(
                name,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                address,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.blue.withOpacity(.5),
          child: ListTile(
              onTap: (){
                Navigator.of(context).pushNamed(HomeScreen.route);
              },
              leading: Icon(Icons.home,color: Colors.white,), title: Text("Home")),
        ),
        Container(
          height: 1,
          color: Colors.blue.withOpacity(.4),
        ),
        Container(
          color: Colors.blue.withOpacity(.5),
          child: ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context)=>CategoryListPages()
                )).then((_){
                  setState(() {

                  });
                });
              },
              leading: Icon(Icons.category,color: Colors.white,), title: Text("Categories")),
        ),
        Container(
          height: 1,
          color: Colors.blue.withOpacity(.4),
        ),
        Container(
          color: Colors.blue.withOpacity(.5),
          child: ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context)=>ShopPage()
                ));
              },
              leading: Icon(Icons.shop,color: Colors.white,), title: Text("Shop")),
        ),
        Container(
          height: 1,
          color: Colors.blue.withOpacity(.4),
        ),
        Container(
          color: Colors.blue.withOpacity(.5),
          child: ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context)=>WishListPage()
                )).then((_){
                  setState(() {

                  });
                });
              },
              leading: Icon(Icons.favorite_border,color: Colors.white,), title: Text("Wish List")),
        ),
        Container(
          height: 1,
          color: Colors.blue.withOpacity(.4),
        ),
        Container(
          color: Colors.blue.withOpacity(.5),
          child: ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context)=>ProfilePage()
                )).then((_){
                  setState(() {

                    AuthenticationService.getUserPhoneNumberByPreference().then((value){
                      print(value);
                      setState(() {
                        authenticationService.getUserProfileByEmail(value).then((profile){
                          setState(() {
                            name=profile.name;
                            address=profile.address;
                          });
                        });
                      });
                    });

                  });
                });
              },
              leading: Icon(Icons.account_box,color: Colors.white,), title: Text("My Account")),
        ),
        Container(
          height: 1,
          color: Colors.blue.withOpacity(.4),
        ),
        Container(
          color: Colors.blue.withOpacity(.5),
          child: ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context)=>MyOrderPage()
                )).then((_){
                  setState(() {

                  });
                });
              },
              leading: Icon(Icons.reorder,color: Colors.white,), title: Text("My Card")),
        ),
        Container(
          height: 1,
          color: Colors.blue.withOpacity(.4),
        ),
        Container(
          color: Colors.blue.withOpacity(.5),
          child: ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context)=>ContactPage()
                ));
              },
              leading: Icon(Icons.contacts,color: Colors.white,), title: Text("Contact Us")),
        ),
        Container(
          height: 1,
          color: Colors.blue.withOpacity(.4),
        ),
        Container(
          color: Colors.blue.withOpacity(.5),
          child: ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context)=>AboutScreen()
                ));
              },
              leading: Icon(Icons.info,color: Colors.white,), title: Text("About Us")),
        ),
        Container(
          height: 1,
          color: Colors.blue.withOpacity(.4),
        ),
        Container(
          color: Colors.blue.withOpacity(.5),
          child: ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context)=>AboutDeveloperPage()
                ));
              },
              leading: Icon(Icons.developer_mode,color: Colors.white,), title: Text("Apps Developer")),
        ),
        Container(
          height: 1,
          color: Colors.blue.withOpacity(.4),
        ),
        Container(
          color: Colors.blue.withOpacity(.5),
          child: ListTile(
            onTap: (){

              authenticationService.logout().then((_){
                Navigator.of(context).pushReplacementNamed(LoginPage.route);
              });
            },
              leading: Image.asset('images/signin.png',width: 20,height: 20,),
              title: Text("Logout")),
        ),
        Container(
          height: 200,
          color: Colors.blue.withOpacity(.4),
        ),
      ],
    );
  }

  ////// Alert Dialog Code
  showAlertDialog(BuildContext context, String message, String heading,
      String buttonAcceptTitle, String buttonCancelTitle,String saveStateTitle) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(buttonCancelTitle),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text(buttonAcceptTitle),
      onPressed: () {
        UserUtils.saveUserSessionToPreference(false);
        UserUtils.getUserSessionUsingPref().then((value) {
          print(value.toString());
          exit(0);
        });
      },
    );
    Widget saveStateButton = FlatButton(
      child: Text(saveStateTitle),
      onPressed: () {
        UserUtils.saveUserSessionToPreference(true);
        UserUtils.getUserSessionUsingPref().then((value) {
          print(value.toString());
          exit(0);
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(heading),
      content: Text(message),
      actions: [
        saveStateButton,
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }




}

class ProductSearchDelegate extends SearchDelegate{
  final String userEmail;
  ProductSearchDelegate(this.userEmail);

  @override
  List<Widget> buildActions(BuildContext context) {
    return[
      IconButton(
        icon: Icon(Icons.cancel),
        onPressed: (){
          query='';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_left),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,

    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    return Center(
      child: FutureBuilder(
        future: ProductsDBService.getAllProductsWithUser(userEmail),
        builder: (context,AsyncSnapshot<List<ProductsUserId>> snapshot){
          if(snapshot.hasData){
            List<ProductsUserId> suggestions=query==null?
            snapshot.data:
            snapshot.data.where((products)=>
            (products.nameKey.toLowerCase().startsWith(query.toLowerCase()))||(products.name.toLowerCase().startsWith(query.toLowerCase()))||(products.authorName.toLowerCase().startsWith(query.toLowerCase()))).toList();

            return StaggeredGridView.countBuilder(crossAxisCount: 4,
                itemCount: suggestions.length,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                itemBuilder: (context,index)=>ProductsWidgets(suggestions[index]),
                staggeredTileBuilder: (_)=>StaggeredTile.fit(2));
          }

          if(snapshot.hasError){
            return new Text('Data Fetch problems');
          }
          return CircularProgressIndicator();
        },

      ),
    );
  }

}