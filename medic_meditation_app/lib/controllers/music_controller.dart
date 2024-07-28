import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:medic_meditation_app/data/song_data.dart';

import '../data/model/song.dart';

class MusicController extends GetxController {
  List<Song> songs = sampleSongs.obs;
  var currentSong = Rx<Song>(sampleSongs.first);
  var indexCurrentSong=0.obs;
  var isPlaying = false.obs;
  var audioPlayer = AudioPlayer();
  var position = Duration().obs;
  var duration = Duration().obs;
  var showPlayer=true.obs;

  @override
  void onInit() {
    super.onInit();
    audioPlayer.positionStream.listen((p) {
      position.value = p;
    });
    audioPlayer.durationStream.listen((d) {
      if (d != null) {
        duration.value = d;
      }
    });
    audioPlayer.playingStream.listen((state) {
      isPlaying.value = state;
      print(isPlaying.value);
    });
    // Initialize the first song
    currentSong.value = sampleSongs.first;

  }

  void showSongsQueue(){
    showPlayer.value=!showPlayer.value;
  }

  void playSong(Song song) {
    currentSong.value=song;
    // indexCurrentSong.value=songs.indexOf(song);
    isPlaying.value = true;
    audioPlayer.setUrl(currentSong.value.url);
    audioPlayer.play();
    showPlayer.value=true;
  }

  void play() {
    isPlaying.value = true;
    if (!audioPlayer.playing) {
      audioPlayer.play();
    }
  }

  void pause() {
    isPlaying.value = false;
    if (audioPlayer.playing) {
      audioPlayer.pause();
    }
  }

  void nextPlay(){
    if(songs.length-1==indexCurrentSong.value){
      indexCurrentSong.value=0;
    }
    indexCurrentSong.value++;
    currentSong.value=songs[indexCurrentSong.value];
    playSong(currentSong.value);
  }

  void seekTo(Duration position) {
    audioPlayer.seek(position);
  }

  void previousPlay(){
    if(0==indexCurrentSong.value){
      indexCurrentSong.value=songs.length;
    }
    indexCurrentSong.value--;
    currentSong.value=songs[indexCurrentSong.value];
    playSong(currentSong.value);
  }
}
