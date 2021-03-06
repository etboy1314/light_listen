class CommonUtils {
  /// 格式化歌词
  static List<LyricData> formatLyric(String lyricStr) {
    RegExp reg = RegExp(r"^\[\d{2}");

    List<LyricData> result = lyricStr.split("\n").where((r) => reg.hasMatch(r)).map((s) {
      String time = s.substring(0, s.indexOf(']'));
      String lyric = s.substring(s.indexOf(']') + 1);
      time = s.substring(1, time.length - 1);
      int hourSeparatorIndex = time.indexOf(":");
      int minuteSeparatorIndex = time.indexOf(".");
      return LyricData(
        lyric,
        startTime: Duration(
          minutes: int.parse(
            time.substring(0, hourSeparatorIndex),
          ),
          seconds: int.parse(time.substring(hourSeparatorIndex + 1, minuteSeparatorIndex)),
          milliseconds: int.parse(time.substring(minuteSeparatorIndex + 1)),
        ),
      );
    }).toList();

    for (int i = 0; i < result.length - 1; i++) {
      result[i].endTime = result[i + 1].startTime;
    }
    result[result.length - 1].endTime = Duration(hours: 1);
    return result;
  }

  /// 查找歌词
  static int findLyricIndex(double curDuration, List<LyricData> lyrics) {
    for (int i = 0; i < lyrics.length; i++) {
      if (curDuration >= lyrics[i].startTime.inMilliseconds && curDuration <= lyrics[i].endTime.inMilliseconds) {
        return i;
      }
    }
    return 0;
  }
}

class LyricData {
  String lyric;
  Duration startTime;
  Duration endTime;
  double offset;

  LyricData(this.lyric, {this.startTime, this.endTime, this.offset});

  @override
  String toString() {
    return 'Lyric{lyric: $lyric, startTime: $startTime, endTime: $endTime}';
  }
}
