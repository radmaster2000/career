import 'dart:math';

import 'package:career/screens/Dashboard/Dashboard.dart';
import 'package:career/screens/otp.dart';
import 'package:career/screens/signUpScreen.dart';
import 'package:career/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nb_utils/nb_utils.dart';

import '../api/api_methods.dart';
import '../utils/app_images.dart';
import '../utils/app_size.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin{
  bool isWhatsappChecked = true;
  bool _isButtonPressed = false;
  late AnimationController _controller;
  final TextEditingController _mobileController = TextEditingController();
  late Animation<double> _scaleAnimation;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _errorMessage;
  @override
  void initState() {
    // TODO: implement initState
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }



  String? _validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter mobile number';
    } else if (value.length != 10) {
      return 'Mobile number must be 10 digits';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Only numbers are allowed';
    }
    return null;
  }

  Future<void> _handleOTPRequest() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isButtonPressed = true;
      _errorMessage = null;
    });

    try {
      final otp = generate4DigitNumber();
      // Replace with your actual API call
      final response = await postOTPVerification(
        mobileNumber: _mobileController.text,
        token: otp,
      );


      // Simulate API call delay
      await Future.delayed(Duration(seconds: 2));

      // If API call is successful
      if(response.data["Result"][0]["Msg"]=="Send"){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => OTPVerificationScreen(phone: _mobileController.text,token: otp,),));
      }

      // Or show OTP dialog if needed
      // _showOTPDialog(otp);

    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to send OTP. Please try again.';
        _isButtonPressed = false;
      });
    }
  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 50),
              Text(
                "Login with\nyour mobile number.",
                style: TextStyle(fontSize: FontSizes.extraSmall, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Text("+91"),
                        VerticalDivider(width: 10),
                        Container(
                          width:250.w,
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                counterText: "",
                                hintText: "Enter mobile number"),
                             controller: _mobileController,
                            maxLength: 10,
                            keyboardType: TextInputType.phone,
                            validator: _validateMobile,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Row(
              //   children: [
              //     Icon(Icons.phone, color: Colors.green),
              //     SizedBox(width: 10),
              //     Expanded(
              //       child: Text.rich(
              //         TextSpan(
              //           children: [
              //             TextSpan(
              //               text: "Get Instant Updates\n",
              //               style: TextStyle(fontWeight: FontWeight.bold),
              //             ),
              //             TextSpan(
              //               text: "From CARS24 On Your ",
              //             ),
              //             TextSpan(
              //               text: "Whatsapp",
              //               style: TextStyle(fontWeight: FontWeight.bold),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //     Checkbox(
              //       value: isWhatsappChecked,
              //       onChanged: (value) {
              //         setState(() {
              //           isWhatsappChecked = value!;
              //         });
              //       },
              //     ),
              //   ],
              // ),
               SizedBox(height: 20),
              ScaleTransition(
                scale: _scaleAnimation,
                child: ElevatedButton(
                  onPressed: (){
                    // _isButtonPressed=true;
                    // String number=generate4DigitNumber();
                    // postOTPVerification("")
                    // //Get.off(DashBoard());
                    setStringAsync("loggedin", "1");
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DashBoard()));
                    ///_handleOTPRequest();
                    // setState(() {
                    //
                    // });
                    },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: (_isButtonPressed)?Center(child: CircularProgressIndicator(color: Colors.white,),):Text("GET OTP"),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text("Or login with"),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: (){

                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpScreen(),));
                  //Get.off(()=>SignUpScreen());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.call, color: Colors.red),
                      SizedBox(width: 10),
                      Text(
                        "One tap Login with ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Learning App",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                "By logging in, you agree to",
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 6),
              Text.rich(
                TextSpan(
                  text: "",
                  children: [
                    TextSpan(
                      text: "Privacy Policy",
                      style: TextStyle(
                          color: AppColors.primaryVariant,
                          decoration: TextDecoration.underline),
                    ),
                    TextSpan(text: " and "),
                    TextSpan(
                      text: "Terms & Conditions\n",
                      style: TextStyle(
                          color: AppColors.primaryVariant,
                          decoration: TextDecoration.underline),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String generate4DigitNumber() {
    final random = Random();
    // Generates between 1000 and 9999 (inclusive)
    final number = 1000 + random.nextInt(9000);
    return number.toString();
  }
}