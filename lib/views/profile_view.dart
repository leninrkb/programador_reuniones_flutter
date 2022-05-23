import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: AnimatedContainer(
          padding: const EdgeInsets.all(24),
          //	color: Colors.yellow,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            //color: Colors.grey.shade200
          ),
          constraints: const BoxConstraints(maxWidth: 500),
          duration: const Duration(milliseconds: 2000),
          child: Center(
            child: Form(
                child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.network(
                    "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                    height: 200,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Usuario", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Telfono", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Nombre", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Apellido", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Contrasenia", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => GoRouter.of(context).go('/'),
                  child: const Text("Actualizar mis datos"),
                )
              ],
            )),
          ),
        ),
      ),
    ));
  }
}
