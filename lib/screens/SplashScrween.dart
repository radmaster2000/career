import 'dart:async';

import 'package:career/screens/Dashboard/Dashboard.dart';
import 'package:career/screens/Login.dart';
import 'package:career/screens/otp.dart';
import 'package:career/screens/signUpScreen.dart';
import 'package:career/screens/teacher/live_courses_teacher.dart';
import 'package:career/utils/app_size.dart' as size;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:local_auth/local_auth.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isAuthenticated = false;
  String _authResult = 'Not authenticated';
  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 5), ()
    {
      debugPrint("Navigating to SignUpScreen");
      checkloggin();
    });
    debugPrint("splash init");
    super.initState();
  }

  checkloggin(){
    String value=getStringAsync('loggedin');
    print("login value is $value");
    if(value==""){
      Navigator.of(context).pushReplacement( // Using pushReplacement to remove splash
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
    else{
      _authenticate();

    }
  }
  Future<void> _authenticate() async {
    try {
      debugPrint("Authentication called");
      bool isCheck = await _localAuth.canCheckBiometrics;
      debugPrint("Can use biometrics: $isCheck");

      List<BiometricType> availableBiometrics = await _localAuth.getAvailableBiometrics();
      debugPrint("Available biometrics: $availableBiometrics");

      bool authenticated = false;
      int attempts = 0;
      const maxAttempts = 3;

      // Keep showing authentication until successful or max attempts reached
      while (!authenticated && attempts < maxAttempts) {
        authenticated = await _localAuth.authenticate(
          localizedReason: 'Authenticate to access secure data',
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            biometricOnly: false, // Changed to false to allow device credentials
            stickyAuth: true,
            sensitiveTransaction: true, // Makes it harder to dismiss
          ),
        );

        attempts++;

        if (!authenticated && attempts < maxAttempts) {
          debugPrint("Authentication failed. Attempt $attempts of $maxAttempts");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Authentication failed. Please try again.'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }

      debugPrint("Authenticated: $authenticated");

      if (authenticated) {
        setState(() {
          _isAuthenticated = true;
          _authResult = 'Authenticated!';
        });
        await setStringAsync("loggedin", "1");
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => DashBoard())
        );
      } else {
        setState(() {
          _isAuthenticated = false;
          _authResult = 'Maximum attempts reached';
        });
        // Optionally show alternative login method
        _showAlternativeLogin();
      }

    } on PlatformException catch (e) {
      setState(() {
        _authResult = 'Error: ${e.message}';
        debugPrint("Authentication error: $_authResult");
      });
      _showAlternativeLogin();
    }
  }

  void _showAlternativeLogin() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing by tapping outside
      builder: (context) => AlertDialog(
        title: Text('Authentication Required'),
        content: Text('Please authenticate using PIN, pattern, or password'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _authenticate(); // Retry biometric auth
            },
            child: Text('Try Biometric Again'),
          ),
          TextButton(
            onPressed: () => _showPinPatternDialog(),
            child: Text('Use PIN/Pattern'),
          ),
        ],
      ),
    );
  }

  void _showPinPatternDialog() {
    TextEditingController pinController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Enter PIN/Pattern'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: pinController,
              obscureText: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'PIN/Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            Text('OR'),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _authenticateDeviceCredential(),
              child: Text('Use Device Credential'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (_validatePin(pinController.text)) {
                Navigator.pop(context);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => DashBoard())
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Invalid PIN/Password')),
                );
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  Future<void> _authenticateDeviceCredential() async {
    try {
      bool authenticated = await _localAuth.authenticate(
        localizedReason: 'Authenticate with device credential',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          biometricOnly: false, // Allows device credentials
          stickyAuth: true,
        ),
      );

      if (authenticated) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => DashBoard())
        );
      }
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.message}')),
      );
    }
  }

  bool _validatePin(String pin) {
    // Implement your PIN/pattern validation logic here
    // Compare against stored PIN or hash
    return pin.length >= 4; // Example validation
  }
  @override
  Widget build(BuildContext context) {
    size.SizeConfig.init(context);
    size.Responsive.init(context);
    return Scaffold(
      body: Container(
        child: Center(child: Image.asset(logo,width: size.SizeConfig.mediumSizeHorizontal,)),
      ),
    );
  }
}
