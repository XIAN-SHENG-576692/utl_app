import '../application/buffer_and_download_file.dart';
import 'resource/path_resource.dart';
import 'resource/service_resource.dart';

class ApplicationPersist {
  ApplicationPersist._();
  static void init() {
    bufferAndDownloadFile = BufferAndDownloadFile(
      electrochemicalDataStream: ServiceResource.electrochemicalDataStream,
      folderPath: PathResource.downloadPath,
    );
  }
  static late final BufferAndDownloadFile bufferAndDownloadFile;
}
