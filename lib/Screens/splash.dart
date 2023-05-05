import 'package:deliveryapp_test/Providers/auth.dart';
import 'package:deliveryapp_test/Providers/order.dart';
import 'package:deliveryapp_test/Screens/login.dart';
import 'package:deliveryapp_test/Utils/assets.dart';
import 'package:deliveryapp_test/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'order.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  init()async{
     if(mounted) {
       AuthProvider authProvider = Provider.of<AuthProvider>(
           context, listen: false);
       await authProvider.checkAuth();
       if (authProvider.isLogin && mounted) {
         await context.read<OrderProvider>().getPosition();
         if(mounted) {
           Navigator.pushReplacement(
               context, MaterialPageRoute(builder: (c) => const OrderScreen()));
         }
       } else {
         Navigator.pushReplacement(
             context, MaterialPageRoute(builder: (c) => const LoginScreen()));
       }
     }
  }
  @override
  void initState(){
    super.initState();
    init();
  }
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(statusBarColor: AppColors.primary),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
          child:Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Image.asset(Assets.logo),
          ),
        ),
      ),
    );
  }
}