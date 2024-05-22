
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      backgroundColor: const Color(0xff000000),
      textColor: Colors.white,
      fontSize: 16.0
  );
}
showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Builder(builder: (context){
      return SizedBox(
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: Color(0xff2B3A67),
            ),
            const SizedBox(height: 18.0,),
            Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text('Loading...'),
            ),
          ],
        ),
      );
    },),
  );
  showDialog(barrierDismissible: false, context: context, builder: (BuildContext context){
    return alert;
  }
  );
}

String getMessageFromErrorCode(String errorCode) {
  switch(errorCode) {
    case "ERROR_EMAIL_ALREADY_IN_USE":
      return "Email already used. Go to login page";
    case "account-exists-with-different-credential":
      return "Email already used. Try another one";
    case "ERROR_WRONG_PASSWORD":
      return "The password you entered is wrong. Try again.";
    case "ERROR_USER_NOT_FOUND":
      return "No user found with this email.";
    case "ERROR_USER_DISABLED":
      return "User disabled";
    case "ERROR_TOO_MANY_REQUESTS":
      return "Can't handle this many requests. Please wait or try again.";
    case "ERROR_OPERATION_NOT_ALLOWED":
      return "Operation not allowed. Please contact support.";
    case "ERROR_INSUFFICIENT_PERMISSIONS":
      return "Insufficient permissions to perform this action.";
    case "ERROR_CART_EMPTY":
      return "Your shopping cart is empty. Add items to continue.";
    case "ERROR_PAYMENT_FAILED":
      return "Payment failed. Please try again or choose a different payment method.";
    case "ERROR_ADDRESS_NOT_FOUND":
      return "Address not found. Please check your address details.";
    case "ERROR_ORDER_NOT_FOUND":
      return "Order not found. Please contact customer support for assistance.";
    case "ERROR_INVALID_CREDENTIAL":
      return "Invalid credentials. Please check your login information.";
    case "ERROR_NETWORK_ERROR":
      return "Network error. Please check your internet connection.";
    case "ERROR_SERVER_ERROR":
      return "Server error. Please try again later.";
    case "ERROR_ACCOUNT_NOT_VERIFIED":
      return "Account not verified. Please verify your email address.";
    case "ERROR_EXPIRED_SESSION":
      return "Session expired. Please log in again.";
    case "ERROR_INVALID_PROMO_CODE":
      return "Invalid promo code. Please enter a valid code.";
    case "ERROR_INSUFFICIENT_FUNDS":
      return "Insufficient funds. Please add funds to your account.";
    case "ERROR_TRANSACTION_FAILED":
      return "Transaction failed. Please try again or contact support.";
    default:
      return "An error occurred. Please try again later.";
  }
}

bool loginValidation(String email,String password) {
  if(email.isEmpty && password.isEmpty) {
    showMessage('Both fields are empty*');
    return false;
  } else if(password.isEmpty) {
      showMessage('Enter your password*');
      return false;
  }else if(email.isEmpty) {
      showMessage('Enter your email*');
      return false;
  }
  else {
    return true;
  }
}

bool signupValidation(String email,String password,String name,String phone) {
  if(email.isEmpty && password.isEmpty && email.isEmpty && name.isEmpty && email.isEmpty && phone.isEmpty) {
    showMessage('All fields are empty. Fill the fields first*');
    return false;
  } else if(name.isEmpty) {
    showMessage('Enter your name*');
    return false;
  }else if(email.isEmpty) {
    showMessage('Enter your email*');
    return false;
  }else if(phone.isEmpty) {
    showMessage('Enter your phone number*');
    return false;
  } else if(password.isEmpty) {
    showMessage('Enter your password*');
    return false;
  }
  else {
    return true;
  }
}