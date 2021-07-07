import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/logic/cubit/theam_cubit.dart';
import 'package:movie_db/models/featuredmoviemodel.dart';
import 'package:movie_db/global.dart';
import 'package:movie_db/ui/screens/details_screen.dart';

class HomePageFeaturedWidget extends StatelessWidget {
  final AsyncSnapshot<List<FeaturedMovieModel>> snapshot;

  const HomePageFeaturedWidget({
    Key key,
    this.snapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (ctx, id) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (
                  ctx,
                ) =>
                    BlocProvider.value(
                        value: BlocProvider.of<TheamCubit>(context),
                        child: DetailsScreen(id: snapshot.data[id].id)),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
            ),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      // movieList[id]['img'],
                      getPosterImage(snapshot.data[id].poster_path),
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                      ),
                      color: Colors.black45,
                    ),
                    child: Text(
                      "${snapshot.data[id].original_title}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
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
      },
    );
  }
}
