import 'dart:convert';
import 'dart:io';

import 'package:career/widgets/inputTextWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../api/api_methods.dart';
import '../utils/app_images.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //ApiService _serv=ApiService();
  final TextEditingController first = TextEditingController();
  final TextEditingController last = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController aadhar = TextEditingController();
  final TextEditingController pan = TextEditingController();
  final TextEditingController dob = TextEditingController();
  final picker = ImagePicker();
  File ?_image;
  String _imageBase64="null";
  @override
  void initState() {
    // TODO: implement initState
    first.text=profileData["firstName"];
    last.text=profileData["lastName"];
    _emailController.text=profileData["email"];
    phone.text=profileData["phoneNumber"];
    dob.text=profileData["dob"].split("T")[0];
    // _rmname.text=profileData["ManagerNAme"];
    // _rmcode.text=profileData["TLCode"];

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          body: NestedScrollView(headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                centerTitle: true,
                // title: Image.asset(appLogoImg,height: 50,width: 50,),
               // title: Image.asset(appProfileImg,height: 60,width: 60,),
               //  leading: IconButton(onPressed: (){
               //    Navigator.pop(context);
               //    // _scaffoldkey.currentState!.openDrawer();
               //  }, icon: Icon(Icons.arrow_back_ios)),
              )
            ];
          }, body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  InkWell(
                    onTap: (){
                      showOptions();
                    },
                    child: Stack(
                      children: [
                        CircleAvatar(
                            radius: 50,
                            // backgroundImage: (profileData==null)?AssetImage(appProfileImg):NetworkImage(profileData[0]["Employeeimage"]) as ImageProvider,
                            //backgroundImage: (profileData==null ||profileData["Imagepath"].isEmpty)?AssetImage(appProfileImg):NetworkImage(profileData["Imagepath"]) as ImageProvider
                          backgroundImage: _getProfileImage(),
                        ),
                        Image.asset(appUpload,height: 30,width: 30,)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
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
                  // makeInput(_name,"Lokendra",label: "Name"),
                  InputTextWidget(
                      controller: _emailController,
                      labelText: "Email Address",
                      icon: Icons.email,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress),
                  SizedBox(
                    height: 12.0,
                  ),
                  InputTextWidget(
                      controller: phone,
                      labelText: "Phone",
                      icon: Icons.phone,
                      obscureText: false,
                      keyboardType: TextInputType.number),
                  SizedBox(
                    height: 12.0,
                  ),
                  InputTextWidget(
                      controller: aadhar,
                      labelText: "Aadhar Number",
                      icon: Icons.phone,
                      obscureText: false,
                      keyboardType: TextInputType.number),
                  SizedBox(
                    height: 12.0,
                  ),
                  InputTextWidget(
                      controller: pan,
                      labelText: "PAN Number",
                      icon: Icons.phone,
                      obscureText: false,
                      keyboardType: TextInputType.text),
                  SizedBox(
                    height: 12.0,
                  ),
                 // makeInput(_rmcode,"Lokendra",label: "RM EmpCode"),
                  Container(
                    height: 55.0,
                    child: ElevatedButton(
                      onPressed: () async {
                        final errors = _validateFields();

                        if (errors.isEmpty ) {
                          // All fields are valid - proceed with submission
                          //_submitForm();
                          /////
                          if(_imageBase64!=""){
                            final response=await updateProfile(first.text, last.text, phone.text, _emailController.text, dob.text,aadhar.text,pan.text,_imageBase64 ??'');
                            print("update data is ${response.data}");
                            if(response.statusCode==201 && response.data["message"]=="User registered successfully"){
                              // _authenticate();
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("successfully updated"),
                                  duration: Duration(seconds: 3),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          }
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Please Select image"),
                                duration: Duration(seconds: 3),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                          ////

                        } else {
                          // Show first error in SnackBar
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
                          child: Text(
                            "Update",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 25,fontFamily:'LexendMedium'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),)
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
  Widget makeInput(
      TextEditingController controller, String message,
      {label, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          enabled: false,
          obscureText: obscureText,
          controller: controller,
          //validator: (value) => _validationUtil.validateField(value, message),
          decoration: InputDecoration(
            // errorText: _validate ? message : null,
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey[400]!)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.grey[400]!)),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
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
    if (aadhar.text.isEmpty) {
      errors['aadhaar'] = 'Aadhaar number is required';
    } else {
      // Aadhaar should be 12 digits only
      final aadhaarDigits = aadhar.text.replaceAll(RegExp(r'[^0-9]'), '');
      if (aadhaarDigits.length != 12) {
        errors['aadhaar'] = 'Aadhaar must be 12 digits';
      } else if (!RegExp(r'^[2-9]{1}[0-9]{11}$').hasMatch(aadhaarDigits)) {
        errors['aadhaar'] = 'Please enter a valid Aadhaar number';
      }
    }

    // PAN Card Validation (assuming you have a panController)
    if (pan.text.isEmpty) {
      errors['pan'] = 'PAN number is required';
    } else {
      // PAN format: ABCDE1234F (5 letters, 4 digits, 1 letter)
      if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(pan.text)) {
        errors['pan'] = 'Please enter a valid PAN (e.g., ABCDE1234F)';
      }
    }
    return errors;
  }
  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text('Photo Gallery'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }
  Future getImageFromGallery() async {
    // final pickedFile = await picker.getImage(source: ImageSource.gallery);
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      final bytes = await _image!.readAsBytes();
      _imageBase64=base64Encode(bytes);
      setState(() {

      });
    }
  }

//Image Picker function to get image from camera
  Future getImageFromCamera() async {
    // final pickedFile = await picker.getImage(source: ImageSource.camera);
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      final bytes = await _image!.readAsBytes();
      _imageBase64=base64Encode(bytes);
      setState(()  {

      });
    }
  //   var res = await _serv.uploadImage(pickedFile!);
  //   if(res!=null){
  //     setState(() {
  //       if (pickedFile != null) {
  //         _image = pickedFile;
  //       }
  //     });
  //   }
  //   else{
  //     toast("Image Not uploaded kindly try again");
  //   }
   }
  ImageProvider _getProfileImage() {
    // 1. Show picked image if available
    if (_image != null) return FileImage(_image!);

    // 2. Show network image from profile data if available
    // if (profileData != null && profileData["Imagepath"].isNotEmpty) {
    //   return NetworkImage(profileData["Imagepath"]);
    // }

    // 3. Fall back to asset image
    return AssetImage(appProfileImg);
  }
}