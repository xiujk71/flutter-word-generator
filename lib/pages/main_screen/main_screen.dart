import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:convert';
import 'dart:math';
import 'words_handler.dart';



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
  final WordsHandler words_handler = WordsHandler();

  Widget create_checkbox(String select_name)
  {
    return Row
    (
      mainAxisAlignment: MainAxisAlignment.center,
      children: 
      [
        Checkbox
        (
          value: words_handler.get_type_bool(select_name), 
          onChanged: (bool? to_select_type)
          {
            setState(()
            {
              words_handler.set_type_bool(select_name, to_select_type);

              String print_select_name = select_name;
              bool? print_select_type = words_handler.get_type_bool(select_name);
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
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 100)
              ),
              onPressed: ()
              {
                setState(()
                {
                  button_string = words_handler.generate_word();
                });
                
              }, 
              child: Text(
                button_string,
                style: TextStyle(fontSize: 20))
            ),
            create_checkbox("verb"),
            create_checkbox("noun"),
            create_checkbox("adjective"),
          ],
        ),
      ),
    );
  }
}