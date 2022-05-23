import 'dart:io';

import 'package:cross_file/cross_file.dart';

extension XFileHelper on XFile {
  Future<void> delete() async {
    File(path).delete();
  }
}