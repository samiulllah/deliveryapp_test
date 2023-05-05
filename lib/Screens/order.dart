import 'dart:math';

import 'package:deliveryapp_test/Screens/Widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../Utils/assets.dart';
import '../Utils/colors.dart';
import 'Widgets/location_field.dart';
import 'Widgets/rounded_text_field.dart';



class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Map prices={
    'Car':100,
     'Small Van':150,
     'Medium Van':180,
    'Luton Van':200
  };
  String? carType;
  late double lat1,long1,lat2,long2;
  String pickup='Pickup location';
  String dropOff= 'Drop off location';
  late String distance;
  late String vatPrice,noVatPrice;
  bool calculated=false;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(statusBarColor: AppColors.primary),
      child: Scaffold(
        body: Column(
          children: [
            header(),
            const SizedBox(height: 30,),
            typeDropdown(),
            LocationField(onChange: (double lat,double long,String address){
              lat1=lat;
              long1=long;
              setState(() {
                pickup=address;
              });
            },title: pickup,),
            LocationField(onChange: (double lat,double long,String address){
              lat2=lat;
              long2=long;
              setState(() {
                dropOff=address;
              });
            },title: dropOff,),
            const SizedBox(height: 20,),
            roundButton(onPress: (){
              calculate();
            },title: 'Calculate'),
            if(calculated)Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                Text("Mileage : $distance"),
                const SizedBox(height: 10,),
                Text("Price(Including VAT) : $vatPrice"),
                const SizedBox(height: 10,),
                Text("Price(Excluding VAT) $vatPrice"),
              ],
            )
          ],
        ),
      ),
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
  typeDropdown(){
    return   Container(
      height: 45,
      width: MediaQuery.of(context).size.width,
      margin:const EdgeInsets.symmetric(horizontal: 20,vertical: 12),
      padding:const EdgeInsets.only(left: 20,right: 20),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(10))
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        hint: const Text('Select vehicle type'),
        value:carType,
        underline: Container(),
        items: <String>['Car', 'Small Van', 'Medium Van', 'Luton Van'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (val) {
          setState(() {
            carType=val!;
          });
        },
      ),
    );
  }
  calculate()async{
    int price=prices[carType];
    double distance=Geolocator.distanceBetween(lat1,long1, lat2, long2);
    distance=(distance/1000)/1.6;
    setState(() {
      this.distance="${distance.toStringAsFixed(2)} miles";
      vatPrice=(distance*price).toStringAsFixed(2);
      noVatPrice=(distance*price).toStringAsFixed(2);
      calculated=true;
    });
  }

}
