import 'package:flutter/material.dart' show Color, required;

import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:e_lapor/libraries/CustomColors.dart';

Map<String, String> statusLaporanIcon = {
  'diverifikasi kordinator kota/kab': ClientPath.svgPath + '/check.svg',
  'diverifikasi kordinator provinsi': ClientPath.svgPath + '/check.svg',
  'ditolak kordinator kota/kab': ClientPath.svgPath + '/alert-octagon.svg',
  'ditolak kordinator provinsi': ClientPath.svgPath + '/alert-octagon.svg'
};

Map<String, String> statusLaporanReadable = {
  'pending': 'Pending',
  'diverifikasi kordinator kota/kab': 'Diverifikasi Kordinator Kota/Kab',
  'diverifikasi kordinator provinsi': 'Diverifikasi Kordinator Provinsi',
  'ditolak kordinator kota/kab': 'Ditolak Kordinator Kota/Kab',
  'ditolak kordinator provinsi': 'Ditolak Kordinator Provinsi'
};

Map<String, Color> statusLaporanColor = {
  'pending': CustomColors.secondaryColor,
  'diverifikasi kordinator kota/kab': CustomColors.successColor,
  'diverifikasi kordinator provinsi': CustomColors.successColor,
  'ditolak kordinator kota/kab': CustomColors.dangerColor,
  'ditolak kordinator provinsi': CustomColors.dangerColor
};

class Laporan {
  final int id;
  final String waktu;
  final String judul;
  final String lokasi;
  final String statusLaporan;
  final String tipeLaporan;

  Laporan(
      {@required this.id,
      @required this.judul,
      @required this.statusLaporan,
      @required this.waktu,
      @required this.lokasi,
      @required this.tipeLaporan});
}
