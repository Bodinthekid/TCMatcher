import 'package:flutter/material.dart';
import 'package:projeto/Login.dart';
import '../app_colors.dart';
import 'main.dart';

void main() {
  runApp(const MyApp());
}

class PaginaRegisterJG extends StatelessWidget {
  PaginaRegisterJG({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: AppColors.darkTheme,
      home: Scaffold(
        appBar: AppBar(title: const Text('Registar'), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(100),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    'images/logo.png',
                    cacheWidth:
                        500,
                    fit: BoxFit.cover,
                  )
                ),
                SizedBox(height: 100),
                TextFormField(
                  controller: emailController,
                  style: const TextStyle(color: AppColors.textPrimary),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.surfaceLight,
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    final String email = value?.trim() ?? '';
                    if (email.isEmpty) {
                      return 'Introduz o email.';
                    }
                    if (!email.contains('@') || !email.contains('.')) {
                      return 'Introduz um email válido.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: passwordController,
                  style: const TextStyle(color: AppColors.textPrimary),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.surfaceLight,
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    final String password = value?.trim() ?? '';
                    if (password.isEmpty) {
                      return 'intruduz uma password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: confirmpasswordController,
                  style: const TextStyle(color: AppColors.textPrimary),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.surfaceLight,
                    hintText: 'Confirmar Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    final String password = value?.trim() ?? '';
                    if (password.isEmpty) {
                      return 'intruduz uma password';
                    }
                    if (value != passwordController.text) {
                      return 'As passes não correspondem';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaginaLogin(),
                          ),
                        );
                      },
                      child: Text('Back'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaginaLogin(),
                            ),
                          );
                        }
                      },
                      child: Text('Registar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
