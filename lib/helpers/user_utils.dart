import 'package:shared_preferences/shared_preferences.dart';

class UserUtils{

  static Future<void> saveUserSessionToPreference(bool tag)async{

    try{
      final prefs=await SharedPreferences.getInstance();
      await prefs.setBool('userSession', tag);
    }catch(error){
      throw error;
    }
  }

  static Future<bool> getUserSessionUsingPref()async{
    final prefs=await SharedPreferences.getInstance();
    return prefs.getBool('userSession')??false;
  }

}