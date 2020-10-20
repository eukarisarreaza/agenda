import 'package:flutter/material.dart';


class Pronostico extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [

          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 20
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/cloudy.png', height: 100,),
                    Expanded(child: Text('25°', style: TextStyle(fontSize: 50), textAlign: TextAlign.center,))
                  ],
                ),

                Text('Venezuela')
              ],
            ),
          )
        ],
      ),

    );
  }
}
