import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/validator.dart';
import 'package:loja_virtual/models/user.dart' as users;
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';

class LoginSreen extends StatelessWidget {
  const LoginSreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // pega os valores dos campos
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color colorDisabled = primaryColor.withAlpha(100);

    // substituimos por ScaffoldMessenger
    // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      // key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
        actions: <Widget>[
          TextButton(
              onPressed: () => {
                    Navigator.of(context).pushReplacementNamed('/signup'),
                  },
              child: const Text(
                'Criar conta',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ))
        ],
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, child) => ListView(
                padding: const EdgeInsets.all(16),
                // menor espaço possivel
                shrinkWrap: true,
                children: <Widget>[
                  TextFormField(
                    // pega o valor do campo
                    controller: emailController,
                    enabled: !userManager.loading,
                    // aparece o nome mas ao digitar sai
                    decoration: const InputDecoration(hintText: 'E-mail'),
                    // aparecer o @ no teclado
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: (email) {
                      // if not validate field
                      if (!emailValid(email!)) return 'E-mail inválido.';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: passController,
                    enabled: !userManager.loading,
                    decoration: const InputDecoration(hintText: 'Senha'),
                    // não mostra a senha digitada
                    obscureText: true,
                    validator: (pass) {
                      if (pass!.isEmpty || pass.length < 6) {
                        return 'Senha inválida, mínimo 6 letras.';
                      }
                      return null;
                    },
                  ),
                  child!,
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      onPressed: userManager.loading
                          ? null
                          : () {
                              // get value field
                              if (formKey.currentState!.validate()) {
                                // context.read<UserManager>().signIn(

                                // usando o consumidor
                                userManager.signIn(
                                    user: users.User(
                                      email: emailController.text,
                                      password: passController.text,
                                    ),
                                    onFail: (error) {
                                      // versao antiga, da aula
                                      /*scaffoldKey.currentState?.showSnackBar(
                                        SnackBar(
                                          content:
                                              Text('Falha ao entrar: $error'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );*/

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text('Falha ao entrar: $error'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    },
                                    onSucess: () {
                                      Navigator.of(context).pop();
                                    });
                              }
                            },
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        backgroundColor: primaryColor,
                        disabledBackgroundColor: colorDisabled,
                      ),
                      child: userManager.loading
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            )
                          : const Text('Entrar'),
                    ),
                  ),
                ],
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Esqueci minha senha'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
