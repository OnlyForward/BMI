import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'BMI'),
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
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  double index;
  String status;

  TextEditingController person_weight;
  TextEditingController person_height;
  TextEditingController person_age;

  void _save(String value) {
    if (!_key.currentState.validate()) {
      return;
    } else {
      calculate();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    person_weight = TextEditingController();
    person_height = TextEditingController();
    person_age = TextEditingController();
    index = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 10;
    double width = MediaQuery.of(context).size.width / 5;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(16.0),
              child: Image.asset(
                'assets/bmi.png',
                height: height,
                width: width,
              ),
            ),
            Container(
              color: Colors.grey,
              child: Form(
                key: _key,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: person_age,
                      keyboardType: TextInputType.number,
                      onSaved: _save,
                      validator: (String value) {

                        if (value.isEmpty || value.trim().length <= 0 ||!RegExp(r'^(?:[1-9]\d*|0)?(?:[.,]\d+)?$').hasMatch(value)) {
                          return 'Введите возраст';
                        }
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: 'Возраст',
                      ),
                    ),
                    TextFormField(
                      controller: person_height,
                      keyboardType: TextInputType.number,
                      onSaved: _save,
                      validator: (String value) {

                        if (value.isEmpty || value.trim().length <= 0 ||!RegExp(r'^(?:[1-9]\d*|0)?(?:[.,]\d+)?$').hasMatch(value)) {
                          return 'Введите рост';
                        }
                      },
                      decoration: InputDecoration(
                          icon: Icon(Icons.equalizer), hintText: 'Рост'),
                    ),
                    TextFormField(
                      controller: person_weight,
                      keyboardType: TextInputType.number,
                      onSaved: _save,
                      validator: (String value) {

                        if (value.isEmpty || value.trim().length <= 0 ||!RegExp(r'^(?:[1-9]\d*|0)?(?:[.,]\d+)?$').hasMatch(value)) {
                          return 'Введите вес в кг';
                        }
                      },
                      decoration: InputDecoration(
                          icon: Icon(Icons.line_weight), hintText: 'Вес в кг'),
                    ),
                    RaisedButton(
                      color: Colors.pink,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(
                              MediaQuery.of(this.context).size.height / 2))),
                      onPressed: () {
                        _key.currentState.save();
                      },
                      child: Text(
                        'Вычислить',
                      ),
                    ),
                    Text(
                      index != 0 ? 'Ваш BMI ${index.toStringAsFixed(2)}' : "",
                      style: TextStyle(
                          fontSize: 19.0,
                          color: Colors.pink,
                          fontStyle: FontStyle.italic),
                    ),
                    Text(
                      index > 0 ? status : "",
                      style: TextStyle(
                          fontSize: 19.0,
                          color: Colors.pink,
                          fontStyle: FontStyle.italic),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void calculate() {
    setState(() {
      index = double.tryParse(person_weight.text.replaceAll(',', '.')) /
          pow(double.tryParse(person_height.text.replaceAll(',', '.')), 2) *
          10000;
      if (index <= 16) {
        status = 'Выраженный дефицит массы тела';
      } else if (index >= 16 && index < 18.5) {
        status = 'Недостаточная (дефицит) масса тела';
      } else if (index >= 18.5 && index < 25) {
        status = 'Норма';
      } else if (index >= 25 && index < 30) {
        status = 'Избыточная масса тела (предожирение)';
      } else if (index >= 30 && index < 35) {
        status = 'Ожирение';
      } else if (index >= 35 && index < 40) {
        status = 'Ожирение резкое';
      } else {
        status = 'Очень резкое ожирение';
      }
    });
  }
}
