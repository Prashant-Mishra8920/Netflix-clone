import 'package:bflix/widgets/credit_widget.dart';
import 'package:bflix/widgets/heading.dart';
import 'package:bflix/widgets/poster_image.dart';
import 'package:flutter/material.dart';
import 'package:bflix/model/movie_model.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tmdb_api/tmdb_api.dart';

class DetailScreen extends StatefulWidget {
  final int index;
  final List<dynamic> movie;
  final type;

  const DetailScreen({
    Key? key,
    required this.index,
    required this.movie,
    required this.type,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() =>
      _DetailScreenState(index: index, movie: movie, type: type);
}

class _DetailScreenState extends State<DetailScreen> {
  final int index;
  final List<dynamic> movie;
  final String type;

  _DetailScreenState({
    Key? key,
    required this.index,
    required this.movie,
    required this.type,
  });

  final String apiKey = '877ebaa8c67bd0e1d4495e0d0c309bdd';
  final String accessToken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4NzdlYmFhOGM2' +
      'N2JkMGUxZDQ0OTVlMGQwYzMwOWJkZCIsInN1YiI6IjYyYWY3MG' +
      'ZjMDQ3MzNmMDYwMjUxZjdiNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJ' +
      'dLCJ2ZXJzaW9uIjoxfQ.EsYnUCKCCoGSmG9RzuJttPh2MNx2YCam5CygfWVD3t0';

  @override
  void initState() {
    loadMovies();
    super.initState();
  }

  Map<dynamic, dynamic> creditResult = {};
  List<Map<dynamic, dynamic>> list = [];
  void loadMovies() async {
    final tmdb = TMDB(
      ApiKeys(apiKey, accessToken),
      logConfig: const ConfigLogger(
        showLogs: true, //must be true than only all other logs will be shown
        showErrorLogs: true,
      ),
    );

    Map result = await tmdb.v3.movies.getCredits(movie[index]['id']);
    setState(() {
      creditResult = result;
    });

    int j = 8;
    for (Map<dynamic, dynamic> i in creditResult['cast']) {
      if (j > 0) {
        list.add(i);
        print(i);
      }
      j--;
    }

    // print(creditResult['cast']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          // leading: IconButton(
          //   icon: const Card(elevation: 10,color: Colors.white, child: Icon(Icons.arrow_back_rounded,color: Colors.black,)),
          //   onPressed: () => Navigator.of(context).pop(),
          // ),
        ),
        body: Scaffold(
            body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Hero(
                    tag: "$type ${index.toString()}",
                    child: PosterImage(
                      addr: 'https://image.tmdb.org/t/p/w500/' +
                          movie[index]['poster_path'].toString(),
                      size: 1.5,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Fluttertoast.showToast(
                      msg: "Playing...",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                    ),
                    icon: const Icon(Icons.play_circle_outline_rounded),
                    color: Colors.white,
                    iconSize: 60,
                    enableFeedback: true,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          movie[index]['adult']
                              ? const Heading(text: "18+")
                              : const Heading(text: "PG"),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Color.fromARGB(255, 255, 230, 0)),
                              (movie[index]['vote_average'] != Null)
                                  ? Heading(
                                      text: movie[index]['vote_average']
                                          .toStringAsFixed(1))
                                  : const Text("NULL"),
                            ],
                          ),
                          const Icon(
                            Icons.add_outlined,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: (movie[index]['title'] != null)
                          ? Heading(
                              text: movie[index]['title'],
                              size: 24,
                            )
                          : const Heading(
                              text: "NULL",
                              size: 24,
                            ),
                    ),
                    (movie[index]['overview'] != Null)
                        ? Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Text(
                              movie[index]['overview'],
                              style: TextStyle(fontWeight: FontWeight.w300),
                            ),
                          )
                        : const Text("NULL"),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Heading(text: "Credits",size: 20,),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 280,
                            child: (list.isNotEmpty) ? ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 8,
                              itemBuilder: (context, index) => CreditWidget(credit: list[index]),
                            ): null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
