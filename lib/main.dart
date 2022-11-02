import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './Src/Page/FaceID.dart';

Future main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Face ID Auth';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: FaceID(),
    );
  }
}
