import 'package:flutter_modular/flutter_modular.dart';
import 'package:movies_app/pages/details-movie/details-movie.dart';
import 'package:movies_app/pages/details-movie/details-movie_controller.dart';
import 'package:movies_app/pages/home-page/home-page.dart';
import 'package:movies_app/pages/home-page/home-page_controller.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
    Bind((i) => DetailsMovieController()),
    Bind((i) => HomeController())
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter('/Home', child: (_, args) => HomePage(), transition: TransitionType.fadeIn),
    ModularRouter('/details-movie', child: (_, args) => DetailsMovie(imdbID: args.data['imdbID'], title: args.data['title'],), transition: TransitionType.fadeIn),
  ];


  static Inject get to => Inject<HomeModule>.of();
}