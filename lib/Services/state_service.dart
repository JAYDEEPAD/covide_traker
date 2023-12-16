import 'dart:convert';

import 'package:covide_traker/Services/Utilites/app_url.dart';
import 'package:covide_traker/View/world_state.dart';
import 'package:http/http.dart'as http;

import '../Models/WorldStatesModels.dart';

class StateServices{

Future<WorldStatesModels> fetchWorldstates() async{

  final response= await http.get(Uri.parse(AppUrl.worldStateApi));

  if(response.statusCode==200){

    var data=jsonDecode(response.body.toString());
    return WorldStatesModels.fromJson(data);
  }
  else{
    throw Exception("Error");
  }


}
Future<List<dynamic>> countriesListApi() async{
 var data;

  final response= await http.get(Uri.parse(AppUrl.countryListApi));

  if(response.statusCode==200){

    data=jsonDecode(response.body.toString());
    return data;
  }
  else{
    throw Exception("Error");
  }


}


}