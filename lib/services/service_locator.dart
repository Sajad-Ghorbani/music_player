import 'package:get_it/get_it.dart';
import 'package:music_player/controllers/page_manager.dart';
import 'package:music_player/services/playlist_repository.dart';

import 'audio_handler.dart';

GetIt getIt = GetIt.instance;
Future setupServiceLocator()async{
  getIt.registerSingleton(await initAudioServices());
  getIt.registerLazySingleton<PlaylistRepository>(() => DemoPlaylist());
  getIt.registerLazySingleton<PageManager>(() => PageManager());
}