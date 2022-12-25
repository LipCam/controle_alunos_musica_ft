// ignore_for_file: library_private_types_in_public_api

import 'package:controle_alunos_musica_ft/config/my_app.dart';
import 'package:controle_alunos_musica_ft/database/dao/instrutores_dao.dart';
import 'package:controle_alunos_musica_ft/entities/instrutores.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'instrutores_form_back.g.dart';

class InstrutoresFormBack = _InstrutoresFormBack with _$InstrutoresFormBack;

abstract class _InstrutoresFormBack with Store {
  Instrutores? instrutor;
  final _dao = InstrutoresDAO();

  _InstrutoresFormBack(BuildContext context) {
    var parameter = ModalRoute.of(context)?.settings.arguments;
    instrutor = parameter == null ? Instrutores() : parameter as Instrutores;
    novoReg = instrutor?.idInstrutor == null;
  }

  @observable
  bool novoReg = true;

  Future<int> onSave() async {
    return await _dao.onSave(instrutor!);
  }

  String? validaNome(String? nome) {
    if (nome == null || nome == "") return "Informe o Nome";
    return null;
  }

  onDelete(int id) {
    _dao.onDelete(id);
  }

  onGoToInstrutoresLista(BuildContext context, Instrutores instrutor) {
    Navigator.of(context)
        .pushNamed(MyApp().instrutoresLista, arguments: instrutor);
  }
}
