import 'package:controle_alunos_musica_ft/entities/alunos.dart';
import 'package:controle_alunos_musica_ft/views/alunos/alunos_lista_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AlunosLista extends StatelessWidget {
  var _back = AlunosListaBack();

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
            icon: Icon(Icons.add),
            onPressed: () {
              _back.GoToForm(context);
            })
      ];
    }

    Widget _buildSearchField() {
      return TextField(
        controller: _back.searchQueryController,
        autofocus: true,
        decoration: InputDecoration(
          hintText: "Pesquisar...",
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white30),
        ),
        style: TextStyle(color: Colors.white, fontSize: 16.0),
        onChanged: (query) => _back.updateSearchQuery(query),
      );
    }

    return Observer(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            leading: _back.isSearching ? const BackButton() : null,
            title: _back.isSearching ? _buildSearchField() : Text("Alunos"),
            actions: _buildActions(),
          ),
          body: Column(
            children: [
              SizedBox(height: 10),
              futureBuilder(),
            ],
          ),
        );
      },
    );

    // return Scaffold(
    //   appBar: AppBar(title: Text("Alunos"), actions: [
    //     IconButton(
    //         icon: Icon(Icons.add),
    //         onPressed: () {
    //           _back.GoToForm(context);
    //         })
    //   ]),
    //   body: Observer(builder: ((context) => futureBuilder())),
    // );
  }

  FutureBuilder futureBuilder() {
    return FutureBuilder(
      future: _back.lstEntities,
      builder: (context, future) {
        if (future.hasData) {
          List<Alunos> lst = future.data;
          return ListView.builder(
              itemCount: lst.length,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                Alunos aluno = lst[i];
                return ListTile(
                  title: Text(
                    aluno.NOME_STR.toString(),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(aluno.STATUS_STR!, style: TextStyle(fontSize: 15)),
                      Text(aluno.INSTRUMENTO_STR!,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  trailing: DeleteButton(context, aluno),
                  onTap: () {
                    _back.GoToForm(context, aluno);
                  },
                );
              });
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget DeleteButton(BuildContext context, Alunos aluno) {
    return IconButton(
      icon: Icon(Icons.delete),
      color: Colors.red,
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Exclusão"),
                  content: Text("Deseja excluir ${aluno.NOME_STR}?"),
                  actions: [
                    TextButton(
                        child: Text("Não"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    TextButton(
                      child: Text("Sim"),
                      onPressed: () {
                        _back.Delete(aluno.ID_ALUNO_INT!);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ));
      },
    );
  }
}
