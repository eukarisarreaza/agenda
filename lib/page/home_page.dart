import 'package:agenda/bloc/diary_bloc.dart';
import 'package:agenda/bloc/provider_bloc.dart';
import 'package:agenda/data/model/cancha.dart';
import 'package:agenda/page/new_diary.dart';
import 'package:agenda/page/widget_pronostico.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class HomePage extends StatelessWidget {
  static final String routeName= 'home';
  DiaryBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc= ProviderBloc.diaryBloc(context);
    bloc.actualizarListadoCanchas();


    return Scaffold(
      /*appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.menu, color: Colors.white), onPressed: null),
        title: Text('titulo', textAlign: TextAlign.center), centerTitle: true,
      ),*/
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
    final _height = MediaQuery.of(context).size.height;



    return StreamBuilder<List<Cancha>>(
      stream: bloc.canchasListStream,
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<Cancha>> snapshot){
        if(snapshot.hasData){
          return SafeArea(
            child: Stack(
              children: [


                /*Container(
                  padding: EdgeInsets.all(10),
                  height: _height*0.30,
                  width: double.infinity,
                  child: Card(
                    elevation: 1,
                    color: Colors.blue,
                    child: Row(
                      children: [


                      ],
                    ),

                  ),
                ),*/


                Container(
                  height: _height*0.30,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                      )
                  ),

                  child: Pronostico(),
                ),


                Container(
                  padding: EdgeInsets.only(
                    top: _height*0.35
                  ),
                  child: generateList(snapshot.data),
                )



              ],
            ),
          );
        }else
          return CircularProgressIndicator();

      },
    );



  }

  Widget generateList(List<Cancha> data) {
    return ListView(
      children:  List<Widget>.generate(data.length, (int index){

        return Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 25.0,
                  child: Text('${data[index].name.substring(0, 1)}', style: TextStyle(color: Colors.white)),
                ),
                trailing: TextButton( child: Text('Eliminar', style: TextStyle(color: Colors.red),), onPressed: deleteDiary),
                title: Text('Cancha ${data[index].name}', style: TextStyle(fontSize: 20)),
                subtitle: Text('09-05-2020'),
              ),


            ],
          ),
        );


      }),
    );
  }

  void deleteDiary() {
  }
}
