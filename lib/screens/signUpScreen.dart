import 'dart:convert';

import 'package:career/api/api_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';
import 'package:nb_utils/nb_utils.dart';
import '../utils/app_colors.dart';
import '../utils/app_size.dart';
import '../widgets/inputTextWidget.dart';
import 'Dashboard/Dashboard.dart';
import 'Login.dart';
import 'loginScreen.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen() : super();

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isAuthenticated = false;
  bool _isButtonPressed = false;
  String _authResult = 'Not authenticated';
  final FirebaseAuth _auth = FirebaseAuth.instance;
   final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile'],);
  final TextEditingController first = TextEditingController();
  final TextEditingController last = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController dob = TextEditingController();
  String? _authToken;
  Future<String?> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      return DateFormat('yyyy-MM-dd').format(picked);
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    debugPrint("signup build callede");
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up",
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Segoe UI',
              fontSize: 30,
              // shadows: [
              //   Shadow(
              //     color: const Color(0xba000000),
              //     offset: Offset(0, 3),
              //     blurRadius: 6,
              //   )
              // ],
            )),
        //centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.to(LoginScreen());
            },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: Colors.white,

            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          width: screenWidth,
          height: screenHeight,
          child: SingleChildScrollView(
            //controller: controller,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    'Welcome to our home',
                    style: TextStyle(
                      fontSize: FontSizes.extraSmall,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff000000),

                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  InputTextWidget(
                      labelText: "First name",
                      icon: Icons.person,
                      controller: first,
                      obscureText: false,
                      keyboardType: TextInputType.text),
                  SizedBox(
                    height: 12.0,
                  ),
                  InputTextWidget(
                      labelText: "Last Name",
                      icon: Icons.person,
                      controller: last,
                      obscureText: false,
                      keyboardType: TextInputType.text),
                  SizedBox(
                    height: 12.0,
                  ),
                  InputTextWidget(
                      controller: _emailController,
                      labelText: "Email Address",
                      icon: Icons.email,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress),
                  SizedBox(
                    height: 12.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.primary),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth / 36, vertical: screenHeight / 96),
                            child: Text("Phone Number",
                                style: TextStyle(fontFamily: 'LexendMedium').copyWith(
                                    fontSize: 12, color: AppColors.primary)),
                          ),
                          SizedBox(
                            height: screenHeight / 25,
                            child: TextFormField(
                              style: TextStyle(fontFamily: 'LexendMedium').copyWith(
                                fontSize: 14,
                              ),
                              enabled: true,
                              controller: phone,
                              maxLength: 10,
                              keyboardType: TextInputType.number,
                              cursorColor: AppColors.textgray,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  hintText: 'Phone Number',

                                  hintStyle: TextStyle(fontFamily: 'LexendMedium').copyWith(
                                      fontSize: 14, color: AppColors.textgray),
                                  counterText: "",
                                  border: const OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // InputTextWidget(
                  //     labelText: "Phone number",
                  //     icon: Icons.phone,
                  //     obscureText: false,
                  //     keyboardType: TextInputType.number),
                  SizedBox(
                    height: 12.0,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                    child: InkWell(
                      onTap: () async {
                        final selectedDate = await _selectDate(context);
                        if (selectedDate != null) {
                          setState(() {
                            dob.text = selectedDate;
                          });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.primary),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth / 36, vertical: screenHeight / 96),
                              child: Text("Date of Birth",
                                  style: TextStyle(fontFamily: 'LexendMedium').copyWith(
                                      fontSize: 12, color: AppColors.primary)),
                            ),
                            SizedBox(
                              height: screenHeight / 25,
                              child: TextFormField(
                                style: TextStyle(fontFamily: 'LexendMedium').copyWith(
                                  fontSize: 14,
                                ),
                                enabled: false,
                                controller: dob,
                                keyboardType: TextInputType.number,
                                cursorColor: AppColors.textgray,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    hintText: 'Date of Birth',
                                    hintStyle: TextStyle(fontFamily: 'LexendMedium').copyWith(
                                        fontSize: 14, color: AppColors.textgray),
                                    border: const OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                  //   child: Container(
                  //     child: Material(
                  //       elevation: 15.0,
                  //       shadowColor: Colors.black,
                  //       borderRadius: BorderRadius.circular(15.0),
                  //       child: Padding(
                  //         padding:
                  //             const EdgeInsets.only(right: 20.0, left: 15.0),
                  //         child: TextFormField(
                  //             obscureText: true,
                  //             autofocus: false,
                  //             keyboardType: TextInputType.text,
                  //             decoration: InputDecoration(
                  //               icon: Icon(
                  //                 Icons.lock,
                  //                 color: Colors.black,
                  //                 size: 32.0, /*Color(0xff224597)*/
                  //               ),
                  //               labelText: "Confirm Password",
                  //               labelStyle: TextStyle(
                  //                   color: Colors.black54, fontSize: 18.0),
                  //               hintText: '',
                  //               enabledBorder: InputBorder.none,
                  //               focusedBorder: UnderlineInputBorder(
                  //                 borderSide: BorderSide(color: Colors.black54),
                  //               ),
                  //               border: InputBorder.none,
                  //             ),
                  //             controller: _confirmPass,
                  //             validator: (val) {
                  //               if (val!.isEmpty)
                  //                 return 'confirm Password';
                  //               if (val != _pass.text)
                  //                 return 'incorrect Password';
                  //               return null;
                  //             }),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 15.0,
                  // ),
                  Container(
                    height: 55.0,
                    child: ElevatedButton(
                      onPressed: () async {
                        final errors = _validateFields();

                        if (errors.isEmpty) {
                          setState(() {
                            _isButtonPressed=true;
                          });
                          // All fields are valid - proceed with submission
                          //_submitForm();
                          final response=await signUp(first.text, last.text, phone.text, _emailController.text, dob.text);
                          if(response.statusCode==201 && response.data["message"]=="User registered successfully"){
                            _authenticate();
                          }
                          else{
                            setState(() {
                              _isButtonPressed=false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Something Error Occurred"),
                                duration: Duration(seconds: 3),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }

                        } else {
                          // Show first error in SnackBar

                          setState(() {
                            _isButtonPressed=false;
                          });
                          _showValidationError(errors.values.first!);

                          // Optionally highlight error fields
                          _highlightErrorFields(errors.keys.toList());
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0.0,
                        minimumSize: Size(screenWidth, 150),
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                        ),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.blue[50]!,
                                  offset: const Offset(1.1, 1.1),
                                  blurRadius: 10.0),
                            ],
                            color: Color(0xffF05945),
                            borderRadius: BorderRadius.circular(12.0)),
                        child: Container(
                          alignment: Alignment.center,
                          child: (_isButtonPressed)?Center(child: CircularProgressIndicator(color: Colors.white,),):Text(
                            "Continue",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                  ),
            //   Padding(
            // padding: const EdgeInsets.only(left: 10.0, right: 30.0, top: 15.0),
            // child: Container(
            //   decoration: BoxDecoration(
            //       boxShadow: <BoxShadow>[
            //         BoxShadow(
            //             color: Colors.grey, //Color(0xfff05945),
            //             offset: const Offset(0, 0),
            //             blurRadius: 5.0),
            //       ],
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(12.0)),
            //   width: (screenWidth / 2) - 30,
            //   height: 55,
            //   child: Material(
            //     borderRadius: BorderRadius.circular(12.0),
            //     child: InkWell(
            //       onTap: () async{
            //       // await _handleSignIn();
            //         try {
            //           debugPrint("Starting authentication");
            //           await signInWithGoogle();
            //           debugPrint("Authentication completed");
            //         } catch (e) {
            //           debugPrint("Authentication error: $e");
            //         }
            //        //await _authenticate();
            //        // print("google tapped");
            //       },
            //       child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Row(
            //           children: [
            //             Image.asset("assets/images/google.png",
            //                 fit: BoxFit.cover),
            //             SizedBox(
            //               width: 7.0,
            //             ),
            //             Text("Sign in with\nGoogle")
            //           ],
            //         ),
            //       ),
            //     ),
            //   ))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _showValidationError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _highlightErrorFields(List<String> errorFields) {
    // You can implement visual feedback for error fields
    // For example, change border color or show error icons
    setState(() {
      // Update state variables that control field styling
    });
  }
  Map<String, String?> _validateFields() {
    final errors = <String, String?>{};

    // First Name Validation
    if (first.text.isEmpty) {
      errors['firstName'] = 'First name is required';
    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(first.text)) {
      errors['firstName'] = 'First name can only contain letters';
    }

    // Last Name Validation
    if (last.text.isEmpty) {
      errors['lastName'] = 'Last name is required';
    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(last.text)) {
      errors['lastName'] = 'Last name can only contain letters';
    }

    // Email Validation
    if (_emailController.text.isEmpty) {
      errors['email'] = 'Email is required';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_emailController.text)) {
      errors['email'] = 'Please enter a valid email';
    }
    if (phone.text.isEmpty) {
      errors['phone'] = 'Phone number is required';
    } else {
      // Remove all non-digit characters
      final digitsOnly = phone.text.replaceAll(RegExp(r'[^0-9]'), '');

      if (digitsOnly.length < 10) {
        errors['phone'] = 'Phone number must be at least 10 digits';
      } else if (!RegExp(r'^[0-9+]{10,15}$').hasMatch(phone.text)) {
        errors['phone'] = 'Please enter a valid phone number';
      }
    }
    // Date of Birth Validation
    if (dob.text.isEmpty) {
      errors['dob'] = 'Date of birth is required';
    }

    return errors;
  }
  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print("handle $error");
    }
  }
  signInWithGoogle() async {
// begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
// user cancels google sign in pop up screen
    if (gUser == null) return;
// obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser.authentication;
// create a new credential for user
    final credential = GoogleAuthProvider.credential(
    accessToken: gAuth.accessToken, idToken: gAuth. idToken,
    );
// finally, sign in!
    }
  Future<Map<String, dynamic>> _authenticateWithCustomApi(String idToken) async {
    const String apiUrl = 'https://backend-learning-45qi.onrender.com/api/auth/google';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': idToken}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to authenticate with API');
    }
  }

  Future<void> _signOut() async {
    await _googleSignIn.signOut();
    setState(() => _authToken = null);
  }

  Future<void> _checkBiometrics() async {
    try {
      bool canCheck = await _localAuth.canCheckBiometrics;
      List<BiometricType> availableBiometrics =
      await _localAuth.getAvailableBiometrics();

      print('Can check biometrics: $canCheck');
      print('Available biometrics: $availableBiometrics');
    } catch (e) {
      print('Error checking biometrics: $e');
    }
  }

  Future<void> _authenticate() async {
    try {
      debugPrint("authentication called");
      bool isCheck=await _localAuth.canCheckBiometrics;
      debugPrint("can use $isCheck");
      List<BiometricType> availableBiometrics = await _localAuth.getAvailableBiometrics();
      debugPrint("Available biometrics: $availableBiometrics");
      bool authenticated = await _localAuth.authenticate(
        localizedReason: 'Authenticate to access secure data',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          biometricOnly: true, // Only biometrics (no device credentials)
          stickyAuth: true, // Keep authentication dialog visible
        ),
      );
      debugPrint("authenticated $authenticated");
      setState(() {
        _isAuthenticated = authenticated;
        if(_isAuthenticated){
          setStringAsync("loggedin", "1");
          setStringAsync('email', _emailController.text);
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DashBoard()));
        }
        _authResult = authenticated ? 'Authenticated!' : 'Failed to authenticate';
      });

    } on PlatformException catch (e) {
      setState(() {
        _authResult = 'Error: ${e.message}';
        print("authenticatopdfbdjbf $_authResult");
      });
    }
  }
}
