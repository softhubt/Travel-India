import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:travelindia/Constant/endpoint_constant.dart';

class HttpServices {
  static String endPointUrl = EndPointConstant.baseUrl;

  static Future<Map<String, dynamic>> getHttpMethod(
      {required String url, required String message}) async {
    Map<String, String> headers = {
      "Content-Type": " application/x-www-form-urlencoded"
    };

    http.Response response =
        await http.get(Uri.parse("$endPointUrl$url"), headers: headers);

    log("----------------------------------------------------------------------------------------------------");
    log("$message url ::: $endPointUrl$url");
    log("$message status code ::: ${response.statusCode}");
    log("$message response ::: ${response.body}");
    log("----------------------------------------------------------------------------------------------------");

    return {'status_code': response.statusCode, 'body': response.body};
  }

  static Future<Map<String, dynamic>> postHttpMethod(
      {required String url,
      required Map<String, dynamic> payload,
      required String message}) async {
    var encoding = Encoding.getByName('utf-8');
    Map<String, String> headers = {
      "Content-Type": " application/x-www-form-urlencoded"
    };
    http.Response response = await http.post(Uri.parse("$endPointUrl$url"),
        headers: headers, encoding: encoding, body: payload);
    log("----------------------------------------------------------------------------------------------------");
    log("$message url ::: $endPointUrl$url");
    log("$message payload ::: $payload");
    log("$message status code ::: ${response.statusCode}");
    log("$message response ::: ${response.body}");
    log("----------------------------------------------------------------------------------------------------");

    return {'status_code': response.statusCode, 'body': response.body};
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
