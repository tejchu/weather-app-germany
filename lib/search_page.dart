import 'package:flutter/material.dart';

import 'forecast_page.dart';
import 'main.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search City'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Hello'),
          CitySelector(),
        ],
      ),
    );
  }
}

class CitySelector extends StatefulWidget {
  List<City> cities = [
    City(cityName: 'Bremen', lat: 51, lon: 8),
    City(cityName: 'Berlin', lat: 59, lon: 10)
  ];
  CitySelector({Key? key}) : super(key: key);

  @override
  State<CitySelector> createState() => _CitySelectorState();
}

class _CitySelectorState extends State<CitySelector> {
  late City selectedCity;
  @override
  void initState() {
    super.initState();
    selectedCity = widget.cities[0];
  }

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton<City>(
          value: selectedCity,
          items: [
            DropdownMenuItem<City>(
              value: widget.cities[0],
              child: Text(widget.cities[0].cityName),
            ),
            DropdownMenuItem<City>(
              value: widget.cities[1],
              child: Text(widget.cities[1].cityName),
            ),
          ],
          onChanged: (newCity) {
            setState(() {
              selectedCity = newCity!;
            });
          },
        ),
        ElevatedButton(
          child: Icon(Icons.search),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ForecastPage(
                  city: selectedCity,
                  date: DateTime.now().toIso8601String(),
                ),
              ),
            );
          }),
    ],
    );
  }
}