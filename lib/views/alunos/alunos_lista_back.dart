import 'package:controle_alunos_musica_ft/core/my_app.dart';
import 'package:controle_alunos_musica_ft/database/dao/alunos_dao.dart';
import 'package:controle_alunos_musica_ft/entities/alunos.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'alunos_lista_back.g.dart';

class AlunosListaBack = _AlunosListaBack with _$AlunosListaBack;

abstract class _AlunosListaBack with Store {
  var _dao = AlunosDAO();

  _AlunosListaBack() {
    CarregaLista();
  }

  @observable
  Future<List<Alunos>>? lstEntities;

  @action
  CarregaLista([dynamic TextPesquisa]) {
    lstEntities = _dao.GetLista(TextPesquisa);
  }

  GoToForm(BuildContext context, [Alunos? aluno]) {
    Navigator.of(context)
        .pushNamed(MyApp().ALUNOS_FORM, arguments: aluno)
        .then(CarregaLista);
  }

  Delete(int id) {
    _dao.Delete(id);
    CarregaLista();
  }

  //#region Pesquisa
  @observable
  bool isSearching = false;
  TextEditingController searchQueryController = TextEditingController();

  void updateSearchQuery(String newQuery) {
    CarregaLista(newQuery);
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
