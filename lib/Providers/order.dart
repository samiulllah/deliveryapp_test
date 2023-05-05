

import 'package:deliveryapp_test/Services/order.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class OrderProvider extends ChangeNotifier{
  OrderService orderService=OrderService();
  Position? position;

  getPosition()async{
    position=await orderService.getPosition();
  }

}