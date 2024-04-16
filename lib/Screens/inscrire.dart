import 'package:activmind_app/Screens/adresse.dart';
import 'package:flutter/material.dart';

class InscrireForm extends StatefulWidget {
  const InscrireForm({super.key});

  @override
  State<InscrireForm> createState() => _InscrireFormState();
}

class _InscrireFormState extends State<InscrireForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inscrir')),
      backgroundColor: const Color.fromARGB(255, 139, 140, 242),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: const Color.fromARGB(255, 139, 140, 242),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10.0),
                Image.asset(
                  './assets/images/logo.png',
                  height: 100.0,
                  width: 100.0,
                ),
                const Text(
                  "Inscrivez-vous",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25.0),
                ),
                Container(
                  child: const Center(
                      child: Text('vous avez déjà un compte ? connectez-vous')),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  margin: const EdgeInsets.only(top: 20.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(color: Colors.blue)),
                      prefixIcon: Icon(Icons.person),
                      hintText: 'Prénom *',
                      fillColor: Color.fromARGB(255, 197, 198, 243),
                      filled: true,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  margin: const EdgeInsets.only(top: 10.0),
                  child: TextFormField(
                    //obscureText: true,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(color: Colors.blue)),
                      prefixIcon: Icon(Icons.family_restroom_sharp),
                      hintText: 'Nom de famille *',
                      fillColor: Color.fromARGB(255, 197, 198, 243),
                      filled: true,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  margin: const EdgeInsets.only(top: 10.0),
                  //child: showDatePicker(context: context, firstDate: firstDate, lastDate: lastDate)
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  margin: const EdgeInsets.only(top: 10.0),
                  child: TextFormField(
                    //obscureText: true,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(color: Colors.blue)),
                      prefixIcon: Icon(Icons.calendar_today),
                      hintText: 'Date de naissance *',
                      fillColor: Color.fromARGB(255, 197, 198, 243),
                      filled: true,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  margin: const EdgeInsets.only(top: 10.0),
                  child: TextFormField(
                    //obscureText: true,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(color: Colors.blue)),
                      prefixIcon: Icon(Icons.admin_panel_settings),
                      hintText: 'Type de compte *',
                      fillColor: Color.fromARGB(255, 197, 198, 243),
                      filled: true,
                    ),
                  ),
                ),
                // Container(
                //   child:const Center(child: Text('mot de pass oublié')),
                // ),

                ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 76, 77, 166),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return const adresse_form();
                          }));
                          
                        },
                        child: const Text('suivant')),

                // Container(
                //     margin: const EdgeInsets.all(30.0),
                //     width: double.infinity,
                //     decoration: BoxDecoration(
                //         color: const Color.fromARGB(255, 76, 77, 166),
                //         borderRadius: BorderRadius.circular(30.0)),
                //     child: TextButton(
                //         onPressed: () {
                          
                //         },
                //         child: const Text(
                //           'suivant',
                //           style: TextStyle(
                //               color: Color.fromARGB(255, 197, 198, 243)),
                //         ))),
                // Container(
                //   child:const Center(child: Text('inscrivez-vous')),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
