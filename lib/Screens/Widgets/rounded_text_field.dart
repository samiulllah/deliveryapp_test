import 'package:flutter/material.dart';


class RoundTextField extends StatefulWidget {
  TextEditingController controller;
  String hint;
  RoundTextField({Key? key,required this.controller,required this.hint}) : super(key: key);

  @override
  State<RoundTextField> createState() => _RoundTextFieldState();
}

class _RoundTextFieldState extends State<RoundTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin:const EdgeInsets.symmetric(horizontal: 20),
      padding:const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(10))
      ),
      child: Center(
        child: TextField(
          controller: widget.controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              isDense:true,
              hintText: widget.hint
          ),
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  TextEditingController controller;
  String hint;
  PasswordField({Key? key,required this.controller,required this.hint}) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscure=false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin:const EdgeInsets.symmetric(horizontal: 20),
      padding:const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(10))
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              obscureText: !obscure,
              controller: widget.controller,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  isDense:true,
                  hintText: widget.hint
              ),
            ),
          ),
          IconButton(
              onPressed: (){
                setState(() {
                  obscure=!obscure;
                });
              },
              icon: Icon(obscure?Icons.visibility:Icons.visibility_off)
          )
        ],
      ),
    );
  }
}
