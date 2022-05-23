import 'package:cross_file/cross_file.dart';
import 'package:lgpdjus/features/quiz/domain/entity.dart';

abstract class FileRepository {
  Future<XFile?> getFromCamera(LensDirection lensDirection);

  Future<String> upload(String intention, XFile file);
}