class RefundModels{
  String refundPolicy;
  String refundKey;
  String aboutUs;
  String privacyPolicy;

  RefundModels({this.refundPolicy});

  Map<String,dynamic> toMap(){
    final map=<String,dynamic>{
      'refundPolicy':refundPolicy,
      'key':refundKey,
      'aboutUs':aboutUs,
      'privacy-Policy':privacyPolicy,
    };
    return map;
  }

  RefundModels.formMap(Map<String,dynamic> map){
    refundPolicy=map['refundPolicy'];
    refundKey=map['key'];
    aboutUs=map['aboutUs'];
    privacyPolicy=map['privacy-Policy'];
  }
}