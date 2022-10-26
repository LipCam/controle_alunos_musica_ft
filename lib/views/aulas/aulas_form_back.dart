import 'package:controle_alunos_musica_ft/database/dao/aulas_dao.dart';
import 'package:controle_alunos_musica_ft/entities/alunos.dart';
import 'package:controle_alunos_musica_ft/entities/aulas.dart';
import 'package:controle_alunos_musica_ft/entities/tipos_aula.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'aulas_form_back.g.dart';

class AulasFormBack = _AulasFormBack with _$AulasFormBack;

abstract class _AulasFormBack with Store {
  Aulas? aula;
  var _dao = AulasDAO();

  _AulasFormBack(BuildContext context) {
    aula = ModalRoute.of(context)?.settings.arguments as Aulas;
    //var parameter = ModalRoute.of(context)?.settings.arguments;
    // aula = parameter == null
    //     ? Aulas(CONCLUIDO_BIT: false, DATA_DTI: DateTime.now())
    //     : parameter as Aulas;
    setData(aula!.DATA_DTI);
    NovoReg = aula?.ID_AULA_INT == null;
    Concluido = aula!.CONCLUIDO_BIT;
  }

  @observable
  bool NovoReg = true;

  @observable
  DateTime? Data;

  setData(DateTime dt) {
    Data = dt;
  }

  @observable
  bool? Concluido;

  Future<List<Alunos>> GetAlunos() {
    return _dao.GetAlunos();
  }

  Future<List<TiposAula>> GetTipos() {
    return _dao.GetTipos();
  }

  Future<int> Save() async {
    return await _dao.Save(aula!);
  }

  Delete(int id) {
    _dao.Delete(id);
  }
}
