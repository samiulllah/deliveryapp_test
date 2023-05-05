import 'package:deliveryapp_test/Providers/auth.dart';
import 'package:deliveryapp_test/Utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../Utils/colors.dart';
import 'Widgets/buttons.dart';
import 'Widgets/rounded_text_field.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthProvider authProvider;

  @override
  void initState(){
    super.initState();
    authProvider=Provider.of<AuthProvider>(context,listen: false);
  }
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(statusBarColor: AppColors.primary),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Column(
              children: [
                header(),
                body(),
              ],
            ),
          ),
        )
    );
  }
  header(){
    return Container(
      padding: EdgeInsets.only(top: AppBar().preferredSize.height*.7,bottom: 10),
      color: AppColors.primary,
      child: Row(
        children: [
          const SizedBox(width: 20,),
          Image.asset(Assets.logo,width: 50,height: 50,fit: BoxFit.contain,),
          const SizedBox(width: 20,),
          const Text("Delivery App",style: TextStyle(color: Colors.white,fontSize: 24),),
        ],
      ),
    );
  }
  body(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 30,),
        Text("Login",style: TextStyle(color:AppColors.primary,fontSize: 34,fontWeight: FontWeight.w500),),
        const SizedBox(height: 70,),
        RoundTextField(controller: authProvider.email,hint: 'Email Address',),
        const SizedBox(height: 30,),
        PasswordField(controller: authProvider.password,hint: 'Password',),
        Container(
            margin: const EdgeInsets.only(right: 20,top: 5),
            alignment:Alignment.centerRight,
            child: Text("Forgot password?",style: TextStyle(color:AppColors.primary,fontSize: 15,fontWeight: FontWeight.w500),),
        ),
        const SizedBox(height: 30,),
        Consumer<AuthProvider>(
            builder: (context,auth,child){
              return !authProvider.loading?roundButton(title: "Login",onPress: (){
                authProvider.authenticate(context);
              }):Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              );
            }
        ),
        const SizedBox(height: 30,),
        registerText()
      ],
    );
  }
  registerText(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("New here?",style: TextStyle(color:AppColors.primary,fontSize: 15,fontWeight: FontWeight.w500),),
        const SizedBox(width: 2,),
        Text("Create an account",style: TextStyle(color:AppColors.primary,fontSize: 15,fontWeight: FontWeight.w500,decoration: TextDecoration.underline),)
      ],
    );
  }
}
