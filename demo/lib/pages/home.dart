import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return appBar();
  }

  Scaffold appBar() {
    var bar = [
        Container (
          margin: EdgeInsets.only(top: 40, left: 20, right: 20),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xff1D1617).withOpacity(0.11),
                blurRadius: 40,
                spreadRadius: 0.0
              )
            ]
          ),
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.all(15),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset('assets/icons/cloud-bolt-svgrepo-com.svg')
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              )
            
            ),
          )
        ),
      ];
    return Scaffold(
    appBar: AppBar(
      title: Text('Breakfast',
      style: TextStyle (color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.bold ),
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {

        },
        child: Container(
        margin: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: 37,
        child: SvgPicture.asset(
          'assets/icons/cloud-bolt-svgrepo-com.svg',
          height: 20,
          width: 20,          
        ),
        decoration: BoxDecoration(
          color: Color(0xffF7F8F8),
          borderRadius: BorderRadius.circular(10)
        ),
      ),
      ),
      actions: [
        GestureDetector(
          onTap: () {

          },
          child: Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            child: SvgPicture.asset(
              'assets/icons/cloud-showers-svgrepo-com.svg',
              height: 20,
              width: 20,          
            ),
            decoration: BoxDecoration(
              color: Color(0xffF7F8F8),
              borderRadius: BorderRadius.circular(10)
            ),
          ),
        )
      ]
    ),
    
  );
  }
}