import 'dart:developer';


import 'package:external_path/external_path.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
Future<void> saveAndLunchFile (List<int> bytes ,String fileName) async{
  //final path = (await getExternalStorageDirectory())!.path;
  var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);

  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
  }


  if(Platform.isAndroid)
  {
      path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
  }else
  {// is ios
    final directory = await getApplicationDocumentsDirectory();
    path =directory.path;
  }

  final file = File('$path/$fileName');
  await file.writeAsBytes(bytes,flush: true);
    //int number =Random().nextInt(100);
    OpenFile.open('$path/$fileName').then((value) {
       log("===${value.message}");
    });
}