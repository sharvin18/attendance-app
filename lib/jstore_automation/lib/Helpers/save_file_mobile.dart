import 'dart:io';

///Package imports
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart' as open_file;

///To save the Excel file in the device
class FileSaveHelper {

  ///To save the Excel file in the device
  static Future<void> saveAndLaunchFile(
      List<int> bytes, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = directory.path;
    final File file = File('$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    await open_file.OpenFile.open('$path/$fileName');
    print("Saved the excel sheet");
  }
}