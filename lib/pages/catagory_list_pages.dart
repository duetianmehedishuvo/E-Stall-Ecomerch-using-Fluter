import 'package:estallecomerch/pages/catagory_wise_product.dart';
import 'package:estallecomerch/pages/catagory_wise_product_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String cosmetics='cosmetics';
String fashion='fashion';
String mask_sanitiser='mask_sanitiser';
String gas_cylinder='gas_cylinder';
String drink_desert='drink_desert';
String groceries='groceries';

class CategoryListPages extends StatefulWidget {
  @override
  _CategoryListPagesState createState() => _CategoryListPagesState();
}

class _CategoryListPagesState extends State<CategoryListPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category List'),
      ),
      body: ListView(
        children: <Widget>[
          Row(children: <Widget>[
            Expanded(
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=>CategoryWiseProductList(categoryName: groceries,isListPage: true,),
                    ));
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 2,bottom: 2),
                    height: 150,
                    child: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Image.asset('images/grocery.jpg',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
//                        Container(
//                          width: double.infinity,
//                          height: double.infinity,
//                          color: Colors.blue.withOpacity(.3),
//                        ),
//                        Positioned(
//                          right: 5,
//                          bottom: 5,
//                          left: 5,
//                          child: Container(
//                            alignment: Alignment.center,
//                            padding: EdgeInsets.all(8),
//                            decoration: BoxDecoration(
//                                color: Colors.black.withOpacity(.5),
//                                borderRadius: BorderRadius.circular(10)
//                            ),
//                            child: Text('Groceries',style: TextStyle(
//                              fontSize: 20,
//                              color: Colors.white,
//                              fontWeight: FontWeight.w500,
//                            ),),
//                          ),
//                        )
                      ],
                    ),
                  ),
                )
            ),
            Expanded(
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=>CategoryWiseProductList(categoryName: drink_desert,isListPage: true,),
                    ));
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 2,bottom: 2),
                    height: 150,
                    child: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Image.asset('images/grocery (2).jpg',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
//                        Container(
//                          width: double.infinity,
//                          height: double.infinity,
//                          color: Colors.blue.withOpacity(.3),
//                        ),
//                        Positioned(
//                          right: 5,
//                          bottom: 5,
//                          left: 5,
//                          child: Container(
//                            alignment: Alignment.center,
//                            padding: EdgeInsets.all(8),
//                            decoration: BoxDecoration(
//                                color: Colors.black.withOpacity(.5),
//                                borderRadius: BorderRadius.circular(10)
//                            ),
//                            child: Text('Drink & Desert',style: TextStyle(
//                              fontSize: 20,
//                              color: Colors.white,
//                              fontWeight: FontWeight.w500,
//                            ),),
//                          ),
//                        )
                      ],
                    ),
                  ),
                )
            ),
          ],),
          Row(children: <Widget>[
            Expanded(
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=>CategoryWiseProductList(categoryName: gas_cylinder,isListPage: true,),
                    ));
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 2,bottom: 2),
                    height: 150,
                    child: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Image.asset('images/Gas R.jpg',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.blue.withOpacity(.3),
                        ),
                        Positioned(
                          right: 5,
                          bottom: 5,
                          left: 5,
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.5),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Text('Gas Cylinder',style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),),
                          ),
                        )
                      ],
                    ),
                  ),
                )
            ),
            Expanded(
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=>CategoryWiseProductList(categoryName: mask_sanitiser,isListPage: true,),
                    ));
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 2,bottom: 2),
                    height: 150,
                    child: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Image.asset('images/mask R.jpg',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.blue.withOpacity(.3),
                        ),
                        Positioned(
                          right: 5,
                          bottom: 5,
                          left: 5,
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.5),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Text('Mask & Sanitiser',style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),),
                          ),
                        )
                      ],
                    ),
                  ),
                )
            ),

          ],),
          Row(children: <Widget>[
            Expanded(
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=>CategoryWiseProductList(categoryName: fashion,isListPage: true,),
                    ));
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 2,bottom: 2),
                    height: 150,
                    child: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Image.asset('images/Fasion Final R.jpg',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.blue.withOpacity(.3),
                        ),
                        Positioned(
                          right: 5,
                          bottom: 5,
                          left: 5,
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.5),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Text('Fashion',style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),),
                          ),
                        )
                      ],
                    ),
                  ),
                )
            ),
            Expanded(
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=>CategoryWiseProductList(categoryName: cosmetics,isListPage: true,),
                    ));
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 2,bottom: 2),
                    height: 150,
                    child: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Image.asset('images/Cosmetics Final R.jpg',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.blue.withOpacity(.3),
                        ),
                        Positioned(
                          right: 5,
                          bottom: 5,
                          left: 5,
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.5),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Text('Cosmetics',style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),),
                          ),
                        )
                      ],
                    ),
                  ),
                )
            ),

          ],),
          Row(children: <Widget>[
            Expanded(
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=>CategoryWiseProductList(categoryName: 'electronic',isListPage: true,),
                    ));
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 2,bottom: 2),
                    height: 150,
                    child: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Image.asset('images/Electronic R.jpg',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.blue.withOpacity(.3),
                        ),
                        Positioned(
                          right: 5,
                          bottom: 5,
                          left: 5,
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.5),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Text('Electronics',style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),),
                          ),
                        )
                      ],
                    ),
                  ),
                )
            ),
            Expanded(
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context)=>CategoryWiseProductList(categoryName: 'furniture',isListPage: true,),
                  ));
                },
                child: Container(
                  margin: EdgeInsets.only(right: 2,bottom: 2),
                  height: 150,
                  child: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Image.asset('images/Furniture R.jpg',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.blue.withOpacity(.3),
                      ),
                      Positioned(
                        right: 5,
                        bottom: 5,
                        left: 5,
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(.5),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text('Furniture',style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ),
          ],),
        ],
      ),
    );
  }
}

