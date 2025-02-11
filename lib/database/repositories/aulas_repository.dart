import 'package:controle_alunos_musica_ft/config/app_string_formats.dart';
import 'package:controle_alunos_musica_ft/database/connection.dart';
import 'package:controle_alunos_musica_ft/models/aulas.dart';
import 'package:controle_alunos_musica_ft/models/aulas_dash.dart';
import 'package:controle_alunos_musica_ft/models/tipos_aula.dart';
import 'package:sqflite/sqflite.dart';

class AulasRepository {
  Database? _db;

  Future<List<Aulas>> onGetLista(
      String? dataIni, String? dataFim, int? idAlunoInt) async {
    _db = await Connection.Get();

    List<Map<String, dynamic>> lstMap;

    if (idAlunoInt == null) {
      lstMap = await _db!.rawQuery('''SELECT A.*, 
                AL.NOME_STR AS ALUNO_STR, 
                INST.NOME_STR AS INSTRUTOR_STR,
                TP.DESCRICAO_STR AS TIPO_STR,
                CASE WHEN A.CONCLUIDO_BIT = 0 THEN 'Pendente' ELSE 'Concluído' END AS CONCLUIDO_STR
                FROM CAD_AULAS_TAB A
                INNER JOIN CAD_ALUNOS_TAB AL ON AL.ID_ALUNO_INT = A.ID_ALUNO_INT
                INNER JOIN CAD_INSTRUTORES_TAB INST ON INST.ID_INSTRUTOR_INT = A.ID_INSTRUTOR_INT
                INNER JOIN SIS_TIPOS_AULA_TAB TP ON TP.ID_TIPO_INT = A.ID_TIPO_INT
                WHERE DATE(DATA_DTI) BETWEEN ? AND ?
                ORDER BY DATA_DTI''', [dataIni, dataFim]);
    } else {
      lstMap = await _db!.rawQuery('''SELECT A.*, 
                AL.NOME_STR AS ALUNO_STR, 
                INST.NOME_STR AS INSTRUTOR_STR,
                TP.DESCRICAO_STR AS TIPO_STR,
                CASE WHEN A.CONCLUIDO_BIT = 0 THEN 'Pendente' ELSE 'Concluído' END AS CONCLUIDO_STR
                FROM CAD_AULAS_TAB A
                INNER JOIN CAD_ALUNOS_TAB AL ON AL.ID_ALUNO_INT = A.ID_ALUNO_INT
                INNER JOIN CAD_INSTRUTORES_TAB INST ON INST.ID_INSTRUTOR_INT = A.ID_INSTRUTOR_INT
                INNER JOIN SIS_TIPOS_AULA_TAB TP ON TP.ID_TIPO_INT = A.ID_TIPO_INT
                WHERE A.ID_ALUNO_INT = ?
                ORDER BY DATA_DTI DESC''', [idAlunoInt]);
    }

    //List<Map<String, dynamic>> lstMap = await _db!.query("CAD_AULAS_TAB");
    List<Aulas> lstEntities = List.generate(lstMap.length, (i) {
      var linha = lstMap[i];
      return Aulas(
        idAula: linha["ID_AULA_INT"],
        idAluno: linha["ID_ALUNO_INT"],
        aluno: linha["ALUNO_STR"],
        instrutor: linha["INSTRUTOR_STR"],
        idTipo: linha["ID_TIPO_INT"],
        tipo: linha["TIPO_STR"],
        idInstrutor: linha["ID_INSTRUTOR_INT"],
        data: DateTime.parse(linha["DATA_DTI"]),
        concluido: linha["CONCLUIDO_BIT"] == 1 ? true : false,
        concluidoStr: linha["CONCLUIDO_STR"],
        assunto: linha["ASSUNTO_STR"],
        observacao: linha["OBSERVACAO_STR"],
      );
    });

    return lstEntities;
  }

  Future<List<TiposAula>> onGetTiposCmb() async {
    _db = await Connection.Get();

    List<Map<String, dynamic>> lstMap = await _db!.query("SIS_TIPOS_AULA_TAB");
    List<TiposAula> lstEntities = List.generate(lstMap.length, (i) {
      var linha = lstMap[i];
      return TiposAula(
          idTipo: linha["ID_TIPO_INT"], descricao: linha["DESCRICAO_STR"]);
    });

    return lstEntities;
  }

  Future<int> onSave(Aulas aula) async {
    _db = await Connection.Get();
    String sql;
    if (aula.idAula == null) {
      sql =
          '''INSERT INTO CAD_AULAS_TAB (ID_ALUNO_INT, ID_TIPO_INT, ID_INSTRUTOR_INT, DATA_DTI, 
              CONCLUIDO_BIT, ASSUNTO_STR, OBSERVACAO_STR)
              VALUES (?,?,?,?,?,?,?)''';
      int id = await _db!.rawInsert(sql, [
        aula.idAluno,
        aula.idTipo,
        aula.idInstrutor,
        aula.data.toString(),
        aula.concluido,
        aula.assunto,
        aula.observacao
      ]);

      return id;
    } else {
      sql =
          '''UPDATE CAD_AULAS_TAB SET ID_ALUNO_INT = ?, ID_TIPO_INT = ?, ID_INSTRUTOR_INT = ?,
              DATA_DTI = ?, CONCLUIDO_BIT = ?, ASSUNTO_STR = ?, OBSERVACAO_STR = ?
              WHERE ID_AULA_INT = ?''';
      _db!.rawUpdate(sql, [
        aula.idAluno,
        aula.idTipo,
        aula.idInstrutor,
        aula.data.toString(),
        aula.concluido,
        aula.assunto,
        aula.observacao,
        aula.idAula
      ]);

      return aula.idAula!;
    }
  }

  onDelete(int id) async {
    _db = await Connection.Get();
    String sql = '''DELETE FROM CAD_AULAS_TAB
                    WHERE ID_AULA_INT = ?''';
    _db!.rawDelete(sql, [id]);
  }

  //----- Dash home -----
  Future<AulasDash> onGetAulasHojeDash() async {
    _db = await Connection.Get();

    List<Map<String, dynamic>> lstMap;

    lstMap = await _db!.rawQuery('''SELECT COUNT(1) AS QTD_INT
              FROM CAD_AULAS_TAB
              WHERE DATE(DATA_DTI) = ?''',
        [getDateFormat_yyyy_MM_dd(DateTime.now())]);

    return AulasDash(
      descricao: "Hoje",
      qtd: lstMap[0]["QTD_INT"],
    );
  }

  Future<AulasDash> onGetAulasMesDash() async {
    _db = await Connection.Get();

    List<Map<String, dynamic>> lstMap;

    lstMap = await _db!.rawQuery('''SELECT COUNT(1) AS QTD_INT
              FROM CAD_AULAS_TAB
              WHERE CAST(STRFTIME('%Y', DATA_DTI) AS INTEGER) = ? AND CAST(STRFTIME('%m', DATA_DTI) AS INTEGER) = ?''',
        [DateTime.now().year, DateTime.now().month]);

    return AulasDash(
      descricao: "Este Mês",
      qtd: lstMap[0]["QTD_INT"],
    );
  }

  Future<AulasDash> onGetAulasAnoDash() async {
    _db = await Connection.Get();

    List<Map<String, dynamic>> lstMap;

    lstMap = await _db!.rawQuery('''SELECT COUNT(1) AS QTD_INT
              FROM CAD_AULAS_TAB
              WHERE CAST(STRFTIME('%Y', DATA_DTI) AS INTEGER) = ?''',
        [DateTime.now().year]);

    return AulasDash(
      descricao: "Este Ano",
      qtd: lstMap[0]["QTD_INT"],
    );
  }

  Future<List<AulasDash>> onGetAulasInstrutoresDash() async {
    _db = await Connection.Get();

    List<Map<String, dynamic>> lstMap;

    lstMap = await _db!
        .rawQuery('''SELECT INS.NOME_STR AS INSTRUTOR_STR, COUNT(1) QTD_INT
                FROM CAD_AULAS_TAB AU
                INNER JOIN CAD_INSTRUTORES_TAB INS ON INS.ID_INSTRUTOR_INT = AU.ID_INSTRUTOR_INT
                GROUP BY AU.ID_INSTRUTOR_INT
                ORDER BY COUNT(AU.ID_AULA_INT) DESC''');

    // lstMap = await _db!.rawQuery(
    //     '''SELECT INS.NOME_STR AS INSTRUTOR_STR, COUNT(AU.ID_AULA_INT) QTD_INT
    //             FROM CAD_INSTRUTORES_TAB INS
    //             left JOIN CAD_AULAS_TAB AU ON INS.ID_INSTRUTOR_INT = AU.ID_INSTRUTOR_INT
    //             GROUP BY INS.ID_INSTRUTOR_INT
    //             ORDER BY COUNT(AU.ID_AULA_INT) DESC''');

    List<AulasDash> lstEntities = List.generate(lstMap.length, (i) {
      var linha = lstMap[i];
      return AulasDash(
        descricao: linha["INSTRUTOR_STR"],
        qtd: linha["QTD_INT"],
      );
    });

    return lstEntities;
  }
}
