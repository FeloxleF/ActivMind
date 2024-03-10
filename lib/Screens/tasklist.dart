import 'package:activmind_app/Screens/Calendar.dart';
import 'package:activmind_app/Screens/HomeForm.dart';
import 'package:flutter/material.dart';
import 'package:activmind_app/common/appandfooterbar.dart';


class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
 
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

  void showFormDialog(BuildContext context, GlobalKey<FormState> formKey) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(backgroundColor: Color.fromARGB(255, 209, 193, 238),
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
                    );
    },
  );
}


  int _currentIndex = 0;

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TaskList()),
      );
      return; // Return here to prevent further execution
    }
    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Calendar()),
      );
      return; // Return here to prevent further execution
    }
    if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeForm()),
      );
      return; // Return here to prevent further execution
    }
    setState(() {
      _currentIndex = index;
    });
  }


 
    
  @override
  Widget build(BuildContext context) {
    Widget currentPage;
    switch (_currentIndex) {
      case 0:
        currentPage = const TaskList();
        break;
      case 1:
        currentPage = const Calendar();
        break;
      case 2:
        currentPage = const HomeForm();
        break;
      case 3:
        // currentPage = SettingsPage();
        break;
      default:
        currentPage = const TaskList(); // Default to the first page
    }
    return Scaffold(
      appBar: MyAppBar(),
      
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
                            onPressed: () => showFormDialog(context, _formKey),
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
                onPressed: () => showFormDialog(context, _formKey),
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
      
    );
  }
  
}