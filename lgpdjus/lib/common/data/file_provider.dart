import 'package:cross_file/cross_file.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:lgpdjus/app/core/extension/http.dart';
import 'package:lgpdjus/app/shared/navigation/navigator.dart';
import 'package:lgpdjus/core/provider/file_provider.dart';
import 'package:lgpdjus/features/quiz/domain/entity.dart';

class FileRepositoryImpl extends FileRepository {
  FileRepositoryImpl(this._httpClient);

  final http.Client _httpClient;

  @override
  Future<XFile?> getFromCamera(LensDirection lensDirection) async {
    final result = await AppNavigator.pushNamedIfExists('/take_picture', args: lensDirection);
    if (result is! XFile?) throw Exception("Invalid result `$result` error");
    print("File received ${result?.path}");

    return result;
  }

  @override
  Future<String> upload(String intention, XFile file) async {
    final response = await _httpClient.upload(Uri(path: '/me/media'), [
      await file.asMultipartFile('media'),
    ], fields: {
      'intention': intention,
    });

    var jsonData = await response.bodyJson;
    return jsonData['id'];
  }
}

extension XFileHelper on XFile {
  Future<http.MultipartFile> asMultipartFile(String field) async {
    MediaType? contentType =
        mimeType != null ? MediaType.parse(mimeType!) : null;

    return http.MultipartFile.fromBytes(
      field,
      await readAsBytes(),
      filename: name,
      contentType: contentType,
    );
  }
}
