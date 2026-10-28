import 'package:flutter/material.dart';
import 'Login.dart';
import '../theme/app_colors.dart';

class PaginaRegisterLJ extends StatefulWidget {
  const PaginaRegisterLJ({super.key});

  @override
  State<PaginaRegisterLJ> createState() => _PaginaRegisterLJState();
}

class _PaginaRegisterLJState extends State<PaginaRegisterLJ> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController = TextEditingController();
  final TextEditingController codigopostalControler = TextEditingController();
  final TextEditingController moradaControler = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    codigopostalControler.dispose();
    moradaControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text('Registar Loja'), centerTitle: true),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.08,
                    vertical: 24,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center, 
                      crossAxisAlignment: CrossAxisAlignment.center, 
                      children: [
                        SizedBox(
                          width: screenSize.width * 0.35,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset('images/logo.png', fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.04),
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
                            if (email.isEmpty) return 'Introduz o email.';
                            if (!email.contains('@') || !email.contains('.')) {
                              return 'Introduz um email válido.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
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
                            if ((value?.trim() ?? '').isEmpty) {
                              return 'Introduz uma password.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: confirmpasswordController,
                          obscureText: true,
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
                            if (value != passwordController.text) {
                              return 'As passes não correspondem.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: codigopostalControler,
                          style: const TextStyle(color: AppColors.textPrimary),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.surfaceLight,
                            hintText: 'Código Postal (ex: 1000-000)',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            final String codigopostal = value?.trim() ?? '';
                            final regex = RegExp(r'^\d{4}-\d{3}$');
                            if (!regex.hasMatch(codigopostal)) {
                              return 'Código postal inválido (ex: 1000-000).';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: moradaControler,
                          style: const TextStyle(color: AppColors.textPrimary),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.surfaceLight,
                            hintText: 'Morada',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if ((value?.trim() ?? '').isEmpty) {
                              return 'Introduz a Morada.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Back'),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const PaginaLogin(),
                                    ),
                                  );
                                }
                              },
                              child: const Text('Registar'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}