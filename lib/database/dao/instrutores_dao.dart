import 'package:controle_alunos_musica_ft/database/connection.dart';
import 'package:controle_alunos_musica_ft/entities/instrutores.dart';
import 'package:sqflite/sqflite.dart';

class InstrutoresDAO {
  Database? _db;

  Future<List<Instrutores>> onGetLista(String? textPesquisa) async {
    _db = await Connection.Get();

    List<Map<String, dynamic>> lstMap = await _db!.rawQuery('''SELECT *
                FROM CAD_INSTRUTORES_TAB
                WHERE NOME_STR LIKE ?
                ORDER BY NOME_STR''',
        [(textPesquisa != null ? "%$textPesquisa%" : "%%")]);

    List<Instrutores> lstEntities = List.generate(lstMap.length, (i) {
      var linha = lstMap[i];
      return Instrutores(
        idInstrutor: linha["ID_INSTRUTOR_INT"],
        nome: linha["NOME_STR"],
        instrumento: linha["INSTRUMENTO_STR"],
        fone: linha["FONE_STR"],
        dataNascimento: linha["DATA_NASCIMENTO_DTI"] != null
            ? DateTime.parse(linha["DATA_NASCIMENTO_DTI"])
            : null,
        dataOficializacao: linha["DATA_OFICIALIZACAO_DTI"] != null
            ? DateTime.parse(linha["DATA_OFICIALIZACAO_DTI"])
            : null,
        endereco: linha["ENDERECO_STR"],
      );
    });

    return lstEntities;
  }

  Future<List<Instrutores>> onGetCmb() async {
    _db = await Connection.Get();

    List<Map<String, dynamic>> lstMap =
        await _db!.query("CAD_INSTRUTORES_TAB", orderBy: "NOME_STR");
    List<Instrutores> lstEntities = List.generate(lstMap.length, (i) {
      var linha = lstMap[i];
      return Instrutores(
        idInstrutor: linha["ID_INSTRUTOR_INT"],
        nome: linha["NOME_STR"],
      );
    });

    return lstEntities;
  }

  Future<int> onSave(Instrutores instrutor) async {
    _db = await Connection.Get();
    String sql;
    if (instrutor.idInstrutor == null) {
      sql =
          '''INSERT INTO CAD_INSTRUTORES_TAB (NOME_STR, INSTRUMENTO_STR, FONE_STR, 
               DATA_NASCIMENTO_DTI, DATA_OFICIALIZACAO_DTI, ENDERECO_STR)
               VALUES (?,?,?,?,?,?)''';
      int id = await _db!.rawInsert(sql, [
        instrutor.nome,
        instrutor.instrumento,
        instrutor.fone,
        if (instrutor.dataNascimento != null)
          instrutor.dataNascimento.toString()
        else
          null,
        if (instrutor.dataOficializacao != null)
          instrutor.dataOficializacao.toString()
        else
          null,
        instrutor.endereco
      ]);

      return id;
    } else {
      sql =
          '''UPDATE CAD_INSTRUTORES_TAB SET NOME_STR = ?, INSTRUMENTO_STR = ?, FONE_STR = ?, 
             DATA_NASCIMENTO_DTI = ?, DATA_OFICIALIZACAO_DTI = ?, ENDERECO_STR = ?
             WHERE ID_INSTRUTOR_INT = ?''';
      _db!.rawUpdate(sql, [
        instrutor.nome,
        instrutor.instrumento,
        instrutor.fone,
        if (instrutor.dataNascimento != null)
          instrutor.dataNascimento.toString()
        else
          null,
        if (instrutor.dataOficializacao != null)
          instrutor.dataOficializacao.toString()
        else
          null,
        instrutor.endereco,
        instrutor.idInstrutor
      ]);

      return instrutor.idInstrutor!;
    }
  }

  onDelete(int id) async {
    _db = await Connection.Get();

    String sql = '''DELETE FROM CAD_INSTRUTORES_TAB
                    WHERE ID_INSTRUTOR_INT = ?''';
    _db!.rawDelete(sql, [id]);
  }
}
