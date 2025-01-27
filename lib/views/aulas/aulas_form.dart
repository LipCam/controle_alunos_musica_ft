// ignore_for_file: use_key_in_widget_constructors

import 'package:controle_alunos_musica_ft/components/custom_checkbox.dart';
import 'package:controle_alunos_musica_ft/components/custom_text_field.dart';
import 'package:controle_alunos_musica_ft/config/app_toast.dart';
import 'package:controle_alunos_musica_ft/components/date_picker.dart';
import 'package:controle_alunos_musica_ft/models/alunos.dart';
import 'package:controle_alunos_musica_ft/models/instrutores.dart';
import 'package:controle_alunos_musica_ft/models/tipos_aula.dart';
import 'package:controle_alunos_musica_ft/views/aulas/aulas_form_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../components/custom_input_decoration.dart';

class AulasForm extends StatefulWidget {
  @override
  State<AulasForm> createState() => _AulasFormState();
}

class _AulasFormState extends State<AulasForm> {
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var back = AulasFormBack(context);
    double alturaCampos = 15;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Aulas"),
        actions: [
          IconButton(
              icon: const Icon(FontAwesomeIcons.check),
              tooltip: "Salvar",
              onPressed: () async {
                if (keyForm.currentState!.validate()) {
                  keyForm.currentState!.save();
                  back.aula?.idAula = await back.onSave();
                  back.novoReg = false;
                  onToastMessage("Salvo");
                }
              }),
          Observer(
            builder: (c) => Visibility(
              visible: !back.novoReg,
              child: PopupMenuButton(itemBuilder: (a) {
                return [
                  PopupMenuItem(
                    child: const Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.solidTrashCan,
                          color: Colors.red,
                        ),
                        SizedBox(width: 10),
                        Text("Excluir"),
                      ],
                    ),
                    onTap: () {
                      Future<void>.delayed(
                        const Duration(milliseconds: 500),
                        () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Exclusão"),
                            content:
                                const Text("Deseja excluir este registro?"),
                            actions: [
                              TextButton(
                                  child: const Text("Não"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }),
                              TextButton(
                                child: const Text("Sim"),
                                onPressed: () {
                                  back.onDelete(back.aula!.idAula!);
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Form(
            key: keyForm,
            child: Column(
              children: [
                FutureBuilder(
                  future: back.onGetAlunosCmb(),
                  builder: (context, future) {
                    if (future.hasData) {
                      List<Alunos> lstAlunos = future.data as List<Alunos>;
                      return Observer(
                        builder: (context) => DropdownButtonFormField<dynamic>(
                          decoration:
                              CustomInputDecoration.onCustomInputDecoration(
                                  "Aluno"),
                          value: back.aula?.idAluno != null
                              ? back.aula!.idAluno
                              : lstAlunos.isNotEmpty
                                  ? lstAlunos[0].idAluno
                                  : null,
                          items: lstAlunos.map((e) {
                            return DropdownMenuItem(
                              value: e.idAluno,
                              child: Text(e.nome.toString()),
                            );
                          }).toList(),
                          onChanged:
                              back.aula?.idAluno == null ? (value) {} : null,
                          onSaved: (value) => back.aula?.idAluno = value,
                          validator: back.validaAluno,
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    DatePicker(
                      label: "Data",
                      dateInit: back.aula!.data,
                      tipoData: 0,
                      onDateTimeChanged: (dt) {
                        back.aula!.data = dt;
                      },
                    ),
                    const SizedBox(width: 80),
                    CustomCheckBox(
                      label: "Concluído",
                      value: back.aula!.concluido,
                      onChange: (bool? value) {
                        back.aula!.concluido = value!;
                      },
                    )
                  ],
                ),
                FutureBuilder(
                  future: back.onGetTiposCmb(),
                  builder: (context, future) {
                    if (future.hasData) {
                      List<TiposAula> lstStatus =
                          future.data as List<TiposAula>;
                      return DropdownButtonFormField<dynamic>(
                        decoration:
                            CustomInputDecoration.onCustomInputDecoration(
                                "Tipo"),
                        value:
                            back.aula?.idTipo != null ? back.aula!.idTipo : 1,
                        items: lstStatus.map((e) {
                          return DropdownMenuItem(
                            value: e.idTipo,
                            child: Text(e.descricao.toString()),
                          );
                        }).toList(),
                        onChanged: (value) {},
                        onSaved: (value) => back.aula?.idTipo = value,
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
                SizedBox(height: alturaCampos),
                FutureBuilder(
                  future: back.onGetInstrutoresCmb(),
                  builder: (context, future) {
                    if (future.hasData) {
                      List<Instrutores> lstInstrutores =
                          future.data as List<Instrutores>;
                      return DropdownButtonFormField<dynamic>(
                        decoration:
                            CustomInputDecoration.onCustomInputDecoration(
                                "Instrutor"),
                        value: back.aula?.idInstrutor != null
                            ? back.aula!.idInstrutor
                            : lstInstrutores.isNotEmpty
                                ? lstInstrutores[0].idInstrutor
                                : null,
                        items: lstInstrutores.map((e) {
                          return DropdownMenuItem(
                            value: e.idInstrutor,
                            child: Text(e.nome.toString()),
                          );
                        }).toList(),
                        onChanged: (value) {},
                        onSaved: (value) => back.aula?.idInstrutor = value,
                        validator: back.validaInstrutor,
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
                SizedBox(height: alturaCampos),
                CustomTextField(
                  label: "Assunto",
                  textCapitalization: TextCapitalization.words,
                  initialValue: back.aula?.assunto,
                  onSaved: (value) => back.aula?.assunto = value,
                  validator: back.validaAssunto,
                ),
                CustomTextField(
                  label: "Observação",
                  textCapitalization: TextCapitalization.words,
                  textInputType: TextInputType.multiline,
                  maxLines: 5,
                  initialValue: back.aula?.observacao,
                  onSaved: (value) => back.aula?.observacao = value,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
