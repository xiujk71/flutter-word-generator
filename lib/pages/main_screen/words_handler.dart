import 'package:flutter/services.dart';

import 'dart:convert';
import 'dart:math';

class WordsHandler
{
  /* Start: class variables */
  final Map<String, bool?> _maps_bool =
  {
    "verb": false,
    "noun": false,
    "adjective": false,
  };

  final Map<String, List> _maps_list =
  {
    "verb": [],
    "noun": [],
    "adjective": []
  };

  WordsHandler()
  {
    _readJson();
  }
  /* End: class variables */

  /* Start: getter/setter functions */
  bool? get_type_bool(String type)
  {
    return _maps_bool[type];
  }

  void set_type_bool(String type, bool? new_bool)
  {
    _maps_bool[type] = new_bool;
  }

  /* Start: logical class functions */
  // Fetch content from the json file
  Future<void> _readJson() async {
    final String response_300_verbs = await rootBundle.loadString('assets/300-verbs.json');
    final String response_689_nouns = await rootBundle.loadString('assets/689-nouns.json');
    final String response_493_adjectives = await rootBundle.loadString('assets/493-adjectives.json');

    final data_300_verbs = await json.decode(response_300_verbs);
    final data_689_nouns = await json.decode(response_689_nouns);
    final data_493_adjectives = await json.decode(response_493_adjectives);

    _maps_list["verb"] = data_300_verbs;
    _maps_list["noun"] = data_689_nouns;
    _maps_list["adjective"] = data_493_adjectives;
  }

  String generate_word()
  {
    List<String> selected_types = [];
    String new_word = "";

    _maps_bool.forEach((string_type, bool_state)
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
      int selected_types_length = selected_types.length;
      int randomed_type = Random().nextInt(selected_types_length);

      // Random a word from the selected type
      String selected_list = selected_types[randomed_type];
      int selected_list_length = _maps_list[selected_list]!.length;
      int randomed_word_id = Random().nextInt(selected_list_length);

      new_word = _maps_list[selected_types[randomed_type]]![randomed_word_id]!;
    }
    return new_word;
  }
  /* End: class functions */
}