import 'package:controle_alunos_musica_ft/core/date_picker.dart';
import 'package:controle_alunos_musica_ft/entities/aulas.dart';
import 'package:controle_alunos_musica_ft/views/aulas/aulas_lista_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

class AulasLista extends StatelessWidget {
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  DateFormat formatter2 = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    var _back = AulasListaBack(context);
    return Scaffold(
      appBar: AppBar(
          title: Text("Aulas" +
              (_back.aluno != null
                  ? " - " + _back.aluno!.NOME_STR.toString()
                  : "")),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Aulas aula = Aulas(
                      ID_ALUNO_INT: _back.aluno?.ID_ALUNO_INT,
                      CONCLUIDO_BIT: false,
                      DATA_DTI: DateTime.now());
                  _back.GoToForm(
                      context,
                      aula,
                      formatter.format(_back.DataIni!),
                      formatter.format(_back.DataFim!),
                      _back.aluno);
                })
          ]),
      body: Column(children: [
        SizedBox(height: 10),
        Observer(
            builder: (a) => Column(
                  children: [
                    Visibility(
                      visible: _back.aluno == null,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              DatePicker(
                                label: "Início",
                                date: _back.DataIni!,
                                getDate: () async {
                                  DateTime? newDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now());

                                  if (newDate != null) {
                                    _back.setDataIni(newDate);
                                    _back.CarregaLista(
                                        formatter.format(_back.DataIni!),
                                        formatter.format(_back.DataFim!));
                                  }
                                },
                              ),
                              DatePicker(
                                label: "Fim",
                                date: _back.DataFim!,
                                getDate: () async {
                                  DateTime? newDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now());

                                  if (newDate != null) {
                                    _back.setDataFim(newDate);
                                    _back.CarregaLista(
                                        formatter.format(_back.DataIni!),
                                        formatter.format(_back.DataFim!));
                                  }
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                    futureBuilder(_back),
                  ],
                )),
      ]),
    );
  }

  FutureBuilder futureBuilder(AulasListaBack _back) {
    return FutureBuilder(
      future: _back.lstEntities,
      builder: (context, future) {
        if (future.hasData) {
          List<Aulas> lst = future.data;
          return ListView.builder(
              itemCount: lst.length,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                Aulas aula = lst[i];
                return _back.aluno == null
                    ? tileAulas(aula, context, _back)
                    : tileAulasAluno(aula, context, _back);
              });
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListTile tileAulas(Aulas aula, BuildContext context, AulasListaBack _back) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            aula.ALUNO_STR.toString(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            formatter2.format(aula.DATA_DTI),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(aula.TIPO_STR.toString(), style: TextStyle(fontSize: 15)),
              Text(aula.CONCLUIDO_STR.toString(),
                  style: TextStyle(fontSize: 15)),
            ],
          ),
          Text(aula.ASSUNTO_STR!,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        ],
      ),
      trailing: DeleteButton(context, _back, aula),
      onTap: () {
        _back.GoToForm(context, aula, formatter.format(_back.DataIni!),
            formatter.format(_back.DataFim!), _back.aluno);
      },
    );
  }

  ListTile tileAulasAluno(
      Aulas aula, BuildContext context, AulasListaBack _back) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            formatter2.format(aula.DATA_DTI),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            aula.TIPO_STR.toString(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            aula.CONCLUIDO_STR.toString(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(aula.ASSUNTO_STR.toString(), style: TextStyle(fontSize: 15)),
            ],
          ),
        ],
      ),
      trailing: DeleteButton(context, _back, aula),
      onTap: () {
        _back.GoToForm(context, aula, formatter.format(_back.DataIni!),
            formatter.format(_back.DataFim!), _back.aluno);
      },
    );
  }

  Widget DeleteButton(BuildContext context, AulasListaBack _back, Aulas aula) {
    return IconButton(
      icon: Icon(Icons.delete),
      color: Colors.red,
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Exclusão"),
                  content: Text("Deseja excluir este registro?"),
                  actions: [
                    TextButton(
                        child: Text("Não"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    TextButton(
                      child: Text("Sim"),
                      onPressed: () {
                        _back.Delete(
                            aula.ID_AULA_INT!,
                            formatter.format(_back.DataIni!),
                            formatter.format(_back.DataFim!),
                            _back.aluno);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ));
      },
    );
  }
}
