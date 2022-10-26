import 'package:controle_alunos_musica_ft/core/app_toast.dart';
import 'package:controle_alunos_musica_ft/core/date_picker.dart';
import 'package:controle_alunos_musica_ft/entities/status_alunos.dart';
import 'package:controle_alunos_musica_ft/views/alunos/alunos_form_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher.dart';

class AlunosForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _back = AlunosFormBack(context);
    final _keyForm = GlobalKey<FormState>();
    TextEditingController? txtFoneController = TextEditingController();
    txtFoneController.text =
        _back.aluno?.FONE_STR != null ? _back.aluno!.FONE_STR! : "";

    return Scaffold(
      appBar: AppBar(
        title: Text("Alunos"),
        actions: [
          IconButton(
              icon: Icon(Icons.check),
              tooltip: "Salvar",
              onPressed: () async {
                if (_keyForm.currentState!.validate()) {
                  _keyForm.currentState!.save();
                  _back.aluno?.ID_ALUNO_INT = await _back.Save();
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
                          Icons.music_note,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10),
                        Text("Aulas"),
                      ],
                    ),
                    onTap: () => Future(
                      () => _back.GoToAulasLista(context, _back.aluno!),
                    ),
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(
                          Icons.notes,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10),
                        Text("Relatório"),
                      ],
                    ),
                    onTap: () {
                      _back.GeraRelatorio(_back.aluno!.ID_ALUNO_INT!);
                    },
                  ),
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
                                              _back.aluno!.ID_ALUNO_INT!);
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
                    TextFormField(
                      decoration: InputDecoration(labelText: "Nome"),
                      textCapitalization: TextCapitalization.words,
                      initialValue: _back.aluno?.NOME_STR,
                      validator: _back.validaNome,
                      onSaved: (value) => _back.aluno?.NOME_STR = value,
                    ),
                    FutureBuilder(
                      future: _back.GetStatus(),
                      builder: (context, future) {
                        if (future.hasData) {
                          List<StatusAlunos> lstStatus =
                              future.data as List<StatusAlunos>;
                          return DropdownButtonFormField<dynamic>(
                            decoration: InputDecoration(labelText: "Status"),
                            value: _back.aluno?.ID_STATUS_INT != null
                                ? _back.aluno!.ID_STATUS_INT
                                : 1,
                            items: lstStatus.map((e) {
                              return DropdownMenuItem(
                                value: e.ID_STATUS_INT,
                                child: Text(e.DESCRICAO_STR.toString()),
                              );
                            }).toList(),
                            onChanged: (value) {},
                            onSaved: (value) =>
                                _back.aluno?.ID_STATUS_INT = value,
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Instrumento"),
                      textCapitalization: TextCapitalization.words,
                      initialValue: _back.aluno?.INSTRUMENTO_STR,
                      onSaved: (value) => _back.aluno?.INSTRUMENTO_STR = value,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Método"),
                      textCapitalization: TextCapitalization.words,
                      initialValue: _back.aluno?.METODO_STR,
                      onSaved: (value) => _back.aluno?.METODO_STR = value,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: "Telefone"),
                            keyboardType: TextInputType.phone,
                            controller: txtFoneController,
                            //initialValue: _back.aluno?.FONE_STR,
                            onSaved: (value) => _back.aluno?.FONE_STR = value,
                          ),
                        ),
                        SizedBox(width: 10),
                        IconButton(
                          icon: Icon(Icons.phone, color: Colors.blue, size: 40),
                          onPressed: () =>
                              SendUrl("tel://${txtFoneController.text}"),
                        ),
                        SizedBox(width: 10),
                        IconButton(
                          icon: Icon(Icons.whatsapp,
                              color: Colors.green, size: 40),
                          onPressed: () => SendUrl(
                              "whatsapp://send?phone=+55${txtFoneController.text}"),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Observer(
                          builder: (b) => DatePickerClear(
                              label: "Nascimento",
                              date: _back.DataNasc,
                              temData: _back.TemDataNasc,
                              getDate: () async {
                                DateTime? newDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now());

                                if (newDate != null) {
                                  _back.aluno?.DATA_NASCIMENTO_DTI = newDate;
                                  _back.setDataNasc(newDate);
                                }
                              },
                              clearDate: () {
                                _back.aluno?.DATA_NASCIMENTO_DTI = null;
                                _back.setDataNasc(null);
                              }),
                        ),
                        SizedBox(width: 80),
                        Observer(
                          builder: (b) => DatePickerClear(
                              label: "Batismo",
                              date: _back.DataBatismo,
                              temData: _back.TemDataBatismo,
                              getDate: () async {
                                DateTime? newDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now());

                                if (newDate != null) {
                                  _back.aluno?.DATA_BATISMO_DTI = newDate;
                                  _back.setDataBatismo(newDate);
                                }
                              },
                              clearDate: () {
                                _back.aluno?.DATA_BATISMO_DTI = null;
                                _back.setDataBatismo(null);
                              }),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Observer(
                          builder: (a) => DatePickerClear(
                              label: "Início GEM",
                              date: _back.DataIniGem,
                              temData: _back.TemDataIniGem,
                              getDate: () async {
                                DateTime? newDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now());

                                if (newDate != null) {
                                  _back.aluno?.DATA_INICIO_GEM_DTI = newDate;
                                  _back.setDataIniGem(newDate);
                                }
                              },
                              clearDate: () {
                                _back.aluno?.DATA_INICIO_GEM_DTI = null;
                                _back.setDataIniGem(null);
                              }),
                        ),
                        SizedBox(width: 80),
                        Observer(
                          builder: (a) => DatePickerClear(
                              label: "Oficialização",
                              date: _back.DataOficializacao,
                              temData: _back.TemDataOficializacao,
                              getDate: () async {
                                DateTime? newDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now());

                                if (newDate != null) {
                                  _back.aluno?.DATA_OFICIALIZACAO_DTI = newDate;
                                  _back.setDataOficializacao(newDate);
                                }
                              },
                              clearDate: () {
                                _back.aluno?.DATA_OFICIALIZACAO_DTI = null;
                                _back.setDataOficializacao(null);
                              }),
                        ),
                      ],
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Endereço"),
                      textCapitalization: TextCapitalization.words,
                      initialValue: _back.aluno?.ENDERECO_STR,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      onSaved: (value) => _back.aluno?.ENDERECO_STR = value,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Observação"),
                      textCapitalization: TextCapitalization.words,
                      initialValue: _back.aluno?.OBSERVACAO_STR,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      onSaved: (value) => _back.aluno?.OBSERVACAO_STR = value,
                    ),
                  ],
                ))),
      ),
    );
  }

  Future<void> SendUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ToastMessage('Aplicativo não encontrado');
    }
  }
}

// Observer(builder: (a) {
                        //   return Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text(
                        //         "Nascimento",
                        //         style:
                        //             TextStyle(color: Colors.grey, fontSize: 12),
                        //       ),
                        //       Row(
                        //         children: [
                        //           GestureDetector(
                        //               child: Text(
                        //                 _back.DataNasc != null
                        //                     ? _back.DataNasc!.day
                        //                             .toString()
                        //                             .padLeft(2, '0') +
                        //                         "/" +
                        //                         _back.DataNasc!.month
                        //                             .toString()
                        //                             .padLeft(2, '0') +
                        //                         "/" +
                        //                         _back.DataNasc!.year.toString()
                        //                     : "__/__/____",
                        //                 style: TextStyle(fontSize: 17),
                        //               ),
                        //               onTap: () async {
                        //                 DateTime? newDate =
                        //                     await showDatePicker(
                        //                         context: context,
                        //                         initialDate: DateTime.now(),
                        //                         firstDate: DateTime(1900),
                        //                         lastDate: DateTime.now());

                        //                 if (newDate != null) {
                        //                   _back.aluno?.DATA_NASCIMENTO_DTI =
                        //                       newDate;
                        //                   _back.setDataNasc(newDate);
                        //                 }
                        //               }),
                        //           SizedBox(width: 10),
                        //           Visibility(
                        //             visible: _back.TemDataNasc,
                        //             child: GestureDetector(
                        //               child: Text(
                        //                 "X",
                        //                 style: TextStyle(
                        //                     fontSize: 17,
                        //                     fontWeight: FontWeight.bold),
                        //               ),
                        //               onTap: () {
                        //                 _back.aluno?.DATA_NASCIMENTO_DTI = null;
                        //                 _back.setDataNasc(null);
                        //               },
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     ],
                        //   );
                        // }),