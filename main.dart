import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//! Correct Method of using ChangeNotifierProvider

    return ChangeNotifierProvider<MyModel>(
        lazy: false,
        create: (_) => MyModel(someValue: 'new data'),
        child: Consumer<MyModel>(builder: (context, foo, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: Colors.blue.shade200,
              appBar: AppBar(title: Text('My App')),
              body: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 100,
                    color: Colors.blue,
                    child: Text(foo.someValue),
                  ),
                  Container(
                    child: RaisedButton(
                      onPressed: () => foo.doSomething(),
                      child: Text('Press'),
                    ),
                  )
                ],
              ),
            ),
          );
        }));
  }
}

class MyModel with ChangeNotifier {
  //                                               <--- MyModel
  MyModel({this.someValue});
  String someValue;
  Future<void> doSomething() async {
    await Future.delayed(Duration(seconds: 2));
    someValue = 'Goodbye';
    notifyListeners();
  }
}
