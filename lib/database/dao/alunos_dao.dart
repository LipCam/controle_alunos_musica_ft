import 'package:controle_alunos_musica_ft/database/connection.dart';
import 'package:controle_alunos_musica_ft/entities/alunos.dart';
import 'package:controle_alunos_musica_ft/entities/status_alunos.dart';
import 'package:sqflite/sqflite.dart';

class AlunosDAO {
  Database? _db;

  Future<List<Alunos>> GetLista(String? TextPesquisa) async {
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
        [(TextPesquisa != null ? "%" + TextPesquisa + "%" : "%%")]);

    //List<Map<String, dynamic>> lstMap = await _db!.query("CAD_ALUNOS_TAB");

    List<Alunos> lstEntities = List.generate(lstMap.length, (i) {
      var linha = lstMap[i];
      return Alunos(
        ID_ALUNO_INT: linha["ID_ALUNO_INT"],
        NOME_STR: linha["NOME_STR"],
        ID_STATUS_INT: linha["ID_STATUS_INT"],
        STATUS_STR: linha["STATUS_STR"],
        INSTRUMENTO_STR: linha["INSTRUMENTO_STR"],
        METODO_STR: linha["METODO_STR"],
        FONE_STR: linha["FONE_STR"],
        DATA_NASCIMENTO_DTI: linha["DATA_NASCIMENTO_DTI"] != null
            ? DateTime.parse(linha["DATA_NASCIMENTO_DTI"])
            : null,
        DATA_BATISMO_DTI: linha["DATA_BATISMO_DTI"] != null
            ? DateTime.parse(linha["DATA_BATISMO_DTI"])
            : null,
        DATA_INICIO_GEM_DTI: linha["DATA_INICIO_GEM_DTI"] != null
            ? DateTime.parse(linha["DATA_INICIO_GEM_DTI"])
            : null,
        DATA_OFICIALIZACAO_DTI: linha["DATA_OFICIALIZACAO_DTI"] != null
            ? DateTime.parse(linha["DATA_OFICIALIZACAO_DTI"])
            : null,
        ENDERECO_STR: linha["ENDERECO_STR"],
        OBSERVACAO_STR: linha["OBSERVACAO_STR"],
      );
    });

    return lstEntities;
  }

  Future<List<StatusAlunos>> GetStatus() async {
    _db = await Connection.Get();

    List<Map<String, dynamic>> lstMap =
        await _db!.query("SIS_STATUS_ALUNOS_TAB");
    List<StatusAlunos> lstEntities = List.generate(lstMap.length, (i) {
      var linha = lstMap[i];
      return StatusAlunos(
          ID_STATUS_INT: linha["ID_STATUS_INT"],
          DESCRICAO_STR: linha["DESCRICAO_STR"]);
    });

    return lstEntities;
  }

  Future<int> Save(Alunos aluno) async {
    _db = await Connection.Get();
    String sql;
    if (aluno.ID_ALUNO_INT == null) {
      sql =
          '''INSERT INTO CAD_ALUNOS_TAB (NOME_STR, ID_STATUS_INT, INSTRUMENTO_STR,
              METODO_STR, FONE_STR, DATA_NASCIMENTO_DTI, DATA_BATISMO_DTI, DATA_INICIO_GEM_DTI,
              DATA_OFICIALIZACAO_DTI, ENDERECO_STR, OBSERVACAO_STR)
              VALUES (?,?,?,?,?,?,?,?,?,?,?)''';
      int id = await _db!.rawInsert(sql, [
        aluno.NOME_STR,
        aluno.ID_STATUS_INT,
        aluno.INSTRUMENTO_STR,
        aluno.METODO_STR,
        aluno.FONE_STR,
        aluno.DATA_NASCIMENTO_DTI != null
            ? aluno.DATA_NASCIMENTO_DTI.toString()
            : null,
        aluno.DATA_BATISMO_DTI != null
            ? aluno.DATA_BATISMO_DTI.toString()
            : null,
        aluno.DATA_INICIO_GEM_DTI != null
            ? aluno.DATA_INICIO_GEM_DTI.toString()
            : null,
        aluno.DATA_OFICIALIZACAO_DTI != null
            ? aluno.DATA_OFICIALIZACAO_DTI.toString()
            : null,
        aluno.ENDERECO_STR,
        aluno.OBSERVACAO_STR
      ]);

      return id;
    } else {
      sql =
          '''UPDATE CAD_ALUNOS_TAB SET NOME_STR = ?, ID_STATUS_INT = ?, INSTRUMENTO_STR = ?,
              METODO_STR = ?, FONE_STR = ?, DATA_NASCIMENTO_DTI = ?, DATA_BATISMO_DTI = ?, DATA_INICIO_GEM_DTI = ?,
              DATA_OFICIALIZACAO_DTI = ?, ENDERECO_STR = ?, OBSERVACAO_STR = ?
              WHERE ID_ALUNO_INT = ?''';
      _db!.rawUpdate(sql, [
        aluno.NOME_STR,
        aluno.ID_STATUS_INT,
        aluno.INSTRUMENTO_STR,
        aluno.METODO_STR,
        aluno.FONE_STR,
        aluno.DATA_NASCIMENTO_DTI != null
            ? aluno.DATA_NASCIMENTO_DTI.toString()
            : null,
        aluno.DATA_BATISMO_DTI != null
            ? aluno.DATA_BATISMO_DTI.toString()
            : null,
        aluno.DATA_INICIO_GEM_DTI != null
            ? aluno.DATA_INICIO_GEM_DTI.toString()
            : null,
        aluno.DATA_OFICIALIZACAO_DTI != null
            ? aluno.DATA_OFICIALIZACAO_DTI.toString()
            : null,
        aluno.ENDERECO_STR,
        aluno.OBSERVACAO_STR,
        aluno.ID_ALUNO_INT
      ]);

      return aluno.ID_ALUNO_INT!;
    }
  }

  Delete(int id) async {
    _db = await Connection.Get();

    String sql = '''DELETE FROM CAD_AULAS_TAB
                    WHERE ID_ALUNO_INT = ?''';
    _db!.rawDelete(sql, [id]);

    sql = '''DELETE FROM CAD_ALUNOS_TAB
                    WHERE ID_ALUNO_INT = ?''';
    _db!.rawDelete(sql, [id]);
  }
}
