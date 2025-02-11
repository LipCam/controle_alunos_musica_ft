import 'package:controle_alunos_musica_ft/database/connection.dart';
import 'package:controle_alunos_musica_ft/models/status_alunos.dart';
import 'package:sqflite/sqflite.dart';

class StatusAlunosRepository {
  Database? _db;

  Future<List<StatusAlunos>> onGetStatus() async {
    _db = await Connection.Get();

    List<Map<String, dynamic>> lstMap =
        await _db!.query("SIS_STATUS_ALUNOS_TAB");
    List<StatusAlunos> lstEntities = List.generate(lstMap.length, (i) {
      var linha = lstMap[i];
      return StatusAlunos(
          idStatus: linha["ID_STATUS_INT"], descricao: linha["DESCRICAO_STR"]);
    });

    return lstEntities;
  }
}
