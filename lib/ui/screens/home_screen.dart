import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/api.dart';
import 'package:movie_db/logic/cubit/theam_cubit.dart';
import 'package:movie_db/models/featuredmoviemodel.dart';
import 'package:movie_db/models/genremodel.dart';
import 'package:movie_db/models/trendingmoviemodel.dart';
import 'package:movie_db/ui/widgets/connectivity.dart';
import 'package:movie_db/ui/widgets/homepagefeaturedwidget.dart';
import 'package:movie_db/ui/widgets/toggle_button.dart';
import 'package:movie_db/ui/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<FeaturedMovieModel>> featuredMovies;
  Future<List<TrendingMovieModel>> trendingMovies;
  Future<List<GenreModel>> genreList;
  Api _api;
  @override
  void initState() {
    super.initState();
    _api = Api();
    featuredMovies = _api.getFeaturedMovies();
    trendingMovies = _api.getTrendingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<TheamCubit, TheamState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: state.theam == true ? Colors.black : Colors.white,
            appBar: AppBar(
              backgroundColor:
                  state.theam == true ? Colors.black : Colors.white,
              elevation: 0,
              actions: <Widget>[Connect(), Toggle()],
              title: Text(
                "Alan's Movie App",
                style: TextStyle(
                    color: state.theam == true ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              centerTitle: false,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    child: FutureBuilder<List<FeaturedMovieModel>>(
                      future: featuredMovies,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return HomePageFeaturedWidget(snapshot: snapshot);
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "   Trending Movies",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color:
                              state.theam == true ? Colors.white : Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 3,
                      child: FutureBuilder<List<TrendingMovieModel>>(
                        future: trendingMovies,
                        builder: (ctx, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.length,
                              itemBuilder: (ctx, id) {
                                return MovieContainer(
                                    snapshot: snapshot.data[id]);
                              },
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
