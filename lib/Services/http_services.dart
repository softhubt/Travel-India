import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:travelindia/Constant/endpoint_constant.dart';

class HttpServices {
  static Future<Map<String, dynamic>> getHttpMethod(
      {required String? url, bool? isChanged = false}) async {
    Map<String, String> headers = {
      "Content-Type": " application/x-www-form-urlencoded"
    };
    log("Get Http Method Url ::: ${EndPointConstant.baseUrl}$url");
    log("Get Http Method Headers ::: $headers");
    http.Response response = (isChanged == true)
        ? await http
            .get(Uri.parse("${EndPointConstant.baseUrl}$url"), headers: headers)
            .timeout(const Duration(seconds: 60))
        : await http
            .get(Uri.parse("${EndPointConstant.baseUrl}$url"), headers: headers)
            .timeout(const Duration(seconds: 60));
    log("Get Http Method's Status Code ::: '${response.statusCode}'");
    log("Get Http Response Body ::: '${response.body}'");
    return {'body': response.body};
  }

  static Future<Map<String, dynamic>> postHttpMethod(
      {required String url,
      required Map<String, dynamic> payload,
      bool? isChanged = false}) async {
    var encoding = Encoding.getByName('utf-8');
    Map<String, String> headers = {
      "Content-Type": " application/x-www-form-urlencoded"
    };
    log("Post Http Method Url ::: ${EndPointConstant.baseUrl}$url");
    log("Get Http Method Headers ::: $headers");
    http.Response response = (isChanged == true)
        ? await http
            .post(
              Uri.parse("${EndPointConstant.baseUrl}$url"),
              body: payload,
              encoding: encoding,
              headers: headers,
            )
            .timeout(const Duration(seconds: 60))
        : await http
            .post(
              Uri.parse("${EndPointConstant.baseUrl}$url"),
              body: payload,
              encoding: encoding,
              headers: headers,
            )
            .timeout(const Duration(seconds: 60));
    log("Post Http Method Status Code ::: ${response.statusCode}");
    log("Post Http Method Response Body ::: ${response.body}");
    return {'body': response.body};
  }

// static Future<Map<String, dynamic>> patchHttpMethod(
//     {required String? url, Map<String, dynamic>? payload}) async {
//   log("Patch Http Method Url ::: '$endPointUrl$url'");
//   http.Response response = await http.patch(
//     Uri.parse("$endPointUrl$url"),
//     body: payload,
//   );
//   log("Patch Http Method Status Code ::: ${response.statusCode}");
//   log("Patch Http Method Response body ::: ${response.body}");
//   return {'body': response.body};
// }
//
// static Future<Map<String, dynamic>> putHttpMethod(
//     {required String? url, Map<String, dynamic>? payload}) async {
//   log("Put Http Method Url ::: $endPointUrl$url");
//   http.Response response = await http.put(
//     Uri.parse("$endPointUrl$url"),
//     body: payload,
//   );
//   log("Put Http Method Status Code ::: ${response.statusCode}");
//   log("Put Http Method Response Body ::: ${response.body}");
//   return {'body': response.body};
// }
//
// static Future<Map<String, dynamic>> deleteHttpMethod(
//     {required String? url, Map<String, dynamic>? payload}) async {
//   log("Delete Http Method Uel ::: $endPointUrl$url");
//   http.Response response = await http.delete(
//     Uri.parse("$endPointUrl$url"),
//     body: payload,
//   );
//   log("Delete Http Method's Status Code ::: ${response.statusCode}");
//   log("Delete Http Method's Response Body ::: ${response.body}");
//   return {'body': response.body};
// }
}
