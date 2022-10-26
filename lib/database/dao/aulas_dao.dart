import 'package:controle_alunos_musica_ft/database/connection.dart';
import 'package:controle_alunos_musica_ft/entities/alunos.dart';
import 'package:controle_alunos_musica_ft/entities/aulas.dart';
import 'package:controle_alunos_musica_ft/entities/tipos_aula.dart';
import 'package:sqflite/sqflite.dart';

class AulasDAO {
  Database? _db;

  Future<List<Aulas>> GetLista(
      String? DataIni, String? DataFim, int? ID_ALUNO_INT) async {
    _db = await Connection.Get();

    List<Map<String, dynamic>> lstMap;

    if (ID_ALUNO_INT == null) {
      lstMap = await _db!.rawQuery(
          '''SELECT A.*, AL.NOME_STR AS ALUNO_STR, TP.DESCRICAO_STR AS TIPO_STR,
                CASE WHEN A.CONCLUIDO_BIT = 0 THEN 'Pendente' ELSE 'Concluído' END AS CONCLUIDO_STR
                FROM CAD_AULAS_TAB A
                INNER JOIN CAD_ALUNOS_TAB AL ON AL.ID_ALUNO_INT = A.ID_ALUNO_INT
                INNER JOIN SIS_TIPOS_AULA_TAB TP ON TP.ID_TIPO_INT = A.ID_TIPO_INT
                WHERE DATE(DATA_DTI) BETWEEN ? AND ?
                ORDER BY DATA_DTI''', [DataIni, DataFim]);
    } else {
      lstMap = await _db!.rawQuery(
          '''SELECT A.*, AL.NOME_STR AS ALUNO_STR, TP.DESCRICAO_STR AS TIPO_STR,
                CASE WHEN A.CONCLUIDO_BIT = 0 THEN 'Pendente' ELSE 'Concluído' END AS CONCLUIDO_STR
                FROM CAD_AULAS_TAB A
                INNER JOIN CAD_ALUNOS_TAB AL ON AL.ID_ALUNO_INT = A.ID_ALUNO_INT
                INNER JOIN SIS_TIPOS_AULA_TAB TP ON TP.ID_TIPO_INT = A.ID_TIPO_INT
                WHERE A.ID_ALUNO_INT = ?
                ORDER BY DATA_DTI DESC''', [ID_ALUNO_INT]);
    }

    //List<Map<String, dynamic>> lstMap = await _db!.query("CAD_AULAS_TAB");
    List<Aulas> lstEntities = List.generate(lstMap.length, (i) {
      var linha = lstMap[i];
      return Aulas(
        ID_AULA_INT: linha["ID_AULA_INT"],
        ID_ALUNO_INT: linha["ID_ALUNO_INT"],
        ALUNO_STR: linha["ALUNO_STR"],
        ID_TIPO_INT: linha["ID_TIPO_INT"],
        TIPO_STR: linha["TIPO_STR"],
        INSTRUTOR_STR: linha["INSTRUTOR_STR"],
        DATA_DTI: DateTime.parse(linha["DATA_DTI"]),
        CONCLUIDO_BIT: linha["CONCLUIDO_BIT"] == 1 ? true : false,
        CONCLUIDO_STR: linha["CONCLUIDO_STR"],
        ASSUNTO_STR: linha["ASSUNTO_STR"],
        OBSERVACAO_STR: linha["OBSERVACAO_STR"],
      );
    });

    return lstEntities;
  }

  Future<List<Alunos>> GetAlunos() async {
    _db = await Connection.Get();

    List<Map<String, dynamic>> lstMap =
        await _db!.query("CAD_ALUNOS_TAB", orderBy: "NOME_STR");
    List<Alunos> lstEntities = List.generate(lstMap.length, (i) {
      var linha = lstMap[i];
      return Alunos(
        ID_ALUNO_INT: linha["ID_ALUNO_INT"],
        NOME_STR: linha["NOME_STR"],
      );
    });

    return lstEntities;
  }

  Future<List<TiposAula>> GetTipos() async {
    _db = await Connection.Get();

    List<Map<String, dynamic>> lstMap = await _db!.query("SIS_TIPOS_AULA_TAB");
    List<TiposAula> lstEntities = List.generate(lstMap.length, (i) {
      var linha = lstMap[i];
      return TiposAula(
          ID_TIPO_INT: linha["ID_TIPO_INT"],
          DESCRICAO_STR: linha["DESCRICAO_STR"]);
    });

    return lstEntities;
  }

  Future<int> Save(Aulas aula) async {
    _db = await Connection.Get();
    String sql;
    if (aula.ID_AULA_INT == null) {
      sql =
          '''INSERT INTO CAD_AULAS_TAB (ID_ALUNO_INT, ID_TIPO_INT, INSTRUTOR_STR, DATA_DTI, 
              CONCLUIDO_BIT, ASSUNTO_STR, OBSERVACAO_STR)
              VALUES (?,?,?,?,?,?,?)''';
      int id = await _db!.rawInsert(sql, [
        aula.ID_ALUNO_INT,
        aula.ID_TIPO_INT,
        aula.INSTRUTOR_STR,
        aula.DATA_DTI.toString(),
        aula.CONCLUIDO_BIT,
        aula.ASSUNTO_STR,
        aula.OBSERVACAO_STR
      ]);

      return id;
    } else {
      sql =
          '''UPDATE CAD_AULAS_TAB SET ID_ALUNO_INT = ?, ID_TIPO_INT = ?, INSTRUTOR_STR = ?,
              DATA_DTI = ?, CONCLUIDO_BIT = ?, ASSUNTO_STR = ?, OBSERVACAO_STR = ?
              WHERE ID_AULA_INT = ?''';
      _db!.rawUpdate(sql, [
        aula.ID_ALUNO_INT,
        aula.ID_TIPO_INT,
        aula.INSTRUTOR_STR,
        aula.DATA_DTI.toString(),
        aula.CONCLUIDO_BIT,
        aula.ASSUNTO_STR,
        aula.OBSERVACAO_STR,
        aula.ID_AULA_INT
      ]);

      return aula.ID_AULA_INT!;
    }
  }

  Delete(int id) async {
    _db = await Connection.Get();
    String sql = '''DELETE FROM CAD_AULAS_TAB
                    WHERE ID_AULA_INT = ?''';
    _db!.rawDelete(sql, [id]);
  }
}
