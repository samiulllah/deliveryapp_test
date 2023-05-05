import 'dart:convert';

import 'package:deliveryapp_test/Utils/endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io' show Platform;

import 'package:shared_preferences/shared_preferences.dart';

class AuthService{


  Future<String?> authenticate(String email,String password)async{
    try{
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      var url = Uri.parse(Endpoints.auth);
      var response = await http.post(url, body: {
        "email": email,
        "password": password,
        "device_name": Platform.isAndroid?androidInfo.model:iosDeviceInfo.model,
        "device_token": Platform.isAndroid?androidInfo.id:iosDeviceInfo.identifierForVendor,
        "device_os": Platform.operatingSystem,
        "device_details": Platform.isAndroid?androidInfo.data.toString():iosDeviceInfo.data.toString()
      });
      Map res=jsonDecode(response.body.toString());
      SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
      sharedPreferences.setBool('isLogin', true);
      return res['message'];
    }catch(e){
      print('Error $e');
      return null;
    }
  }


}