import 'package:career/api/api_methods.dart';
import 'package:career/screens/Dashboard/Dashboard.dart';
import 'package:career/screens/signUpScreen.dart';
import 'package:career/utils/app_colors.dart';
import 'package:flutter/material.dart';

class OTPVerificationScreen extends StatefulWidget {
  String ?phone,token;
  OTPVerificationScreen({this.phone,this.token});
  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final int _otpLength = 4; // Changed to 4 digits
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  String _enteredOTP = '';
  bool verified=false;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(_otpLength, (index) => TextEditingController());
    _focusNodes = List.generate(_otpLength, (index) => FocusNode());
    _focusNodes[0].requestFocus();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onOTPChanged(int index, String value) {
    if (value.length == 1 && index < _otpLength - 1) {
      _focusNodes[index].unfocus();
      debugPrint("jubj");
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      debugPrint("dbndj");
      verified=false;
      setState(() {

      });
      _focusNodes[index].unfocus();
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }

    _enteredOTP = _controllers.map((c) => c.text).join();

    if (_enteredOTP.length == _otpLength) {
      _verifyOTP();
    }
  }

  void _verifyOTP() {
    print('Verifying OTP: $_enteredOTP');
    verified=true;
    setState(() {

    });
    // Add your verification logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Important for keyboard overflow
      appBar: AppBar(
        title: Text('OTP Verification'),
        elevation: 0,
      ),
      body: SingleChildScrollView( // Wrap with SingleChildScrollView
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter Verification Code',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'We have sent a 4-digit code to your mobile number',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 32),

            // OTP Input Fields - Centered
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_otpLength, (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    width: 50,
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      style: TextStyle(fontSize: 24),
                      decoration: InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.symmetric(vertical: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: _focusNodes[index].hasFocus
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                      ),
                      onChanged: (value) => _onOTPChanged(index, value),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 32),

            // Resend Code Button
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Didn't receive code?"),
                  TextButton(
                    onPressed: () {
                      // Resend OTP logic
                    },
                    child: Text(
                      'Resend',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Verify Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: ()async{
                  if(verified&&_enteredOTP==widget.token){
                    print("verified");
                   final response=await login(widget.phone!);
                   print('login response ${response.data}');
                   if(response.statusCode==500 && response.data["message"]=="User does not exist"){
                     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignUpScreen()));
                   }
                   else{
                     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DashBoard()));
                   }
                  }
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: verified?AppColors.primary:Colors.grey,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Verify',
                  style: TextStyle(fontSize: 18,color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}