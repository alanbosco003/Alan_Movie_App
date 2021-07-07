import 'package:flutter/material.dart';
import 'package:movie_db/global.dart';
import 'package:movie_db/models/featuredmoviemodel.dart';
import 'package:movie_db/models/trendingmoviemodel.dart';
import '../screens/screens.dart';

class MovieContainer extends StatelessWidget {
  final TrendingMovieModel snapshot;

  const MovieContainer({
    Key key,
    this.snapshot,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => DetailsScreen(id: snapshot.id),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2.5,
        margin: EdgeInsets.all(15.0),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  // movieList[id]['img'],
                  getPosterImage(snapshot.poster_path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  // "${movieList[id]['title']}",
                  snapshot.original_title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                  ),
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
