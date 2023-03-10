import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/validator.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final User user = User();

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color colorDisabled = primaryColor.withAlpha(100);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar conta'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __) {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  // menor espaço possivel
                  shrinkWrap: true,
                  children: <Widget>[
                    TextFormField(
                      decoration:
                          const InputDecoration(hintText: 'Nome Completo'),
                      enabled: !userManager.loading,
                      validator: (nome) {
                        if (nome!.isEmpty) {
                          return 'Campo Obrigatório';
                        } else if (nome.trim().split(' ').length <= 1) {
                          return 'Preencha seu Nome Completo';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (name) => user.name = name,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'E-mail'),
                      // aparecer o @ no teclado
                      keyboardType: TextInputType.emailAddress,
                      enabled: !userManager.loading,
                      validator: (email) {
                        if (email!.isEmpty) {
                          return 'Campo Obrigatório';
                        } else if (!emailValid(email)) {
                          return 'E-mail inválido';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (email) => user.email = email,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Senha'),
                      obscureText: true,
                      enabled: !userManager.loading,
                      validator: (pass) {
                        if (pass!.isEmpty) {
                          return 'Campo Obrigatório';
                        } else if (pass.length < 6) {
                          return 'Senha muito curta';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (pass) => user.password = pass,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration:
                          const InputDecoration(hintText: 'Repita a Senha'),
                      obscureText: true,
                      enabled: !userManager.loading,
                      validator: (repass) {
                        if (repass!.isEmpty) {
                          return 'Campo Obrigatório';
                        } else if (repass.length < 6) {
                          return 'Senha muito curta';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (pass) => user.confirmPassword = pass,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();

                            if (user.password != user.confirmPassword) {
                              // menssagem de alerta
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Senhas diferentes'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }
                            // context.read<UserManager>()
                            // usando o consumidor
                            userManager.signUp(
                              user: user,
                              onSucess: () {
                                Navigator.of(context).pop();
                              },
                              onFail: (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Falha ao cadastrar: $e'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              },
                            );
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
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : const Text('Criar Conta'),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
