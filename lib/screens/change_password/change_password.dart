import 'package:arshop/constants/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../firebase_helpers/firebase_auth_helper/firebase_auth_helper.dart';
import '../../widgets/primary_button/primary_button.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isShowPassword = true;
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text("Change Password", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.w700,),),
        ),

        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            ///New password
            TextFormField(
              controller: newPassword,
              obscureText: isShowPassword,
              decoration:  InputDecoration(
                hintText: "New Password",
                prefixIcon: const Icon(Icons.password_sharp),
                suffixIcon: CupertinoButton(onPressed: () {
                  setState(() {
                    isShowPassword = !isShowPassword;
                  });
                }, padding: EdgeInsets.zero, child: const Icon(Icons.visibility, color: Colors.grey,)),
              ),),
            const SizedBox(height: 12.0,),

            ///Confirm password
            TextFormField(
              controller: confirmPassword,
              obscureText: isShowPassword,
              decoration:  const InputDecoration(
                hintText: "Confirm Password",
                prefixIcon: Icon(Icons.password_sharp
                ),
              ),
            ),

            const SizedBox(height: 34.0,),

            PrimaryButton(title: "Update", onPressed: () async{
              if(newPassword.text.isEmpty){
                showMessage("New password is empty*");
              }
              else if(confirmPassword.text.isEmpty){
                showMessage("Confirm password is empty*");
              }
              else if(confirmPassword.text == newPassword.text){
                  FirebaseAuthHelper.instance.changePassword(newPassword.text, context);
                }
                else{
                  showMessage("Confirm password not matched*");
                }


              /*UserModel userModel = appProvider.getUserInformation.copyWith(name: textEditingController.text);
              appProvider.updateUserInfoFirebase(context, userModel, image);*/

            },),
          ],
        )
    );
  }
}
