import 'package:exemple4/Widgets/BottomNavigationBar.dart';
import 'package:exemple4/components/bouttons.dart';
import 'package:exemple4/components/textfeilds.dart';
import 'package:exemple4/pages/planifies_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void loginUser(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NavigationHome()),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50,),
              Container(
                child: Image.asset('assets/images/atlaprest.jpeg',),
              ),
              const SizedBox(height: 50,),

              MyTextFeilds(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),
              const SizedBox(height: 20,),
              MyTextFeilds(
                controller: passwordController,
                hintText: 'Mot de passe',
                obscureText: true,
              ),
              const SizedBox(height: 30,),

              MyButton(onTap: loginUser,),

              const SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }
}
