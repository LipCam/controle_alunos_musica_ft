// ignore_for_file: library_private_types_in_public_api

import 'package:controle_alunos_musica_ft/config/my_app.dart';
import 'package:controle_alunos_musica_ft/database/repositories/alunos_repository.dart';
import 'package:controle_alunos_musica_ft/models/alunos.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'alunos_lista_back.g.dart';

class AlunosListaBack = _AlunosListaBack with _$AlunosListaBack;

abstract class _AlunosListaBack with Store {
  final _dao = AlunosRepository();

  _AlunosListaBack() {
    carregaLista();
  }

  @observable
  Future<List<Alunos>>? lstEntities;

  @action
  carregaLista([dynamic textPesquisa]) {
    lstEntities = _dao.onGetLista(textPesquisa);
  }

  goToForm(BuildContext context, [Alunos? aluno]) {
    Navigator.of(context)
        .pushNamed(MyApp().alunosForm, arguments: aluno)
        .then(carregaLista);
  }

  onDelete(int id) {
    _dao.onDelete(id);
    carregaLista();
  }

  //#region Pesquisa
  @observable
  bool isSearching = false;
  TextEditingController searchQueryController = TextEditingController();

  void updateSearchQuery(String newQuery) {
    carregaLista(newQuery);
  }

  void clearSearchQuery() {
    searchQueryController.clear();
    updateSearchQuery("");
  }

  void stopSearching() {
    clearSearchQuery();
    isSearching = false;
  }

  @action
  void startSearch(BuildContext context) {
    ModalRoute.of(context)
        ?.addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearching));

    isSearching = true;
  }
  // #endregion
}
