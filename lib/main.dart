import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Hva er ukenummer????'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime selectedDate = DateTime.now();
  bool weeknumberSelected = false;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        weeknumberSelected = true;
        selectedDate = picked;
      });
  }

  int _getWeek() {
    final date = selectedDate;
    final startOfYear = new DateTime(date.year, 1, 1, 0, 0);
    final firstMonday = startOfYear.weekday;
    final daysInFirstWeek = 8 - firstMonday;
    final diff = date.difference(startOfYear);
    var weeks = ((diff.inDays - daysInFirstWeek) / 7).ceil();
    // It might differ how you want to treat the first week
    if (daysInFirstWeek > 3) {
      weeks += 1;
    }

    return weeks;
  }

  static TextStyle textStyle = TextStyle(fontSize: 20);

  Widget test =
      Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
    Text(
      'Innlevering i uke 22.',
      style: textStyle,
      textAlign: TextAlign.center,
    ),
    Text(
      "Hvem faen vet når uke 22 er??",
      style: textStyle,
      textAlign: TextAlign.center,
    ),
    Text(
      "Kunne like gjerne brukt navnedag.",
      style: textStyle,
      textAlign: TextAlign.center,
    ),
    Text(
      '"Det blir innlevering på Helenes dag"',
      style: textStyle,
      textAlign: TextAlign.center,
    ),
  ]);

  Widget _contentBuilder() {
    if (!weeknumberSelected) {
      return test;
    } else {
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(selectedDate.toString().substring(0, 10)),
            Text(
              'Dette er ukenr. ' + _getWeek().toString(),
              style: Theme.of(context).textTheme.display1,
            )
          ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(child: _contentBuilder()) /* add child content here */,
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _selectDate(context);
          },
          label: Text('Velg dato'),
          icon: Icon(Icons.calendar_today),
          backgroundColor: Colors.green,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
