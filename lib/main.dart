import 'package:agenda/bloc/provider_bloc.dart';
import 'package:agenda/page/home_page.dart';
import 'package:agenda/page/new_diary.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return ProviderBloc(
      child: MaterialApp(
        title: 'Agenda App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName : (BuildContext context) => HomePage(),
          NewDiaryPage.routeName : (BuildContext context) => NewDiaryPage(),
        },
      ),
    );
  }
}

