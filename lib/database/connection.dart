// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Connection {
  static Database? _db;

  static Future<Database> Get() async {
    if (_db == null) {
      var path = join(await getDatabasesPath(), 'controle_alunos');
      //deleteDatabase(path);
      _db = await openDatabase(
        path,
        version: 1,
        onCreate: (db, v) {
          CriarTabelas(db);
          InserirDados(db);
        },
      );
    }
    return _db!;
  }
}

CriarTabelas(Database db) {
  db.execute('''CREATE TABLE IF NOT EXISTS SIS_STATUS_ALUNOS_TAB (
                ID_STATUS_INT INT,
                DESCRICAO_STR NVARCHAR(150))''');

  db.execute('''CREATE TABLE IF NOT EXISTS CAD_ALUNOS_TAB (
                ID_ALUNO_INT INTEGER NOT NULL PRIMARY KEY, 
                NOME_STR NVARCHAR(150), 
                ID_STATUS_INT INT, 
                INSTRUMENTO_STR NVARCHAR(150), 
                METODO_STR NVARCHAR(150), 
                FONE_STR NVARCHAR(15), 
                DATA_NASCIMENTO_DTI DATETIME, 
                DATA_BATISMO_DTI DATETIME, 
                DATA_INICIO_GEM_DTI DATETIME, 
                DATA_OFICIALIZACAO_DTI DATETIME, 
                ENDERECO_STR NVARCHAR(255), 
                OBSERVACAO_STR NVARCHAR(255),
                DATA_IMPORTACAO_DTI DATETIME)''');

  db.execute('''CREATE TABLE IF NOT EXISTS SIS_TIPOS_AULA_TAB (
                ID_TIPO_INT INT, 
                DESCRICAO_STR NVARCHAR(150))''');

  db.execute('''CREATE TABLE IF NOT EXISTS CAD_AULAS_TAB (
                ID_AULA_INT INTEGER NOT NULL PRIMARY KEY, 
                ID_ALUNO_INT INT, 
                ID_TIPO_INT INT, 
                INSTRUTOR_STR NVARCHAR(150), 
                DATA_DTI DATETIME, 
                CONCLUIDO_BIT BIT, 
                ASSUNTO_STR NVARCHAR(255),
                OBSERVACAO_STR NVARCHAR(255),
                DATA_IMPORTACAO_DTI DATETIME, 
                FOREIGN KEY(ID_ALUNO_INT) REFERENCES CAD_ALUNOS_TAB(ID_ALUNO_INT))''');

  /*db.execute('''CREATE TABLE IF NOT EXISTS TEMP_ALUNOS_TAB (
                ID_TEMP_INT INT, 
                ID_ALUNO_INT INT, 
                NOME_STR NVARCHAR(150), 
                ID_STATUS_INT INT, 
                INSTRUMENTO_STR NVARCHAR(150), 
                METODO_STR NVARCHAR(150), 
                FONE_STR NVARCHAR(15), 
                DATA_NASCIMENTO_DTI DATETIME, 
                DATA_BATISMO_DTI DATETIME, 
                DATA_INICIO_GEM_DTI DATETIME, 
                DATA_OFICIALIZACAO_DTI DATETIME, 
                ENDERECO_STR NVARCHAR(255), 
                OBSERVACAO_STR NVARCHAR(255),
                FLAG_BIT BIT)''');

  db.execute('''CREATE TABLE IF NOT EXISTS TEMP_AULAS_TAB (
                ID_TEMP_INT INT, 
                ID_ITEM_INT INT, 
                ID_TIPO_INT INT, 
                INSTRUTOR_STR NVARCHAR(150), 
                DATA_DTI DATETIME, 
                CONCLUIDO_BIT BIT, 
                ASSUNTO_STR NVARCHAR(255),
                OBSERVACAO_STR NVARCHAR(255),
                FLAG_BIT BIT)''');*/
}

InserirDados(Database db) {
  db.execute("DELETE FROM SIS_STATUS_ALUNOS_TAB");
  db.execute(
      "INSERT INTO SIS_STATUS_ALUNOS_TAB (ID_STATUS_INT, DESCRICAO_STR) VALUES (1,'Aprendiz')");
  db.execute(
      "INSERT INTO SIS_STATUS_ALUNOS_TAB (ID_STATUS_INT, DESCRICAO_STR) VALUES (2,'Ensaio musical')");
  db.execute(
      "INSERT INTO SIS_STATUS_ALUNOS_TAB (ID_STATUS_INT, DESCRICAO_STR) VALUES (3,'Culto de jovens')");
  db.execute(
      "INSERT INTO SIS_STATUS_ALUNOS_TAB (ID_STATUS_INT, DESCRICAO_STR) VALUES (4,'Culto oficial')");
  db.execute(
      "INSERT INTO SIS_STATUS_ALUNOS_TAB (ID_STATUS_INT, DESCRICAO_STR) VALUES (5,'Oficializado(a)')");

  db.execute("DELETE FROM SIS_TIPOS_AULA_TAB");
  db.execute(
      "INSERT INTO SIS_TIPOS_AULA_TAB (ID_TIPO_INT, DESCRICAO_STR) VALUES (1,'Teoria')");
  db.execute(
      "INSERT INTO SIS_TIPOS_AULA_TAB (ID_TIPO_INT, DESCRICAO_STR) VALUES (2,'Método')");
  db.execute(
      "INSERT INTO SIS_TIPOS_AULA_TAB (ID_TIPO_INT, DESCRICAO_STR) VALUES (3,'Hino')");
  db.execute(
      "INSERT INTO SIS_TIPOS_AULA_TAB (ID_TIPO_INT, DESCRICAO_STR) VALUES (4,'Outros')");
}
