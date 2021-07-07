import 'package:flutter/material.dart';
import 'package:movie_db/ui/screens/screens.dart';

class MyHero extends StatelessWidget {
  final String imgUrl;

  const MyHero({Key key, @required this.imgUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 3.0),
      height: MediaQuery.of(context).size.height / 2.5,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 25,
            left: 0,
            right: 0,
            top: 0,
            child: ClipPath(
              child: Image.network(
                "$imgUrl",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            child: Container(
              color: Colors.black.withOpacity(.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height - 31);
    path.quadraticBezierTo(
        size.width / 2, size.height + 31, size.width, size.height - 31);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClip oldClipper) {
    return true;
  }
}
