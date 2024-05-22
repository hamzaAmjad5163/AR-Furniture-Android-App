// ignore_for_file: use_build_context_synchronously

import 'package:arshop/constants/constant.dart';
import 'package:arshop/constants/routes.dart';
import 'package:arshop/screens/custom_bottom_navbar/custom_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../firebase_helpers/firebase_auth_helper/firebase_auth_helper.dart';
import '../../../widgets/appBar_title/top_title.dart';
import '../../../widgets/primary_button/primary_button.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool isShowPassword = true;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopTitle(title: 'Signup',subtitle: 'Signup to create a new account, and start shopping know.',),
              const SizedBox(height: 24.0,),
        
              ///Name
              TextField(
                controller: name,
                decoration: const InputDecoration(
                  hintText: "Name",
                  prefixIcon: Icon(Icons.person_outline),
                ),
                maxLength: 15,
              ),

              const SizedBox(height: 12.0,),
        
              ///email
              TextField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                hintText: "E-mail",
                prefixIcon: Icon(Icons.email_outlined),
              ),),
              const SizedBox(height: 12.0,),
        
              ///phone Number
              TextField(
                controller: phone,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: "Phone Number",
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Allow only numbers
                  LengthLimitingTextInputFormatter(11), // Limit input to 11 characters
                ],
              ),
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
        
              PrimaryButton(title: 'Create an account', onPressed: () async{
                bool isValidated = signupValidation(name.text, email.text, phone.text, password.text);
                if(isValidated) {
                  bool isLogin = await FirebaseAuthHelper.instance.signup(name.text, email.text, password.text,  context);
                  if (isLogin) {
                    Routes.instance.pushAndRemoveUntil(const CustomBottomBar(), context);
                  }
                }
              },),
              const SizedBox(height: 20.0,),
        
              const Center(child: Text("Already have an account?")),
              const SizedBox(height: 12.0,),

              Center(child: CupertinoButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text('Go to Login', style: TextStyle(color: Theme.of(context).primaryColor),))),
            ],
          ),
        ),
      ),
    );
  }
}
