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

  Map<String, bool?> maps_bool =
  {
    "verb": false,
    "noun": false,
    "adjective": false,
  };

  Map<String, List> maps_list =
  {
    "verb": [],
    "noun": [],
    "adjective": []
  };

  List words = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response_500_words = await rootBundle.loadString('assets/500-words.json');
    final String response_300_verbs = await rootBundle.loadString('assets/300-verbs.json');
    final String response_689_nouns = await rootBundle.loadString('assets/689-nouns.json');
    final String response_493_adjectives = await rootBundle.loadString('assets/493-adjectives.json');

    final data_500_words = await json.decode(response_500_words);
    final data_300_verbs = await json.decode(response_300_verbs);
    final data_689_nouns = await json.decode(response_689_nouns);
    final data_493_adjectives = await json.decode(response_493_adjectives);

    setState(() {
      words = data_500_words;
      maps_list["verb"] = data_300_verbs;
      maps_list["noun"] = data_689_nouns;
      maps_list["adjective"] = data_493_adjectives;
    });
  }

  void generate_word()
  {
    List<String> selected_types = [];
    String new_word = "";

    maps_bool.forEach((string_type, bool_state)
      {
        if (bool_state == true) 
        {
          selected_types.add(string_type);
        };
      }
    );

    if (selected_types.length == 0)
    {
      new_word = "Select a type";
    }
    else
    {
      // Random a type
      int randomed_type = Random().nextInt(selected_types.length);

      // Random a word from the selected type
      int randomed_word_id = Random().nextInt(maps_list[selected_types[randomed_type]]!.length);

      new_word = maps_list[selected_types[randomed_type]]![randomed_word_id]!;
    }

    // int random_number = Random().nextInt(100);
    // String new_word = words[random_number];
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
          value: maps_bool[select_name], 
          onChanged: (bool? to_select_type)
          {
            setState(()
            {
              maps_bool[select_name] = to_select_type;

              String print_select_name = select_name;
              bool? print_select_type = maps_bool[select_name];
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
                generate_word();
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