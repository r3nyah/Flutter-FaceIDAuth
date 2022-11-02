import 'package:flutter/material.dart';
import './Home.dart';
import '../Api/LocalAuth.dart';
import '../../main.dart';

class FaceID extends StatelessWidget {
  const FaceID({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildHeader(),
              SizedBox(height: 32,),
              buildAvailability(context),
              SizedBox(height: 24,),
              buildAuthenticate(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(){
    return Column(
      children: [
        Text(
          'Face ID Auth',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 16,
        ),
        ShaderMask(
          shaderCallback: (bounds){
            final colors = [
              Colors.blueAccent,
              Colors.pink
            ];
            return RadialGradient(
              colors: colors
            ).createShader(bounds);
          },
          child: Icon(
            Icons.face_retouching_natural,
            size: 100,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget buildButton({
    required String text,
    required IconData icon,
    required VoidCallback onClicked,
}){
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(50),
      ),
      icon: Icon(
        icon,
        size: 26,
      ),
      label: Text(
        text,
        style: TextStyle(
          fontSize: 20
        ),
      ),
      onPressed: onClicked,
    );
  }

  Widget buildAuthenticate(BuildContext context){
    return buildButton(
      text: 'Authenticate',
      icon: Icons.lock_open,
      onClicked: ()async{
        final isAuthenticated = await LocalAuthApi.authenticate();
        if(isAuthenticated){
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context){
              return Home();
            },
          )
          );
        }
      }
    );
  }

  Widget buildText(String text,bool checked){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          checked
            ?Icon(
            Icons.check,
            color: Colors.green,
            size: 24,
          ):Icon(
            Icons.close,
            color: Colors.red,
            size: 24,
          ),
          const SizedBox(width: 12,),
          Text(
            text,
            style: TextStyle(
              fontSize: 24
            ),
          )
        ],
      ),
    );
  }

  Widget buildAvailability(BuildContext context){
    return buildButton(
      text: 'Check Availability',
      icon: Icons.event_available,
      onClicked: ()async{
        final isAvailable = await LocalAuthApi.hasBiometrics();
        showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: Text(
                'Availablity',
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16,),
                  buildText('Biometrics', isAvailable),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'OK'
                  ),
                )
              ],
            );
          }
        );
      }
    );
  }
}
