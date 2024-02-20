import 'package:activmind_app/Screens/inscrire.dart';
import 'package:activmind_app/Screens/login_form.dart';
import 'package:activmind_app/common/comhelper.dart';
import 'package:activmind_app/databaseHandler/Dbhelper.dart';
import 'package:activmind_app/model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:activmind_app/common/gen_text_form_field.dart';
import 'package:toast/toast.dart';


class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formkey = new GlobalKey<FormState>();
  final _conemail = TextEditingController();
  final _conpassword = TextEditingController();
  final _conconfpassword = TextEditingController();
  var dbHelper;

  @override 
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }
  

  SignUp() async{
    final form = _formkey.currentState;
    String email = _conemail.text;
    String password = _conpassword.text;
    String confpassword = _conconfpassword.text;
    // DateTime create_date = DateTime.now();

    if (_formkey.currentState!.validate()) {
      if(password != confpassword){
        alterdialog(context, 'non concordance des mots de passe');  
      }else{
        _formkey.currentState?.save();

        UserModel uModel = UserModel(email, password);
        await dbHelper.saveData(uModel).then((userData){
        alterdialog(context, 'successfully registrer');

        }).catchError((error){
          print(error);
          alterdialog(context, 'Error data save faile');
        });

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
        key: _formkey,
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
                  
                  SizedBox(height: 20.0),
                  
                  GetTextFormField(
                    controller: _conemail,
                    icon: Icons.person,
                    hintName: 'Email*',
                    inputtype: TextInputType.text,
                  ),
        
                  SizedBox(height: 10.0),
                  GetTextFormField(
                    controller: _conpassword,
                    icon: Icons.lock,
                    hintName: 'mot de passe *',
                    isObscureText: true,
                  ),
                  SizedBox(height: 10.0),
                  GetTextFormField(
                    controller: _conconfpassword,
                    icon: Icons.lock,
                    hintName: 'confirmer le mot de passe *',
                    isObscureText: true,
                  ),
        
                  SizedBox(height: 20.0),
                  
                  
                  ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onPrimary: Colors.white,
                            primary: Color.fromARGB(255, 76, 77, 166),
                          ),
                          onPressed: SignUp,
                          child: Text('Registre')),
        
                  
                  SizedBox(height: 20.0),
                  
                  Container(
                    
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('vous avez une compte?'),
                        TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => LoginForm(),),
                                      (Route<dynamic> route)=>false);
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
