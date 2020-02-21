import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'mood.dart';

class AddEntryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Add an entry'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Text(
              'How was your day ?',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300),
            ),
            margin: EdgeInsets.only(bottom: 100.0),
          ),
          Container(
            child: Row(
              children: Mood.values.map((mood) => 
                InkResponse(
                  child: Column(
                    children: <Widget>[
                      SvgPicture.asset(
                        mood_icon(mood),
                        semanticsLabel: mood.toString(),
                        height: 70.0,
                        width: 70.0,
                        color: mood_color(mood),
                      ),
                      Text(mood_name(mood), style: TextStyle(color: mood_color(mood))),
                    ],
                  ),
                  onTap: () {},
                  radius: 50.0,
                  splashColor: mood_color(mood).withOpacity(0.3),
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                ),
              ).toList(),
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            margin: EdgeInsets.only(bottom: 200.0),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
