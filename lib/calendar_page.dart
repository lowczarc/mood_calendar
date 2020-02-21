import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    case Mood.veryBad: {
      return Colors.red[400];
    }
  }
}

class MoodCounter extends StatelessWidget {
  MoodCounter({this.dayMoods});
  final Map<String, Mood> dayMoods;

  @override build(BuildContext context) {
    return Row(
      children: Mood.values.map((mood) =>
        Container(
          child: Container(
              child: Center(
                child: Text(
                  dayMoods.entries.fold(0, (acc, elem) => acc + (elem.value == mood ? 1 : 0)).toString(),
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: mood_color(mood)),
                  textAlign: TextAlign.center,
                ),
              ),
              width: 40,
              margin: const EdgeInsets.symmetric(vertical: 5.0),
          ),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: mood_color(mood), width: 4.0)),
          ),
          width: 40,
          margin: const EdgeInsets.all(10.0),
        )
      ).toList(),
      mainAxisAlignment: MainAxisAlignment.center,
    );
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


class CalendarPage extends StatefulWidget {
  CalendarPage({this.title, this.dayMoods});
  final String title;
  final DateTime now = new DateTime.now();
  final Map<String, Mood> dayMoods; 

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
          child: Text(day.day.toString(), style: TextStyle(color: Colors.grey, fontSize: 12.0)),
          color: Colors.transparent,
          isToday: false,
        );
      } else {
        return CalendarDay(
          child: Text(day.day.toString(), style: TextStyle(color: textStyle.color, fontSize: 12.0)),
          color: color,
          isToday: false,
        );
      }
  }

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _currentMonth = DateTime(DateTime.now().year, DateTime.now().month);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
              onCalendarChanged: (date) => setState(() {
                _currentMonth = date;
              }),
              pageScrollPhysics: NeverScrollableScrollPhysics(),
              customDayBuilder: widget.customDayBuilder,
            ),
            MoodCounter(dayMoods: Map.fromEntries(widget.dayMoods.entries.where((elem) {
              final DateTime date = DateFormat('yyyy-MM-dd').parse(elem.key);

              return date.year == _currentMonth.year && date.month == _currentMonth.month;
            }).toList())),
          ],
        ),
        margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
      ),
    );
  }
}
