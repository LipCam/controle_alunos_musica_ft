// ignore_for_file: library_private_types_in_public_api

import 'package:controle_alunos_musica_ft/config/my_app.dart';
import 'package:controle_alunos_musica_ft/database/dao/alunos_dao.dart';
import 'package:controle_alunos_musica_ft/entities/alunos.dart';
import 'package:controle_alunos_musica_ft/entities/status_alunos.dart';
import 'package:controle_alunos_musica_ft/views/alunos/relatorio/relatorio_alunos.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'alunos_form_back.g.dart';

class AlunosFormBack = _AlunosFormBack with _$AlunosFormBack;

abstract class _AlunosFormBack with Store {
  Alunos? aluno;
  final _dao = AlunosDAO();

  _AlunosFormBack(BuildContext context) {
    var parameter = ModalRoute.of(context)?.settings.arguments;
    aluno = parameter == null ? Alunos() : parameter as Alunos;
    novoReg = aluno?.idAluno == null;
  }

  @observable
  bool novoReg = true;

  Future<List<StatusAlunos>> onGetStatus() {
    return _dao.onGetStatus();
  }

  Future<int> onSave() async {
    return await _dao.onSave(aluno!);
  }

  String? validaNome(String? nome) {
    if (nome == null || nome == "") return "Informe o Nome";
    return null;
  }

  onDelete(int id) {
    _dao.onDelete(id);
  }

  onGoToAulasLista(BuildContext context, Alunos aluno) {
    Navigator.of(context).pushNamed(MyApp().aulasLista, arguments: aluno);
  }

  Future<void> onGeraRelatorio(int idAluno) async {
    RelatorioAlunos().onGeraRelatorio(idAluno);
  }
}
