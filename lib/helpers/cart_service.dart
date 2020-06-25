
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estallecomerch/models/choose_products_models.dart';
import 'package:estallecomerch/models/payment_product_models.dart';
import 'package:estallecomerch/models/shop_models.dart';

final COLLECTION_PRODUCTS_CHOOSE='products_choose';
final COLLECTION_PAYMENT_SHOP='shop_wise_product_seel';
final COLLECTION_PAYMENT_SHOP_NAME='payment_shopName';

class CartService{

  static final Firestore db=Firestore.instance;


  static Future addtocartProduct(ChooseProductModels chooseProductModels,String email)async{
    final doc= db.collection(COLLECTION_PRODUCTS_CHOOSE).document(email).collection('Products').document(chooseProductModels.nameKey);
    return await doc.setData(chooseProductModels.toMap());
  }

  static Future removetocartProduct(ChooseProductModels chooseProductModels,String email)async{
    final doc= db.collection(COLLECTION_PRODUCTS_CHOOSE).document(email).collection('Products').document(chooseProductModels.nameKey);
    return await doc.delete();
  }

  static Future<List<ChooseProductModels>> getAllChooseProducts(String email)async{
    QuerySnapshot snapshot=await db.collection(COLLECTION_PRODUCTS_CHOOSE).document(email).collection('Products').getDocuments();

    if(snapshot!=null){
      return snapshot.documents.map((chooseProducts) => ChooseProductModels.fromMap(chooseProducts.data)).toList();
    }
  }

  static Future addtocartProductDelete(String nameKey,String email)async{
    final doc= db.collection(COLLECTION_PRODUCTS_CHOOSE).document(email).collection('Products').document(nameKey);
    return await doc.delete();
  }

  static Future addShopNameForPayment(PaymentProductModels paymentProductModels,String date,String email,String time)async{
    final doc=db.collection(COLLECTION_PAYMENT_SHOP).document(date).collection(paymentProductModels.authName).document(email).collection(time).document(paymentProductModels.keyName);
    return await doc.setData(paymentProductModels.tomap());
  }
  static Future<List<PaymentProductModels>> getShopNameForPayment(String authName,String date,String email,String time)async{
    QuerySnapshot snapshot=await db.collection(COLLECTION_PAYMENT_SHOP).document(date).collection(authName).document(email).collection(time).getDocuments();
    if(snapshot!=null){
      return snapshot.documents.map((e) => PaymentProductModels.fromMap(e.data)).toList();
    }
  }


  static Future addShopName(ShopModels shopname,String date)async{
    final doc=db.collection(COLLECTION_PAYMENT_SHOP_NAME).document(date).collection('shopName').document(shopname.name);
    return await doc.setData(shopname.tomap());
  }

  static Future<List<ShopModels>> getShopNameForPaymentName(String date)async{
    QuerySnapshot snapshot=await db.collection(COLLECTION_PAYMENT_SHOP_NAME).document(date).collection('shopName').getDocuments();
    if(snapshot!=null){
      return snapshot.documents.map((e) => ShopModels.formMap(e.data)).toList();
    }
  }



}