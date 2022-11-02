import 'package:flutter/material.dart';
import 'package:flutter_faceid/Src/Page/FaceID.dart';
import './Home.dart';
import '../../main.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Home',
                style: TextStyle(
                  fontSize: 40
                ),
              ),
              SizedBox(height: 45,),
              buildLogoutButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLogoutButton(BuildContext context){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(50),
      ),
      child: Text(
        'Logout',
        style: TextStyle(
          fontSize: 20
        ),
      ),
      onPressed: (){
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context){
            return FaceID();
          }
        ));
      },
    );
  }
}
