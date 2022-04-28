abstract class PlaylistRepository {
  Future<List<Map<String, String>>> fetchInitialPlaylist();
}

class DemoPlaylist extends PlaylistRepository {
  @override
  Future<List<Map<String, String>>> fetchInitialPlaylist() async {
    const song1 =
        'https://irsv.upmusics.com/99/Behnam%20Bani%20-%20Khoshhalam%20(128).mp3?_ga=2.136526643.2071546763.1638023053-301902198.1638023053';
    const song2 =
        'https://dl.avangtv.com/music/99-09/Shadmehr-Aghili-Baroon-Delam-Khast.mp3.T8d9b3e8ce147673.mp3?md5=afae68a4dbb4a98d00972c75fe409253&expires=1640846072';
    const song3 =
        'https://dl.rozmusic.com/Music/1399/02/09/Puzzle%20Band%20Ft.%20Bardia%20-%20Moo%20Ghermez%20%28128%29.mp3';
    const song4 =
        'https://dl.rozmusic.com/Music/1396/01/14/Mohsen%20Yeganeh%20-%20Behet%20Ghol%20Midam%20%28128%29.mp3';
    return [
      {
        'id': '0',
        'title': 'Khoshhalam',
        'artist': 'Behnam Bani',
        'artUri': 'https://naslemusic.com/file/thumbnails-250-250/jpg/naslemusic_454Behnam-Bani-Khoshhalam-min.jpg',
        'url': song1,
      },
      {
        'id': '1',
        'title': 'Baroon Delam Khast',
        'artist': 'Shadmehr Aghili',
        'artUri': 'http://sv.original-music.ir/Archive/S/Shadmehr%20Aghili/1399/Shadmehr%20Aghili%20-%20Baroon%20Delam%20Khast.jpg',
        'url': song2,
      },
      {
        'id': '2',
        'title': 'Moo Ghermez',
        'artist': 'Pazzle Band',
        'artUri': 'https://rozmusic.com/wp-content/uploads/2020/04/Puzzle-Band-Ft.-Bardia-Moo-Ghermez.jpg',
        'url': song3,
      },
      {
        'id': '3',
        'title': 'Behet ghol Midam',
        'artist': 'Mohsen Yeganeh',
        'artUri': 'https://rozmusic.com/wp-content/uploads/2017/04/Mohsen-Yeganeh-Behet-Ghol-Midam.jpg',
        'url': song4,
      },
    ];
  }
}
