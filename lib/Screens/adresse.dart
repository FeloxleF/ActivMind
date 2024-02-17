import 'package:activmind_app/Screens/loginform.dart';
import 'package:flutter/material.dart';

class adresse_form extends StatefulWidget {
  const adresse_form({super.key});

  @override
  State<adresse_form> createState() => _adresse_formState();
}

class _adresse_formState extends State<adresse_form> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log In')),
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
                  'assets/images/logo.png',
                  height: 100.0,
                  width: 100.0,
                ),
                const Text(
                  "s'inscrire",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25.0),
                ),
                Container(
                  child: const Center(
                      child: Text('Adresse postale')),
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
                      prefixIcon: Icon(Icons.numbers),
                      hintText: 'Numéro',
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
                      prefixIcon: Icon(Icons.streetview),
                      hintText: 'Rue',
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
                      prefixIcon: Icon(Icons.location_city),
                      hintText: 'Ville',
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
                      prefixIcon: Icon(Icons.local_post_office),
                      hintText: 'Code postal',
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
                      prefixIcon: Icon(Icons.mobile_friendly),
                      hintText: 'Numéro de téléphone',
                      fillColor: Color.fromARGB(255, 197, 198, 243),
                      filled: true,
                    ),
                  ),
                ),
                Container(
                  child:const Center(child: Text('vous pouvez ignorer cette partie pour l’instant')),
                ),

                ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          onPrimary: Colors.white,
                          primary: Color.fromARGB(255, 76, 77, 166),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return const LoginForm();
                          }));
                          
                        },
                        child: Text('terminer l’inscription')),

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
