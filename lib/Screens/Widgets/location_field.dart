import 'package:deliveryapp_test/Providers/order.dart';
import 'package:flutter/material.dart';
import 'package:map_location_picker/map_location_picker.dart';

import '../../Utils/colors.dart';



class LocationField extends StatefulWidget {
  Function onChange;
  String title;
  LocationField({Key? key,required this.onChange,required this.title}) : super(key: key);

  @override
  State<LocationField> createState() => _LocationFieldState();
}

class _LocationFieldState extends State<LocationField> {

  @override
  Widget build(BuildContext context) {
    return  gpsLoc();
  }


  gpsLoc(){
    return Material(
      child: InkWell(
        onTap: ()async{
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return MapLocationPicker(
                  apiKey: "AIzaSyAE6QaETdm1HXoktZlod3HRVLNaRvS_C7E",
                  canPopOnNextButtonTaped: true,
                  currentLatLng: const LatLng(29.121599, 76.396698),
                  onNext: (GeocodingResult? result) {
                    if (result != null) {
                      changeLocation(result.geometry.location.lat,result.geometry.location.lng,result.formattedAddress!);
                    }
                  },
                  onSuggestionSelected: (PlacesDetailsResponse? result) {
                    if (result != null) {
                      changeLocation(result.result.geometry!.location.lat,result.result.geometry!.location.lng,result.result.formattedAddress!);
                    }
                  },
                );
              },
            ),
          );

        },
        child: Container(
          height: 50,
          margin:const EdgeInsets.symmetric(horizontal: 20,vertical: 12),
          padding:const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: const BorderRadius.all(Radius.circular(10))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(widget.title),
              ),
              const SizedBox(width:10,),
              Icon(Icons.gps_fixed,color: AppColors.primary,),
              const SizedBox(width:15,),
            ],
          ),
        ),
      ),
    );
  }
  changeLocation(double lat,double long,String address){
    widget.onChange(lat,long,address);
  }

}
