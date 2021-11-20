import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_app/utils/local_storage.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    nextPage();
    super.initState();
  }

  nextPage() async {
    // String user = await LocalStorage.getObj('user');
    Future.delayed(Duration(seconds: 4), () {
      // if(user != null) {
        Modular.to.popAndPushNamed('/home');
      // }else{
      //   Modular.to.popAndPushNamed('/initial-page');
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.cyan,
              Colors.black
            ]
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/images/34590-movie-theatre.json', width: size.width*.4),
              Text('Movie App', style: TextStyle(fontSize: size.height*.02, color: Colors.white70),)
            ],
          ),
        ),
      ),
    );
  }
}