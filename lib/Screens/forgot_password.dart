import 'package:flutter/material.dart';
import 'package:flutter_realapp_1/widget/bottomWidget.dart';
import 'package:flutter_realapp_1/widget/textfielform.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  final eamilcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 30, top: 90),
          child: Column(
            spacing: 30,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Forgot\nPassword ? ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              CustomTextfielform(
                eamilcontroller,
                hinText: "Enter your email",
                prefixicon: Icons.email,
                obusreText: false,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "* We will send you a message to set or reset your new password",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              Center(
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: Bottomwidget(text: "Submit", ontap: () {}),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
