import 'package:activmind_app/Screens/HomeForm.dart';
import 'package:activmind_app/Screens/signup_form.dart';
import 'package:activmind_app/common/comhelper.dart';
import 'package:activmind_app/common/gen_text_form_field.dart';
import 'package:activmind_app/databaseHandler/Dbhelper.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formkey = new GlobalKey<FormState>();
  
  final _conemail = TextEditingController();
  final _conpassword = TextEditingController();
  var dbHelper;


  @override 
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }
  

  login() async{
    String email = _conemail.text;
    String password = _conpassword.text;
    // if (_formkey.currentState!.validate()) {
    if (email.isEmpty){
      alterdialog(context, 'Veuillez entrer un email valid');
    } else if(password.isEmpty){
      alterdialog(context, 'Veuillez entrer le mot de passe');

    }else{
      await dbHelper.getLoginUser(email, password).then((userData){
        Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => HomeForm()),
                (Route<dynamic> route) => false);
      }).catchError((error){
          print(error);
          alterdialog(context, 'Error login  faile');

        });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Log In to ActivMine'),
        // titleTextStyle: const TextStyle(
        //     color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25.0),
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
                GetTextFormField(
                  controller: _conemail,
                  icon: Icons.person,
                  hintName: 'Email',
                  inputtype: TextInputType.text
                ),
                SizedBox(height: 5.0),
                GetTextFormField(
                  controller: _conpassword,
                  icon: Icons.lock,
                  hintName: 'mot de passe',
                  isObscureText: true,
                ),
                
                Container(
                  child: const Center(child: Text('mot de pass oublié')),
                ),
                
                Container(
                    margin: const EdgeInsets.all(30.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 76, 77, 166),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: TextButton(
                        onPressed: login,
                        child: const Text(
                          'connexion',
                          style: TextStyle(
                              color: Color.fromARGB(255, 197, 198, 243)),
                        ))),
                Center(
                  child: Container(
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SignupForm()));
                          },
                          child: const Text(
                            'Inscrivez-vous',
                            style: TextStyle(
                                color: Color.fromARGB(255, 197, 198, 243)),
                          ))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
