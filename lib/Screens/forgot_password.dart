// ignore_for_file: avoid_print
import 'package:activmind_app/Screens/login_form.dart';
import 'package:activmind_app/common/gen_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _conemail = TextEditingController();
  final _conpassword = TextEditingController();
  final _conconfpassword = TextEditingController();

  Future<bool> resetPassword() async {
    if (_conpassword.text != _conconfpassword.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Les mots de passe ne correspondent pas.'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/forgot_password/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': _conemail.text,
          'password': _conpassword.text,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Réinitialisation du mot de passe réussie.'),
            backgroundColor: Colors.green,
          ),
        );
        return true;
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors de la réinitialisation du mot de passe: ${response.statusCode}'),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Une erreur s\'est produite. Veuillez réessayer plus tard.'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
  }

  void onResetPasswordSuccess(BuildContext context) {
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginForm()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 139, 140, 242),
      ),
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
                  '././assets/images/logo.png',
                  height: 100.0,
                  width: 100.0,
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Reinitialiser le mot de passe',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25.0),
                ),
                const SizedBox(height: 30.0),
                GetTextFormField(
                    controller: _conemail,
                    icon: Icons.person,
                    hintName: 'Email',
                    inputtype: TextInputType.text),
                const SizedBox(height: 5.0),
                GetTextFormField(
                  controller: _conpassword,
                  icon: Icons.lock,
                  hintName: 'mot de passe',
                  isObscureText: true,
                ),
                const SizedBox(height: 5.0),
                GetTextFormField(
                  controller: _conconfpassword,
                  icon: Icons.lock,
                  hintName: 'confirmer mot de passe',
                  isObscureText: true,
                ),
                const SizedBox(height: 20.0),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginForm()),
                    );
                  },
                  child: const Text('Retourner à la page de connexion'),
                ),
                Container(
                  margin: const EdgeInsets.all(30.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 76, 77, 166),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: TextButton(
                    onPressed: () async {
                      if (await resetPassword()) {
                        await Future.delayed(const Duration(seconds: 1)); // Attendez 1 seconde
                        onResetPasswordSuccess(context); // Redirigez vers LoginForm uniquement si la réinitialisation du mot de passe a réussi
                      }
                    },
                    child: const Text(
                      'Reinitialiser le mot de passe',
                      style: TextStyle(
                          color: Color.fromARGB(255, 197, 198, 243)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
