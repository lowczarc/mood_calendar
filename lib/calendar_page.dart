import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;

enum Mood {
  veryGood,
  good,
  meh,
  bad,
  veryBad,
}

Color mood_color(Mood mood) {
  switch (mood) {
    case Mood.veryGood: {
      return Colors.greenAccent;
    }
    case Mood.good: {
      return Colors.green;
    }
    case Mood.meh: {
      return Colors.blue;
    }
    case Mood.bad: {
      return Colors.orange;
    }
    case Mood.veryBad: {
      return Colors.red;
    }
  }
}

class CalendarDay extends StatelessWidget {
  CalendarDay({this.color, this.isToday, this.child});
  final Color color;
  final bool isToday;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Color today_color = Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white;
    final double border_size = isToday ? (
        color == Colors.transparent ? 4.0 : 6.0
    ) : 8.0;

    return Container(
      child: Container(
        child: Center(child: child),
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: isToday ? today_color : Colors.transparent),
          shape: BoxShape.circle,
        ),
        margin: const EdgeInsets.all(2.0),
      ),
      decoration: BoxDecoration(
        border: Border.all(width: border_size, color: color),
        shape: BoxShape.circle,
      ),
    );
  }
}

class CalendarPage extends StatelessWidget {
  CalendarPage({this.title});
  final String title;
  final now = new DateTime.now();
  final Map dayMoods = { '2020-02-15': Mood.veryGood, '2020-02-01': Mood.good, '2020-02-21': Mood.meh, '2020-02-18': Mood.bad, '2020-02-05': Mood.veryBad };

  Widget customDayBuilder(
    bool isSelectable,
    int index,
    bool isSelectedDay,
    bool isToday,
    bool isPrevMonthDay,
    TextStyle textStyle,
    bool isNextMonthDay,
    bool isThisMonthDay,
    DateTime day,
  ) {
    final String keyDateFormat = DateFormat('yyyy-MM-dd').format(day);
    final color = (dayMoods[keyDateFormat] != null) ? mood_color(dayMoods[keyDateFormat]) : Colors.transparent;
    if (isToday) {
        return CalendarDay(
          child: Text(day.day.toString(), style: TextStyle(color: textStyle.color, fontSize: 12.0)),
          color: color,
          isToday: true,
        );
      } else if (!isThisMonthDay || day.millisecondsSinceEpoch > now.millisecondsSinceEpoch) {
        return CalendarDay(
          child: Text(day.day.toString(), style: TextStyle(color: Colors.grey)),
          color: Colors.transparent,
          isToday: false,
        );
      } else {
        return CalendarDay(
          child: Text(day.day.toString(), style: TextStyle(color: textStyle.color)),
          color: color,
          isToday: false,
        );
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            CalendarCarousel(
              height: 420.0,
              headerTextStyle: TextStyle(color: Theme.of(context).accentColor),
              iconColor: Theme.of(context).accentColor,
              weekendTextStyle: TextStyle(color: Theme.of(context).textTheme.body1.color),
              weekdayTextStyle: TextStyle(color: Theme.of(context).accentColor),
              todayButtonColor: Colors.transparent,
              dayPadding: 1.0,
              firstDayOfWeek: 1,
              pageScrollPhysics: NeverScrollableScrollPhysics(),
              customDayBuilder: this.customDayBuilder,
            ),
            Text('AAA'),
          ],
        ),
        margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
      ),
    );
  }
}
