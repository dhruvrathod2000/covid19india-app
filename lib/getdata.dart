import 'package:http/http.dart';
import 'dart:convert';
class CoronaApi {
  dynamic deaths, confirmed, recovered, active,deltaconfirmed,deltarecovered,deltadeaths;
  Future<void> getData() async {
    try{
      Response response = await get("https://api.covid19india.org/data.json");
      Map data=jsonDecode(response.body);
      //print(data["statewise"]);
      Map total=data["statewise"][0];
      //print(total);
      confirmed=total['confirmed'];
      deaths=total['deaths'];
      //last_updated=total['lastupdatedtime'];
      active=total['active'];
      recovered=total['recovered'];
      deltaconfirmed=total['deltaconfirmed'];
      deltadeaths=total['deltadeaths'];
      deltarecovered=total['deltarecovered'];
    }
    catch(e){
      confirmed=0;deaths=0;active=0;recovered=0;
    }
    print("$confirmed $active $deaths $recovered");

  }
}