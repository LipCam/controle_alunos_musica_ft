// ignore_for_file: library_private_types_in_public_api

import 'package:controle_alunos_musica_ft/config/my_app.dart';
import 'package:controle_alunos_musica_ft/database/repositories/instrutores_repository.dart';
import 'package:controle_alunos_musica_ft/models/instrutores.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'instrutores_lista_back.g.dart';

class InstrutoresListaBack = _InstrutoresListaBack with _$InstrutoresListaBack;

abstract class _InstrutoresListaBack with Store {
  final _repository = InstrutoresRepository();

  _InstrutoresListaBack() {
    carregaLista();
  }

  @observable
  Future<List<Instrutores>>? lstEntities;

  @action
  carregaLista([dynamic textPesquisa]) {
    lstEntities = _repository.onGetLista(textPesquisa);
  }

  goToForm(BuildContext context, [Instrutores? aluno]) {
    Navigator.of(context)
        .pushNamed(MyApp().instrutoresForm, arguments: aluno)
        .then(carregaLista);
  }

  onDelete(int id) async {
    await _repository.onDelete(id);
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
