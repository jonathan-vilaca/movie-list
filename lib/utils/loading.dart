import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoadingScreen {
  static loading() {
    EasyLoading.show(
      indicator: AnimationLoading(),
      maskType: EasyLoadingMaskType.custom
    );
  }

  static loadingClose(){
    EasyLoading.dismiss();
  }
}


class AnimationLoading extends StatefulWidget {
  @override
  _AnimationLoadingState createState() => _AnimationLoadingState();
}

class _AnimationLoadingState extends State<AnimationLoading> with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(seconds: 2))..repeat();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, widget) {
        return ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              colors: [Colors.black, Colors.grey, Colors.black],
              stops: [controller.value - 0.3, controller.value, controller.value + 0.3],
            ).createShader(
              Rect.fromLTWH(0, 0, rect.width, rect.height),
            );
          },
          child: Column(
            children: [
              Container(
                // width: size.width*.02,
                //child: Image.asset('assets/images/logo_vazada2.png')
                child: CircularProgressIndicator(),
              ),
              SizedBox(height: size.height*.02,),
              Text('Carregando...', style: TextStyle(fontSize: size.height*.02),)
            ],
          ),
          blendMode: BlendMode.srcIn,
        );
      },
    );
  }
  
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}