// ignore_for_file: use_key_in_widget_constructors

import 'package:controle_alunos_musica_ft/components/custom_text_field.dart';
import 'package:controle_alunos_musica_ft/config/app_toast.dart';
import 'package:controle_alunos_musica_ft/components/date_picker.dart';
import 'package:controle_alunos_musica_ft/views/instrutores/instrutores_form_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class InstrutoresForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var back = InstrutoresFormBack(context);
    final keyForm = GlobalKey<FormState>();
    TextEditingController? txtFoneController = TextEditingController();
    txtFoneController.text =
        back.instrutor?.fone != null ? back.instrutor!.fone! : "";
    double alturaCampos = 15;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Instrutores"),
        actions: [
          IconButton(
              icon: const Icon(FontAwesomeIcons.check),
              tooltip: "Salvar",
              onPressed: () async {
                if (keyForm.currentState!.validate()) {
                  keyForm.currentState!.save();
                  back.instrutor?.idInstrutor = await back.onSave();
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
                                  back.onDelete(back.instrutor!.idInstrutor!);
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
                    CustomTextField(
                      label: "Nome",
                      textCapitalization: TextCapitalization.sentences,
                      initialValue: back.instrutor?.nome,
                      validator: back.validaNome,
                      onSaved: (value) => back.instrutor?.nome = value,
                    ),
                    CustomTextField(
                      label: "Instrumento",
                      textCapitalization: TextCapitalization.sentences,
                      initialValue: back.instrutor?.instrumento,
                      onSaved: (value) => back.instrutor?.instrumento = value,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CustomTextField(
                            label: "Telefone",
                            textInputType: TextInputType.phone,
                            controller: txtFoneController,
                            onSaved: (value) => back.instrutor?.fone = value,
                          ),
                        ),
                        const SizedBox(width: 5),
                        IconButton(
                          icon: const Icon(
                            FontAwesomeIcons.phone,
                            color: Colors.blue,
                            size: 40,
                          ),
                          onPressed: () =>
                              onSendUrl("tel://${txtFoneController.text}"),
                        ),
                        const SizedBox(width: 5),
                        IconButton(
                          icon: const Icon(
                            FontAwesomeIcons.whatsapp,
                            color: Colors.green,
                            size: 40,
                          ),
                          onPressed: () => onSendUrl(
                              "whatsapp://send?phone=+55${txtFoneController.text}"),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                    Row(
                      children: [
                        DatePickerClear(
                          label: "Nascimento",
                          date: back.instrutor?.dataNascimento,
                          tipoData: 1,
                          onDateTimeChanged: (dt) {
                            back.instrutor?.dataNascimento = dt;
                          },
                          clearDate: () {
                            back.instrutor?.dataNascimento = null;
                          },
                        ),
                        const SizedBox(width: 80),
                        DatePickerClear(
                          label: "Oficialização",
                          date: back.instrutor?.dataOficializacao,
                          tipoData: 1,
                          onDateTimeChanged: (dt) {
                            back.instrutor?.dataOficializacao = dt;
                          },
                          clearDate: () {
                            back.instrutor?.dataOficializacao = null;
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: alturaCampos),
                    CustomTextField(
                      label: "Endereço",
                      textCapitalization: TextCapitalization.sentences,
                      initialValue: back.instrutor?.endereco,
                      textInputType: TextInputType.multiline,
                      maxLines: 3,
                      onSaved: (value) => back.instrutor?.endereco = value,
                    ),
                  ],
                ))),
      ),
    );
  }

  Future<void> onSendUrl(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      onToastMessage('Aplicativo não encontrado');
    }
  }
}
