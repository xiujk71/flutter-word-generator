import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:convert';
import 'dart:math';

class MainScreen extends StatefulWidget 
{
  const MainScreen({super.key, required this.title});

  final String title;

  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen>
{
  String button_string = "Click to Generate Words";

  Map<String, bool?> bool_maps =
  {
    "verb": false,
    "noun": false,
    "adjective": false,
  };

  List words = [];

    // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/500-words.json');
    final data = await json.decode(response);
    setState(() {
      words = data;
    });
  }

  void generate_word()
  {
    int random_number = Random().nextInt(100);
    String new_word = words[random_number];
    setState(() {
      button_string = new_word;
    });
  }

  void initState()
  {
    super.initState();
    readJson();
  }

  Widget create_checkbox(String select_name)
  {
    return Row
    (
      mainAxisAlignment: MainAxisAlignment.center,
      children: 
      [
        Checkbox
        (
          value: bool_maps[select_name], 
          onChanged: (bool? to_select_type)
          {
            setState(()
            {
              bool_maps[select_name] = to_select_type;

              String print_select_name = select_name;
              bool? print_select_type = bool_maps[select_name];
              print("$print_select_name: $print_select_type");
            });
          }
        ),
        Text(select_name),
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>
          [
            ElevatedButton
            (
              onPressed: ()
              {
                generate_word();
              }, 
              child: Text(button_string)
            ),
            Row
            (
              mainAxisAlignment: MainAxisAlignment.center,
              children: 
              [
                create_checkbox("verb"),
                create_checkbox("noun"),
                create_checkbox("adjective"),
              ],
            ),

          ],
        ),
      ),
    );
  }
}