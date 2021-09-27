import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:testapp/src/Nav/navKey.dart';
import 'package:testapp/src/State/contact.reducers.dart';
import 'package:testapp/src/State/store.dart';
import 'package:testapp/src/widgets.dart';

void main() {
  final store = createStore();
  runApp(MyApp(
    store: store,
  ));
}

class MyApp extends StatelessWidget {
  final Store<ContactState> store;

  MyApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<ContactState>(
      store: store,
      child: MaterialApp(
        title: 'Contact Saver',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorKey: NavKey.navKey,
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => ContactListWidget(),
          '/detail': (BuildContext context) => ContactDetailWidget(),
        },
      ),
    );
  }
}
