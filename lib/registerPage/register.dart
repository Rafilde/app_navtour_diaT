import 'package:app_navtour/LoginPage/login.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  String confirmPassword = "";

  bool _obscureTextOne = true;
  bool _obscureTextTwo = true;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, 0),
            radius: 1,
            colors: [Color.fromARGB(255, 5, 158, 2),
              Color.fromARGB(255, 0, 58, 1)],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 28, right: 28),
          child: Center(
            child: Container(
              //width: 350,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(10.0), // Bordas arredondadas
              ),
              padding: EdgeInsets.all(28),
              //vai fazer o container aumenta a medida que eu coloco coisa
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Inserir nome";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Nome de usuário',
                            labelStyle: TextStyle(
                                //fontFamily: ,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            contentPadding: EdgeInsets.only(
                                top: 10) // Remova o preenchimento vertical
                            ),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Inserir email";
                          } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                              .hasMatch(value!)) {
                            return "Email inválido";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                                //fontFamily: ,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            contentPadding: EdgeInsets.only(
                                top: 10) // Remova o preenchimento vertical
                            ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        validator: (value) {
                          confirmPassword = value.toString();
                          if (value!.isEmpty) {
                            return "Inserir senha";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Criar senha',
                          labelStyle: TextStyle(
                              //fontFamily: ,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          contentPadding: EdgeInsets.only(
                              top: 10), // Remova o preenchimento vertical
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureTextOne = !_obscureTextOne;
                              });
                            },
                            child: Icon(_obscureTextOne
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                        ),
                        obscureText: _obscureTextOne,
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Inserir senha";
                          } else if (value.toString() != confirmPassword) {
                            return "Senha inválida";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Confirmar senha',
                          labelStyle: TextStyle(
                              //fontFamily: ,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          contentPadding: EdgeInsets.only(
                              top: 10), // Remova o preenchimento vertical
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureTextTwo = !_obscureTextTwo;
                              });
                            },
                            child: Icon(_obscureTextTwo
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                        ),
                        obscureText: _obscureTextTwo,
                      ),
                      SizedBox(height: 32.0),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                            Navigator.pushNamed(context, '/Explorar');
                          }
                        },
                        onLongPress: () {},
                        onFocusChange: (value) {},
                        onHover: (value) {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xFF1246FF),
                          minimumSize: const Size(167, 52),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                        child: const Text(
                          'Cadastrar',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                      SizedBox(height: 32.0),
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: 0.87,
                              decoration:
                                  BoxDecoration(color: Color(0xFF9B9B9B)),
                            ),
                            const SizedBox(width: 8.66),
                            Container(
                              child: Text(
                                'ou',
                                style: TextStyle(
                                  color: Color(0xFF9B9B9B),
                                  fontSize: 17.56,
                                  //fontFamily: 'Lexend Deca',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8.66),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: 0.87,
                              decoration:
                                  BoxDecoration(color: Color(0xFF9B9B9B)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 32.0),
                      // Botão "Entrar com Google"
                      ElevatedButton(
                        onPressed: () {
                          // Adicione a ação para entrar com o Google aqui
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFFFFFF),
                          minimumSize: const Size(167, 52),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              'https://static-00.iconduck.com/assets.00/google-icon-2048x2048-czn3g8x8.png', // Adicione o caminho da imagem do Google
                              height:
                                  24, // Ajuste o tamanho da imagem conforme necessário
                              width: 24,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              'Cadastrar com Google',
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16.0),

                      // Botão "Entrar com Apple"
                      ElevatedButton(
                        onPressed: () {
                          // Adicione a ação para entrar com a Apple aqui
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 0, 0, 0),
                          minimumSize: const Size(167, 52),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/3/31/Apple_logo_white.svg/1724px-Apple_logo_white.svg.png', // Adicione o caminho da imagem da Apple
                              height:
                                  24, // Ajuste o tamanho da imagem conforme necessário
                              width: 24,
                            ),
                            SizedBox(width: 8.0),
                            Text('Cadastrar com Apple', style: TextStyle(color: Colors.white),),
                          ],
                        ),
                      ),
                      SizedBox(height: 32.0),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => login()));
                          },
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Já tem uma conta?',
                                  style: TextStyle(
                                    color: Color(0xFF737373),
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: ' ',
                                  style: TextStyle(
                                    color: Color(0xFF777777),
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Logar',
                                  style: TextStyle(
                                    color: Color(0xFFFFAE50),
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}