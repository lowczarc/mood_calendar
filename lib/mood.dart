import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
enum Mood {
  awesome,
  good,
  meh,
  bad,
  awful,
}

Color mood_color(Mood mood) {
  switch (mood) {
    case Mood.awesome: {
      return Colors.green[600];
    }
    case Mood.good: {
      return Colors.lightGreen[400];
    }
    case Mood.meh: {
      return Colors.blue[400];
    }
    case Mood.bad: {
      return Colors.orange[400];
    }
    case Mood.awful: {
      return Colors.red[400];
    }
  }
}

String mood_icon(Mood mood) {
  switch (mood) {
    case Mood.awesome: {
      return 'assets/mood_icon_awesome.svg';
    }
    case Mood.good: {
      return 'assets/mood_icon_good.svg';
    }
    case Mood.meh: {
      return 'assets/mood_icon_meh.svg';
    }
    case Mood.bad: {
      return 'assets/mood_icon_bad.svg';
    }
    case Mood.awful: {
      return 'assets/mood_icon_awful.svg';
    }
  }
}

String mood_name(Mood mood) {
  switch (mood) {
    case Mood.awesome: {
      return 'Awesome';
    }
    case Mood.good: {
      return 'Good';
    }
    case Mood.meh: {
      return 'Meh';
    }
    case Mood.bad: {
      return 'Bad';
    }
    case Mood.awful: {
      return 'Awful';
    }
  }
}

Mood parse_mood(String str) {
  for (final mood in Mood.values) {
    if (mood.toString() == str) {
      return mood;
    }
  }
  return null;
}
