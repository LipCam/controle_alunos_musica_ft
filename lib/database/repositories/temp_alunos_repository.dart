import 'package:controle_alunos_musica_ft/database/connection.dart';
import 'package:controle_alunos_musica_ft/models/temp_alunos.dart';
import 'package:sqflite/sqflite.dart';

class TempAlunosRepository {
  Database? _db;

  Future carregaTempAlunosLista() async {
    _db = await Connection.Get();

    await _db!.rawDelete('''DELETE FROM TEMP_ALUNOS_TAB''');

    await _db!.rawInsert(
        '''INSERT INTO TEMP_ALUNOS_TAB (ID_ALUNO_INT, NOME_STR, INSTRUMENTO_STR, FLAG_BIT)
            SELECT ID_ALUNO_INT,
                  NOME_STR,
                  INSTRUMENTO_STR,
                  0
                FROM CAD_ALUNOS_TAB
                ORDER BY NOME_STR''');
  }

  Future<List<TempAlunos>> getTempAlunosLista(String? textPesquisa) async {
    _db = await Connection.Get();

    List<Map<String, dynamic>> lstMap = await _db!.rawQuery('''SELECT *
                FROM TEMP_ALUNOS_TAB
                WHERE NOME_STR LIKE ?
                ORDER BY NOME_STR''',
        [(textPesquisa != null ? "%$textPesquisa%" : "%%")]);

    List<TempAlunos> lstEntities = List.generate(
      lstMap.length,
      (i) {
        var linha = lstMap[i];
        return TempAlunos(
          idAluno: linha["ID_ALUNO_INT"],
          nome: linha["NOME_STR"],
          instrumento: linha["INSTRUMENTO_STR"] ?? "",
          flag: linha["FLAG_BIT"] == 0 ? false : true,
        );
      },
    );

    return lstEntities;
  }

  selectTempAluno(int idAluno) async {
    _db = await Connection.Get();

    String sql = '''UPDATE TEMP_ALUNOS_TAB SET FLAG_BIT = NOT FLAG_BIT
                    WHERE ID_ALUNO_INT = ?''';
    _db!.rawUpdate(sql, [idAluno]);
  }

  selectTodosTempAluno(bool selTodos) async {
    _db = await Connection.Get();

    String sql = '''UPDATE TEMP_ALUNOS_TAB SET FLAG_BIT = ?''';
    _db!.rawUpdate(sql, [selTodos]);
  }

  copiarAula(int idAula) async {
    _db = await Connection.Get();

    String sql =
        '''INSERT INTO CAD_AULAS_TAB (ID_ALUNO_INT, ID_TIPO_INT, ID_INSTRUTOR_INT, DATA_DTI, 
                      CONCLUIDO_BIT, ASSUNTO_STR, OBSERVACAO_STR)
                    SELECT TEMP.ID_ALUNO_INT, ID_TIPO_INT, ID_INSTRUTOR_INT, DATA_DTI, 
                      CONCLUIDO_BIT, ASSUNTO_STR, OBSERVACAO_STR
                    FROM CAD_AULAS_TAB AL
                    INNER JOIN TEMP_ALUNOS_TAB TEMP ON 1=1
                    WHERE ID_AULA_INT = ? AND TEMP.FLAG_BIT = 1 AND TEMP.ID_ALUNO_INT <> AL.ID_ALUNO_INT''';
    await _db!.rawInsert(sql, [idAula]);
  }
}
