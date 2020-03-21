import 'package:bmi_app/calculate.dart';
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
  final Calculate single = Calculate();

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
    super.initState();
    person_weight = TextEditingController();
    person_height = TextEditingController();
    person_age = TextEditingController();
    single.index = 0.0;
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
                key: Key("bmi_image"),
              ),
            ),
            Spacer(),
            Container(
              color: Colors.grey,
              child: Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      key: Key("age"),
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
                      key: Key("height"),
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
                      key: Key("weight"),
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
                      key: Key('calculate'),
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
                      single.index != 0 ? 'Ваш BMI ${single.index.toStringAsFixed(2)}' : "",
                      style: TextStyle(
                          fontSize: 19.0,
                          color: Colors.pink,
                          fontStyle: FontStyle.italic),
                    ),
                    Text(
                      single.index > 0 ? single.status : "",
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
            ),
            Spacer(flex: 3,)
          ],
        ),
      ),
    );
  }

  void calculate() {
    setState(() {
      single.index = double.tryParse(person_weight.text.replaceAll(',', '.')) /
          pow(double.tryParse(person_height.text.replaceAll(',', '.')), 2) *
          10000;
      if (single.index <= 16) {
        single.status = 'Выраженный дефицит массы тела';
      } else if (single.index >= 16 && single.index < 18.5) {
        single.status = 'Недостаточная (дефицит) масса тела';
      } else if (single.index >= 18.5 && single.index < 25) {
        single.status = 'Норма';
      } else if (single.index >= 25 && single.index < 30) {
        single.status = 'Избыточная масса тела (предожирение)';
      } else if (single.index >= 30 && single.index < 35) {
        single.status = 'Ожирение';
      } else if (single.index >= 35 && single.index < 40) {
        single.status = 'Ожирение резкое';
      } else {
        single.status = 'Очень резкое ожирение';
      }
    });
  }
}
