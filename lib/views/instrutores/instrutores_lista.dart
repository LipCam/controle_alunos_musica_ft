// ignore_for_file: no_leading_underscores_for_local_identifiers, use_key_in_widget_constructors

import 'package:controle_alunos_musica_ft/models/instrutores.dart';
import 'package:controle_alunos_musica_ft/views/instrutores/instrutores_lista_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class InstrutoresLista extends StatelessWidget {
  final _back = InstrutoresListaBack();

  @override
  Widget build(BuildContext context) {
    List<Widget> _buildActions() {
      if (_back.isSearching) {
        return <Widget>[
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              if (_back.searchQueryController.text.isEmpty) {
                Navigator.pop(context);
                return;
              }
              _back.clearSearchQuery();
            },
          ),
        ];
      }

      return <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            _back.startSearch(context);
          },
        ),
        IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _back.goToForm(context);
            })
      ];
    }

    Widget _buildSearchField() {
      return TextField(
        controller: _back.searchQueryController,
        autofocus: true,
        decoration: const InputDecoration(
          hintText: "Pesquisar...",
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white30),
        ),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
        onChanged: (query) => _back.updateSearchQuery(query),
      );
    }

    return Observer(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            leading: _back.isSearching ? const BackButton() : null,
            title: _back.isSearching
                ? _buildSearchField()
                : const Text("Instrutores"),
            actions: _buildActions(),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: instrutoresLista(),
          ),
        );
      },
    );
  }

  FutureBuilder instrutoresLista() {
    return FutureBuilder(
      future: _back.lstEntities,
      builder: (context, future) {
        if (future.hasData) {
          List<Instrutores> lst = future.data;
          return ListView.builder(
              itemCount: lst.length,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                Instrutores aluno = lst[i];
                return ListTile(
                  dense: true,
                  title: Text(
                    aluno.nome.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        aluno.instrumento!,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  trailing: deleteButton(context, aluno),
                  onTap: () {
                    _back.goToForm(context, aluno);
                  },
                );
              });
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget deleteButton(BuildContext context, Instrutores aluno) {
    return IconButton(
      icon: const Icon(Icons.delete),
      color: Colors.red,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Exclusão"),
            content: Text("Deseja excluir ${aluno.nome}?"),
            actions: [
              TextButton(
                  child: const Text("Não"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              TextButton(
                child: const Text("Sim"),
                onPressed: () {
                  _back.delete(aluno.idInstrutor!);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
