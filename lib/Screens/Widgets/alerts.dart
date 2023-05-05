import 'package:flutter/material.dart';

import '../../Utils/colors.dart';

showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message,style: const TextStyle(color: Colors.white),),
    backgroundColor: AppColors.primary,
  ));
}