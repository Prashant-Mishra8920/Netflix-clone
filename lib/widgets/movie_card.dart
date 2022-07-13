import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MovieCard extends StatelessWidget {
  // final String movieName;
  final String addr;
  final bool isLoading;
  const MovieCard({
    Key? key,
    // required this.movieName,
    required this.addr,
    this.isLoading = false
    })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(isLoading.toString());
    return (isLoading) ? Card(
      color: Colors.black,
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: 100,
        child: Container(
          foregroundDecoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(addr),
              fit: BoxFit.cover
            ),
          ),
        )
      )
    ):
    Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Shimmer.fromColors(
        baseColor: Colors.black,
        highlightColor: Color.fromARGB(255, 30, 30, 30),
        child: Container(
          height: 155,
          width: 100,
          color: Colors.black,
        ),
      ),
    );
  }
}
