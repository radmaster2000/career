// import 'package:career/screens/signUpScreen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// import '../widgets/inputTextWidget.dart';
// import 'Dashboard.dart';
// import 'otp.dart';
//
//
// class LoginScreen extends StatefulWidget {
//   LoginScreen() : super();
//
//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<LoginScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   bool _isLoading = false;
//   final TextEditingController _pwdController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   //final snackBar = SnackBar(content: Text('email ou mot de passe incorrect'));
//   final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final double r = (175 / 360); //  rapport for web test(304 / 540);
//     final coverHeight = screenWidth * r;
//     bool _pinned = false;
//     bool _snap = false;
//     bool _floating = false;
//
//     final widgetList = [
//       Row(
//         children: [
//           SizedBox(
//             width: 28,
//           ),
//           Text(
//             'Welcome',
//             style: TextStyle(
//               fontFamily: 'Segoe UI',
//               fontSize: 40,
//               fontWeight: FontWeight.bold,
//               color: const Color(0xff000000),
//
//             ),
//             textAlign: TextAlign.left,
//           ),
//         ],
//       ),
//       SizedBox(
//         height: 12.0,
//       ),
//       Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               InputTextWidget(
//                   controller: _emailController,
//                   labelText: "Email Address",
//                   icon: Icons.email,
//                   obscureText: false,
//                   keyboardType: TextInputType.emailAddress),
//               SizedBox(
//                 height: 12.0,
//               ),
//               InputTextWidget(
//                   controller: _pwdController,
//                   labelText: "Password",
//                   icon: Icons.lock,
//                   obscureText: true,
//                   keyboardType: TextInputType.text),
//               Padding(
//                 padding: const EdgeInsets.only(right: 25.0, top: 10.0),
//                 child: Align(
//                     alignment: Alignment.topRight,
//                     child: Material(
//                       color: Colors.transparent,
//                       child: InkWell(
//                         onTap: () {},
//                         child: Text(
//                           "Forgot Password",
//                           style: TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.grey[700]),
//                         ),
//                       ),
//                     )),
//               ),
//               SizedBox(
//                 height: 15.0,
//               ),
//               Container(
//                 height: 55.0,
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//                       print("I ove tunisia");
//                     }
//                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => DashBoard(),));
//                     //Get.to(ChoiceScreen());
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     elevation: 0.0,
//                     minimumSize: Size(screenWidth, 150),
//                     padding: EdgeInsets.symmetric(horizontal: 30),
//                     shape: const RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(0)),
//                     ),
//                   ),
//                   child: Ink(
//                     decoration: BoxDecoration(
//                         boxShadow: <BoxShadow>[
//                           BoxShadow(
//                               color: Colors.red,
//                               offset: const Offset(1.1, 1.1),
//                               blurRadius: 10.0),
//                         ],
//                         color: Colors.red, // Color(0xffF05945),
//                         borderRadius: BorderRadius.circular(12.0)),
//                     child: Container(
//                       alignment: Alignment.center,
//                       child: Text(
//                         "Sign In",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(color: Colors.white, fontSize: 25),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           )),
//       SizedBox(
//         height: 15.0,
//       ),
//       // Inside _GoogleSignInButton
//       OutlinedButton(
//         onPressed: ()async{
//           await _handleSignIn();
//         },
//         style: OutlinedButton.styleFrom(
//           backgroundColor: Colors.white,
//           padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(24),
//           ),
//           side: BorderSide(color: Colors.grey.shade300),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Image.asset(
//               'assets/images/google.png', // PNG version
//               height: 24,
//               width: 24,
//             ),
//             SizedBox(width: 12),
//             Text(
//               'Continue with Google',
//               style: TextStyle(
//                 color: Colors.grey[800],
//                 fontSize: 16,
//               ),
//             ),
//           ],
//         ),
//       ),
//       // Wrap(
//       //   children: [
//       //     Padding(
//       //       padding: const EdgeInsets.only(left: 30.0, right: 10.0, top: 15.0),
//       //       child: Container(
//       //         decoration: BoxDecoration(
//       //             boxShadow: <BoxShadow>[
//       //               BoxShadow(
//       //                   color: Colors.grey, //Color(0xfff05945),
//       //                   offset: const Offset(0, 0),
//       //                   blurRadius: 5.0),
//       //             ],
//       //             color: Colors.white,
//       //             borderRadius: BorderRadius.circular(12.0)),
//       //         width: (screenWidth / 2) - 40,
//       //         height: 55,
//       //         child: Material(
//       //           borderRadius: BorderRadius.circular(12.0),
//       //           child: InkWell(
//       //             onTap: () {
//       //               print("facebook tapped");
//       //             },
//       //             child: Padding(
//       //               padding: const EdgeInsets.all(8.0),
//       //               child: Row(
//       //                 children: [
//       //                   Image.asset("assets/images/fb.png", fit: BoxFit.cover),
//       //                   SizedBox(
//       //                     width: 7.0,
//       //                   ),
//       //                   Text("Sign in avec\nfacebook")
//       //                 ],
//       //               ),
//       //             ),
//       //           ),
//       //         ),
//       //       ),
//       //     ),
//       //     Padding(
//       //       padding: const EdgeInsets.only(left: 10.0, right: 30.0, top: 15.0),
//       //       child: Container(
//       //         decoration: BoxDecoration(
//       //             boxShadow: <BoxShadow>[
//       //               BoxShadow(
//       //                   color: Colors.grey, //Color(0xfff05945),
//       //                   offset: const Offset(0, 0),
//       //                   blurRadius: 5.0),
//       //             ],
//       //             color: Colors.white,
//       //             borderRadius: BorderRadius.circular(12.0)),
//       //         width: (screenWidth / 2) - 40,
//       //         height: 55,
//       //         child: Material(
//       //           borderRadius: BorderRadius.circular(12.0),
//       //           child: InkWell(
//       //             onTap: () {
//       //               print("google tapped");
//       //             },
//       //             child: Padding(
//       //               padding: const EdgeInsets.all(8.0),
//       //               child: Row(
//       //                 children: [
//       //                   Image.asset("assets/images/google.png",
//       //                       fit: BoxFit.cover),
//       //                   SizedBox(
//       //                     width: 7.0,
//       //                   ),
//       //                   Text("Sign in avec\nGoogle")
//       //                 ],
//       //               ),
//       //             ),
//       //           ),
//       //         ),
//       //       ),
//       //     ),
//       //   ],
//       // ),
//       SizedBox(
//         height: 15.0,
//       ),
//     ];
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         // leading: Icon(Icons.arrow_back),
//         backgroundColor: Colors.transparent,
//         elevation: 0.0,
//       ),
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverAppBar(
//             pinned: _pinned,
//             snap: _snap,
//             floating: _floating,
//             expandedHeight: coverHeight - 25, //304,
//             backgroundColor: Color(0xFFdccdb4),
//             flexibleSpace: FlexibleSpaceBar(
//               centerTitle: true,
//               background:
//                   Image.asset("assets/images/cover.jpg", fit: BoxFit.cover),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//
//                       ),
//                   gradient: LinearGradient(
//                       colors: <Color>[Color(0xFFdccdb4), Color(0xFFd8c3ab)])
//
//                   ),
//               width: screenWidth,
//               height: 25,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: <Widget>[
//                   Container(
//                     width: screenWidth,
//                     height: 25,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//
//                       borderRadius: BorderRadius.only(
//                         topLeft: const Radius.circular(30.0),
//                         topRight: const Radius.circular(30.0),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           SliverList(
//               delegate:
//                   SliverChildBuilderDelegate((BuildContext context, int index) {
//             return widgetList[index];
//           }, childCount: widgetList.length))
//         ],
//       ),
//       bottomNavigationBar: Stack(
//         children: [
//           new Container(
//             height: 50.0,
//             color: Colors.white,
//             child: Center(
//                 child: Wrap(
//               children: [
//                 Text(
//                   "Don't have an account?",
//                   style: TextStyle(
//                       color: Colors.grey[600], fontWeight: FontWeight.bold),
//                 ),
//                 Material(
//                     child: InkWell(
//                   onTap: () {
//                     print("sign up tapped");
//                     Get.to(SignUpScreen());
//                   },
//                   child: Text(
//                     "Sign Up",
//                     style: TextStyle(
//                       color: Colors.blue[800],
//                       fontWeight: FontWeight.bold,
//                       fontSize: 15,
//                     ),
//                   ),
//                 )),
//               ],
//             )),
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   Future<User?> _handleSignIn() async {
//     setState(() => _isLoading = true);
//
//     try {
//       // Trigger Google Sign-In flow
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) return null;
//
//       // Obtain auth details from request
//       final GoogleSignInAuthentication googleAuth =
//       await googleUser.authentication;
//
//       // Create Firebase credential
//       final OAuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       // Sign in to Firebase with Google credentials
//       //final UserCredential userCredential =
//       //await _auth.signInWithCredential(credential);
//        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DashBoard(),));
//       //return userCredential.user;
//     } catch (error) {
//       print('Error signing in with Google: $error');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Sign in failed: ${error.toString()}')),
//       );
//       return null;
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }
// }
