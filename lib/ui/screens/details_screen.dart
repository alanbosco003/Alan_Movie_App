import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/global.dart';
import 'package:movie_db/logic/cubit/theam_cubit.dart';
import 'package:movie_db/models/genremodel.dart';
import 'package:movie_db/models/moviemodel.dart';
import 'package:movie_db/ui/screens/playvideo.dart';
import 'package:movie_db/ui/widgets/widgets.dart';
import '../../api.dart';

class DetailsScreen extends StatefulWidget {
  final int id;

  const DetailsScreen({Key key, this.id}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Api _api;
  Future<MovieModel> movieModel;
  Future<List<GenreModel>> genremodel;
  @override
  void initState() {
    _api = Api();
    movieModel = _api.getMovieInfo(widget.id);
    genremodel = _api.getGenreList(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<TheamCubit, TheamState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: state.theam == true ? Colors.black : Colors.white,
            body: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: FutureBuilder<MovieModel>(
                        future: movieModel,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  MyHero(
                                    imgUrl: getPosterImage(
                                        snapshot.data.poster_path),
                                  ),
                                  SizedBox(
                                    height: 11,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                "${snapshot.data.original_title}",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: state.theam == true
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontSize: 26,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.red,
                                            ),
                                            Text(
                                              " ${snapshot.data.rating}",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: RichText(
                                            text: TextSpan(
                                              children: List.generate(
                                                snapshot.data.genre.length,
                                                (i) {
                                                  return TextSpan(
                                                      text:
                                                          "${snapshot.data.genre[i]['name']} ");
                                                },
                                              ),
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 9.0),
                                        SizedBox(height: 13.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                Text(
                                                  "Year",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  "${DateTime.parse(snapshot.data.release_date).year}",
                                                  style: TextStyle(
                                                    color: state.theam == true
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Text(
                                                  "Country",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  "${snapshot.data.country}",
                                                  style: TextStyle(
                                                    color: state.theam == true
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Text(
                                                  "Length",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  "${snapshot.data.run_time} min",
                                                  style: TextStyle(
                                                    color: state.theam == true
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 18.0),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: InkWell(
                                            onTap: () {
                                              // Navigator.pushNamed(
                                              //     context, VideoApp.route);
                                            },
                                            child: SizedBox(
                                              height: 40,
                                              width: 120,
                                              child: ElevatedButton(
                                                  onLongPress: () {
                                                    Navigator.pushNamed(context,
                                                        VideoPlayerApp.route);
                                                  },
                                                  child: RichText(
                                                    text: TextSpan(
                                                      style: TextStyle(
                                                        color:
                                                            state.theam == true
                                                                ? Colors.white
                                                                : Colors.black,
                                                        fontSize: 15,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                            text:
                                                                'Player Trailer'),
                                                      ],
                                                    ),
                                                  ),
                                                  style: ButtonStyle(
                                                      foregroundColor:
                                                          MaterialStateProperty.all<Color>(
                                                              Colors.white),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(
                                                                  Colors.red),
                                                      shape: MaterialStateProperty.all<
                                                              RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(18.0),
                                                              side: BorderSide(color: Colors.red)))),
                                                  onPressed: () => null),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 15.0),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            padding: EdgeInsets.only(
                                              bottom:
                                                  5, // Space between underline and text
                                            ),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                              color: Colors.red,
                                              width: 2.0, // Underline thickness
                                            ))),
                                            child: Text(
                                              "Info",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "${snapshot.data.overview}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: state.theam == true
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 20,
                                          ),
                                        ),
                                        SizedBox(height: 13.0),
                                      ],
                                    ),
                                  ),
                                  // MyScreenshots(),
                                  SizedBox(height: 13.0),
                                ],
                              ),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.only(
                          bottom: 5, // Space between underline and text
                        ),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.red,
                          width: 2.0, // Underline thickness
                        ))),
                        child: Text(
                          "Cast",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //"${snapshot.data[index].name}",
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      child: FutureBuilder<List<GenreModel>>(
                        future: genremodel,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                padding: const EdgeInsets.all(8),
                                itemCount: 5,
                                itemBuilder: (BuildContext context, int index) {
                                  return SizedBox(
                                    height: 130,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: Card(
                                        color: state.theam == true
                                            ? Colors.black
                                            : Colors.white,
                                        child: Row(children: <Widget>[
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Image.network(
                                              getPosterImage(snapshot
                                                  .data[index].poster_path),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 35,
                                                ),
                                                Text(
                                                  "${snapshot.data[index].character}",
                                                  style: TextStyle(
                                                      color: state.theam == true
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontSize: 18),
                                                ),
                                                SizedBox(height: 20),
                                                RichText(
                                                  text: TextSpan(
                                                    text: 'Artist : ',
                                                    style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontSize: 17,
                                                      color: state.theam == true
                                                          ? Colors.white
                                                          : Colors.black,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text:
                                                              '${snapshot.data[index].name}',
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            color:
                                                                state.theam ==
                                                                        true
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ])),
                                  );
                                });
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                  ]),
            ),
          );
        },
      ),
    );
  }
}
