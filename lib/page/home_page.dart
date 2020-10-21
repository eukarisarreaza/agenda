import 'package:agenda/bloc/diary_bloc.dart';
import 'package:agenda/bloc/provider_bloc.dart';
import 'package:agenda/data/model/cancha.dart';
import 'package:agenda/data/model/diary.dart';
import 'package:agenda/page/new_diary.dart';
import 'package:agenda/page/widget_pronostico.dart';
import 'package:agenda/services/response/weather_response.dart';
import 'package:agenda/utils/location_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class HomePage extends StatelessWidget {
  static final String routeName= 'home';
  DiaryBloc bloc;
  var helper= LocationHelper();



  Future<void> initGps() async {
    var helper= LocationHelper();

    if(! await helper.locationGranted()){
      await helper.requestPermission();
    }

    if( ! await helper.serviceEnable()) {
      await helper.requestServicioEnable();
    }

    if(await helper.locationGranted() && await helper.serviceEnable()) {
      helper.initService();
    }
  }


  @override
  Widget build(BuildContext context) {
    bloc= ProviderBloc.diaryBloc(context);
    bloc.actualizarClima();
    bloc.listDiary();
    initGps();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.menu, color: Colors.white), onPressed: null),
        title: Text('Listado de Citas', textAlign: TextAlign.center), centerTitle: true,
      ),
      body: body(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.black,
        onPressed: (){
          Navigator.pushNamed(context, NewDiaryPage.routeName);
        },
        child: Icon(Icons.add, color: Colors.white,),
      ),
    );
  }

  Widget body(BuildContext context) {
    //final _height = MediaQuery.of(context).size.height;

    return StreamBuilder<List<Diary>>(
      stream: bloc.diaryListStream,
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<Diary>> snapshot){
        if(snapshot.hasData){
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(

                  children: [

                    Container(
                      child: pronosticoTiempo(),
                    ),

                    SizedBox(height: 20,),
                    Container(
                      child: generateList(snapshot.data),
                    ),


                    SizedBox(height: 50,)

                  ],
                ),
              ),
            ),
          );
        }else
          return CircularProgressIndicator();

      },
    );



  }


  Widget pronosticoTiempo() {
    return StreamBuilder<WeatherResponse>(
        stream: bloc.weatherStream,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return Card(
              elevation: 1,
              color: Colors.blue,
              child: Pronostico(weather: snapshot.data),
            );
          }else
            return CircularProgressIndicator();
        }
    );
  }

  Widget generateList(List<Diary> data) {
    return Column(
      children:  List<Widget>.generate(data.length, (int index){

        return Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FutureBuilder(
                future: data[index].getCancha(),
                builder: (context, snapshot){
                  var cancha= snapshot.data;

                  if(snapshot.hasData){
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 25.0,
                        child: Text('${cancha.name.substring(0, 1)}', style: TextStyle(color: Colors.white)),
                      ),
                      trailing: TextButton( child: Text('Eliminar', style: TextStyle(color: Colors.red),), onPressed: ()=> deleteDiary(data[index])),
                      title: Text('Cancha ${cancha.name}', style: TextStyle(fontSize: 20)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Usuario: ${data[index].userName}', textAlign: TextAlign.start,),
                          SizedBox(width: double.infinity,),
                          Text('${data[index].fecha}'),
                        ],
                      ),
                    );
                  }else
                    return CircularProgressIndicator();
                },
              ),


            ],
          ),
        );


      }),
    );
  }

  void deleteDiary(Diary cita) {

    bloc.eliminarCita(cita);
  }
}
