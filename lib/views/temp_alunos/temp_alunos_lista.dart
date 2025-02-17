// ignore_for_file: no_leading_underscores_for_local_identifiers, use_key_in_widget_constructors, use_build_context_synchronously

import 'package:controle_alunos_musica_ft/config/app_colors.dart';
import 'package:controle_alunos_musica_ft/config/app_dimensions.dart';
import 'package:controle_alunos_musica_ft/config/app_toast.dart';
import 'package:controle_alunos_musica_ft/views/temp_alunos/components/temp_alunos_tile.dart';
import 'package:controle_alunos_musica_ft/views/temp_alunos/temp_alunos_lista_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TempAlunosLista extends StatefulWidget {
  @override
  State<TempAlunosLista> createState() => _TempAlunosListaState();
}

class _TempAlunosListaState extends State<TempAlunosLista> {
  final _back = TempAlunosListaBack();
  int idAula = 0;
  bool selTodos = false;

  @override
  void initState() {
    super.initState();
    onCarregaTempAlunosLista();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (idAula == 0) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is int) {
        setState(() {
          idAula = args;
        });
      }
    }
  }

  onCarregaTempAlunosLista() async {
    setState(() async {
      await _back.carregaTempAlunosLista();
      await _back.onGetTempAlunosLista("");
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _buildActions() {
      if (_back.isSearching) {
        return <Widget>[
          IconButton(
            icon: const Icon(FontAwesomeIcons.xmark),
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
          icon: const Icon(FontAwesomeIcons.magnifyingGlass),
          onPressed: () {
            _back.startSearch(context);
          },
        ),
        IconButton(
          icon: const Icon(FontAwesomeIcons.check),
          tooltip: "Copiar",
          onPressed: () async {
            await onCopiarAula(context);
          },
        ),
        PopupMenuButton(itemBuilder: (a) {
          return [
            PopupMenuItem(
              child: const Row(
                children: [
                  Icon(
                    FontAwesomeIcons.check,
                    color: Colors.black,
                  ),
                  SizedBox(width: 10),
                  Text("Sel. Todos"),
                ],
              ),
              onTap: () {
                setState(() {
                  selTodos = !selTodos;
                  _back.onSelectTodosTempAluno(selTodos);
                });
              },
            ),
          ];
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
          fontSize: AppDimensions.searchFieldFontSize,
        ),
        onChanged: (query) => _back.updateSearchQuery(query),
      );
    }

    return Observer(
      builder: (context) {
        return Scaffold(
          backgroundColor: AppColors.scafoldBackGround,
          appBar: AppBar(
            leading: _back.isSearching ? const BackButton() : null,
            title: _back.isSearching
                ? _buildSearchField()
                : const Text("Copiar Aula"),
            actions: _buildActions(),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Selecione alunos para copiar a aula",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Expanded(
                  child: tempAlunosLista(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> onCopiarAula(BuildContext context) async {
    if (_back.lstTempAlunos!
        .where((element) => element.flag == true)
        .isNotEmpty) {
      await _back.onCopiarAula(idAula);
      onToastMessage("Cópia realizada");
      Navigator.of(context).pop();
    } else {
      onToastMessage("Selecione alunos para copiar a aula");
    }
  }

  tempAlunosLista() {
    if (_back.lstTempAlunos != null) {
      return ListView.builder(
        itemCount: _back.lstTempAlunos!.length,
        shrinkWrap: true,
        itemBuilder: (context, i) {
          return TempAlunosTile(
            tempAluno: _back.lstTempAlunos![i],
            back: _back,
          );
        },
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
