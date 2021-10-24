import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:path_provider/path_provider.dart';
class cryptData{

  Future<List<dynamic>> getCryptData() async {
    print('insided function');
    dynamic data;
    String filename = 'cachedata.json';
    var cachedir = await getTemporaryDirectory();
    if(await File(cachedir.path +"/"+filename).exists()){
        print('device memory');
        var jsondata = File(cachedir.path +"/"+filename).readAsStringSync();
        data = convert.jsonDecode(jsondata) as Map<String, dynamic>;
    }else{
        var url = Uri.parse('http://api.coinlayer.com/list?access_key=26d363c4b0ea49bf66fa7f22469bd100');
        var response = await http.get(url);
        var jsonResponse = response.body;
        var tempdir = await getTemporaryDirectory();
        File file = File(tempdir.path + "/" + filename);
        file.writeAsString(jsonResponse);
        data = convert.jsonDecode(response.body) as Map<String, dynamic>;
    }


    data = data['crypto'];
    var dataValue = await dataMapping(data);
    // print(dataValue);
    return dataValue;
  }

  Future<List> dataMapping(Map<String,dynamic> data) async {
    print('api to be called');
    var dataValue = [];
    for(var k in data.keys){
      var symbol = data[k]['symbol'];
      var name = data[k]['name'];
      var iconUrl = data[k]['icon_url'];
      var value = [];
      value.add(symbol);
      value.add(name);
      value.add(iconUrl);
      dataValue.add(value);
    }
    return dataValue;
  }

  Future<Map<String, dynamic>> getCryptoValue(var symbol) async {
    var url = Uri.parse('http://api.coinlayer.com/live?access_key=26d363c4b0ea49bf66fa7f22469bd100&expand=1');
    var response = await http.get(url);
    // print(response.body);
    var data = convert.jsonDecode(response.body) as Map<String, dynamic>;
    print(data['rates'][symbol]);
    return data['rates'][symbol];

  }

}