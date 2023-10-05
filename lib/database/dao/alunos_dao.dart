import 'package:controle_alunos_musica_ft/database/connection.dart';
import 'package:controle_alunos_musica_ft/models/alunos.dart';
import 'package:controle_alunos_musica_ft/models/alunos_dash.dart';
import 'package:controle_alunos_musica_ft/models/status_alunos.dart';
import 'package:sqflite/sqflite.dart';

class AlunosDAO {
  Database? _db;

  Future<List<Alunos>> onGetLista(String? textPesquisa) async {
    _db = await Connection.Get();

    List<Map<String, dynamic>> lstMap = await _db!.rawQuery('''SELECT A.*, 
                  CASE WHEN A.ID_STATUS_INT IN (1,2,3,4) THEN 
                    S.DESCRICAO_STR || IFNULL(' - Iní. GEM ' || strftime('%d/%m/%Y',A.DATA_INICIO_GEM_DTI ), '')
                  ELSE 	
                    S.DESCRICAO_STR || IFNULL(' - ' || strftime('%d/%m/%Y',A.DATA_OFICIALIZACAO_DTI ), '') 
                  END AS STATUS_STR
                FROM CAD_ALUNOS_TAB A
                INNER JOIN SIS_STATUS_ALUNOS_TAB S ON S.ID_STATUS_INT = A.ID_STATUS_INT
                WHERE A.NOME_STR LIKE ?
                ORDER BY NOME_STR''',
        [(textPesquisa != null ? "%$textPesquisa%" : "%%")]);

    //List<Map<String, dynamic>> lstMap = await _db!.query("CAD_ALUNOS_TAB");

    List<Alunos> lstEntities = List.generate(lstMap.length, (i) {
      var linha = lstMap[i];
      return Alunos(
        idAluno: linha["ID_ALUNO_INT"],
        nome: linha["NOME_STR"],
        idStatus: linha["ID_STATUS_INT"],
        status: linha["STATUS_STR"],
        instrumento: linha["INSTRUMENTO_STR"],
        metodo: linha["METODO_STR"],
        fone: linha["FONE_STR"],
        dataNascimento: linha["DATA_NASCIMENTO_DTI"] != null
            ? DateTime.parse(linha["DATA_NASCIMENTO_DTI"])
            : null,
        dataBatismo: linha["DATA_BATISMO_DTI"] != null
            ? DateTime.parse(linha["DATA_BATISMO_DTI"])
            : null,
        dataInicioGEM: linha["DATA_INICIO_GEM_DTI"] != null
            ? DateTime.parse(linha["DATA_INICIO_GEM_DTI"])
            : null,
        dataOficializacao: linha["DATA_OFICIALIZACAO_DTI"] != null
            ? DateTime.parse(linha["DATA_OFICIALIZACAO_DTI"])
            : null,
        endereco: linha["ENDERECO_STR"],
        observacao: linha["OBSERVACAO_STR"],
      );
    });

    return lstEntities;
  }

  Future<List<Alunos>> onGetCmb() async {
    _db = await Connection.Get();

    List<Map<String, dynamic>> lstMap =
        await _db!.query("CAD_ALUNOS_TAB", orderBy: "NOME_STR");
    List<Alunos> lstEntities = List.generate(lstMap.length, (i) {
      var linha = lstMap[i];
      return Alunos(
        idAluno: linha["ID_ALUNO_INT"],
        nome: linha["NOME_STR"],
      );
    });

    return lstEntities;
  }

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

  Future<int> onSave(Alunos aluno) async {
    _db = await Connection.Get();
    String sql;
    if (aluno.idAluno == null) {
      sql =
          '''INSERT INTO CAD_ALUNOS_TAB (NOME_STR, ID_STATUS_INT, INSTRUMENTO_STR,
              METODO_STR, FONE_STR, DATA_NASCIMENTO_DTI, DATA_BATISMO_DTI, DATA_INICIO_GEM_DTI,
              DATA_OFICIALIZACAO_DTI, ENDERECO_STR, OBSERVACAO_STR)
              VALUES (?,?,?,?,?,?,?,?,?,?,?)''';
      int id = await _db!.rawInsert(sql, [
        aluno.nome,
        aluno.idStatus,
        aluno.instrumento,
        aluno.metodo,
        aluno.fone,
        if (aluno.dataNascimento != null)
          aluno.dataNascimento.toString()
        else
          null,
        if (aluno.dataBatismo != null) aluno.dataBatismo.toString() else null,
        if (aluno.dataInicioGEM != null)
          aluno.dataInicioGEM.toString()
        else
          null,
        if (aluno.dataOficializacao != null)
          aluno.dataOficializacao.toString()
        else
          null,
        aluno.endereco,
        aluno.observacao
      ]);

      return id;
    } else {
      sql =
          '''UPDATE CAD_ALUNOS_TAB SET NOME_STR = ?, ID_STATUS_INT = ?, INSTRUMENTO_STR = ?,
              METODO_STR = ?, FONE_STR = ?, DATA_NASCIMENTO_DTI = ?, DATA_BATISMO_DTI = ?, DATA_INICIO_GEM_DTI = ?,
              DATA_OFICIALIZACAO_DTI = ?, ENDERECO_STR = ?, OBSERVACAO_STR = ?
              WHERE ID_ALUNO_INT = ?''';
      _db!.rawUpdate(sql, [
        aluno.nome,
        aluno.idStatus,
        aluno.instrumento,
        aluno.metodo,
        aluno.fone,
        if (aluno.dataNascimento != null)
          aluno.dataNascimento.toString()
        else
          null,
        if (aluno.dataBatismo != null) aluno.dataBatismo.toString() else null,
        if (aluno.dataInicioGEM != null)
          aluno.dataInicioGEM.toString()
        else
          null,
        if (aluno.dataOficializacao != null)
          aluno.dataOficializacao.toString()
        else
          null,
        aluno.endereco,
        aluno.observacao,
        aluno.idAluno
      ]);

      return aluno.idAluno!;
    }
  }

  onDelete(int id) async {
    _db = await Connection.Get();

    String sql = '''DELETE FROM CAD_AULAS_TAB
                    WHERE ID_ALUNO_INT = ?''';
    _db!.rawDelete(sql, [id]);

    sql = '''DELETE FROM CAD_ALUNOS_TAB
                    WHERE ID_ALUNO_INT = ?''';
    _db!.rawDelete(sql, [id]);
  }

  //----- Dash home -----
  Future<List<AlunosDash>> onGetAlunosDash() async {
    _db = await Connection.Get();

    List<Map<String, dynamic>> lstMap;

    lstMap = await _db!
        .rawQuery('''SELECT ST.DESCRICAO_STR AS STATUS_STR, COUNT(1) QTD_INT
                FROM CAD_ALUNOS_TAB AL
                INNER JOIN SIS_STATUS_ALUNOS_TAB ST ON ST.ID_STATUS_INT = AL.ID_STATUS_INT
                GROUP BY ST.ID_STATUS_INT''');

    List<AlunosDash> lstEntities = List.generate(lstMap.length, (i) {
      var linha = lstMap[i];
      return AlunosDash(
        descricao: linha["STATUS_STR"],
        qtd: linha["QTD_INT"],
      );
    });

    lstMap =
        await _db!.rawQuery('''SELECT 'Total' AS DESCRICAO_STR, COUNT(1) QTD_INT
                FROM CAD_ALUNOS_TAB''');

    for (var element in lstMap) {
      lstEntities.add(AlunosDash(
        descricao: element["DESCRICAO_STR"],
        qtd: element["QTD_INT"],
      ));
    }

    return lstEntities;
  }
}
