import 'package:e_lapor/libraries/Environment.dart';

class ServerPath {
  static String apiBaseURL = (Environment.environment == 'development')
      ? 'http://10.0.2.2/laukpauk.id'
      : 'https://app.laukpauk.id/admin';
}
