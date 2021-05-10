import 'package:e_lapor/libraries/Environment.dart';

class ServerPath {
  static String apiBaseURL = (Environment.environment == 'development')
      ? 'http://10.0.2.2/laukpauk.id'
      : 'https://sitampan.pertanian.go.id';

  static String login = 'elapor/api/login';
  static String komoditasPath = 'elapor/api/v1/komoditas';
  static String kecWilKerPath = 'elapor/api/v1/kecamatan-wilker';
  static String desaWilKerPath = 'elapor/api/v1/desa-wilker';
  static String adminWAContactPath = 'elapor/api/v1/whatsapp';
  static String laporanPath = 'elapor/api/v1/reports';

  static String saveGangguanFisiologisPath =
      'elapor/api/v1/report-dpi/gangguan/store';
  static String detailGangguanFisiologisPath =
      'elapor/api/v1/report-dpi/gangguan/detail';
  static String updateGangguanFisiologisPath =
      'elapor/api/v1/report-dpi/gangguan/update';

  static String saveKekeringanPath =
      'elapor/api/v1/report-dpi/kekeringan/store';
  static String detailKekeringanPath =
      'elapor/api/v1/report-dpi/kekeringan/detail';
  static String updateKekeringanPath =
      'elapor/api/v1/report-dpi/kekeringan/update';

  static String saveBencanaAlamPath = 'elapor/api/v1/report-dpi/bencana/store';
  static String detailBencanaAlamPath =
      'elapor/api/v1/report-dpi/bencana/detail';
  static String updateBencanaAlamPath =
      'elapor/api/v1/report-dpi/bencana/update';

  static String saveBanjirPath = 'elapor/api/v1/report-dpi/banjir/store';
  static String detailBanjirPath = 'elapor/api/v1/report-dpi/banjir/detail';
  static String updateBanjirPath = 'elapor/api/v1/report-dpi/banjir/update';

  static String optPath = 'elapor/api/v1/opt';
  static String kriteriaPath = 'elapor/api/v1/kriteria';

  static String saveOPTPath = 'elapor/api/v1/report-opt/store';
  static String detailOPTPath = 'elapor/api/v1/report-opt/detail';
  static String updaetOPTPath = 'elapor/api/v1/report-opt/update';

  static String notifikasiPath = 'elapor/api/v1/notifikasi';

  static String changePasswordPath = 'elapor/api/change_password';
}
