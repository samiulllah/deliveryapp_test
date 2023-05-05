import 'package:deliveryapp_test/Screens/Widgets/alerts.dart';
import 'package:deliveryapp_test/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/order.dart';

class AuthProvider extends ChangeNotifier{
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  AuthService authService=AuthService();
  bool isLogin=false;
  bool loading=false;

  Future<void> checkAuth()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    isLogin=sharedPreferences.getBool('isLogin')??false;
  }

  Future<void> authenticate(BuildContext context)async{
    if(validate(context)) {
      toggleLoader();
      String? authenticated=await authService.authenticate(email.text, password.text);
      toggleLoader();
      if(authenticated!=null&&context.mounted){
        showMessage(context, authenticated);
        await Future.delayed(const Duration(seconds: 1));
        if(context.mounted) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (c) => const OrderScreen()));
        }
      }else{
        showMessage(context, "Something went wrong. Try again!");
      }
    }
  }

  bool validate(BuildContext context){
    if(email.text.isEmpty){
      showMessage(context, "Email is required.");
      return false;
    }
    if(password.text.length<8){
      showMessage(context, "8 char long password is required.");
      return false;
    }
    return true;
  }
  toggleLoader(){
    loading=!loading;
    notifyListeners();
  }
}