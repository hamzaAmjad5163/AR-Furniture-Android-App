// ignore_for_file: use_build_context_synchronously

import 'package:arshop/constants/constant.dart';
import 'package:arshop/constants/routes.dart';
import 'package:arshop/firebase_helpers/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:arshop/screens/auth_ui/signup/signup.dart';
import 'package:arshop/screens/custom_bottom_navbar/custom_bottom_bar.dart';
import 'package:arshop/screens/home/home.dart';
import 'package:arshop/widgets/primary_button/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/appBar_title/top_title.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isShowPassword = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopTitle(title: 'Login',subtitle: 'Login to continue Shopping',),
            const SizedBox(height: 24.0,),

            ///email
            TextField(
              controller: email,
              decoration: const InputDecoration(
              hintText: "E-mail",
              prefixIcon: Icon(Icons.email_outlined),
            ),),
            const SizedBox(height: 12.0,),

            ///password field
            TextField(
              controller: password,
              obscureText: isShowPassword,
              decoration:  InputDecoration(
              hintText: "Password",
              prefixIcon: const Icon(Icons.padding_outlined),
                suffixIcon: CupertinoButton(onPressed: () {
                  setState(() {
                    isShowPassword = !isShowPassword;
                  });
                }, padding: EdgeInsets.zero, child: const Icon(Icons.visibility, color: Colors.grey,)),
            ),),
            const SizedBox(height: 24.0,),

            ///Login button

            PrimaryButton(title: 'Login', onPressed: () async {
              bool isValidated = loginValidation(email.text, password.text);
              if(isValidated) {
                bool isLogin = await FirebaseAuthHelper.instance.login(email.text, password.text, context);
                if (isLogin) {
                  Routes.instance.pushAndRemoveUntil(const CustomBottomBar(), context);
                  }
                }
              },
            ),
            const SizedBox(height: 20.0,),

            const Center(child: Text("Don't have an account?")),
            Center(child: CupertinoButton(onPressed: (){
              Routes.instance.push(const Signup(), context);
            }, child: Text('Create an account', style: TextStyle(color: Theme.of(context).primaryColor),))),
          ],
        ),
      ),
    );
  }
}
