
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

class ForecastPage extends StatefulWidget {
  final City city;
  final String date;

  const ForecastPage({Key? key, required this.city, required this.date}) : super(key: key);

  @override
  _ForecastPageState createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  Map? responseMap;
  late List forecast;

  @override
  void initState(){
    super.initState();
    forecast = [];
    fetchForeast(widget.city.lat, widget.city.lon, widget.date);
  }

  Future<void> fetchForeast(double lat, double lon, String date)async {
    var url = Uri.parse('https://api.brightsky.dev/weather?lat=$lat&lon=$lon&date=$date');
    http.Response response = await http.get(url);
    responseMap = jsonDecode(response.body);


    setState(() {
      forecast = responseMap!['weather'];
    });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forecast App')),
      body: ListView.builder(
        itemCount: forecast.length,
        itemBuilder: (context,index){
          var time = forecast[index]['timestamp'];
          var temperature = forecast[index]['temperature'];
          var condition = forecast[index]['condition'];
          return ListTile(
            title: Text(time),
            subtitle: Text('$condition, $temperature'),
            tileColor: index %2 == 0 ? Colors.grey : Colors.white,
          );
        },

      ),

    );
  }
}