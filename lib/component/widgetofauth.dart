
import 'package:flutter/material.dart';

import 'Color.dart';
Container textform(controllerText, String Title, TextInputType type,void Function()? onTappassword,bool _isHiddenPassword,String? Function(String?)? validator,context) {

   var height= MediaQuery.of(context).size.height;
    return Container(
      height: height/7,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            height: height/19,
            child: Text(Title,style: TextStyle(fontSize: 17),)),
            SizedBox(height: 3,),
          Container(
            height: 55,
            child: TextFormField(
              
              validator: validator,
              // textAlign: TextAlign.center,
              obscureText: type == TextInputType.visiblePassword
                  ? _isHiddenPassword
                  : false,
              keyboardType: type,
              cursorColor: Colors.black,
              controller: controllerText,
              decoration: InputDecoration(
                errorStyle: TextStyle(fontSize: 5),
                suffixIcon: type != TextInputType.visiblePassword
                    ? SizedBox()
                    : InkWell(
                        onTap:onTappassword,
                        child: Icon(
                          _isHiddenPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: globalcolor,
                        ),
                      ),
                
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: globalcolor)),
                    errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: globalcolor)),
                
                // hintText: Title,
                // hintStyle:
                //     TextStyle(color: Color(0xff8c9289), fontFamily: 'Cobe',fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ElevatedButton loginbutton(String title, void Function()? onPressed,ignoring) {
    return ElevatedButton(
      
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                // side: BorderSide(width: 1.0, color: Colors.black),
                borderRadius: BorderRadius.circular(12)),
            minimumSize: const Size(250, 50),
            primary:ignoring? globalcolor:Colors.grey));
  }