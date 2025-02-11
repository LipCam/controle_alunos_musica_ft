// ignore_for_file: must_be_immutable

import 'package:controle_alunos_musica_ft/components/borded_text.dart';
import 'package:controle_alunos_musica_ft/config/app_colors.dart';
import 'package:controle_alunos_musica_ft/database/repositories/alunos_repository.dart';
import 'package:flutter/material.dart';

import '../../models/alunos_dash.dart';

class AlunosDashTab extends StatelessWidget {
  AlunosDashTab({super.key});
  final _dao = AlunosRepository();
  bool loadGetAlunosDash = true;
  int iCores = -1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          BordedText(
            text: "Por Status",
          ),
          onGetAlunosDash(context),
        ],
      ),
    );
  }

  FutureBuilder onGetAlunosDash(BuildContext context) {
    return FutureBuilder(
      future: _dao.onGetAlunosDash(),
      builder: (context, future) {
        if (loadGetAlunosDash) {
          loadGetAlunosDash = false;
          return const Center(child: CircularProgressIndicator());
        } else {
          loadGetAlunosDash = true;
          if (future.hasData) {
            List<AlunosDash> lstAulasDash = future.data;
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: Wrap(
                spacing: 15,
                runSpacing: 15,
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  ...lstAulasDash.map(
                    (aulaDash) {
                      iCores++;
                      if (iCores > AppColors().bkgroundDash.length - 1) {
                        iCores = 0;
                      }

                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 15.0),
                        width: MediaQuery.of(context).size.width / 2 - 35,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppColors().bkgroundDash[iCores],
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              aulaDash.descricao,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              aulaDash.qtd.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                height: 0.8,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      },
    );
  }
}
