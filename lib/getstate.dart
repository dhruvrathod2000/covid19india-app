import 'package:http/http.dart';
import 'dart:convert';
class CoronaStateApi {
  List total=[];
  Future<void> getStateData() async {
    Response response = await get("https://api.covid19india.org/data.json");
    Map data=jsonDecode(response.body);
    //print(data["statewise"]);
    total=data['statewise'];
    total.removeAt(0);
    //print(total[0]);
    /*confirmed=total['confirmed'];
    deaths=total['deaths'];
    last_updated=total['lastupdatedtime'];
    active=total['active'];
    recovered=total['recovered'];
    print("$confirmed $active $deaths $recovered $last_updated");*/

  }
}