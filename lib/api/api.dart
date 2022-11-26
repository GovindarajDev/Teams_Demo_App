import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:teams/utils/const.dart';

abstract class Repository {
  Future getContactAndInviteList() async {}
  Future sendInvite(email, roleId) async {}
}

class ApiHandler implements Repository {
  http.Client client = http.Client();
  var token =
      "eyJhbGciOiJSUzI1NiIsImtpZCI6ImE5NmFkY2U5OTk5YmJmNWNkMzBmMjlmNDljZDM3ZjRjNWU2NDI3NDAiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vbWFybG8tYmFuay1kZXYiLCJhdWQiOiJtYXJsby1iYW5rLWRldiIsImF1dGhfdGltZSI6MTY2OTQzNzkzMSwidXNlcl9pZCI6IlJoSGdiY1U0cHZNMGR3RE90d1piTlhPOTlRMjMiLCJzdWIiOiJSaEhnYmNVNHB2TTBkd0RPdHdaYk5YTzk5UTIzIiwiaWF0IjoxNjY5NDM3OTMxLCJleHAiOjE2Njk0NDE1MzEsImVtYWlsIjoieGlob2g1NTQ5NkBkaW5lcm9hLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJ4aWhvaDU1NDk2QGRpbmVyb2EuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.r87EWFDRtcClpzs2Or2uE10Dm3GeszHAQjulwnHFdt8GcVWEeh9AfMuCFBdpx5TNTlyXru9M8oi7wtdL8Znl8HejuYCCuJafCd77VXFazJtyoPKg8OHX1mLbqHm7hVNsrW2MTZi7MjIJDv7Rs41ozsAZdOE9flukzSU25HIJfuu7vmRs017TFcGbV3gxd0kIKRHIu3NsOCSWIBHEVht-utSsyN4NxSspBpnG8SzixATCpGmu3q_sKYP3AGMyrWQYCBwKtMPMOP3t52vG2eFGjGhU3x5fbBFd7QsrEwOwIXptCe9S7aucZE9vz0XmTuiSI0ohzYAJEMx2UJMxWARchw";

/**
 * get invite 
 * calling API to Get Details
 */
  @override
  Future getContactAndInviteList() async {
    try {
      Response response = await client
          .get(Uri.parse(baseUrl + getTeamsUrl), headers: {"authtoken": token});
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
        return decodedResponse;
      }
      return null;
    } on Exception catch (e) {
      log(e.toString());
    }
  }

/**
 * used to add new invite 
 * calling API to Get Details
 */
  @override
  Future sendInvite(email, roleId) async {
    try {
      Response response = await client.post(Uri.parse(baseUrl + inviteUrl),
          headers: {"authtoken": token},
          body: {"email": email, "role": roleId.toString()});
      if (response.statusCode == 200 || response.statusCode == 201) {
        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
        log(jsonEncode(decodedResponse).toString(), name: "data");
        return decodedResponse;
      }
      return null;
    } catch (e) {
      log(e.toString(), name: "API");
    }
  }
}
