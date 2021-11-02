import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movies_app/app_widget.dart';
import 'package:movies_app/pages/splash-page/splash-page.dart';
import 'package:movies_app/shared/modules/home_module.dart';


class AppModule extends MainModule {
  @override
  List<Bind> get binds => [

  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter('/', child: (_, args) => SplashPage(), transition: TransitionType.fadeIn),
    //Module Filhos
    ModularRouter('/home', module: HomeModule(), transition: TransitionType.fadeIn),
  ];

  @override
  Widget get bootstrap => AppWidget();
}