import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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
                  'se connecter',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25.0),
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
                      hintText: 'user name',
                      fillColor: Color.fromARGB(255, 197, 198, 243),
                      filled: true,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  margin: const EdgeInsets.only(top: 10.0),
                  child: TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(color: Colors.blue)),
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'password',
                      fillColor: Color.fromARGB(255, 197, 198, 243),
                      filled: true,
                    ),
                  ),
                ),
                Container(
                  child:const Center(child: Text('mot de pass oublié')),
                ),
                Container(
                  margin:const EdgeInsets.all(30.0),
                  width: double.infinity,
                  
                  decoration: BoxDecoration(
                      color:const Color.fromARGB(255, 76, 77, 166),
                      borderRadius: BorderRadius.circular(30.0)
                      ),
                      child: TextButton(
                      onPressed: () {},
                      child:const Text(
                        'connexion',
                        style: TextStyle(
                            color: Color.fromARGB(255, 197, 198, 243)),
                      ))
                ),
                Container(
                  child:const Center(child: Text('inscrivez-vous')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
