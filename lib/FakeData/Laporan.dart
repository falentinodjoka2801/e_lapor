import 'package:e_lapor/Object/Laporan.dart';

List<Laporan> laporan = [
  Laporan(
      waktu: '22 Januari 2021',
      jam: '14:02',
      judul: 'Laporan OPT',
      lokasi: 'Sibolangit, Sumatera Utara',
      statusLaporan: StatusLaporan.verified),
  Laporan(
      waktu: '22 Januari 2021',
      jam: '13:42',
      judul: 'Lap. Kekeringan',
      lokasi: 'Hamparan Perak, Sumatera Utara',
      statusLaporan: StatusLaporan.checking),
  Laporan(
      waktu: '12 Januari 2021',
      jam: '15:21',
      judul: 'Lap. Banjir',
      lokasi: 'Jakarta, Indonesia',
      statusLaporan: StatusLaporan.rejected)
];

List<Laporan> laporanPending = [
  Laporan(
      waktu: '22 Januari 2021',
      jam: '14:02',
      judul: 'Laporan OPT',
      lokasi: 'Sibolangit, Sumatera Utara',
      statusLaporan: StatusLaporan.pending),
  Laporan(
      waktu: '22 Januari 2021',
      jam: '13:42',
      judul: 'Lap. Kekeringan',
      lokasi: 'Hamparan Perak, Sumatera Utara',
      statusLaporan: StatusLaporan.pending),
  Laporan(
      waktu: '12 Januari 2021',
      jam: '15:21',
      judul: 'Lap. Banjir',
      lokasi: 'Jakarta, Indonesia',
      statusLaporan: StatusLaporan.pending)
];
