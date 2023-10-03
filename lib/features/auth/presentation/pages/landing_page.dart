// lib/presentation/pages/landing_page.dart

import 'package:flutter/material.dart';
import 'sign_up_page.dart';
import 'sign_in_page.dart';

class LandingPage extends StatelessWidget {
  static const String id = "landing_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final textScaleFactor = (constraints.maxWidth < 600)
                ? 0.8
                : 1.0; // Ajusta según tus necesidades

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo de tu app
                Image.asset(
                  'assets/images/Icono.png', // Reemplaza con la ruta de tu logo
                  width: 250,
                  height: 250,
                ),
                const SizedBox(height: 70),
                Text("Bienvenido a nuestra Aplicación" ,style: TextStyle(
                      fontSize: 18 * textScaleFactor,
                      color: Color.fromARGB(255, 255, 0, 0)
                    )),
                // Botón para crear una cuenta
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SignUpPage.id);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 253, 113, 31), // Color del botón
                  ),
                  child: Text(
                    'Crear una cuenta',
                    style: TextStyle(
                      fontSize: 18 * textScaleFactor,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Texto para iniciar sesión
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, SignInPage.id);
                  },
                  child: Text(
                    '¿Ya tienes una cuenta? Iniciar sesión',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 0, 0), // Color del texto
                      fontSize: 16 * textScaleFactor,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
