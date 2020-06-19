import 'package:estallecomerch/pages/catagory_wise_product.dart';
import 'package:estallecomerch/pages/catagory_wise_product_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              child: Container(
                margin: EdgeInsets.only(right: 2,bottom: 2),
                child: FlatButton(
                  color: Colors.lightBlue.withOpacity(.7),
                  child: Container(
                    height: 150,
                    alignment: Alignment.center,
                    child: Text('Groceries',style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),),
                  ),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=>CategoryWiseProductList(categoryName: 'groceries',isListPage: true,),
                    ));
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 2),
                child: FlatButton(
                  color: Colors.lightBlue.withOpacity(.8),
                  child: Container(
                    height: 150,
                    alignment: Alignment.center,
                    child: Text('Drink & Desert',style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),),
                  ),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=>CategoryWiseProductList(categoryName: 'drink_desert',isListPage: true,),
                    ));
                  },
                ),
              ),
            ),
          ],),
          Row(children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 2,bottom: 2),
                child: FlatButton(
                  color: Colors.lightBlue.withOpacity(.7),
                  child: Container(
                    height: 150,
                    alignment: Alignment.center,
                    child: Text('Gas Cylinder',style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),),
                  ),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=>CategoryWiseProductList(categoryName: 'gas_cylinder',isListPage: true,),
                    ));
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 2),
                child: FlatButton(
                  color: Colors.lightBlue.withOpacity(.8),
                  child: Container(
                    height: 150,
                    alignment: Alignment.center,
                    child: Text('Mask & Sanitiser',style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),),
                  ),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=>CategoryWiseProductList(categoryName: 'mask_sanitiser',isListPage: true,),
                    ));
                  },
                ),
              ),
            ),
          ],),
          Row(children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 2,bottom: 2),
                child: FlatButton(
                  color: Colors.lightBlue.withOpacity(.7),
                  child: Container(
                    height: 150,
                    alignment: Alignment.center,
                    child: Text('Fashion',style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),),
                  ),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=>CategoryWiseProductList(categoryName: 'fashion',isListPage: true,),
                    ));
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 2),
                child: FlatButton(
                  color: Colors.lightBlue.withOpacity(.8),
                  child: Container(
                    height: 150,
                    alignment: Alignment.center,
                    child: Text('Cosmetics',style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),),
                  ),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=>CategoryWiseProductList(categoryName: 'cosmetics',isListPage: true,),
                    ));
                  },
                ),
              ),
            ),
          ],),
          Row(children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 2,bottom: 2),
                child: FlatButton(
                  color: Colors.lightBlue.withOpacity(.7),
                  child: Container(
                    height: 150,
                    alignment: Alignment.center,
                    child: Text('Electronics',style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),),
                  ),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=>CategoryWiseProductList(categoryName: 'electronic',isListPage: true,),
                    ));
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 2),
                child: FlatButton(
                  color: Colors.lightBlue.withOpacity(.8),
                  child: Container(
                    height: 150,
                    alignment: Alignment.center,
                    child: Text('Furniture',style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),),
                  ),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=>CategoryWiseProductList(categoryName: 'furniture',isListPage: true,),
                    ));
                  },
                ),
              ),
            ),
          ],),
        ],
      ),
    );
  }
}
