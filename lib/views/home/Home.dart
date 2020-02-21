import 'package:pokedex/views/home/widgets/AppBarHome.dart';
import 'package:flutter/material.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double layoutWidth = MediaQuery.of(context).size.width;
    double statusWidth = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
          alignment: Alignment.topCenter,
          overflow: Overflow.visible,
          children: <Widget>[
            Positioned(
              top: -(240/4.7),
              left: layoutWidth - (240/1.6),
              child: Opacity(
                child: Image.asset('assets/images/pokeball_dark.png', 
                height: 240, 
                width: 240
              ),
              opacity: 0.1
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: statusWidth,
                ),
                AppBarHome()
              ],
            ),
          ),
        ]
      ),
    );
  }
}