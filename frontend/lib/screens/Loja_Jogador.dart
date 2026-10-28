import 'package:flutter/material.dart';
import 'Register_Jogador.dart';
import 'Registar_Loja.dart';

class PaginaJGLJ extends StatelessWidget {
  const PaginaJGLJ({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text('Registar'), centerTitle: true),
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
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: screenSize.width * 0.35,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              'images/logo.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.04),
                        // Botão Jogador com largura controlada (50% do ecrã)
                        SizedBox(
                          width: screenSize.width * 0.3,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PaginaRegisterJG(),
                                ),
                              );
                            },
                            child: const Text('Jogador'),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Botão Loja com a mesma largura
                        SizedBox(
                          width: screenSize.width * 0.3,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PaginaRegisterLJ(),
                                ),
                              );
                            },
                            child: const Text('Loja'),
                          ),
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