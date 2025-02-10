// ignore_for_file: use_key_in_widget_constructors

//import 'package:android_intent_plus/android_intent.dart';
import 'package:controle_alunos_musica_ft/components/custom_input_decoration.dart';
import 'package:controle_alunos_musica_ft/components/custom_text_field.dart';
import 'package:controle_alunos_musica_ft/config/app_colors.dart';
import 'package:controle_alunos_musica_ft/config/app_toast.dart';
import 'package:controle_alunos_musica_ft/components/date_picker.dart';
import 'package:controle_alunos_musica_ft/database/dao/status_alunos_dao.dart';
import 'package:controle_alunos_musica_ft/models/status_alunos.dart';
import 'package:controle_alunos_musica_ft/views/alunos/alunos_form_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AlunosForm extends StatefulWidget {
  @override
  State<AlunosForm> createState() => _AlunosFormState();
}

class _AlunosFormState extends State<AlunosForm> {
  List<StatusAlunos> lstStatus = [];
  bool isLoad = true;
  int idStatusSel = 1;
  final keyForm = GlobalKey<FormState>();
  late TextEditingController txtFoneController = TextEditingController();
  final _dao = StatusAlunosDAO();

  @override
  void initState() {
    super.initState();
    getStatusAlunos();
  }

  getStatusAlunos() async {
    lstStatus = await _dao.onGetStatus();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var back = AlunosFormBack(context);

    if (isLoad) {
      isLoad = false;
      txtFoneController.text =
          back.aluno?.fone != null ? back.aluno!.fone! : txtFoneController.text;
      idStatusSel = back.aluno?.idStatus ?? 1;
    }
    double alturaCampos = 15;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Alunos"),
        actions: [
          IconButton(
              icon: const Icon(FontAwesomeIcons.check),
              tooltip: "Salvar",
              onPressed: () async {
                if (keyForm.currentState!.validate()) {
                  keyForm.currentState!.save();
                  back.aluno?.idAluno = await back.onSave();
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
                          FontAwesomeIcons.music,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10),
                        Text("Aulas"),
                      ],
                    ),
                    onTap: () => Future(
                      () => back.onGoToAulasLista(context, back.aluno!),
                    ),
                  ),
                  PopupMenuItem(
                    child: const Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.bars,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10),
                        Text("Relatório"),
                      ],
                    ),
                    onTap: () {
                      back.onGeraRelatorio(back.aluno!.idAluno!);
                    },
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.solidTrashCan,
                          color: AppColors.deleteIcon,
                        ),
                        const SizedBox(width: 10),
                        const Text("Excluir"),
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
                                  back.onDelete(back.aluno!.idAluno!);
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
                  initialValue: back.aluno?.nome,
                  validator: back.validaNome,
                  onSaved: (value) => back.aluno?.nome = value,
                ),
                DropdownButtonFormField<dynamic>(
                  decoration:
                      CustomInputDecoration.onCustomInputDecoration("Status"),
                  value: idStatusSel,
                  items: lstStatus.map((e) {
                    return DropdownMenuItem(
                      value: e.idStatus,
                      child: Text(e.descricao.toString()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      idStatusSel = value;
                    });
                  },
                  onSaved: (value) => back.aluno?.idStatus = value,
                ),
                SizedBox(height: alturaCampos),
                CustomTextField(
                  label: "Instrumento",
                  textCapitalization: TextCapitalization.sentences,
                  initialValue: back.aluno?.instrumento,
                  onSaved: (value) => back.aluno?.instrumento = value,
                ),
                CustomTextField(
                  label: "Método",
                  textCapitalization: TextCapitalization.sentences,
                  initialValue: back.aluno?.metodo,
                  onSaved: (value) => back.aluno?.metodo = value,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: "Telefone",
                        textInputType: TextInputType.phone,
                        controller: txtFoneController,
                        //initialValue: _back.aluno?.FONE_STR,
                        onSaved: (value) => back.aluno?.fone = value,
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
                      // onPressed: () {
                      //   const intent = AndroidIntent(
                      //     action: 'android.intent.action.MAIN',
                      //     package: 'com.br.evoitizarandroid',
                      //     componentName:
                      //         'com.br.evoitizarandroid.MainActivity',
                      //     arguments: <String, dynamic>{
                      //       'ReceiverBluetooth': '',
                      //       'Id': '',
                      //       'MacAdress': 'AC:4D:16:21:F6:7F',
                      //     },
                      //     flags: <int>[
                      //       268435456,
                      //       32768,
                      //     ],
                      //   );
                      //   intent.launch();
                      // },
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                Row(
                  children: [
                    DatePickerClear(
                      label: "Nascimento",
                      date: back.aluno?.dataNascimento,
                      tipoData: 1,
                      onDateTimeChanged: (dt) {
                        back.aluno?.dataNascimento = dt;
                      },
                      clearDate: () {
                        back.aluno?.dataNascimento = null;
                      },
                    ),
                    const SizedBox(width: 80),
                    DatePickerClear(
                      label: "Batismo",
                      date: back.aluno?.dataBatismo,
                      tipoData: 1,
                      onDateTimeChanged: (dt) {
                        back.aluno?.dataBatismo = dt;
                      },
                      clearDate: () {
                        back.aluno?.dataBatismo = null;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    DatePickerClear(
                      label: "Início GEM",
                      date: back.aluno?.dataInicioGEM,
                      tipoData: 1,
                      onDateTimeChanged: (dt) {
                        back.aluno?.dataInicioGEM = dt;
                      },
                      clearDate: () {
                        back.aluno?.dataInicioGEM = null;
                      },
                    ),
                    const SizedBox(width: 80),
                    DatePickerClear(
                      label: "Oficialização",
                      date: back.aluno?.dataOficializacao,
                      tipoData: 1,
                      onDateTimeChanged: (dt) {
                        back.aluno?.dataOficializacao = dt;
                      },
                      clearDate: () {
                        back.aluno?.dataOficializacao = null;
                      },
                    ),
                  ],
                ),
                SizedBox(height: alturaCampos),
                CustomTextField(
                  label: "Endereço",
                  textCapitalization: TextCapitalization.sentences,
                  initialValue: back.aluno?.endereco,
                  textInputType: TextInputType.multiline,
                  maxLines: 3,
                  onSaved: (value) => back.aluno?.endereco = value,
                ),
                CustomTextField(
                  label: "Observação",
                  textCapitalization: TextCapitalization.sentences,
                  initialValue: back.aluno?.observacao,
                  textInputType: TextInputType.multiline,
                  maxLines: 5,
                  onSaved: (value) => back.aluno?.observacao = value,
                ),
              ],
            ),
          ),
        ),
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
