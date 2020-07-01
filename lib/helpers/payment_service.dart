import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estallecomerch/models/payment_get_email.dart';
import 'package:estallecomerch/models/payment_models.dart';
import 'package:estallecomerch/models/payment_product_models.dart';

final COLLECTION_PAYMENT='payment';
final COLLECTION_PAYMENT_DETAILS='payment_details';
class PaymentService{

  static final Firestore db=Firestore.instance;

  static Future addPayment(PaymentModels paymentModels,String date,String time)async{
    final doc=db.collection(COLLECTION_PAYMENT).document(date).collection('allEmail').document(paymentModels.profile.email).collection('AllTime').document(time).collection('collection').document('userPayment');
    return await doc.setData(paymentModels.toMap());
  }

//  static Future<List<PaymentModels>> getUserPayment(String date) async{
//    QuerySnapshot snapshot=await db.collection(COLLECTION_PAYMENT).document(date).collection('allEmail').document("01777368276@gmail.com").collection('AllTime').document("09:15:25 PM").collection('collection').getDocuments();
//    if(snapshot!=null){
//      return snapshot.documents.map((e) => PaymentModels.fromMap(e.data)).toList();
//    }
//  }


  static Future addPaymentEmail(PaymentGetEmail paymentGetEmail,String date)async{
    final doc=db.collection(COLLECTION_PAYMENT_DETAILS).document(date).collection('allEmail').document(paymentGetEmail.email);
    return await doc.setData(paymentGetEmail.toMap());
  }
//  static Future<List<PaymentGetEmail>> getUserEmailforPayment(String date) async{
//    QuerySnapshot snapshot=await db.collection(COLLECTION_PAYMENT_DETAILS).document(date).collection('allEmail').getDocuments();
//    if(snapshot!=null){
//      return snapshot.documents.map((e) => PaymentGetEmail.fromMap(e.data)).toList();
//    }
//  }



  static Future addPaymentTime(PaymentGetEmail paymentGetEmail,String date)async{
    final doc=db.collection(COLLECTION_PAYMENT_DETAILS).document(date).collection('AllTime').document(paymentGetEmail.email).collection('AllTime').document(paymentGetEmail.date);
    return await doc.setData(paymentGetEmail.toMap());
  }
//  static Future<List<PaymentGetEmail>> getUserTimeforPayment(String date) async{
//    QuerySnapshot snapshot=await db.collection(COLLECTION_PAYMENT_DETAILS).document(date).collection('AllTime').document('01777368276@gmail.com').collection('AllTime').getDocuments();
//    if(snapshot!=null){
//      return snapshot.documents.map((e) => PaymentGetEmail.fromMap(e.data)).toList();
//    }
//  }

  static Future addPaymentShopName(PaymentModels paymentModels,String date,String time)async{
    final doc=db.collection(COLLECTION_PAYMENT_DETAILS).document(date).collection('AllShopName').document(paymentModels.paymentProductModels[0].authName).collection(paymentModels.profile.email).document(time);
    return doc.setData(paymentModels.toMap());
  }
//
//  static Future<List<PaymentModels>> getAllShopName(String date)async{
//    QuerySnapshot querySnapshot=await db.collection(COLLECTION_PAYMENT_DETAILS).document(date).collection('AllShopName').document('rfl').collection("01777368276@gmail.com").getDocuments();
//
//    if(querySnapshot!=null){
//      return querySnapshot.documents.map((paymentModels) =>PaymentModels.fromMap(paymentModels.data)).toList();
//    }
//
//  }

//  static Future addPaymentWithShopName(String date,PaymentProductModels paymentProductModels,String time,String email)async{
//
//    final doc=db.collection(COLLECTION_PAYMENT_DETAILS).document(date).collection(paymentProductModels.authName).document(email).collection(time).document(paymentProductModels.keyName);
//
//    return await doc.setData(paymentProductModels.tomap());
//
//  }

//  static Future<List<PaymentProductModels>> getAllPaymentWithShop(String authName,String date,String email,String time)async{
//
//   QuerySnapshot snapshot=await db.collection(COLLECTION_PAYMENT_DETAILS).document(date).collection(authName).document(email).collection(time).getDocuments();
//
//   if(snapshot!=null){
//     return snapshot.documents.map((products)=>PaymentProductModels.fromMap(products.data)).toList();
//   }
//
//  }

}