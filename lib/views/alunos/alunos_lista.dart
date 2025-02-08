// ignore_for_file: no_leading_underscores_for_local_identifiers, use_key_in_widget_constructors

import 'package:controle_alunos_musica_ft/config/app_colors.dart';
import 'package:controle_alunos_musica_ft/config/app_dimensions.dart';
import 'package:controle_alunos_musica_ft/models/alunos.dart';
import 'package:controle_alunos_musica_ft/views/alunos/alunos_lista_back.dart';
import 'package:controle_alunos_musica_ft/views/alunos/components/alunos_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AlunosLista extends StatelessWidget {
  final _back = AlunosListaBack();

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
            icon: const Icon(FontAwesomeIcons.plus),
            tooltip: "Novo",
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
            backgroundColor: AppColors.appBarBackGround,
            foregroundColor: AppColors.appBarFontColor,
            leading: _back.isSearching ? const BackButton() : null,
            title:
                _back.isSearching ? _buildSearchField() : const Text("Alunos"),
            actions: _buildActions(),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: alunosLista(),
          ),
        );
      },
    );
  }

  FutureBuilder alunosLista() {
    return FutureBuilder(
      future: _back.lstEntities,
      builder: (context, future) {
        if (future.hasData) {
          List<Alunos> lst = future.data;
          return ListView.builder(
              itemCount: lst.length,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return AlunosTile(aluno: lst[i], back: _back);
              });
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
