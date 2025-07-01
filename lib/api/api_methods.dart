import 'package:career/api/api_routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

Dio _dio = Dio();
var profileData;
Future<Response> postOTPVerification({
  required String mobileNumber,
  required String token,
}) async {
  try {
    debugPrint("Sending OTP request for $mobileNumber");

    // Create FormData properly
    final formData = FormData.fromMap({
      'MobileNumber': mobileNumber,
      'token': token,
    });

    // Make the request with proper configuration
    final response = await _dio.post(
      otpurl, // Make sure this URL is correct
      data: formData,
      options: Options(
        contentType: 'multipart/form-data', // or 'application/x-www-form-urlencoded'
        headers: {
          'Accept': 'application/json',
        },
      ),
    );

    debugPrint("OTP API Response: ${response.statusCode} - ${response.data}");
    return response;

  } on DioException catch (e) {
    debugPrint("DioError Details:");
    debugPrint("- Type: ${e.type}");
    debugPrint("- Message: ${e.message}");
    debugPrint("- Response: ${e.response?.data}");
    debugPrint("- Status: ${e.response?.statusCode}");
    debugPrint("- Headers: ${e.response?.headers}");
    debugPrint("- Request: ${e.requestOptions.data}");

    if (e.response != null) {
      // Server responded with error status code
      throw Exception(
        'Server error (${e.response?.statusCode}): ${e.response?.data}',
      );
    } else {
      // No response from server (network error)
      throw Exception(
        'Network error: ${e.message}',
      );
    }
  } catch (e) {
    debugPrint("Unexpected error: $e");
    throw Exception('Unexpected error occurred');
  }
}

Future<Response> login(String phone) async {
  print("Url is $loginUrl");
  try {
    final response = await _dio.post(
      loginUrl, // Make sure this URL is correct
      data: {
        "phoneNumber": phone
      },
    );

    debugPrint("OTP API Response: ${response.statusCode} - ${response.data}");
    return response;
  } on DioException catch (e) {
    debugPrint("DioError Details:");
    debugPrint("- Type: ${e.type}");
    debugPrint("- Message: ${e.message}");
    debugPrint("- Response: ${e.response?.data}");
    debugPrint("- Status: ${e.response?.statusCode}");
    debugPrint("- Headers: ${e.response?.headers}");
    debugPrint("- Request: ${e.requestOptions.data}");

    if (e.response != null) {
      // Server responded with error status code (including 500)
      return e.response!; // Return the error response
    } else {
      // No response from server (network error)
      print("network error ${e.message}");
      throw Exception(
        'Network error: ${e.message}',

      );

    }
  } catch (e) {
    debugPrint("Unexpected error: $e");
    throw Exception('Unexpected error occurred');
  }
}
Future<Response> signUp(String first,String last,String phone,String email,String dob) async {
  print("Url is $signUpUrl");
  try {
    final response = await _dio.post(
      signUpUrl, // Make sure this URL is correct
      data: {
        "firstName": first,
   "lastName": last,
        "phoneNumber": phone,
   "email": email,
  "dob": dob
      },
    );

    debugPrint("OTP API Response: ${response.statusCode} - ${response.data}");
    return response;
  } on DioException catch (e) {
    debugPrint("DioError Details:");
    debugPrint("- Type: ${e.type}");
    debugPrint("- Message: ${e.message}");
    debugPrint("- Response: ${e.response?.data}");
    debugPrint("- Status: ${e.response?.statusCode}");
    debugPrint("- Headers: ${e.response?.headers}");
    debugPrint("- Request: ${e.requestOptions.data}");

    if (e.response != null) {
      // Server responded with error status code (including 500)
      return e.response!; // Return the error response
    } else {
      // No response from server (network error)
      throw Exception(
        'Network error: ${e.message}',
      );
    }
  } catch (e) {
    debugPrint("Unexpected error: $e");
    throw Exception('Unexpected error occurred');
  }
}
Future<Response> updateProfile(String first,String last,String phone,String email,String dob,String aadhar,String pan,String photo) async {
  print("Url is $signUpUrl");
  try {
    final response = await _dio.post(
      signUpUrl, // Make sure this URL is correct
      data: {
        "firstName": first,
        "lastName": last,
        "phoneNumber": phone,
        "email": email,
        "dob": dob,
         "aadharNumber":aadhar,
         "panNumber":pan,
         "profilePhoto":photo
      },
    );

    debugPrint("OTP API Response: ${response.statusCode} - ${response.data}");
    return response;
  } on DioException catch (e) {
    debugPrint("DioError Details:");
    debugPrint("- Type: ${e.type}");
    debugPrint("- Message: ${e.message}");
    debugPrint("- Response: ${e.response?.data}");
    debugPrint("- Status: ${e.response?.statusCode}");
    debugPrint("- Headers: ${e.response?.headers}");
    debugPrint("- Request: ${e.requestOptions.data}");

    if (e.response != null) {
      // Server responded with error status code (including 500)
      return e.response!; // Return the error response
    } else {
      // No response from server (network error)
      throw Exception(
        'Network error: ${e.message}',
      );
    }
  } catch (e) {
    debugPrint("Unexpected error: $e");
    throw Exception('Unexpected error occurred');
  }
}
Future<Response> getProfileData(String email) async {
  print("Url is $profileDataUrl");
  try {
    final response = await _dio.get(
      profileDataUrl, // Make sure this URL is correct
      data: {
        "email": email
      },
    );

    debugPrint("OTP API Response: ${response.statusCode} - ${response.data}");
    return response;
  } on DioException catch (e) {
    debugPrint("DioError Details:");
    debugPrint("- Type: ${e.type}");
    debugPrint("- Message: ${e.message}");
    debugPrint("- Response: ${e.response?.data}");
    debugPrint("- Status: ${e.response?.statusCode}");
    debugPrint("- Headers: ${e.response?.headers}");
    debugPrint("- Request: ${e.requestOptions.data}");

    if (e.response != null) {
      // Server responded with error status code (including 500)
      return e.response!; // Return the error response
    } else {
      // No response from server (network error)
      throw Exception(
        'Network error: ${e.message}',
      );
    }
  } catch (e) {
    debugPrint("Unexpected error: $e");
    throw Exception('Unexpected error occurred');
  }
}
Future<Response> getLiveCoursesData() async {
  print("Url is $liveCoursesDataUrl");
  try {
    final response = await _dio.get(
      liveCoursesDataUrl, // Make sure this URL is correct
    );

    print("live courses API Response: ${response.statusCode} - ${response.data}");
    return response;
  }on DioException catch (e) {
    if (e.response != null) {
      return e.response!;
    } else {
      throw Exception('Network error: ${e.message}');
    }
  } catch (e) {
    throw Exception('Unexpected error: $e');
  }
}
Future<Response> getAllNotes() async {
  print("Url is $NotesDataUrl");
  try {
    final response = await _dio.get(
      NotesDataUrl, // Make sure this URL is correct
    );

    print("live courses API Response: ${response.statusCode} - ${response.data}");
    return response;
  }on DioException catch (e) {
    if (e.response != null) {
      return e.response!;
    } else {
      throw Exception('Network error: ${e.message}');
    }
  } catch (e) {
    throw Exception('Unexpected error: $e');
  }
}
Future<Response> getAllMentorsData() async {
  print("mentor url is $getAllMentorsUrl");
  try {
    final response = await _dio.get(
      getAllMentorsUrl, // Make sure this URL is correct
    );

    print("All Mentors data: ${response.statusCode} - ${response.data}");
    return response;
  }on DioException catch (e) {
    if (e.response != null) {
      return e.response!;
    } else {
      throw Exception('Network error: ${e.message}');
    }
  } catch (e) {
    throw Exception('Unexpected error: $e');
  }
}
Future<Response> postCourse(var body) async {
  print("live class url is $createLiveClassUrl");
  try {
    final response = await _dio.post(
      createLiveClassUrl,
      data: body
      // Make sure this URL is correct
    );

    print("All live class data: ${response.statusCode} - ${response.data}");
    return response;
  }on DioException catch (e) {
    if (e.response != null) {
      return e.response!;
    } else {
      throw Exception('Network error: ${e.message}');
    }
  } catch (e) {
    throw Exception('Unexpected error: $e');
  }
}