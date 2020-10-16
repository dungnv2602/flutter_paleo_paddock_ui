import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:textstyle_extensions/textstyle_extensions.dart';

import '../shared/_shared.dart';

const _kGray = Color(0xFFAAAAAA);

const _kCardShadow = BoxShadow(
  color: Colors.black12,
  offset: Offset(0, 5),
  blurRadius: 2,
  spreadRadius: 5,
);

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({
    Key key,
    @required this.model,
  }) : super(key: key);

  final Restaurant model;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 225,
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage(model.imagePath),
          fit: BoxFit.cover,
        ),
        boxShadow: const [_kCardShadow],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              const Spacer(),
              const Spacer(),
              ClipPath(
                clipper: _RestaurantDetailsClipper(
                  height: 20,
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: model.iconColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            model.icon,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.title,
                              style: context.headline6,
                            ),
                            Text(
                              model.subtitle,
                              style: context.bodyText1
                                  .letterSpace(1)
                                  .textColor(_kGray),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 2,
                        height: 70,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white,
                              _kGray,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.favorite_border,
                              color: Colors.red,
                            ),
                            Text('${model.likes}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(8),
            width: 40,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black87,
            ),
            child: Center(
              child: Text(
                '200m',
                style: context.bodyText2.textColor(Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Restaurant>('model', model));
  }
}

class _RestaurantDetailsClipper extends CustomClipper<Path> {
  _RestaurantDetailsClipper({
    this.height = 20,
    this.density = 50,
  }) : path = Path();
  final double height;
  final double density;

  static const _radius = Radius.circular(5);

  final Path path;

  @override
  Path getClip(Size size) {
    path.lineTo(0.0, height);

    double curXPos = 0.0;
    final curYPos = height;

    final increment = size.width / density;

    while (curXPos < size.width) {
      curXPos += increment;
      path.arcToPoint(Offset(curXPos, curYPos), radius: _radius);
    }

    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(_RestaurantDetailsClipper oldClipper) => true;
}
