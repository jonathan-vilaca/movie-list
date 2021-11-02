import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movies_app/pages/home-page/home-page_controller.dart';

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
          _msgCenter = 'Movie not found :(';
        })
      },
      if(mounted)
      setState(() {
        _movieList = value;
      })
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
              SizedBox(height: size.height*.02,),
              CarouselSlider(
                options: CarouselOptions(
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  height: size.height*.5,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    print(index);
                    if(mounted)
                    setState(() {
                      indexList = index;
                    });
                  },
                ),
                items: _movieList
                  .map((dynamic item) => Container(
                    child: GestureDetector(
                      onTap: () => print(item['Title']),
                      child: Center(
                        child: Image.network(item['Poster'], fit: BoxFit.cover, width: size.width)
                      ),
                    ),
                  ))
                  .toList(),
              ),
              Container(
                margin: EdgeInsets.all(size.width*.1),
                // color: Colors.red,
                width: size.width,
                height: size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Title: '+_movieList[indexList]['Title'], style: TextStyle(fontSize: size.height*.02, fontWeight: FontWeight.bold),),
                    SizedBox(height: size.height*.015,),
                    Text('Year: '+_movieList[indexList]['Year'], style: TextStyle(fontSize: size.height*.02, fontWeight: FontWeight.bold)),
                    SizedBox(height: size.height*.015,),
                    Text('Type: '+_movieList[indexList]['Type'], style: TextStyle(fontSize: size.height*.02, fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}