import 'package:carousel_slider/carousel_slider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movies_app/pages/home-page/home-page_controller.dart';
import 'package:movies_app/widgets/button_default.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();
  HomeController _homeController;
  List<dynamic> _movieList = [];
  int indexList = 0;
  String _msgCenter = 'Search for your favorite movie or serie';

  @override
  void initState() {
    _homeController = Modular.get<HomeController>();
    super.initState();
  }

  listMovies(String search) async {
    await _homeController.getMovies(search).then((value) => {
      if(value == null){
        setState((){
          _msgCenter = 'Not found :(';
        })
      },
      if(mounted)
      setState(() {
        _movieList = value;
      }),
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          keyboardType: TextInputType.name,
          controller: _searchController,
          onFieldSubmitted: (value) async {
            await listMovies(value);
          },
          decoration: InputDecoration(
            fillColor: Colors.white,
            hoverColor: Colors.white,
            focusColor: Colors.white,
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white),
            suffixIcon: GestureDetector(
              onTap: () async {
                 await listMovies(_searchController.text);
              },
              child: Icon(Icons.search, color: Colors.white,)
            )
          )
        )
      ),
      body: Container(
        child: _movieList == null || _movieList.isEmpty ? Center(
          child: Text(_msgCenter, style: TextStyle(color: Colors.black),),
        ) : SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: size.height*.08,),
              CarouselSlider(
                options: CarouselOptions(
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  height: size.height*.7,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    if(mounted)
                    setState(() {
                      indexList = index;
                    });
                  },
                ),
                items: _movieList
                  .map((dynamic item) => Container(
                    child: FlipCard(
                      front: Center(
                        child: Center(child: Image.network(item['Poster'], fit: BoxFit.cover, width: size.width) ?? CircularProgressIndicator())
                      ),
                      back: Container(
                        width: size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.blue[900],
                              Colors.blue[400],
                              Colors.cyan[100],
                            ]
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(size.width*.02),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: size.height*.03),
                                  child: Align(alignment: Alignment.center, child: Text(item['Title'], textAlign: TextAlign.center, style: TextStyle(fontSize: size.height*.04, fontWeight: FontWeight.bold),)),
                                ),
                                SizedBox(height: size.height*.02,),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: 'Year: ',
                                    style: TextStyle(color: Colors.grey[700], fontSize: size.height*.03, fontWeight: FontWeight.bold),
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: item['Year'].toString(),
                                        style: TextStyle(color: Colors.grey[700], fontSize: size.height*.025, fontWeight: FontWeight.w700),
                                      ),
                                    ]
                                  )
                                ),
                                Padding(padding: EdgeInsets.symmetric(vertical: size.height*.08)),
                                ButtonDefault(
                                  hintText: 'More details',
                                  fontSize: 0.02,
                                  fontWeight: FontWeight.bold,
                                  colorBorder: Colors.blue,
                                  colorButton: Colors.blue[100],
                                  splashColor: Colors.white,
                                  colorFont: Colors.blue,
                                  clickFunction: () {
                                    Modular.to.pushNamed('/home/details-movie', arguments: {'title': item['Title'], 'imdbID': item['imdbID']});
                                  },
                                )
                              ],
                            ),
                          ),
                        )
                      ),
                    ),
                  ))
                  .toList(),
              ),
              Padding(padding: EdgeInsets.all(size.width*.03), child: Text('Click to flip', style: TextStyle(color: Colors.grey[500], fontSize: size.height*.02),),)
            ],
          ),
        )
      ),
    );
  }
}