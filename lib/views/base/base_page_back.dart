// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';

part 'base_page_back.g.dart';

class BasePageBack = _BasePageBack with _$BasePageBack;

abstract class _BasePageBack with Store {
  @observable
  int currentPage = 0;
}
