import 'package:bflix/model/trending_model.dart';
import 'package:bflix/screens/downloads_screen.dart';
import 'package:bflix/screens/more_screen.dart';
import 'package:bflix/screens/search_screen.dart';
// import 'package:bflix/widgets/heading.dart';
import 'package:bflix/widgets/list_row.dart';
import 'package:bflix/widgets/poster_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bflix/model/movie_model.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:bflix/screens/detail_screen.dart';
import 'package:shimmer/shimmer.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currIndex = 0;
  bool loading = true;
  List<Movie> li = [
    Movie(name: "KGF", addr: "lib/images/kgf.jpg"),
    Movie(name: "Black Crab", addr: "lib/images/black_crab.jpg"),
    Movie(name: "KGF", addr: "lib/images/kgf.jpg"),
    Movie(name: "Black Crab", addr: "lib/images/black_crab.jpg"),
    Movie(name: "KGF", addr: "lib/images/kgf.jpg"),
    Movie(name: "Black Crab", addr: "lib/images/black_crab.jpg"),
  ];

  var tredingMovies = [];
  var topRatedMovies = [];
  var popularMovies = [];
  var nowPlayingMovies = [];
  List<Result> result = [];

  var screens = [
    const MainPage(),
    SearchScreen(),
    DownloadsScreen(),
    MoreScreen(),
  ];

  final String apiKey = '877ebaa8c67bd0e1d4495e0d0c309bdd';
  final String accessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4NzdlYmFhOGM2N2JkMGUxZDQ0OTVlMGQwYzMwOWJkZCIsInN1YiI6IjYyYWY3MGZjMDQ3MzNmMDYwMjUxZjdiNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.EsYnUCKCCoGSmG9RzuJttPh2MNx2YCam5CygfWVD3t0';

  @override
  void initState() {
    loadMovies();
    super.initState();
  }

  void loadMovies() async {
    final tmdb = TMDB(
      ApiKeys(apiKey, accessToken),
      logConfig: const ConfigLogger(
        showLogs: true, //must be true than only all other logs will be shown
        showErrorLogs: true,
      ),
    );

    Map result = await tmdb.v3.trending.getTrending();
    Map popularMovieResult = await tmdb.v3.movies.getPopular();
    Map topRatedMovieResult = await tmdb.v3.movies.getTopRated();
    Map nowPlayingMovieResult = await tmdb.v3.movies.getNowPlaying();

    setState(() {
      tredingMovies = result['results'];
      topRatedMovies = topRatedMovieResult['results'];
      popularMovies = popularMovieResult['results'];
      nowPlayingMovies = nowPlayingMovieResult['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: (currIndex == 0) ? AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset(
            'lib/images/netflix_logo.png',
          ),
        ),
        leadingWidth: 50,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    currIndex = 1;
                  });
                },
                icon: const Icon(Icons.search)),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => DownloadsScreen()));
                setState(() {
                  currIndex = 3;
                });
              },
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.asset(
                  'lib/images/a5.png',
                  width: 40,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      ): null,
      body: (currIndex == 0)
          ? SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                    movie: tredingMovies,
                                    index: 0,
                                    type: "homePage",
                                  )));
                    },
                    child: (tredingMovies.isNotEmpty)
                        ? Stack(
                            children: [
                              PosterImage(addr: 'https://image.tmdb.org/t/p/w500/${tredingMovies[0]["poster_path"]}'),
                              Positioned(
                                bottom: 10,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: const [
                                        Icon(Icons.add,color: Colors.white,),
                                        Text("My List"),
                                      ],
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white),),
                                      onPressed: () => Null, 
                                      child: Row(
                                        children: const[
                                          Icon(Icons.play_arrow, color: Colors.black),
                                          Text("Play",style: TextStyle(color: Colors.black),)
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: const [
                                        Icon(Icons.info_outline_rounded,color: Colors.white,),
                                        Text("My List"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Shimmer.fromColors(
                            baseColor: Colors.black,
                            highlightColor: Color.fromARGB(255, 30, 30, 30),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height/1.6,
                              color: Colors.black,
                            ),
                          ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child:ListRow(
                      heading: "Now Playing on Netflix",
                      movieList: nowPlayingMovies,
                      type: "nowPlaying",
                      isLoading: loading)
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ListRow(
                      heading: "Popular on Netflix",
                      movieList: popularMovies,
                      type: "popular",
                      isLoading: loading)
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ListRow(
                      heading: "Trending on Netflix",
                      movieList: tredingMovies,
                      type: "trending",
                      isLoading: loading)
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ListRow(
                      heading: "Top Rated on Netflix",
                      movieList: topRatedMovies,
                      type: "topRated",
                      isLoading: loading)
                  ),
                ],
              ),
            )
          : screens[currIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currIndex,
          onTap: (value) => setState(() => currIndex = value),
          iconSize: 20,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromARGB(255, 20, 20, 20),
          fixedColor: Colors.white,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Color.fromARGB(255, 20, 20, 20),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
              // backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.download),
              label: 'Downloads',
              // backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'More',
              // backgroundColor: Colors.white,
            ),
          ]),
    );
  }
}
