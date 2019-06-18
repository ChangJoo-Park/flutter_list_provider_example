import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListState with ChangeNotifier {
  List<String> items = List<String>.generate(10, (i) => "Item $i");

  get listItems {
    return items;
  }

  void appendItem() {
    this.items.add('New Append Item');
    notifyListeners();
  }

  void prependItem() {
    this.items.insert(0, 'New prepend item');
    notifyListeners();
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => ListState()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Provider Items'),
      ),
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
  @override
  Widget build(BuildContext context) {
    final listState = Provider.of<ListState>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("${widget.title} - ${listState.items.length}"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: listState.prependItem,
            )
          ],
        ),
        body: ListView.builder(
          itemCount: listState.listItems.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${listState.listItems[index]}'),
              onTap: () {},
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: listState.appendItem,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ));
  }
}
