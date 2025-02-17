// ignore_for_file: library_private_types_in_public_api, null_closures, avoid_function_literals_in_foreach_calls

import 'package:controle_alunos_musica_ft/database/repositories/temp_alunos_repository.dart';
import 'package:controle_alunos_musica_ft/models/temp_alunos.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'temp_alunos_lista_back.g.dart';

class TempAlunosListaBack = _TempAlunosListaBack with _$TempAlunosListaBack;

abstract class _TempAlunosListaBack with Store {
  final _repository = TempAlunosRepository();

  @observable
  List<TempAlunos>? lstTempAlunos;

  @action
  carregaTempAlunosLista([dynamic textPesquisa]) async {
    await _repository.carregaTempAlunosLista();
  }

  onGetTempAlunosLista([dynamic textPesquisa]) async {
    lstTempAlunos = await _repository.getTempAlunosLista(textPesquisa);
  }

  @action
  onSelectTempAluno(int idAluno) {
    TempAlunos tempAlunos = lstTempAlunos!
        .firstWhere((element) => element.idAluno == idAluno, orElse: null);
    tempAlunos.flag = !tempAlunos.flag;

    _repository.selectTempAluno(idAluno);
  }

  onSelectTodosTempAluno(bool selTodos) {
    lstTempAlunos!.forEach((element) => element.flag = selTodos);

    _repository.selectTodosTempAluno(selTodos);
  }

  onCopiarAula(int idAula) {
    _repository.copiarAula(idAula);
  }

  //#region Pesquisa
  @observable
  bool isSearching = false;
  TextEditingController searchQueryController = TextEditingController();

  void updateSearchQuery(String newQuery) {
    onGetTempAlunosLista(newQuery);
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
