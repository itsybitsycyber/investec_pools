import 'dart:html';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Pool {
  String name;
  String desc;
  double goal;
  Uri link;
  DateTime deployDate;
  DateTime investClose;
  DateTime claimOpen;

  Pool(this.name, this.desc, this.goal,
      this.link, this.deployDate, this.investClose,
      this.claimOpen);

  String toString() {
    return "$name\n$desc\n$goal";
  }

  static Future<List<Pool>> getPools(List<Uri> links) async {
    List<Pool> pools = <Pool>[];

    await Future.forEach(links, (element)  async {
      var responseJSON = jsonDecode((await http.get(element as Uri)).body);

      var name = responseJSON["name"];
      var desc = responseJSON["description"];
      var link = Uri.parse(responseJSON["website"]);
      var goal = double.parse(responseJSON["target"].replaceAll(" ", ""));
      var deployDate = DateTime.parse(responseJSON["date_deployed"]);
      var investClose = DateTime.parse(responseJSON["investing_closing_date"]);
      var claimOpen = DateTime.parse(responseJSON["claimable_date"]);
      pools.add(Pool(name, desc, goal, link, deployDate, investClose, claimOpen));
    });

    return pools;
  }
}