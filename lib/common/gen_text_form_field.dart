import 'package:activmind_app/common/comhelper.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GetTextFormField extends StatelessWidget {
  TextEditingController? controller;
  String? hintName;
  IconData? icon;
  bool isObscureText;
  TextInputType? inputtype;

  GetTextFormField(
      {super.key,
      this.controller,
      this.hintName,
      this.icon,
      this.isObscureText = false,
      this.inputtype = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      // margin: const EdgeInsets.only(top: 20.0),
      child: TextFormField(
        controller: controller,
        obscureText: isObscureText,
        keyboardType: inputtype,

        validator: (value) {
          if (value==null || value.isEmpty){
            return "Veuillez entrer $hintName";

          }
          if (hintName=='Email*' && !validateemail(value)){
            return 'Veuillez entrer un email valid';
          }
          return null;
        },
            
        onSaved: (val)=> controller!.text=val!,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30.0),
              ),
              borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(color: Colors.blue)),
          prefixIcon: Icon(icon),
          hintText: hintName,
          labelText: hintName,
          fillColor: Color.fromARGB(255, 197, 198, 243),
          filled: true,
        ),
      ),
    );
  }
}
