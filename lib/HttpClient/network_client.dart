import 'dart:convert';

import 'package:http/http.dart' as http;



class HttpClient {


   Future <dynamic> fetchData(String url) async {

    var response = await http.get(url);
    if(response.statusCode == 200)
    {
      return jsonDecode(response.body);
    }
    else{
      print("Can't get Data!");
    }

  }

}




