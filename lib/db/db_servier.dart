import 'dart:convert';
import 'package:fcm_test02/db/user_model.dart';
import 'package:http/http.dart' as http;

class DBService{

  Future<void> saveUser(User user) async{
    var client = http.Client();
    try{

      final response = await client.post(
        Uri.parse('http://172.30.1.98:9999/restFlutter/save')
        ,headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
        },
        body: jsonEncode(user.toJson()),
      ).timeout(const Duration(seconds: 30),onTimeout: (){
          return http.Response('Error',408);
          // Request Timeout response status code
      });
      // Map<String, dynamic> result = json.decode(response.body);
      // print(result);
      var statusCode = response.statusCode;
      print('statusCode:: $statusCode');
      if(statusCode != 200){
        throw Exception("Failed to send data");
      }else{
        print("User Data send successfully");
      }
    }catch(e){
      print("Failed to send post data: ${e}");
    }finally{
      client.close();
      print("client Close!!!");

    }
  }
}
