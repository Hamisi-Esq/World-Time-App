import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location;   //location name fot the UI
  String time;  //the time in that location
  String  flag; //url to an asset flag icon
  String url;   //location url for api endpoint
  bool isDaytime;  //true or false if daytime or night

  WorldTime({this.location, this.flag, this.url});


  Future<void> getTime() async{

    try{
      // Response response = await get(Uri.parse("https://jsonplaceholder.typicode.com/todos/1"));
      // Map data = jsonDecode(response.body);
      // print(data);
      // print(data['title']);

      //make the request
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      // print(datetime);
      // print(offset);

      //create a DateTime object
      print(datetime);
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours:int.parse(offset)));

      //set the time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);


    }
    catch(e){
      print('caught error: $e');
      time ='Could not get Time Data!';

    }


  }



}
