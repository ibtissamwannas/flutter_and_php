import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';

// ignore: prefer_interpolation_to_compose_strings
String _basicAuth = 'Basic ' + base64Encode(utf8.encode('ibtissam:sam12345'));

Map<String, String> myheaders = {'authorization': _basicAuth};

class Crud {
  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("error : ${response.statusCode}");
      }
    } catch (e) {
      print("Error Catch $e");
    }
  }

  postRequest(String url, Map data) async {
    try {
      var response =
          await http.post(Uri.parse(url), body: data, headers: myheaders);
      if (response.statusCode == 200) {
        print(response.body);
        var responsebody = jsonDecode(response.body);

        return responsebody;
      } else {
        print("error : ${response.statusCode}");
      }
    } catch (e) {
      print("Error Catch $e");
    }
  }

  postwithfile(String url, Map data, File file) async {
    var req = http.MultipartRequest("post", Uri.parse(url));
    var length = await file.length();
    var stream = http.ByteStream(file.openRead());
    var m = http.MultipartFile("file", stream, length,
        filename: basename(file.path));
    req.headers.addAll(myheaders);
    req.files.add(m);
    data.forEach((key, value) {
      req.fields[key] = value;
    });
    var myrequest = await req.send();
    var response = await http.Response.fromStream(myrequest);
    print(response.body);
    if (myrequest.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("Error ${myrequest.statusCode}");
    }
  }
}
