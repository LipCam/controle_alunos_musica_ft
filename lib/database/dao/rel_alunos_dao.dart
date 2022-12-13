import 'package:controle_alunos_musica_ft/database/connection.dart';
import 'package:controle_alunos_musica_ft/entities/alunos.dart';
import 'package:controle_alunos_musica_ft/entities/aulas.dart';
import 'package:sqflite/sqflite.dart';

class RelAlunosDAO {
  Database? _db;

  Future<List<Alunos>> onGetAlunoRelatorio(int idAlunoInt) async {
    _db = await Connection.Get();

    List<Map<String, dynamic>> lstMap = await _db!.rawQuery(
        '''SELECT AL.ID_ALUNO_INT, AL.NOME_STR, ST.DESCRICAO_STR AS STATUS_STR, AL.INSTRUMENTO_STR, AL.METODO_STR,
                AL.FONE_STR, AL.DATA_NASCIMENTO_DTI, AL.DATA_BATISMO_DTI,
                AL.DATA_INICIO_GEM_DTI, AL.DATA_OFICIALIZACAO_DTI,
                AL.ENDERECO_STR
                FROM CAD_ALUNOS_TAB AL
                INNER JOIN SIS_STATUS_ALUNOS_TAB ST ON ST.ID_STATUS_INT = AL.ID_STATUS_INT
                WHERE AL.ID_ALUNO_INT = ?''', [idAlunoInt]);

    List<Alunos> lstEntities = List.generate(lstMap.length, (i) {
      var linha = lstMap[i];
      return Alunos(
          idAluno: linha["ID_ALUNO_INT"],
          nome: linha["NOME_STR"],
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
          endereco: linha["ENDERECO_STR"]);
    });

    return lstEntities;
  }

  Future<List<Aulas>> onGetAulasAlunoRelatorio(int idAlunoInt) async {
    _db = await Connection.Get();

    List<Map<String, dynamic>> lstMap =
        await _db!.rawQuery('''SELECT A.ID_ALUNO_INT, 
                A.DATA_DTI, TP.DESCRICAO_STR AS TIPO_STR, A.CONCLUIDO_BIT,
                CASE WHEN A.CONCLUIDO_BIT = 0 THEN 'Pendente' ELSE 'Concluído' END AS CONCLUIDO_STR,
                IFNULL(A.INSTRUTOR_STR, '') AS INSTRUTOR_STR, IFNULL(A.ASSUNTO_STR, '') AS ASSUNTO_STR
                FROM CAD_AULAS_TAB A
                INNER JOIN SIS_TIPOS_AULA_TAB TP ON TP.ID_TIPO_INT = A.ID_TIPO_INT
                WHERE A.ID_ALUNO_INT = ?
                ORDER BY A.DATA_DTI''', [idAlunoInt]);

    List<Aulas> lstEntities = List.generate(lstMap.length, (i) {
      var linha = lstMap[i];
      return Aulas(
        idAluno: linha["ID_ALUNO_INT"],
        tipo: linha["TIPO_STR"],
        instrutor: linha["INSTRUTOR_STR"],
        data: DateTime.parse(linha["DATA_DTI"]),
        concluido: linha["CONCLUIDO_BIT"] == 1 ? true : false,
        concluidoStr: linha["CONCLUIDO_STR"],
        assunto: linha["ASSUNTO_STR"],
      );
    });

    return lstEntities;
  }
}
