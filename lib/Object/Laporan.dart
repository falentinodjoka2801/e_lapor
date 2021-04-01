import 'package:flutter/material.dart' show Color;

import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:e_lapor/libraries/CustomColors.dart';

enum StatusLaporan { pending, checking, verified, rejected }

Map<StatusLaporan, String> statusLaporanIcon = {
  StatusLaporan.checking: ClientPath.laporanIconPath + '/clock.png',
  StatusLaporan.pending: ClientPath.laporanIconPath + '/info.png',
  StatusLaporan.verified: ClientPath.laporanIconPath + '/check.png',
  StatusLaporan.rejected: ClientPath.laporanIconPath + '/warning.png'
};

Map<StatusLaporan, String> statusLaporanReadable = {
  StatusLaporan.checking: 'Dalam Pengecekan',
  StatusLaporan.pending: 'Pending',
  StatusLaporan.verified: 'Telah Diverifikasi',
  StatusLaporan.rejected: 'Ditolak'
};

Map<StatusLaporan, Color> statusLaporanColor = {
  StatusLaporan.checking: CustomColors.warningColor,
  StatusLaporan.pending: CustomColors.secondaryColor,
  StatusLaporan.verified: CustomColors.successColor,
  StatusLaporan.rejected: CustomColors.dangerColor
};

class Laporan {
  final String waktu;
  final String jam;
  final String judul;
  final String lokasi;
  final StatusLaporan statusLaporan;

  Laporan({this.waktu, this.jam, this.judul, this.lokasi, this.statusLaporan});
}
