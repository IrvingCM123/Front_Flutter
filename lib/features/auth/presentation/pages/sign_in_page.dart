import 'package:flutter/material.dart';
import 'package:ui_one/features/auth/presentation/pages/admin_page.dart';
import 'package:ui_one/features/auth/presentation/pages/main_home.dart';
import 'package:ui_one/features/auth/presentation/pages/sign_up_page.dart';
import 'package:ui_one/features/auth/presentation/validator/auth_validator.dart';
import '../../../../service/auth_service.dart';

class SignInPage extends StatefulWidget {
  static const String id = "sign_in_page";

  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _signInGlobalKey = GlobalKey<FormState>();
  TextEditingController usernameController =
      TextEditingController(); // Cambio en el controlador
  TextEditingController passwordController = TextEditingController();
  bool passwordSee = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Iniciar sesión",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 138, 59),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "¡Bienvenido de nuevo! ¿Qué te trae por aquí?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Form(
                key: _signInGlobalKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller:
                          usernameController, // Cambio en el controlador
                      validator: AuthValidator
                          .isNameValid, // Cambio en la función de validación
                      decoration: const InputDecoration(
                        hintText: "Nombre de usuario", // Cambio en la etiqueta
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: passwordSee,
                      validator: AuthValidator.isPasswordValid,
                      decoration: InputDecoration(
                        hintText: "Contraseña",
                        suffixIcon: GestureDetector(
                          onTap: () {
                            passwordSee = !passwordSee;
                            setState(() {});
                          },
                          child: Icon(
                            passwordSee
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
              ),
              ElevatedButton(
                onPressed: signIn,
                child: Text(
                  "Siguiente",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 255, 138, 59),
                  padding: EdgeInsets.symmetric(horizontal: 125, vertical: 22),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "¿No tienes una cuenta?",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black, // Color negro
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navegar a la página de registro cuando se presione
                  Navigator.pushNamed(context, SignUpPage.id);
                },
                child: Text(
                  "Registrarse",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 255, 97, 57), // Color personalizado
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signIn() async {
    if (_signInGlobalKey.currentState!.validate()) {
      final authService = AuthService();

      final token = await authService.login(
        usernameController.text.trim(),
        passwordController.text.trim(),
      );

      if (token != null) {
        // La autenticación fue exitosa, aquí puedes navegar a la página principal
        Navigator.pushNamed(context, MyApp.id);
      } else {
        // La autenticación falló, muestra un mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Inicio de sesión fallido"),
            // Configura el estilo de tu SnackBar
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    usernameController.dispose(); // Cambio en el nombre del controlador
    passwordController.dispose();
    super.dispose();
  }
}