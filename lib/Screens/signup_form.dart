import 'package:activmind_app/Screens/login_form.dart';
import 'package:activmind_app/common/comhelper.dart';
import 'package:flutter/material.dart';
import 'package:activmind_app/common/gen_text_form_field.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:toast/toast.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _conemail = TextEditingController();
  final _conpassword = TextEditingController();
  final _conconfpassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> signUp() async {
    final form = _formKey.currentState;
    String email = _conemail.text;
    String password1= _conpassword.text;
    String password2 = _conconfpassword.text;
    ToastContext toastContext = ToastContext();
    if (form!.validate()){
      if (password1 != password2){
      alterdialog(context, 'non concordance des mots de passe');
      }
      else{
        final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/register/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': _conemail.text,
          'password': _conpassword.text,
        }),
      );


      if (response.statusCode == 200 || response.statusCode == 201) {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const LoginForm(),
                                  ),
                                  (Route<dynamic> route) => false);
      }   else {
        

        // ignore: use_build_context_synchronously
        alterdialog(context, "La définition de l'utilisateur a rencontré une erreur");
      }
      }
    }
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 139, 140, 242),
      ),
      backgroundColor: const Color.fromARGB(255, 139, 140, 242),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                  const SizedBox(height: 20.0),
                  GetTextFormField(
                    controller: _conemail,
                    icon: Icons.person,
                    hintName: 'Email*',
                    inputtype: TextInputType.text,
                  ),
                  const SizedBox(height: 5.0),
                  GetTextFormField(
                    controller: _conpassword,
                    icon: Icons.lock,
                    hintName: 'mot de passe *',
                    isObscureText: true,
                  ),
                  const SizedBox(height: 5.0),
                  GetTextFormField(
                    controller: _conconfpassword,
                    icon: Icons.lock,
                    hintName: 'confirmer le mot de passe *',
                    isObscureText: true,
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 76, 77, 166),
                    ),
                    onPressed: signUp, 
                    child: const Text('soumettre'),
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('vous avez une compte?'),
                        TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const LoginForm(),
                                  ),
                                  (Route<dynamic> route) => false);
                            },
                            child: const Text(
                              'connectez-vous',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 197, 198, 243)),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}