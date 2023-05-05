import 'package:flutter/material.dart';

import '../../Utils/colors.dart';


roundButton({title,onPress}){
  return InkWell(
    onTap:(){
      onPress();
    },
    child: Container(
      height: 50,
      margin:const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: AppColors.primary
      ),
      child: Center(
        child: Text(title,style:const  TextStyle(color:Colors.white,fontSize: 15,fontWeight: FontWeight.w500),),
      ),
    ),
  );
}