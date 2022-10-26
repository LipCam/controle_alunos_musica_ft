import 'package:controle_alunos_musica_ft/core/app_toast.dart';
import 'package:controle_alunos_musica_ft/core/date_picker.dart';
import 'package:controle_alunos_musica_ft/entities/alunos.dart';
import 'package:controle_alunos_musica_ft/entities/tipos_aula.dart';
import 'package:controle_alunos_musica_ft/views/aulas/aulas_form_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher.dart';

class AulasForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _back = AulasFormBack(context);
    final _keyForm = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Aulas"),
        actions: [
          IconButton(
              icon: Icon(Icons.check),
              tooltip: "Salvar",
              onPressed: () async {
                if (_keyForm.currentState!.validate()) {
                  _keyForm.currentState!.save();
                  _back.aula?.ID_AULA_INT = await _back.Save();
                  _back.NovoReg = false;
                  ToastMessage("Salvo");
                }
              }),
          Observer(
            builder: (c) => Visibility(
              visible: !_back.NovoReg,
              child: PopupMenuButton(itemBuilder: (a) {
                return [
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        SizedBox(width: 10),
                        Text("Excluir"),
                      ],
                    ),
                    onTap: () {
                      Future<void>.delayed(
                          Duration(milliseconds: 500),
                          () => showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text("Exclusão"),
                                    content:
                                        Text("Deseja excluir este registro?"),
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
                                              _back.aula!.ID_AULA_INT!);
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  )));
                    },
                  ),
                ];
              }),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
                key: _keyForm,
                child: Column(
                  children: [
                    FutureBuilder(
                      future: _back.GetAlunos(),
                      builder: (context, future) {
                        if (future.hasData) {
                          List<Alunos> lstStatus = future.data as List<Alunos>;
                          return Observer(
                            builder: ((context) =>
                                DropdownButtonFormField<dynamic>(
                                  decoration:
                                      InputDecoration(labelText: "Aluno"),
                                  value: _back.aula?.ID_ALUNO_INT != null
                                      ? _back.aula!.ID_ALUNO_INT
                                      : lstStatus[0].ID_ALUNO_INT,
                                  items: lstStatus.map((e) {
                                    return DropdownMenuItem(
                                      value: e.ID_ALUNO_INT,
                                      child: Text(e.NOME_STR.toString()),
                                    );
                                  }).toList(),
                                  //onChanged: _back.NovoReg ? (value) {} : null,
                                  onChanged: _back.aula?.ID_ALUNO_INT == null
                                      ? (value) {}
                                      : null,
                                  onSaved: (value) =>
                                      _back.aula?.ID_ALUNO_INT = value,
                                )),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                    Row(
                      children: [
                        Observer(
                          builder: (b) => DatePicker(
                            label: "Data",
                            date: _back.Data!,
                            getDate: () async {
                              DateTime? newDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now());

                              if (newDate != null) {
                                _back.aula!.DATA_DTI = newDate;
                                _back.setData(newDate);
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 80),
                        Observer(
                          builder: (context) => Expanded(
                            child: CheckboxListTile(
                              title: Text("Concluído"),
                              value: _back.Concluido,
                              onChanged: (bool? value) {
                                _back.Concluido = value;
                                _back.aula!.CONCLUIDO_BIT = value!;
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          ),
                        )
                      ],
                    ),
                    FutureBuilder(
                      future: _back.GetTipos(),
                      builder: (context, future) {
                        if (future.hasData) {
                          List<TiposAula> lstStatus =
                              future.data as List<TiposAula>;
                          return DropdownButtonFormField<dynamic>(
                            decoration: InputDecoration(labelText: "Tipo"),
                            value: _back.aula?.ID_TIPO_INT != null
                                ? _back.aula!.ID_TIPO_INT
                                : 1,
                            items: lstStatus.map((e) {
                              return DropdownMenuItem(
                                value: e.ID_TIPO_INT,
                                child: Text(e.DESCRICAO_STR.toString()),
                              );
                            }).toList(),
                            onChanged: (value) {},
                            onSaved: (value) => _back.aula?.ID_TIPO_INT = value,
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Instrutor"),
                      initialValue: _back.aula?.INSTRUTOR_STR,
                      onSaved: (value) => _back.aula?.INSTRUTOR_STR = value,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Assunto"),
                      initialValue: _back.aula?.ASSUNTO_STR,
                      onSaved: (value) => _back.aula?.ASSUNTO_STR = value,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Observação"),
                      initialValue: _back.aula?.OBSERVACAO_STR,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      onSaved: (value) => _back.aula?.OBSERVACAO_STR = value,
                    ),
                  ],
                ))),
      ),
    );
  }
}
