import 'package:flutter/material.dart';

class PosterImage extends StatelessWidget {
  final String addr;
  final double size;
  
  const PosterImage({
    Key? key,
    required this.addr,
    this.size = 1.6,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height/size,
          foregroundDecoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                addr,
              ),
              fit: BoxFit.cover
            ),
          ),
          // child: Image.network('https://image.tmdb.org/t/p/w500/'+tredingMovies[0]["poster_path"],fit: BoxFit.fitHeight,),
        ),
        Container(
          height: MediaQuery.of(context).size.height/size,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                // Colors.black,
                Colors.transparent,
                Colors.transparent,
                Colors.transparent,
                Colors.transparent,
                Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ), 
        ),
      ],
    );
  }
}