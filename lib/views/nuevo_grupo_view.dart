import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:programador_reuniones_flutter/widgets/appbar_widget.dart';

class NuevoGrupo extends StatefulWidget {
  const NuevoGrupo({Key? key}) : super(key: key);

  @override
  State<NuevoGrupo> createState() => _NuevoGrupoState();
}

class _NuevoGrupoState extends State<NuevoGrupo> {
  final _formKey = GlobalKey<FormState>();
  final integrantes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget('Crear grupo'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Nombre de grupo",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Ingrese el nombre del grupo";
                      }
                      return null;
                    },
                  ),
                ),
                //	const	SizedBox(width: 10),

                const SizedBox(
                  width: 60,
                  height: 50,
                  child: VerticalDivider(width: 2),
                ),
                const Text('Buscar integrantes: '),
                IconButton(
                  onPressed: () async {
                    final resultado = await showSearch(context: context, delegate: Busqueda());
                    if (resultado != "") {
                      setState(() {
                        integrantes.add(resultado);
                      });
                    }
                  },
                  icon: const Icon(Icons.search),
                ),
              ]),

              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: integrantes.length,
                  itemBuilder: (context, index) {
                    final sugerencia = integrantes[index];
                    return Dismissible(
                      key: Key(sugerencia),
                      background: Container(
                        color: Color.fromARGB(140, 224, 70, 59),
                        child: Icon(Icons.delete),
                        alignment: Alignment.topLeft,
                      ),
                      onDismissed: (direction) {
                        setState(() {
                          integrantes.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$sugerencia eliminado.')));
                      },
                      child: ListTile(
                        leading: const Icon(Icons.tab_unselected_rounded),
                        title: Text(sugerencia),
                        onTap: () {},
                      ),
                    );
                  },
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: SizedBox(
                              child: Text('Procesando'),
                            ),
                          ));
                        }
                      },
                      child: const SizedBox(
                        width: 60,
                        child: Text(
                          "Crear",
                          textAlign: TextAlign.center,
                        ),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: const SizedBox(
                        width: 60,
                        child: Text(
                          "Cancelar",
                          textAlign: TextAlign.center,
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Busqueda extends SearchDelegate<String> {
  final usuarios = ["Erick", "Josué", "Lenin", "Steven", "Jean"];
  final usuariosRecientes = ["Erick", "Josué"];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, "");
          } else {
            query = "";
          }
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, "");
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final sugerencias = query.isEmpty
        ? usuariosRecientes
        : usuarios.where((usuario) {
            final usuarioLower = usuario.toLowerCase();
            final queryLower = query.toLowerCase();

            return usuarioLower.startsWith(queryLower);
          }).toList();

    return buildSuggestionsSuccess(sugerencias);
  }

  Widget buildSuggestionsSuccess(List<String> sugerencias) {
    return ListView.builder(
      itemCount: sugerencias.length,
      itemBuilder: (context, index) {
        final sugerencia = sugerencias[index];
        return ListTile(
          leading: const Icon(Icons.tab_unselected_rounded),
          title: Text(sugerencia),
          onTap: () {
            query = sugerencia;
            close(context, query);
          },
        );
      },
    );
  }
}
