import 'package:flutter/material.dart';
// import 'package:icons_flutter/icons_flutter.dart';

class MyHomePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final List<Map<String, String>> items = [
    {
      "title": "médicament",
      "description": "n'oubliez pas de prendre de médicament"
    },
    {
      "title": "visit le médecin",
      "description": "n'oubliez pas aller chez médecin"
    },
    {
      "title": "médicament",
      "description":
          "n'oubliez pas de prendre de médicament, n'oubliez pas de prendre de médicament,n'oubliez pas de prendre de médicament,n'oubliez pas de prendre de médicament,n'oubliez pas de prendre de médicament,"
    },
    {
      "title": "visit le médecin",
      "description": "n'oubliez pas aller chez médecin"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Activ\'Mind',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.indigoAccent,
              fontSize: 24,
              fontFamily: 'Arial',
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.alarm),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Text(
              'Emploi du temps de la semaine',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Arial',
              ),
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 8.0, left: 5),
                  child: Text(
                    'passer à votre emploi du temps de la journée',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 240, 169, 37),
                      onPrimary: Color.fromARGB(255, 255, 255, 255),
                    ),
                    onPressed: () {},
                    child: const Text('jour'),
                  ),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.all(5),
                  child: ListTile(
                    title: Text(items[index]["title"]!),
                    subtitle: Text(items[index]["description"]!),
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(items[index]["title"]!),
                        content: Text(items[index]["description"]!),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Modifier'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          TextButton(
                            child: Text('ّFermer'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: FloatingActionButton(
                onPressed: () async {
                  await showDialog<void>(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Color.fromARGB(255, 209, 193, 238),
                      content: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          Positioned(
                            right: -40,
                            top: -40,
                            child: InkResponse(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.red,
                                child: Icon(Icons.close),
                              ),
                            ),
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Nom de l’activité',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Color.fromARGB(255, 23, 79, 124),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: TextField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      hintText:
                                          'Veuillez entrer un nom de l\'activité ',
                                      border: OutlineInputBorder(),
                                      fillColor:
                                          Color.fromARGB(255, 232, 217, 255),
                                      filled: true,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Description (optionnel)',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Color.fromARGB(255, 23, 79, 124),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: TextField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      hintText:
                                          'Si vous voulez, vous pouvez entrer votre description (c\'est optionnel)',
                                      border: OutlineInputBorder(),
                                      fillColor:
                                          Color.fromARGB(255, 232, 217, 255),
                                      filled: true,
                                    ),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 10),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary:
                                              Color.fromARGB(255, 65, 64, 155),
                                          onPrimary: Color.fromARGB(
                                              255, 255, 255, 255),
                                        ),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _formKey.currentState!.save();
                                            Navigator.of(context).pop();
                                          }
                                        },
                                        child: const Text('Annuler'),
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary:
                                              Color.fromARGB(255, 255, 181, 70),
                                          onPrimary:
                                              Color.fromARGB(255, 44, 41, 223),
                                        ),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _formKey.currentState!.save();
                                          }
                                        },
                                        child: const Text('Enregistrer'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gamepad_outlined),
            label: 'Game',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Setting',
          ),

          // ...
        ],
      ),
    );
  }
}
