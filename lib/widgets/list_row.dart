import 'package:bflix/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:bflix/widgets/heading.dart';
import 'package:bflix/widgets/movie_card.dart';
import 'package:bflix/model/movie_model.dart';

class ListRow extends StatelessWidget {
  final String heading;
  final List<dynamic> movieList;
  final String type;
  final bool isLoading;

  const ListRow({
    Key? key,
    required this.heading,
    required this.movieList,
    required this.type,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(movieList);
    return Container(
            margin: const EdgeInsets.only(top: 20),
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Heading(text: heading),
                  SizedBox(
                    height: 155,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(left: 5),
                      scrollDirection: Axis.horizontal,
                      itemCount: movieList.length,
                      itemBuilder: ((context, index) => InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                            movie: movieList,
                                            index: index,
                                            type: type,
                                          )));
                            },
                            child: Hero(
                              tag: "$type ${index.toString()}",
                              child: MovieCard(
                                // movieName: movieList[index]["title"],
                                addr: 'https://image.tmdb.org/t/p/w500/' +
                                    movieList[index]["poster_path"],
                                isLoading: isLoading
                              ),
                            ),
                          )),
                    ),
                  )
                ],
              ),
            ),
          );
  }

}
