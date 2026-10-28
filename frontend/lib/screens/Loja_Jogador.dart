import '../app_colors.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'Register_Jogador.dart';
import 'Registar_Loja.dart';

void main() {
  runApp(const MyApp());
}

class PaginaJGLJ extends StatelessWidget {
  const PaginaJGLJ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: AppColors.darkTheme,
      home: Scaffold(
        appBar: AppBar(title: const Text('Registar'), centerTitle: true),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaginaRegisterJG()),
                  );
                },
                child: Text('Jogador'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaginaRegisterLJ()),
                  );
                },
                child: Text('Loja'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
