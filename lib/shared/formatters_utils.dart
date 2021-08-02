class FormatUtils {
  static String formatPhoneNumber([String tel]) {
    return '${tel.substring(0, 4)}-${tel.substring(4, 7)}-${tel.substring(7)}';
  }

  static String formatAccountNumber([String acc]) {
    return '${acc.substring(0, 4)}-${acc.substring(4, 8)}-${acc.substring(8)}';
  }
}
