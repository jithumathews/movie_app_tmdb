import 'package:flutter/material.dart';
import 'package:movie_app_tmdb/utils/text.dart';
import 'package:tmdb_api/tmdb_api.dart';

import 'Widgets/top_rated.dart';
import 'Widgets/trending_movies.dart';
import 'Widgets/tv_movies.dart';



void main()=>runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.teal),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List trendingmovies = [];
  List topratedmovies = [];
  List tv = [];
  final String apikey = '189b9f668cee14f79de98a88f61fcebe';
  final readaccesstoken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxODliOWY2NjhjZWUxNGY3OWRlOThhODhmNjFmY2ViZSIsInN1YiI6IjY0MjY2YTJiMDFiMWNhMDBiNjI5NTU0NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GxiKtP-yruBlahw2HR4qnUVgXDDZ_-HhSg2WQi5RmSc';


  void initState(){
    loadmovies();
    super.initState();
  }

  loadmovies()async{
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apikey, readaccesstoken),
        logConfig: ConfigLogger(
            showLogs: true,
            showErrorLogs: true
        ));
    Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvresult = await tmdbWithCustomLogs.v3.tv.getPopular();

    setState(() {
      trendingmovies = trendingresult['results'];
      topratedmovies = topratedresult['results'];
      tv = tvresult['results'];
    });
    print(trendingmovies);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black,
        title: modified_text(text: 'Movie App', color: Colors.white,size: 20,),),
      body: ListView(
        children: [
          TV(tv: tv,),
          TopRated(toprated: topratedmovies),
          TrendingMovies(
            trending: trendingmovies,
          ),
        ],
      ),
    );
  }
}
