import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.onTap});

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(18),
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(8) ,
          color: Colors.black,
        ),
        child: Center(
          child: Text('Lien de connection par e-mail',style: TextStyle(
              color: Colors.white,fontSize:16,fontWeight: FontWeight.bold),),

        ),
      ),
    );
  }
}

class MyButton1 extends StatelessWidget {
  const MyButton1({super.key, required this.onTap1});

  final Function()? onTap1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap1,
      child: Container(
        padding: EdgeInsets.all(18),
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(8) ,
          color: Colors.black,
        ),
        child: Center(
          child: Text('to insert page',style: TextStyle(
              color: Colors.white,fontSize:16,fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}


class MyButton2 extends StatelessWidget {
  const MyButton2({super.key, required this.onTap2});

  final Function()? onTap2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap2,
      child: Container(
        padding: EdgeInsets.all(18),
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(8) ,
          color: Colors.black,
        ),
        child: Center(
          child: Text('to display page',style: TextStyle(
              color: Colors.white,fontSize:16,fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}

class MyButton3 extends StatelessWidget {
  const MyButton3({super.key, required this.onTap3});

  final Function()? onTap3;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap3,
      child: Container(
        padding: EdgeInsets.all(18),
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(8) ,
          color: Colors.black,
        ),
        child: Center(
          child: Text('to update page',style: TextStyle(
              color: Colors.white,fontSize:16,fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}
