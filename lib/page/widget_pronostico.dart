import 'package:agenda/services/response/weather_response.dart';
import 'package:flutter/material.dart';


class Pronostico extends StatelessWidget {

  final WeatherResponse weather;

  const Pronostico({Key key, this.weather}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [

          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/cloudy.png', height: 80,),
                Expanded(
                  child: Column(
                    children: [
                      Text('Temperatura ${(weather.main.temp- 273.15).round()}°', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black), textAlign: TextAlign.center, ),
                      Text('${weather.name}', style: TextStyle(fontSize: 20, color: Colors.black), textAlign: TextAlign.center, ),

                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),

    );
  }
}
