import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/main.dart';

void main(){

  testWidgets("the was loaded", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    // TextFormField - age
    expect(find.byKey(Key("age")), findsOneWidget);
    // TextFormField - height
    expect(find.byKey(Key("height")), findsOneWidget);
    // TextFormField - weight
    expect(find.byKey(Key("weight")), findsOneWidget);
    // Image
    expect(find.byKey(Key("bmi_image")), findsOneWidget);
  });

  testWidgets("less than normal", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    // enter age
    await tester.enterText(find.byKey(Key("age")), "17");
    // enter height
    await tester.enterText(find.byKey(Key("height")), "178");
    // enter age
    await tester.enterText(find.byKey(Key("weight")), "55");
    // press calculate
    await tester.tap(find.byKey(Key("calculate")));

    await tester.pumpAndSettle();

    expect(find.text("Ваш BMI 17.36"), findsOneWidget);
    expect(find.text("Недостаточная (дефицит) масса тела"), findsOneWidget);
  });

  testWidgets("normal", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    // enter age
    await tester.enterText(find.byKey(Key("age")), "17");
    // enter height
    await tester.enterText(find.byKey(Key("height")), "178");
    // enter age
    await tester.enterText(find.byKey(Key("weight")), "59");
    // press calculate
    await tester.tap(find.byKey(Key("calculate")));

    await tester.pumpAndSettle();

    expect(find.text("Ваш BMI 18.62"), findsOneWidget);
    expect(find.text("Норма"), findsOneWidget);
  });

  testWidgets("higher than normal", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    // enter age
    await tester.enterText(find.byKey(Key("age")), "17");
    // enter height
    await tester.enterText(find.byKey(Key("height")), "178");
    // enter age
    await tester.enterText(find.byKey(Key("weight")), "89");
    // press calculate
    await tester.tap(find.byKey(Key("calculate")));

    await tester.pumpAndSettle();

    expect(find.text("Ваш BMI 28.09"), findsOneWidget);
    expect(find.text("Избыточная масса тела (предожирение)"), findsOneWidget);
  });

  testWidgets("one ore more fileds are empty", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    // enter age
    await tester.enterText(find.byKey(Key("age")), "17");
    // enter height
    await tester.enterText(find.byKey(Key("height")), "178");
    // press calculate
    await tester.tap(find.byKey(Key("calculate")));

    await tester.pumpAndSettle();

    expect(find.text("Введите вес в кг"), findsOneWidget);
  });
}