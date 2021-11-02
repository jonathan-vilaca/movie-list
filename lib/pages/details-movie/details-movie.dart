import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_app/pages/details-movie/details-movie_controller.dart';

class DetailsMovie extends StatefulWidget {
  final String imdbID;
  final String title;
  DetailsMovie({Key key, this.imdbID, this.title}) : super(key: key);

  @override
  _DetailsMovieState createState() => _DetailsMovieState();
}

class _DetailsMovieState extends State<DetailsMovie> {

  DetailsMovieController _detailsMovieController;

  @override
  void initState() {
    _detailsMovieController = Modular.get<DetailsMovieController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Object>(
          future: _detailsMovieController.movieDetails(widget.imdbID),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Container(
                height: size.height*.8,
                child: Center(
                  child: Lottie.asset('assets/images/1961-movie-loading.json', width: size.width*.2),
                ),
              );
            }
            Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
            return Padding(
              padding: EdgeInsets.all(size.width*.03),
              child: Column(
                children: [
                  Align(alignment: Alignment.center, child: Image.network(data['Poster'], fit: BoxFit.cover, width: size.width*.5)),
                  SizedBox(height: size.height*.02,),
                  LineDetails(title: 'Year: ', value: data['Year'],),
                  LineDetails(title: 'Released: ', value: data['Released'],),
                  LineDetails(title: 'Runtime: ', value: data['Runtime'],),
                  LineDetails(title: 'Genre: ', value: data['Genre'],),
                  LineDetails(title: 'Actors: ', value: data['Actors'],),
                  LineDetails(title: 'BoxOffice: ', value: data['BoxOffice'],),
                  LineDetails(title: 'IMDB: ', value: data['imdbRating'],),
                  LineDetails(title: 'IMDB Votes: ', value: data['imdbVotes'],),
                  LineDetails(title: 'Plot: ', value: data['Plot'],),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}


class LineDetails extends StatefulWidget {
  final String title;
  final String value;
  LineDetails({Key key, this.title, this.value}) : super(key: key);

  @override
  _LineDetailsState createState() => _LineDetailsState();
}

class _LineDetailsState extends State<LineDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: size.width*.02),
          child: RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            text: widget.title,
            style: TextStyle(color: Colors.grey[700], fontSize: size.height*.03, fontWeight: FontWeight.bold),
            children: <InlineSpan>[
              TextSpan(
                text: widget.value,
                style: TextStyle(color: Colors.grey[700], fontSize: size.height*.025, fontWeight: FontWeight.w700),
              ),
            ]
          )
        ),
      ),
    );
  }
}