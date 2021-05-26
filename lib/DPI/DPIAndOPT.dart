import 'dart:io';

import 'package:e_lapor/FakeData/Wilayah.dart';
import 'package:e_lapor/Future/Akun/AkunFuture.dart';
import 'package:e_lapor/Future/DPIFuture.dart';
import 'package:e_lapor/globalWidgets/Alert.dart';
import 'package:e_lapor/globalWidgets/CustomForm.dart';
import 'package:e_lapor/globalWidgets/CustomNavigation.dart';
import 'package:e_lapor/globalWidgets/Loading.dart';
import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:e_lapor/libraries/DecimalTextInputFormatter.dart';
import 'package:e_lapor/libraries/ImagePickerDialog.dart';
import 'package:e_lapor/libraries/LocalStorage.dart';
import 'package:e_lapor/libraries/SPKey.dart';
import 'package:e_lapor/libraries/ServerPath.dart';
import 'package:flutter/material.dart';

import 'package:e_lapor/globalWidgets/Button.dart';

import 'package:e_lapor/libraries/SizeConfig.dart';
import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart' show ImageSource, PickedFile;
import 'package:metadata/metadata.dart' as metaData;

enum DPIType { banjir, kekeringan, bencanaAlam, gangguanFisiologis }
enum DPIAndOPTAction { add, detail, edit }

class DPIAndOPT extends StatefulWidget {
  final int idLaporan;
  final DPIAndOPTAction action;
  final DPIType type;
  final String dpiAndOPTTitle;
  final void Function(Map<String, dynamic> dataDPI) onSubmit;
  final bool tinggiBanjir,
      sisaTerkena,
      sisaTerkenaMenjadiRingan,
      sisaTerkenaMenjadiSedang,
      sisaTerkenaMenjadiBerat,
      sisaTerkenaMenjadiPuso,
      sisaTerkenaMenjadiSurut,
      sisaTerkenaMenjadiPulih,
      sisaTerkenaJumlah,
      luasTambahTerkena,
      luasTambahRingan,
      luasTambahSedang,
      luasTambahBerat,
      luasTambahSurut,
      luasTambahPulih,
      luasTambahJumlah,
      keadaanTerkena,
      keadaanRingan,
      keadaanSedang,
      keadaanBerat,
      keadaanSurut,
      keadaanPulih,
      keadaanJumlah,
      isBtnSubmitActive;

  DPIAndOPT(
      {@required this.dpiAndOPTTitle,
      @required this.onSubmit,
      @required this.type,
      @required this.isBtnSubmitActive,
      this.idLaporan,
      this.action,
      this.tinggiBanjir = false,
      this.sisaTerkena = false,
      this.sisaTerkenaMenjadiRingan = false,
      this.sisaTerkenaMenjadiSedang = false,
      this.sisaTerkenaMenjadiBerat = false,
      this.sisaTerkenaMenjadiPuso = false,
      this.sisaTerkenaMenjadiSurut = false,
      this.sisaTerkenaMenjadiPulih = false,
      this.luasTambahRingan = false,
      this.luasTambahSedang = false,
      this.luasTambahBerat = false,
      this.luasTambahSurut = false,
      this.luasTambahPulih = false,
      this.sisaTerkenaJumlah = false,
      this.luasTambahTerkena = false,
      this.luasTambahJumlah = false,
      this.keadaanTerkena = false,
      this.keadaanRingan = false,
      this.keadaanSedang = false,
      this.keadaanBerat = false,
      this.keadaanSurut = false,
      this.keadaanPulih = false,
      this.keadaanJumlah = false});
  _DPIState createState() => _DPIState();
}

class _DPIState extends State<DPIAndOPT> {
  PickedFile _foto;

  TextEditingController _provinsiUserController = TextEditingController();
  TextEditingController _kotaKabupatenUserController = TextEditingController();

  TextEditingController _bulanController = TextEditingController();
  TextEditingController _tahunController = TextEditingController();
  TextEditingController _latitudeController = TextEditingController();
  TextEditingController _longitudeController = TextEditingController();
  TextEditingController _varietasController = TextEditingController();
  TextEditingController _luasPersemaianController = TextEditingController();
  TextEditingController _luasTanamController = TextEditingController();
  TextEditingController _umurTanamController = TextEditingController();
  TextEditingController _umurPersemaianController = TextEditingController();
  TextEditingController _penyebabController = TextEditingController();
  TextEditingController _penangananController = TextEditingController();
  TextEditingController _tinggiBanjirController = TextEditingController();
  TextEditingController _sisaTerkenaController = TextEditingController();
  TextEditingController _sisaTerkenaMenjadiRinganController =
      TextEditingController();
  TextEditingController _sisaTerkenaMenjadiSedangController =
      TextEditingController();
  TextEditingController _sisaTerkenaMenjadiBeratController =
      TextEditingController();
  TextEditingController _sisaTerkenaMenjadiPusoController =
      TextEditingController();
  TextEditingController _sisaTerkenaMenjadiSurutController =
      TextEditingController();
  TextEditingController _sisaTerkenaMenjadiPulihController =
      TextEditingController();
  TextEditingController _sisaTerkenaJumlahController = TextEditingController();

  TextEditingController _luasTambahTerkenaController = TextEditingController();
  TextEditingController _luasTambahRinganController = TextEditingController();
  TextEditingController _luasTambahSedangController = TextEditingController();
  TextEditingController _luasTambahBeratController = TextEditingController();
  TextEditingController _luasTambahPusoController = TextEditingController();
  TextEditingController _luasTambahPulihController = TextEditingController();
  TextEditingController _luasTambahSurutController = TextEditingController();
  TextEditingController _luasTambahJumlahController = TextEditingController();

  TextEditingController _keadaanTerkenaController = TextEditingController();
  TextEditingController _keadaanRinganController = TextEditingController();
  TextEditingController _keadaanSedangController = TextEditingController();
  TextEditingController _keadaanBeratController = TextEditingController();
  TextEditingController _keadaanPusoController = TextEditingController();

  TextEditingController _keadaanSurutController = TextEditingController();
  TextEditingController _keadaanPulihController = TextEditingController();
  TextEditingController _keadaanJumlahController = TextEditingController();

  TextEditingController _thMTController = TextEditingController();
  TextEditingController _periodeOkmarAsepController = TextEditingController();
  TextEditingController _mtMKMHController = TextEditingController();
  TextEditingController _subRoundController = TextEditingController();
  TextEditingController _visitedAtController = TextEditingController();

  TextEditingController _curahHujanController = TextEditingController();

  List _kecamatanWilKerState = [];
  List _desaWilKerState = [];
  List _komoditasState = [];
  List<Map<String, dynamic>> _periodeState = [
    {'text': 'Periode I', 'value': '1'},
    {'text': 'Periode II', 'value': '2'}
  ];

  int _kecamatanWilKerSelected = 0;
  int _desaWilKerSelected = 0;
  int _komoditasSelected = 0;

  String _periodeSelected = '';
  String _kecamatanWilKerSelectedString = '',
      _desaWilKerSelectedString = '',
      _komoditasSelectedString = '',
      _fotoPath;

  bool _showTahun = false;
  bool _showBulan = false;
  bool _showPeriodeOkmarAsep = false;
  bool _showTHMT = false;
  bool _showMTMKMH = false;
  bool _showSubround = false;
  bool _showLat = false;
  bool _showLong = false;

  void dispose() {
    super.dispose();

    _provinsiUserController.dispose();
    _kotaKabupatenUserController.dispose();

    _bulanController.dispose();
    _tahunController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    _varietasController.dispose();
    _luasPersemaianController.dispose();
    _luasTanamController.dispose();
    _umurTanamController.dispose();
    _umurPersemaianController.dispose();
    _penyebabController.dispose();
    _penangananController.dispose();
    _tinggiBanjirController.dispose();
    _sisaTerkenaController.dispose();
    _sisaTerkenaMenjadiRinganController.dispose();

    _sisaTerkenaMenjadiSedangController.dispose();
    _sisaTerkenaMenjadiBeratController.dispose();
    _sisaTerkenaMenjadiPusoController.dispose();
    _sisaTerkenaMenjadiSurutController.dispose();
    _sisaTerkenaMenjadiPulihController.dispose();
    _sisaTerkenaJumlahController.dispose();

    _luasTambahTerkenaController.dispose();
    _luasTambahRinganController.dispose();
    _luasTambahSedangController.dispose();
    _luasTambahBeratController.dispose();
    _luasTambahPulihController.dispose();
    _luasTambahPusoController.dispose();
    _luasTambahSurutController.dispose();
    _luasTambahJumlahController.dispose();

    _keadaanTerkenaController.dispose();
    _keadaanRinganController.dispose();
    _keadaanSedangController.dispose();
    _keadaanBeratController.dispose();
    _keadaanPusoController.dispose();
    _keadaanSurutController.dispose();
    _keadaanPulihController.dispose();
    _keadaanJumlahController.dispose();

    _thMTController.dispose();
    _periodeOkmarAsepController.dispose();
    _mtMKMHController.dispose();
    _subRoundController.dispose();
    _visitedAtController.dispose();

    _curahHujanController.dispose();
  }

  void initState() {
    super.initState();
    _stateInitialization();
  }

  Future<void> _stateInitialization() async {
    int _idLaporan = widget.idLaporan;
    DPIType _type = widget.type;

    Map<String, dynamic> _dataLogin = await AkunFuture.getDataLogin();
    int _idProvinsiUser = _dataLogin[SPKey.provinsiUser];
    int _idKabupatenKotaUser = _dataLogin[SPKey.kabupatenKotaUser];
    int _idUser = _dataLogin[SPKey.idUser];

    List _kWK = await DPIFuture.getKecamatanWilayahKerja(
        idProvinsi: _idProvinsiUser,
        idKabupaten: _idKabupatenKotaUser,
        idUser: _idUser);
    _kWK = _kWK.map((kecamatan) => kecamatan['kecamatan']).toList();

    List _komoditas = await DPIFuture.getKomoditas();

    if (_idLaporan != null) {
      Map<String, dynamic> _detailDPI =
          await DPIFuture.getDetailDPI(_idLaporan, _type);

      if (_detailDPI != null) {
        int _kecWilKerTerpilih = _detailDPI['kecamatan']['id'];

        List _desaWilKer = await DPIFuture.getDesaWilayahKerja(
            idProvinsi: _idProvinsiUser,
            idKabupaten: _idKabupatenKotaUser,
            idKecamatan: _kecWilKerTerpilih);
        _desaWilKer = _desaWilKer.map((desa) => desa['desa']).toList();

        int _desWilKerTerpilih = _detailDPI['desa']['id'];
        int _komoditasTerpilih = _detailDPI['komoditas']['id'];
        String _periodeTerpilih = _detailDPI['periode'];

        // if (false) {
        setState(() {
          _showBulan = true;
          _showTahun = true;
          _showLat = true;
          _showLong = true;
          _showPeriodeOkmarAsep = true;
          _showTHMT = true;
          _showMTMKMH = true;
          _showSubround = true;

          _fotoPath = _detailDPI['photo'];
          _kecamatanWilKerState = _kWK;
          _kecamatanWilKerSelected = _kecWilKerTerpilih;
          _kecamatanWilKerSelectedString = _detailDPI['kecamatan']['name'];

          _desaWilKerState = _desaWilKer;
          _desaWilKerSelected = _desWilKerTerpilih;
          _desaWilKerSelectedString = _detailDPI['desa']['name'];

          _komoditasState = _komoditas;
          _komoditasSelected = _komoditasTerpilih;
          _komoditasSelectedString = _detailDPI['komoditas']['name'];

          _periodeSelected = _periodeTerpilih;

          _provinsiUserController.text = _dataLogin[SPKey.provinsiUserString];
          _kotaKabupatenUserController.text =
              _dataLogin[SPKey.kabupatenKotaUserString];

          _bulanController.text = _detailDPI['bulan'].toString();
          _tahunController.text = _detailDPI['tahun'];
          _latitudeController.text = _detailDPI['lat'];
          _longitudeController.text = _detailDPI['lng'];

          _varietasController.text = _detailDPI['varietas'];
          _umurPersemaianController.text =
              _detailDPI['persemaian']['umur'].toString();
          _luasPersemaianController.text =
              _detailDPI['persemaian']['luas'].toString();
          _umurTanamController.text = _detailDPI['tanam']['umur'].toString();
          _luasTanamController.text = _detailDPI['tanam']['luas'].toString();
          _penyebabController.text = _detailDPI['penyebab'];
          _penangananController.text = _detailDPI['penanganan'];

          if (widget.tinggiBanjir) {
            _curahHujanController.text = _detailDPI['curah_hujan'];
            _tinggiBanjirController.text =
                _detailDPI['tinggi_banjir'].toString();
          }

          if (widget.sisaTerkena) {
            _sisaTerkenaController.text = _detailDPI['sisa_terkena'];
          }
          if (widget.sisaTerkenaMenjadiRingan) {
            _sisaTerkenaMenjadiRinganController.text =
                _detailDPI['sisa_terkena_menjadi_ringan'];
          }
          if (widget.sisaTerkenaMenjadiSedang) {
            _sisaTerkenaMenjadiSedangController.text =
                _detailDPI['sisa_terkena_menjadi_sedang'];
          }
          if (widget.sisaTerkenaMenjadiBerat) {
            _sisaTerkenaMenjadiBeratController.text =
                _detailDPI['sisa_terkena_menjadi_berat'];
          }
          if (widget.sisaTerkenaMenjadiPuso) {
            _sisaTerkenaMenjadiPusoController.text =
                _detailDPI['sisa_terkena_menjadi_puso'];
          }
          if (widget.sisaTerkenaMenjadiPulih) {
            _sisaTerkenaMenjadiPulihController.text =
                _detailDPI['sisa_terkena_menjadi_pulih'];
          }
          if (widget.sisaTerkenaJumlah) {
            _sisaTerkenaJumlahController.text =
                _detailDPI['sisa_terkena_jumlah'];
          }
          if (widget.sisaTerkenaMenjadiSurut) {
            _sisaTerkenaMenjadiSurutController.text =
                _detailDPI['sisa_terkena_menjadi_surut'];
          }

          if (widget.luasTambahRingan) {
            _luasTambahRinganController.text = _detailDPI['luas_tambah_ringan'];
          }
          if (widget.luasTambahSedang) {
            _luasTambahSedangController.text = _detailDPI['luas_tambah_sedang'];
          }
          if (widget.luasTambahBerat) {
            _luasTambahBeratController.text = _detailDPI['luas_tambah_berat'];
          }
          if (widget.luasTambahTerkena) {
            _luasTambahTerkenaController.text =
                _detailDPI['luas_tambah_terkena'];
          }
          if (widget.luasTambahPulih) {
            _luasTambahPulihController.text = _detailDPI['luas_tambah_pulih'];
          }
          if (widget.luasTambahJumlah) {
            _luasTambahJumlahController.text = _detailDPI['luas_tambah_jumlah'];
          }
          _luasTambahPusoController.text = _detailDPI['luas_tambah_puso'];
          if (widget.luasTambahSurut) {
            _luasTambahSurutController.text = _detailDPI['luas_tambah_surut'];
          }
          if (widget.keadaanTerkena) {
            _keadaanTerkenaController.text = _detailDPI['keadaan_terkena'];
          }

          if (widget.keadaanSurut) {
            _keadaanSurutController.text = _detailDPI['keadaan_surut'];
          }
          if (widget.keadaanRingan) {
            _keadaanRinganController.text = _detailDPI['keadaan_ringan'];
          }
          if (widget.keadaanSedang) {
            _keadaanSedangController.text = _detailDPI['keadaan_sedang'];
          }
          if (widget.keadaanBerat) {
            _keadaanBeratController.text = _detailDPI['keadaan_berat'];
          }

          _keadaanPusoController.text = _detailDPI['keadaan_puso'];
          if (widget.keadaanPulih) {
            _keadaanPulihController.text = _detailDPI['keadaan_pulih'];
          }
          if (widget.keadaanJumlah) {
            _keadaanJumlahController.text = _detailDPI['keadaan_jumlah'];
          }

          _periodeOkmarAsepController.text = _detailDPI['periode_okmar_asep'];
          _thMTController.text = _detailDPI['th_mt'];
          _mtMKMHController.text = _detailDPI['mt_mk_mh'];
          _subRoundController.text = _detailDPI['subround'];
          _visitedAtController.text = _detailDPI['visited_at'];
        });
        // }
      }
    } else {
      setState(() {
        _provinsiUserController.text = _dataLogin[SPKey.provinsiUserString];
        _kotaKabupatenUserController.text =
            _dataLogin[SPKey.kabupatenKotaUserString];

        _kecamatanWilKerState = _kWK;
        _komoditasState = _komoditas;
      });
    }
  }

  Future<void> _setData(BuildContext context,
      {@required PickedFile pickedFile,
      @required ImageSource imageSource,
      @required Map<String, dynamic> decodedExifData}) async {
    Map _image = decodedExifData['image'];
    if (_image.containsKey('ModifyDate')) {
      String _modifyDate = _image['ModifyDate'];

      List<String> _arrayOfTime = _modifyDate.split(' ');
      String _date = _arrayOfTime[0];
      _date = _date.replaceAll(':', '-');

      String _time = _arrayOfTime[1];

      _modifyDate = _date + ' ' + _time;

      DateTime _modifyDateDateTime = DateTime.parse(_modifyDate);
      int _intYear = _modifyDateDateTime.year;
      int _intMonth = _modifyDateDateTime.month;
      String _tahun = _intYear.toString();
      String _bulan = _intMonth.toString();
      String _tanggal = _modifyDateDateTime.day.toString();

      String _pOA;
      String _thMT;
      String _mtMKMH;
      String _subRound;
      String _latitude, _longitude;

      if (_intMonth < 4) {
        _pOA = 'OKMAR';
        _thMT = (_intYear - 1).toString() + '/' + (_intYear.toString());
        _mtMKMH = 'MH';
      } else {
        if (_intMonth < 10) {
          _pOA = 'ASEP';
          _thMT = _intYear.toString();
          _mtMKMH = 'MK';
        } else {
          _pOA = 'OKMAR';
          _thMT = (_intYear).toString() + '/' + ((_intYear + 1).toString());
          _mtMKMH = 'MH';
        }
      }

      if (_intMonth < 5) {
        _subRound = 'I';
      } else {
        if (_intMonth < 9) {
          _subRound = 'II';
        } else {
          _subRound = 'III';
        }
      }

      if (imageSource == ImageSource.camera) {
        Map<String, double> _savedLocation =
            await LocalStorage.getSavedLocation();
        _latitude = _savedLocation['latitude'].toString();
        _longitude = _savedLocation['longitude'].toString();
      } else {
        Map _gps = decodedExifData['gps'];
        if (_gps.containsKey('GPSLatitude') &&
            _gps.containsKey('GPSLongitude')) {
          List _latitudeArray =
              _gps['GPSLatitude']; //element runtimeType is double
          List _longitudeArray =
              _gps['GPSLongitude']; //element runtimeType is double

          double _latDeg = _latitudeArray[0];
          double _latMin = _latitudeArray[1] / 60;
          double _latSec = _latitudeArray[2] / 3600;

          double _longDeg = _longitudeArray[0];
          double _longMin = _longitudeArray[1] / 60;
          double _longSec = _longitudeArray[2] / 3600;

          _latitude = (_latDeg + _latMin + _latSec).toString();
          _longitude = (_longDeg + _longMin + _longSec).toString();
        } else {
          String _title = 'Foto Tidak Valid!';
          String _subTitle =
              'Foto yang dipakai tidak memiliki data lokasi yang diperlukan! Gunakan foto lain!';
          Widget _actions = Button.button(context, 'Coba Lagi', () {
            Navigator.pop(context);
          }, color: CustomColors.dangerColor, outline: true);

          await Alert.textComponent(context,
              icon: SvgPicture.asset(ClientPath.svgPath + '/danger.svg'),
              title: _title,
              subTitle: _subTitle,
              actions: _actions);
        }
      }

      if (_latitude != null && _longitude != null) {
        setState(() {
          _foto = pickedFile;
          _showTahun = true;
          _showBulan = true;
          _showPeriodeOkmarAsep = true;
          _showTHMT = true;
          _showMTMKMH = true;
          _showSubround = true;
          _showLat = true;
          _showLong = true;

          _latitudeController.text = _latitude;
          _longitudeController.text = _longitude;
          _bulanController.text = _bulan;
          _tahunController.text = _tahun;
          _periodeOkmarAsepController.text = _pOA;
          _thMTController.text = _thMT;
          _mtMKMHController.text = _mtMKMH;
          _subRoundController.text = _subRound;
          _visitedAtController.text = '$_tahun-$_bulan-$_tanggal';
        });
      }
    } else {
      String _title = 'Foto Tidak Valid!';
      String _subTitle =
          'Foto yang dipakai tidak memiliki data waktu yang diperlukan! Gunakan foto lain!';
      Widget _actions = Button.button(context, 'Coba Lagi', () {
        Navigator.pop(context);
      }, color: CustomColors.dangerColor, outline: true);

      await Alert.textComponent(context,
          icon: SvgPicture.asset(ClientPath.svgPath + '/danger.svg'),
          title: _title,
          subTitle: _subTitle,
          actions: _actions);
    }
  }

  void _calculateSisaTerkenaJumlah() {
    String _sTMR = _sisaTerkenaMenjadiRinganController.text;
    String _sTMS = _sisaTerkenaMenjadiSedangController.text;
    String _sTMB = _sisaTerkenaMenjadiBeratController.text;
    String _sTMPuso = _sisaTerkenaMenjadiPusoController.text;
    String _sTMPulih = _sisaTerkenaMenjadiPulihController.text;

    double _sisaTerkenaRingan = (_sTMR.isNotEmpty) ? double.parse(_sTMR) : 0;
    double _sisaTerkenaSedang = (_sTMS.isNotEmpty) ? double.parse(_sTMS) : 0;
    double _sisaTerkenaBerat = (_sTMB.isNotEmpty) ? double.parse(_sTMB) : 0;
    double _sisaTerkenaPuso =
        (_sTMPuso.isNotEmpty) ? double.parse(_sTMPuso) : 0;
    double _sisaTerkenaPulih =
        (_sTMPulih.isNotEmpty) ? double.parse(_sTMPulih) : 0;

    _sisaTerkenaJumlahController.text = (_sisaTerkenaRingan +
            _sisaTerkenaSedang +
            _sisaTerkenaBerat +
            _sisaTerkenaPuso +
            _sisaTerkenaPulih)
        .toString();
  }

  void _calculateLuasTambahJumlah() {
    String _lTR = _luasTambahRinganController.text;
    String _lTS = _luasTambahSedangController.text;
    String _lTB = _luasTambahBeratController.text;
    String _lTPuso = _luasTambahPusoController.text;
    String _lTPulih = _luasTambahPulihController.text;

    double _luasTambahRingan = (_lTR.isNotEmpty) ? double.parse(_lTR) : 0;
    double _luasTambahSedang = (_lTS.isNotEmpty) ? double.parse(_lTS) : 0;
    double _luasTambahBerat = (_lTB.isNotEmpty) ? double.parse(_lTB) : 0;
    double _luasTambahPuso = (_lTPuso.isNotEmpty) ? double.parse(_lTPuso) : 0;
    double _luasTambahPulih =
        (_lTPulih.isNotEmpty) ? double.parse(_lTPulih) : 0;

    _luasTambahJumlahController.text = (_luasTambahRingan +
            _luasTambahSedang +
            _luasTambahBerat +
            _luasTambahPuso +
            _luasTambahPulih)
        .toString();
  }

  void _calculateKeadaanTerkena() {
    String _sT = _sisaTerkenaController.text;
    String _lT = _luasTambahTerkenaController.text;

    double _sisaTerkena = (_sT.isNotEmpty) ? double.parse(_sT) : 0;
    double _luasTambahTerkena = (_lT.isNotEmpty) ? double.parse(_lT) : 0;

    _keadaanTerkenaController.text =
        (_sisaTerkena + _luasTambahTerkena).toString();
  }

  void _calculateKeadaanRingan() {
    String _sTMR = _sisaTerkenaMenjadiRinganController.text;
    String _lTR = _luasTambahRinganController.text;

    double _sisaTerkenaRingan = (_sTMR.isNotEmpty) ? double.parse(_sTMR) : 0;
    double _luasTambahRingan = (_lTR.isNotEmpty) ? double.parse(_lTR) : 0;

    _keadaanRinganController.text =
        (_sisaTerkenaRingan + _luasTambahRingan).toString();
    _calculateKeadaanJumlah();
  }

  void _calculateKeadaanSedang() {
    String _sTMS = _sisaTerkenaMenjadiSedangController.text;
    String _lTS = _luasTambahSedangController.text;

    double _sisaTerkenaSedang = (_sTMS.isNotEmpty) ? double.parse(_sTMS) : 0;
    double _luasTambahSedang = (_lTS.isNotEmpty) ? double.parse(_lTS) : 0;

    _keadaanSedangController.text =
        (_sisaTerkenaSedang + _luasTambahSedang).toString();
    _calculateKeadaanJumlah();
  }

  void _calculateKeadaanBerat() {
    String _sTB = _sisaTerkenaMenjadiBeratController.text;
    String _lTB = _luasTambahBeratController.text;

    double _sisaTerkenaBerat = (_sTB.isNotEmpty) ? double.parse(_sTB) : 0;
    double _luasTambahBerat = (_lTB.isNotEmpty) ? double.parse(_lTB) : 0;
    _keadaanBeratController.text =
        (_sisaTerkenaBerat + _luasTambahBerat).toString();
    _calculateKeadaanJumlah();
  }

  void _calculateKeadaanPuso() {
    String _sTMPuso = _sisaTerkenaMenjadiPusoController.text;
    String _lTPuso = _luasTambahPusoController.text;

    double _sisaTerkenaPuso =
        (_sTMPuso.isNotEmpty) ? double.parse(_sTMPuso) : 0;
    double _luasTambahPuso = (_lTPuso.isNotEmpty) ? double.parse(_lTPuso) : 0;

    _keadaanPusoController.text =
        (_sisaTerkenaPuso + _luasTambahPuso).toString();
    _calculateKeadaanJumlah();
  }

  void _calculateKeadaanPulih() {
    String _sTMPulih = _sisaTerkenaMenjadiPulihController.text;
    String _lTPulih = _luasTambahPulihController.text;

    double _sisaTerkenaPulih =
        (_sTMPulih.isNotEmpty) ? double.parse(_sTMPulih) : 0;
    double _luasTambahPulih =
        (_lTPulih.isNotEmpty) ? double.parse(_lTPulih) : 0;
    _keadaanPulihController.text =
        (_sisaTerkenaPulih + _luasTambahPulih).toString();

    _calculateKeadaanJumlah();
  }

  void _calculateKeadaanJumlah() {
    String _kR = _keadaanRinganController.text;
    String _kS = _keadaanSedangController.text;
    String _kB = _keadaanBeratController.text;
    String _kPuso = _keadaanPusoController.text;
    String _kPulih = _keadaanPulihController.text;

    double _keadaanRingan = (_kR.isNotEmpty) ? double.parse(_kR) : 0;
    double _keadaanSedang = (_kS.isNotEmpty) ? double.parse(_kS) : 0;
    double _keadaanBerat = (_kB.isNotEmpty) ? double.parse(_kB) : 0;
    double _keadaanPuso = (_kPuso.isNotEmpty) ? double.parse(_kPuso) : 0;
    double _keadaanPulih = (_kPulih.isNotEmpty) ? double.parse(_kPulih) : 0;

    _keadaanJumlahController.text = (_keadaanRingan +
            _keadaanSedang +
            _keadaanBerat +
            _keadaanPuso +
            _keadaanPulih)
        .toStringAsFixed(2);
  }

  void _calculateKeadaanSurut() {
    String _sS = _sisaTerkenaMenjadiSurutController.text;
    String _lTS = _luasTambahSurutController.text;

    double _sisaSurut = (_sS.isNotEmpty) ? double.parse(_sS) : 0;
    double _luasTambahSurut = (_lTS.isNotEmpty) ? double.parse(_lTS) : 0;

    _keadaanSurutController.text = (_sisaSurut + _luasTambahSurut).toString();
  }

  Widget build(BuildContext context) {
    SizeConfig().initSize(context);

    bool _isBtnSubmitActive = widget.isBtnSubmitActive;

    double _paddingTop = SizeConfig.horizontalBlock * 4.0;

    double _labelAndFieldSpace = 10.0;
    double _textFieldLabelFontSize = SizeConfig.horizontalBlock * 3.0;
    double _leadingAndHintTextSpacing = SizeConfig.horizontalBlock * 3.25;

    Color _borderColor = Color(0xFFCBD2D9);

    FontWeight _textFieldLabelFontWeight = FontWeight.w800;

    int _idLaporan = widget.idLaporan;
    DPIAndOPTAction _action = widget.action;

    bool _enableInput = true;
    if (_action == DPIAndOPTAction.detail) {
      _enableInput = false;
    }

    List<DropdownMenuItem> _kecamatanWilKer = Wilayah.dropdownMenuItemBuilder(
        _kecamatanWilKerState,
        textIndex: 'name',
        valueIndex: 'id');

    List<DropdownMenuItem> _desaWilKer = Wilayah.dropdownMenuItemBuilder(
        _desaWilKerState,
        textIndex: 'name',
        valueIndex: 'id');

    List<DropdownMenuItem> _komoditas = Wilayah.dropdownMenuItemBuilder(
        _komoditasState,
        textIndex: 'name',
        valueIndex: 'id');

    List<DropdownMenuItem> _periode = Wilayah.dropdownMenuItemBuilder(
        _periodeState,
        textIndex: 'text',
        valueIndex: 'value');

    String _dpiAndOPTTitle = widget.dpiAndOPTTitle;

    FocusScopeNode _focusScope = FocusScope.of(context);

    bool _readyToShow = true;
    if (_action == DPIAndOPTAction.detail || _action == DPIAndOPTAction.edit) {
      _readyToShow = (_fotoPath == null) ? false : true;
    }

    Widget _pinGmapsIcon = SvgPicture.asset(ClientPath.svgPath + '/map-pin.svg',
        width: SizeConfig.horizontalBlock * 5.5,
        color: CustomColors.dangerColor);

    TextInputFormatter _comaFormatter =
        FilteringTextInputFormatter.deny(RegExp(','));

    return Scaffold(
        appBar: CustomNavigation.appBar(
            appBarContext: context, title: _dpiAndOPTTitle),
        body: (_readyToShow)
            ? Padding(
                padding: EdgeInsets.only(
                    left: SizeConfig.leftAndRightContentContainerPadding,
                    right: SizeConfig.leftAndRightContentContainerPadding,
                    bottom: SizeConfig.leftAndRightContentContainerPadding),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.horizontalBlock * 5.0),
                          child: Row(children: [
                            Icon(Icons.info_outline_rounded,
                                color: CustomColors.eLaporRed,
                                size: SizeConfig.horizontalBlock * 7.5),
                            SizedBox(width: SizeConfig.horizontalBlock * 3.0),
                            Text(_dpiAndOPTTitle,
                                style: TextStyle(
                                    fontSize: SizeConfig.horizontalBlock * 5.0,
                                    fontWeight: FontWeight.w700))
                          ]),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: _paddingTop),
                            child: Container(
                              height: 0.5,
                              width: SizeConfig.horizontalBlock * 100.0,
                              decoration: BoxDecoration(
                                  color: CustomColors.eLaporIconColor),
                            )),
                        (_action == DPIAndOPTAction.detail ||
                                _action == DPIAndOPTAction.edit)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Container(
                                  constraints: BoxConstraints(
                                      minHeight:
                                          SizeConfig.horizontalBlock * 45.0),
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          SizeConfig.horizontalBlock * 10.0),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.contain,
                                          image: (_foto != null)
                                              ? FileImage(File(_foto.path))
                                              : NetworkImage(
                                                  ServerPath.apiBaseURL +
                                                      '/elapor/' +
                                                      _fotoPath)),
                                      borderRadius: BorderRadius.circular(15.0),
                                      color: Color(0X5534C369)),
                                ))
                            : (_foto != null)
                                ? Padding(
                                    padding: EdgeInsets.only(top: _paddingTop),
                                    child: Container(
                                      constraints: BoxConstraints(
                                          minHeight:
                                              SizeConfig.horizontalBlock *
                                                  45.0),
                                      padding: EdgeInsets.symmetric(
                                          vertical: SizeConfig.horizontalBlock *
                                              10.0),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.contain,
                                              image:
                                                  FileImage(File(_foto.path))),
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          color: Color(0X5534C369)),
                                    ))
                                : SizedBox(),
                        (_action == DPIAndOPTAction.add ||
                                _action == DPIAndOPTAction.edit)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Button.submitButton(
                                    context, 'PILIH/AMBIL FOTO', () async {
                                  ImageSource _imageSource =
                                      await ImagePickerDialog.showImagePicker(
                                          context,
                                          isDismissible: true);
                                  if (_imageSource != null) {
                                    PickedFile _pickedFile =
                                        await ImagePickerDialog.takePicture(
                                            context, _imageSource);

                                    if (_pickedFile != null) {
                                      File _file = File(_pickedFile.path);
                                      List<int> _filesIntBytes =
                                          _file.readAsBytesSync();
                                      metaData.CallBack _callBack =
                                          metaData.MetaData.exifData(
                                              _filesIntBytes);

                                      if (_callBack != null) {
                                        dynamic _exifData = _callBack.exifData;
                                        if (_exifData != null) {
                                          await _setData(context,
                                              pickedFile: _pickedFile,
                                              decodedExifData: _exifData,
                                              imageSource: _imageSource);
                                        }
                                      }
                                    }
                                  }
                                },
                                    color: CustomColors.eLaporGreen,
                                    trailing: Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        color: CustomColors.eLaporWhite)))
                            : SizedBox(),
                        (_showBulan)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomForm.textFieldLabel(context,
                                          label: 'Bulan',
                                          color: CustomColors.eLaporBlack,
                                          fontSize: _textFieldLabelFontSize,
                                          fontWeight:
                                              _textFieldLabelFontWeight),
                                      SizedBox(height: _labelAndFieldSpace),
                                      CustomForm.textField(context,
                                          leading: _pinGmapsIcon,
                                          enabled: false,
                                          controller: _bulanController,
                                          hintText: 'Masukkan Nilai',
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            DecimalTextInputFormatter(
                                                decimalRange: 2),
                                            _comaFormatter
                                          ],
                                          borderColor: _borderColor,
                                          leadingAndHintTextSpacing:
                                              _leadingAndHintTextSpacing)
                                    ]),
                              )
                            : SizedBox(),
                        (_showTahun)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomForm.textFieldLabel(context,
                                          label: 'Tahun',
                                          color: CustomColors.eLaporBlack,
                                          fontSize: _textFieldLabelFontSize,
                                          fontWeight:
                                              _textFieldLabelFontWeight),
                                      SizedBox(height: _labelAndFieldSpace),
                                      CustomForm.textField(context,
                                          enabled: false,
                                          controller: _tahunController,
                                          hintText: 'Masukkan Nilai',
                                          keyboardType: TextInputType.text,
                                          borderColor: _borderColor,
                                          leading: _pinGmapsIcon,
                                          leadingAndHintTextSpacing:
                                              _leadingAndHintTextSpacing)
                                    ]),
                              )
                            : SizedBox(),
                        (_showLat)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomForm.textFieldLabel(context,
                                          label: 'Latitude',
                                          color: CustomColors.eLaporBlack,
                                          fontSize: _textFieldLabelFontSize,
                                          fontWeight:
                                              _textFieldLabelFontWeight),
                                      SizedBox(height: _labelAndFieldSpace),
                                      CustomForm.textField(context,
                                          enabled: false,
                                          controller: _latitudeController,
                                          hintText: 'Masukkan Nilai',
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            DecimalTextInputFormatter(
                                                decimalRange: 2),
                                            _comaFormatter
                                          ],
                                          borderColor: _borderColor,
                                          leading: _pinGmapsIcon,
                                          leadingAndHintTextSpacing:
                                              _leadingAndHintTextSpacing)
                                    ]),
                              )
                            : SizedBox(),
                        (_showLong)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomForm.textFieldLabel(context,
                                          label: 'Longitude',
                                          color: CustomColors.eLaporBlack,
                                          fontSize: _textFieldLabelFontSize,
                                          fontWeight:
                                              _textFieldLabelFontWeight),
                                      SizedBox(height: _labelAndFieldSpace),
                                      CustomForm.textField(context,
                                          enabled: false,
                                          controller: _longitudeController,
                                          hintText: 'Masukkan Nilai',
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            DecimalTextInputFormatter(
                                                decimalRange: 2),
                                            _comaFormatter
                                          ],
                                          borderColor: _borderColor,
                                          leading: _pinGmapsIcon,
                                          leadingAndHintTextSpacing:
                                              _leadingAndHintTextSpacing)
                                    ]),
                              )
                            : SizedBox(),
                        Padding(
                          padding: EdgeInsets.only(top: _paddingTop),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomForm.textFieldLabel(context,
                                    label: 'Provinsi',
                                    color: CustomColors.eLaporBlack,
                                    fontSize: _textFieldLabelFontSize,
                                    fontWeight: _textFieldLabelFontWeight),
                                SizedBox(height: _labelAndFieldSpace),
                                CustomForm.textField(context,
                                    enabled: false,
                                    hintText: 'Provinsi',
                                    leading: _pinGmapsIcon,
                                    leadingAndHintTextSpacing:
                                        _leadingAndHintTextSpacing,
                                    controller: _provinsiUserController,
                                    borderColor: _borderColor)
                              ]),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: _paddingTop),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomForm.textFieldLabel(context,
                                    label: 'Kota/Kabupaten',
                                    color: CustomColors.eLaporBlack,
                                    fontSize: _textFieldLabelFontSize,
                                    fontWeight: _textFieldLabelFontWeight),
                                SizedBox(height: _labelAndFieldSpace),
                                CustomForm.textField(context,
                                    enabled: false,
                                    leading: _pinGmapsIcon,
                                    leadingAndHintTextSpacing:
                                        _leadingAndHintTextSpacing,
                                    hintText: 'Kota/Kabupaten',
                                    controller: _kotaKabupatenUserController,
                                    borderColor: _borderColor)
                              ]),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: _paddingTop),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomForm.textFieldLabel(context,
                                    label: 'Kecamatan',
                                    color: CustomColors.eLaporBlack,
                                    fontSize: _textFieldLabelFontSize,
                                    fontWeight: _textFieldLabelFontWeight),
                                SizedBox(height: _labelAndFieldSpace),
                                (_enableInput)
                                    ? CustomForm.selectBox(context,
                                        leading: _pinGmapsIcon,
                                        leadingAndHintTextSpacing:
                                            _leadingAndHintTextSpacing,
                                        borderColor: _borderColor,
                                        items: _kecamatanWilKer,
                                        value: _kecamatanWilKerSelected,
                                        onChanged: (selected) async {
                                        setState(() {
                                          _desaWilKerState = [];
                                          _desaWilKerSelected = 0;
                                        });

                                        Map<String, dynamic> _dataLogin =
                                            await AkunFuture.getDataLogin();
                                        int _provinsiUser =
                                            _dataLogin[SPKey.provinsiUser];
                                        int _kabupatenUser =
                                            _dataLogin[SPKey.kabupatenKotaUser];

                                        List _dWK =
                                            await DPIFuture.getDesaWilayahKerja(
                                                idProvinsi: _provinsiUser,
                                                idKabupaten: _kabupatenUser,
                                                idKecamatan: selected);
                                        _dWK = _dWK
                                            .map((desa) => desa['desa'])
                                            .toList();

                                        setState(() {
                                          _kecamatanWilKerSelected = selected;
                                          _desaWilKerSelected = 0;
                                          _desaWilKerState = _dWK;
                                        });
                                      },
                                        defaultOptionText: 'Pilih Kecamatan',
                                        defaultOptionValue: 0)
                                    : CustomForm.readOnlyTextField(context,
                                        leading: _pinGmapsIcon,
                                        leadingAndHintTextSpacing:
                                            _leadingAndHintTextSpacing,
                                        borderColor: _borderColor,
                                        value: _kecamatanWilKerSelectedString)
                              ]),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: _paddingTop),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomForm.textFieldLabel(context,
                                    label: 'desa/kelurahan',
                                    color: CustomColors.eLaporBlack,
                                    fontSize: _textFieldLabelFontSize,
                                    fontWeight: _textFieldLabelFontWeight),
                                SizedBox(height: _labelAndFieldSpace),
                                (_enableInput)
                                    ? CustomForm.selectBox(context,
                                        leading: _pinGmapsIcon,
                                        leadingAndHintTextSpacing:
                                            _leadingAndHintTextSpacing,
                                        borderColor: _borderColor,
                                        items: _desaWilKer,
                                        value: _desaWilKerSelected,
                                        onChanged: (selected) {
                                        setState(() {
                                          _desaWilKerSelected = selected;
                                        });
                                      },
                                        defaultOptionText: 'Pilih Desa',
                                        defaultOptionValue: 0)
                                    : CustomForm.readOnlyTextField(context,
                                        leading: _pinGmapsIcon,
                                        leadingAndHintTextSpacing:
                                            _leadingAndHintTextSpacing,
                                        borderColor: _borderColor,
                                        value: _desaWilKerSelectedString)
                              ]),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: _paddingTop),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomForm.textFieldLabel(context,
                                    label: 'Komoditas',
                                    color: CustomColors.eLaporBlack,
                                    fontSize: _textFieldLabelFontSize,
                                    fontWeight: _textFieldLabelFontWeight),
                                SizedBox(height: _labelAndFieldSpace),
                                (_enableInput)
                                    ? CustomForm.selectBox(context,
                                        leading: _pinGmapsIcon,
                                        leadingAndHintTextSpacing:
                                            _leadingAndHintTextSpacing,
                                        borderColor: _borderColor,
                                        items: _komoditas,
                                        value: _komoditasSelected,
                                        onChanged: (selected) {
                                        setState(() {
                                          _komoditasSelected = selected;
                                        });
                                      },
                                        defaultOptionText: 'Pilih Komoditas',
                                        defaultOptionValue: 0)
                                    : CustomForm.readOnlyTextField(context,
                                        leading: _pinGmapsIcon,
                                        leadingAndHintTextSpacing:
                                            _leadingAndHintTextSpacing,
                                        value: _komoditasSelectedString,
                                        borderColor: _borderColor)
                              ]),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: _paddingTop),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomForm.textFieldLabel(context,
                                    label: 'Varietas',
                                    color: CustomColors.eLaporBlack,
                                    fontSize: _textFieldLabelFontSize,
                                    fontWeight: _textFieldLabelFontWeight),
                                SizedBox(height: _labelAndFieldSpace),
                                CustomForm.textField(context,
                                    leading: _pinGmapsIcon,
                                    leadingAndHintTextSpacing:
                                        _leadingAndHintTextSpacing,
                                    enabled: _enableInput,
                                    borderColor: _borderColor,
                                    maxLength: 100,
                                    hintText: 'Masukkan Nilai',
                                    controller: _varietasController,
                                    onEditingComplete: () =>
                                        _focusScope.nextFocus())
                              ]),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: _paddingTop),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomForm.textFieldLabel(context,
                                    label: 'Umur persemaian (hari)',
                                    color: CustomColors.eLaporBlack,
                                    fontSize: _textFieldLabelFontSize,
                                    fontWeight: _textFieldLabelFontWeight),
                                SizedBox(height: _labelAndFieldSpace),
                                CustomForm.textField(context,
                                    leading: _pinGmapsIcon,
                                    leadingAndHintTextSpacing:
                                        _leadingAndHintTextSpacing,
                                    enabled: _enableInput,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      DecimalTextInputFormatter(
                                          decimalRange: 2),
                                      _comaFormatter
                                    ],
                                    borderColor: _borderColor,
                                    hintText: 'Masukkan Nilai',
                                    controller: _umurPersemaianController,
                                    onEditingComplete: () =>
                                        _focusScope.nextFocus())
                              ]),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: _paddingTop),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomForm.textFieldLabel(context,
                                    label: 'Luas persemaian (ha)',
                                    color: CustomColors.eLaporBlack,
                                    fontSize: _textFieldLabelFontSize,
                                    fontWeight: _textFieldLabelFontWeight),
                                SizedBox(height: _labelAndFieldSpace),
                                CustomForm.textField(context,
                                    leading: _pinGmapsIcon,
                                    leadingAndHintTextSpacing:
                                        _leadingAndHintTextSpacing,
                                    enabled: _enableInput,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      DecimalTextInputFormatter(
                                          decimalRange: 2),
                                      _comaFormatter
                                    ],
                                    borderColor: _borderColor,
                                    hintText: 'Masukkan Nilai',
                                    controller: _luasPersemaianController,
                                    onEditingComplete: () =>
                                        _focusScope.nextFocus())
                              ]),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: _paddingTop),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomForm.textFieldLabel(context,
                                    label: 'HST (hari)',
                                    color: CustomColors.eLaporBlack,
                                    fontSize: _textFieldLabelFontSize,
                                    fontWeight: _textFieldLabelFontWeight),
                                SizedBox(height: _labelAndFieldSpace),
                                CustomForm.textField(context,
                                    leading: _pinGmapsIcon,
                                    leadingAndHintTextSpacing:
                                        _leadingAndHintTextSpacing,
                                    enabled: _enableInput,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      DecimalTextInputFormatter(
                                          decimalRange: 2),
                                      _comaFormatter
                                    ],
                                    hintText: 'Masukkan Nilai',
                                    borderColor: _borderColor,
                                    controller: _umurTanamController,
                                    onEditingComplete: () =>
                                        _focusScope.nextFocus())
                              ]),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: _paddingTop),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomForm.textFieldLabel(context,
                                    label: 'Luas tanam (ha)',
                                    color: CustomColors.eLaporBlack,
                                    fontSize: _textFieldLabelFontSize,
                                    fontWeight: _textFieldLabelFontWeight),
                                SizedBox(height: _labelAndFieldSpace),
                                CustomForm.textField(context,
                                    leading: _pinGmapsIcon,
                                    leadingAndHintTextSpacing:
                                        _leadingAndHintTextSpacing,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      DecimalTextInputFormatter(
                                          decimalRange: 2),
                                      _comaFormatter
                                    ],
                                    enabled: _enableInput,
                                    hintText: 'Masukkan Nilai',
                                    borderColor: _borderColor,
                                    controller: _luasTanamController,
                                    onEditingComplete: () =>
                                        _focusScope.nextFocus())
                              ]),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: _paddingTop),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomForm.textFieldLabel(context,
                                    label: 'Periode Laporan',
                                    color: CustomColors.eLaporBlack,
                                    fontSize: _textFieldLabelFontSize,
                                    fontWeight: _textFieldLabelFontWeight),
                                SizedBox(height: _labelAndFieldSpace),
                                (_enableInput)
                                    ? CustomForm.selectBox(context,
                                        leading: _pinGmapsIcon,
                                        leadingAndHintTextSpacing:
                                            _leadingAndHintTextSpacing,
                                        borderColor: _borderColor,
                                        items: _periode,
                                        value: _periodeSelected,
                                        onChanged: (selected) {
                                        setState(() {
                                          _periodeSelected = selected;
                                        });
                                      },
                                        defaultOptionText: 'Pilih Periode',
                                        defaultOptionValue: '')
                                    : CustomForm.readOnlyTextField(context,
                                        leading: _pinGmapsIcon,
                                        leadingAndHintTextSpacing:
                                            _leadingAndHintTextSpacing,
                                        value: _periodeSelected,
                                        borderColor: _borderColor)
                              ]),
                        ),
                        (widget.tinggiBanjir)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomForm.textFieldLabel(context,
                                          label: 'Curah Hujan (mm/hari)',
                                          color: CustomColors.eLaporBlack,
                                          fontSize: _textFieldLabelFontSize,
                                          fontWeight:
                                              _textFieldLabelFontWeight),
                                      SizedBox(height: _labelAndFieldSpace),
                                      CustomForm.textField(context,
                                          leading: _pinGmapsIcon,
                                          leadingAndHintTextSpacing:
                                              _leadingAndHintTextSpacing,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            DecimalTextInputFormatter(
                                                decimalRange: 2),
                                            _comaFormatter
                                          ],
                                          enabled: _enableInput,
                                          hintText: 'Masukkan Nilai',
                                          borderColor: _borderColor,
                                          controller: _curahHujanController,
                                          onEditingComplete: () =>
                                              _focusScope.nextFocus())
                                    ]),
                              )
                            : SizedBox(),
                        Padding(
                          padding: EdgeInsets.only(top: _paddingTop),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomForm.textFieldLabel(context,
                                    label: 'PENYEBAB',
                                    color: CustomColors.eLaporBlack,
                                    fontSize: _textFieldLabelFontSize,
                                    fontWeight: _textFieldLabelFontWeight),
                                SizedBox(height: _labelAndFieldSpace),
                                CustomForm.textField(context,
                                    leading: _pinGmapsIcon,
                                    leadingAndHintTextSpacing:
                                        _leadingAndHintTextSpacing,
                                    maxLength: 100,
                                    counterText: null,
                                    hintText: 'Deskripsikan',
                                    enabled: _enableInput,
                                    borderColor: _borderColor,
                                    controller: _penyebabController,
                                    onEditingComplete: () =>
                                        _focusScope.nextFocus())
                              ]),
                        ),
                        (widget.tinggiBanjir)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomForm.textFieldLabel(context,
                                          label: 'Tinggi banjir (cm)',
                                          color: CustomColors.eLaporBlack,
                                          fontSize: _textFieldLabelFontSize,
                                          fontWeight:
                                              _textFieldLabelFontWeight),
                                      SizedBox(height: _labelAndFieldSpace),
                                      CustomForm.textField(context,
                                          leading: _pinGmapsIcon,
                                          leadingAndHintTextSpacing:
                                              _leadingAndHintTextSpacing,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            DecimalTextInputFormatter(
                                                decimalRange: 2),
                                            _comaFormatter
                                          ],
                                          enabled: _enableInput,
                                          hintText: 'Masukkan Nilai',
                                          borderColor: _borderColor,
                                          controller: _tinggiBanjirController,
                                          onEditingComplete: () =>
                                              _focusScope.nextFocus())
                                    ]),
                              )
                            : SizedBox(),
                        Padding(
                          padding: EdgeInsets.only(top: _paddingTop),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomForm.textFieldLabel(context,
                                    label: 'penanganan',
                                    color: CustomColors.eLaporBlack,
                                    fontSize: _textFieldLabelFontSize,
                                    fontWeight: _textFieldLabelFontWeight),
                                SizedBox(height: _labelAndFieldSpace),
                                CustomForm.textField(context,
                                    leading: _pinGmapsIcon,
                                    leadingAndHintTextSpacing:
                                        _leadingAndHintTextSpacing,
                                    maxLength: 100,
                                    counterText: null,
                                    enabled: _enableInput,
                                    hintText: 'Deskripsikan',
                                    borderColor: _borderColor,
                                    controller: _penangananController,
                                    onEditingComplete: () =>
                                        _focusScope.nextFocus())
                              ]),
                        ),
                        (widget.sisaTerkena)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomForm.textFieldLabel(context,
                                          label: 'Sisa Terkena (ha)',
                                          color: CustomColors.eLaporBlack,
                                          fontSize: _textFieldLabelFontSize,
                                          fontWeight:
                                              _textFieldLabelFontWeight),
                                      SizedBox(height: _labelAndFieldSpace),
                                      CustomForm.textField(context,
                                          leading: _pinGmapsIcon,
                                          leadingAndHintTextSpacing:
                                              _leadingAndHintTextSpacing,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            DecimalTextInputFormatter(
                                                decimalRange: 2),
                                            _comaFormatter
                                          ],
                                          hintText: 'Masukkan Nilai',
                                          enabled: _enableInput,
                                          borderColor: _borderColor,
                                          controller: _sisaTerkenaController,
                                          onChange: (value) {
                                            _calculateKeadaanTerkena();
                                          },
                                          onEditingComplete: () =>
                                              _focusScope.nextFocus())
                                    ]),
                              )
                            : SizedBox(),
                        (widget.sisaTerkenaMenjadiRingan)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomForm.textFieldLabel(context,
                                          label:
                                              'Sisa Terkena Menjadi (Ringan) (ha)',
                                          color: CustomColors.eLaporBlack,
                                          fontSize: _textFieldLabelFontSize,
                                          fontWeight:
                                              _textFieldLabelFontWeight),
                                      SizedBox(height: _labelAndFieldSpace),
                                      CustomForm.textField(context,
                                          leading: _pinGmapsIcon,
                                          leadingAndHintTextSpacing:
                                              _leadingAndHintTextSpacing,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            DecimalTextInputFormatter(
                                                decimalRange: 2),
                                            _comaFormatter
                                          ],
                                          enabled: _enableInput,
                                          hintText: 'Masukkan Nilai',
                                          borderColor: _borderColor,
                                          controller:
                                              _sisaTerkenaMenjadiRinganController,
                                          onEditingComplete: () =>
                                              _focusScope.nextFocus(),
                                          onChange: (value) {
                                            _calculateSisaTerkenaJumlah();
                                            _calculateKeadaanRingan();
                                          })
                                    ]),
                              )
                            : SizedBox(),
                        (widget.sisaTerkenaMenjadiSedang)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomForm.textFieldLabel(context,
                                          label:
                                              'Sisa Terkena Menjadi (Sedang) (ha)',
                                          color: CustomColors.eLaporBlack,
                                          fontSize: _textFieldLabelFontSize,
                                          fontWeight:
                                              _textFieldLabelFontWeight),
                                      SizedBox(height: _labelAndFieldSpace),
                                      CustomForm.textField(context,
                                          leading: _pinGmapsIcon,
                                          leadingAndHintTextSpacing:
                                              _leadingAndHintTextSpacing,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            DecimalTextInputFormatter(
                                                decimalRange: 2),
                                            _comaFormatter
                                          ],
                                          enabled: _enableInput,
                                          hintText: 'Masukkan Nilai',
                                          borderColor: _borderColor,
                                          controller:
                                              _sisaTerkenaMenjadiSedangController,
                                          onChange: (value) {
                                            _calculateSisaTerkenaJumlah();
                                            _calculateKeadaanSedang();
                                          },
                                          onEditingComplete: () =>
                                              _focusScope.nextFocus())
                                    ]),
                              )
                            : SizedBox(),
                        (widget.sisaTerkenaMenjadiBerat)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomForm.textFieldLabel(context,
                                          label:
                                              'Sisa Terkena Menjadi (Berat) (ha)',
                                          color: CustomColors.eLaporBlack,
                                          fontSize: _textFieldLabelFontSize,
                                          fontWeight:
                                              _textFieldLabelFontWeight),
                                      SizedBox(height: _labelAndFieldSpace),
                                      CustomForm.textField(context,
                                          leading: _pinGmapsIcon,
                                          leadingAndHintTextSpacing:
                                              _leadingAndHintTextSpacing,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            DecimalTextInputFormatter(
                                                decimalRange: 2),
                                            _comaFormatter
                                          ],
                                          hintText: 'Masukkan Nilai',
                                          enabled: _enableInput,
                                          borderColor: _borderColor,
                                          controller:
                                              _sisaTerkenaMenjadiBeratController,
                                          onChange: (value) {
                                            _calculateSisaTerkenaJumlah();
                                            _calculateKeadaanBerat();
                                          },
                                          onEditingComplete: () =>
                                              _focusScope.nextFocus())
                                    ]),
                              )
                            : SizedBox(),
                        (widget.sisaTerkenaMenjadiPuso)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomForm.textFieldLabel(context,
                                          label:
                                              'Sisa Terkena Menjadi (Puso) (ha)',
                                          color: CustomColors.eLaporBlack,
                                          fontSize: _textFieldLabelFontSize,
                                          fontWeight:
                                              _textFieldLabelFontWeight),
                                      SizedBox(height: _labelAndFieldSpace),
                                      CustomForm.textField(context,
                                          leading: _pinGmapsIcon,
                                          leadingAndHintTextSpacing:
                                              _leadingAndHintTextSpacing,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            DecimalTextInputFormatter(
                                                decimalRange: 2),
                                            _comaFormatter
                                          ],
                                          hintText: 'Masukkan Nilai',
                                          enabled: _enableInput,
                                          borderColor: _borderColor,
                                          onChange: (value) {
                                            _calculateSisaTerkenaJumlah();
                                            _calculateKeadaanPuso();
                                          },
                                          controller:
                                              _sisaTerkenaMenjadiPusoController,
                                          onEditingComplete: () =>
                                              _focusScope.nextFocus())
                                    ]),
                              )
                            : SizedBox(),
                        (widget.sisaTerkenaMenjadiSurut)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomForm.textFieldLabel(context,
                                          label:
                                              'Sisa Terkena Menjadi (Surut) (ha)',
                                          color: CustomColors.eLaporBlack,
                                          fontSize: _textFieldLabelFontSize,
                                          fontWeight:
                                              _textFieldLabelFontWeight),
                                      SizedBox(height: _labelAndFieldSpace),
                                      CustomForm.textField(context,
                                          leading: _pinGmapsIcon,
                                          leadingAndHintTextSpacing:
                                              _leadingAndHintTextSpacing,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            DecimalTextInputFormatter(
                                                decimalRange: 2),
                                            _comaFormatter
                                          ],
                                          hintText: 'Masukkan Nilai',
                                          enabled: _enableInput,
                                          borderColor: _borderColor,
                                          controller:
                                              _sisaTerkenaMenjadiSurutController,
                                          onChange: (value) {
                                            _calculateKeadaanSurut();
                                          },
                                          onEditingComplete: () =>
                                              _focusScope.nextFocus())
                                    ]),
                              )
                            : SizedBox(),
                        (widget.sisaTerkenaMenjadiPulih)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomForm.textFieldLabel(context,
                                          label:
                                              'Sisa Terkena Menjadi (Pulih) (ha)',
                                          color: CustomColors.eLaporBlack,
                                          fontSize: _textFieldLabelFontSize,
                                          fontWeight:
                                              _textFieldLabelFontWeight),
                                      SizedBox(height: _labelAndFieldSpace),
                                      CustomForm.textField(context,
                                          leading: _pinGmapsIcon,
                                          leadingAndHintTextSpacing:
                                              _leadingAndHintTextSpacing,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            DecimalTextInputFormatter(
                                                decimalRange: 2),
                                            _comaFormatter
                                          ],
                                          hintText: 'Masukkan Nilai',
                                          enabled: _enableInput,
                                          borderColor: _borderColor,
                                          controller:
                                              _sisaTerkenaMenjadiPulihController,
                                          onChange: (value) {
                                            _calculateSisaTerkenaJumlah();
                                            _calculateKeadaanPulih();
                                          },
                                          onEditingComplete: () =>
                                              _focusScope.nextFocus())
                                    ]),
                              )
                            : SizedBox(),
                        (widget.sisaTerkenaJumlah)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomForm.textFieldLabel(context,
                                          label: 'Sisa Terkena (Jumlah) (ha)',
                                          color: CustomColors.eLaporBlack,
                                          fontSize: _textFieldLabelFontSize,
                                          fontWeight:
                                              _textFieldLabelFontWeight),
                                      SizedBox(height: _labelAndFieldSpace),
                                      CustomForm.textField(context,
                                          leading: _pinGmapsIcon,
                                          leadingAndHintTextSpacing:
                                              _leadingAndHintTextSpacing,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            DecimalTextInputFormatter(
                                                decimalRange: 2),
                                            _comaFormatter
                                          ],
                                          hintText: 'Masukkan Nilai',
                                          enabled: false,
                                          borderColor: _borderColor,
                                          controller:
                                              _sisaTerkenaJumlahController,
                                          onEditingComplete: () =>
                                              _focusScope.nextFocus())
                                    ]),
                              )
                            : SizedBox(),
                        (widget.luasTambahTerkena)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomForm.textFieldLabel(context,
                                          label: 'Luas Tambah Terkena (ha)',
                                          color: CustomColors.eLaporBlack,
                                          fontSize: _textFieldLabelFontSize,
                                          fontWeight:
                                              _textFieldLabelFontWeight),
                                      SizedBox(height: _labelAndFieldSpace),
                                      CustomForm.textField(context,
                                          leading: _pinGmapsIcon,
                                          leadingAndHintTextSpacing:
                                              _leadingAndHintTextSpacing,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            DecimalTextInputFormatter(
                                                decimalRange: 2),
                                            _comaFormatter
                                          ],
                                          hintText: 'Masukkan Nilai',
                                          enabled: _enableInput,
                                          borderColor: _borderColor,
                                          controller:
                                              _luasTambahTerkenaController,
                                          onChange: (value) {
                                            _calculateKeadaanTerkena();
                                          },
                                          onEditingComplete: () =>
                                              _focusScope.nextFocus())
                                    ]),
                              )
                            : SizedBox(),
                        (widget.luasTambahRingan)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomForm.textFieldLabel(context,
                                          label: 'Luas Tambah (Ringan) (ha)',
                                          color: CustomColors.eLaporBlack,
                                          fontSize: _textFieldLabelFontSize,
                                          fontWeight:
                                              _textFieldLabelFontWeight),
                                      SizedBox(height: _labelAndFieldSpace),
                                      CustomForm.textField(context,
                                          leading: _pinGmapsIcon,
                                          leadingAndHintTextSpacing:
                                              _leadingAndHintTextSpacing,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            DecimalTextInputFormatter(
                                                decimalRange: 2),
                                            _comaFormatter
                                          ],
                                          hintText: 'Masukkan Nilai',
                                          enabled: _enableInput,
                                          borderColor: _borderColor,
                                          controller:
                                              _luasTambahRinganController,
                                          onChange: (value) {
                                            _calculateLuasTambahJumlah();
                                            _calculateKeadaanRingan();
                                          },
                                          onEditingComplete: () =>
                                              _focusScope.nextFocus())
                                    ]),
                              )
                            : SizedBox(),
                        (widget.luasTambahSedang)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomForm.textFieldLabel(context,
                                          label: 'Luas Tambah (Sedang) (ha)',
                                          color: CustomColors.eLaporBlack,
                                          fontSize: _textFieldLabelFontSize,
                                          fontWeight:
                                              _textFieldLabelFontWeight),
                                      SizedBox(height: _labelAndFieldSpace),
                                      CustomForm.textField(context,
                                          leading: _pinGmapsIcon,
                                          leadingAndHintTextSpacing:
                                              _leadingAndHintTextSpacing,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            DecimalTextInputFormatter(
                                                decimalRange: 2),
                                            _comaFormatter
                                          ],
                                          hintText: 'Masukkan Nilai',
                                          enabled: _enableInput,
                                          borderColor: _borderColor,
                                          controller:
                                              _luasTambahSedangController,
                                          onChange: (value) {
                                            _calculateLuasTambahJumlah();
                                            _calculateKeadaanSedang();
                                          },
                                          onEditingComplete: () =>
                                              _focusScope.nextFocus())
                                    ]),
                              )
                            : SizedBox(),
                        (widget.luasTambahBerat)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomForm.textFieldLabel(context,
                                          label: 'Luas Tambah (Berat) (ha)',
                                          color: CustomColors.eLaporBlack,
                                          fontSize: _textFieldLabelFontSize,
                                          fontWeight:
                                              _textFieldLabelFontWeight),
                                      SizedBox(height: _labelAndFieldSpace),
                                      CustomForm.textField(context,
                                          leading: _pinGmapsIcon,
                                          leadingAndHintTextSpacing:
                                              _leadingAndHintTextSpacing,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            DecimalTextInputFormatter(
                                                decimalRange: 2),
                                            _comaFormatter
                                          ],
                                          hintText: 'Masukkan Nilai',
                                          borderColor: _borderColor,
                                          enabled: _enableInput,
                                          controller:
                                              _luasTambahBeratController,
                                          onChange: (value) {
                                            _calculateLuasTambahJumlah();

                                            _calculateKeadaanBerat();
                                          },
                                          onEditingComplete: () =>
                                              _focusScope.nextFocus())
                                    ]),
                              )
                            : SizedBox(),
                        Padding(
                          padding: EdgeInsets.only(top: _paddingTop),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomForm.textFieldLabel(context,
                                    label: 'Luas Tambah (Puso) (ha)',
                                    color: CustomColors.eLaporBlack,
                                    fontSize: _textFieldLabelFontSize,
                                    fontWeight: _textFieldLabelFontWeight),
                                SizedBox(height: _labelAndFieldSpace),
                                CustomForm.textField(context,
                                    leading: _pinGmapsIcon,
                                    leadingAndHintTextSpacing:
                                        _leadingAndHintTextSpacing,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      DecimalTextInputFormatter(
                                          decimalRange: 2),
                                      _comaFormatter
                                    ],
                                    hintText: 'Masukkan Nilai',
                                    enabled: _enableInput,
                                    borderColor: _borderColor,
                                    controller: _luasTambahPusoController,
                                    onChange: (value) {
                                      _calculateLuasTambahJumlah();
                                      _calculateKeadaanPuso();
                                    },
                                    onEditingComplete: () =>
                                        _focusScope.nextFocus())
                              ]),
                        ),
                        (widget.luasTambahSurut)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomForm.textFieldLabel(context,
                                          label: 'Luas Tambah (Surut) (ha)',
                                          color: CustomColors.eLaporBlack,
                                          fontSize: _textFieldLabelFontSize,
                                          fontWeight:
                                              _textFieldLabelFontWeight),
                                      SizedBox(height: _labelAndFieldSpace),
                                      CustomForm.textField(context,
                                          leading: _pinGmapsIcon,
                                          leadingAndHintTextSpacing:
                                              _leadingAndHintTextSpacing,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            DecimalTextInputFormatter(
                                                decimalRange: 2),
                                            _comaFormatter
                                          ],
                                          hintText: 'Masukkan Nilai',
                                          enabled: _enableInput,
                                          borderColor: _borderColor,
                                          controller:
                                              _luasTambahSurutController,
                                          onChange: (value) {
                                            _calculateKeadaanSurut();
                                          },
                                          onEditingComplete: () =>
                                              _focusScope.nextFocus())
                                    ]),
                              )
                            : SizedBox(),
                        (widget.luasTambahPulih)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomForm.textFieldLabel(context,
                                          label: 'Luas Tambah (Pulih) (ha)',
                                          color: CustomColors.eLaporBlack,
                                          fontSize: _textFieldLabelFontSize,
                                          fontWeight:
                                              _textFieldLabelFontWeight),
                                      SizedBox(height: _labelAndFieldSpace),
                                      CustomForm.textField(context,
                                          leading: _pinGmapsIcon,
                                          leadingAndHintTextSpacing:
                                              _leadingAndHintTextSpacing,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            DecimalTextInputFormatter(
                                                decimalRange: 2),
                                            _comaFormatter
                                          ],
                                          hintText: 'Masukkan Nilai',
                                          enabled: _enableInput,
                                          borderColor: _borderColor,
                                          controller:
                                              _luasTambahPulihController,
                                          onChange: (value) {
                                            _calculateLuasTambahJumlah();
                                            _calculateKeadaanPulih();
                                          },
                                          onEditingComplete: () =>
                                              _focusScope.nextFocus())
                                    ]),
                              )
                            : SizedBox(),
                        (widget.luasTambahJumlah)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomForm.textFieldLabel(context,
                                          label: 'Luas Tambah (Jumlah) (ha)',
                                          color: CustomColors.eLaporBlack,
                                          fontSize: _textFieldLabelFontSize,
                                          fontWeight:
                                              _textFieldLabelFontWeight),
                                      SizedBox(height: _labelAndFieldSpace),
                                      CustomForm.textField(context,
                                          leading: _pinGmapsIcon,
                                          leadingAndHintTextSpacing:
                                              _leadingAndHintTextSpacing,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            DecimalTextInputFormatter(
                                                decimalRange: 2),
                                            _comaFormatter
                                          ],
                                          hintText: 'Masukkan Nilai',
                                          enabled: false,
                                          borderColor: _borderColor,
                                          controller:
                                              _luasTambahJumlahController,
                                          onEditingComplete: () =>
                                              _focusScope.nextFocus())
                                    ]),
                              )
                            : SizedBox(),
                        (widget.keadaanTerkena)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomForm.textFieldLabel(context,
                                          label: 'Keadaan Terkena (ha)',
                                          color: CustomColors.eLaporBlack,
                                          fontSize: _textFieldLabelFontSize,
                                          fontWeight:
                                              _textFieldLabelFontWeight),
                                      SizedBox(height: _labelAndFieldSpace),
                                      CustomForm.textField(context,
                                          leading: _pinGmapsIcon,
                                          leadingAndHintTextSpacing:
                                              _leadingAndHintTextSpacing,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            DecimalTextInputFormatter(
                                                decimalRange: 2),
                                            _comaFormatter
                                          ],
                                          hintText: 'Masukkan Nilai',
                                          enabled: false,
                                          borderColor: _borderColor,
                                          controller: _keadaanTerkenaController,
                                          onEditingComplete: () =>
                                              _focusScope.nextFocus())
                                    ]),
                              )
                            : SizedBox(),
                        (widget.keadaanRingan)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomForm.textFieldLabel(context,
                                          label: 'Keadaan (Ringan) (ha)',
                                          color: CustomColors.eLaporBlack,
                                          fontSize: _textFieldLabelFontSize,
                                          fontWeight:
                                              _textFieldLabelFontWeight),
                                      SizedBox(height: _labelAndFieldSpace),
                                      CustomForm.textField(context,
                                          leading: _pinGmapsIcon,
                                          leadingAndHintTextSpacing:
                                              _leadingAndHintTextSpacing,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            DecimalTextInputFormatter(
                                                decimalRange: 2),
                                            _comaFormatter
                                          ],
                                          hintText: 'Masukkan Nilai',
                                          enabled: false,
                                          borderColor: _borderColor,
                                          controller: _keadaanRinganController,
                                          onEditingComplete: () =>
                                              _focusScope.nextFocus())
                                    ]),
                              )
                            : SizedBox(),
                        (widget.keadaanSedang)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomForm.textFieldLabel(context,
                                          label: 'Keadaan (Sedang) (ha)',
                                          color: CustomColors.eLaporBlack,
                                          fontSize: _textFieldLabelFontSize,
                                          fontWeight:
                                              _textFieldLabelFontWeight),
                                      SizedBox(height: _labelAndFieldSpace),
                                      CustomForm.textField(context,
                                          leading: _pinGmapsIcon,
                                          leadingAndHintTextSpacing:
                                              _leadingAndHintTextSpacing,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            DecimalTextInputFormatter(
                                                decimalRange: 2),
                                            _comaFormatter
                                          ],
                                          hintText: 'Masukkan Nilai',
                                          enabled: false,
                                          borderColor: _borderColor,
                                          controller: _keadaanSedangController,
                                          onEditingComplete: () =>
                                              _focusScope.nextFocus())
                                    ]),
                              )
                            : SizedBox(),
                        (widget.keadaanBerat)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomForm.textFieldLabel(context,
                                          label: 'Keadaan (Berat) (ha)',
                                          color: CustomColors.eLaporBlack,
                                          fontSize: _textFieldLabelFontSize,
                                          fontWeight:
                                              _textFieldLabelFontWeight),
                                      SizedBox(height: _labelAndFieldSpace),
                                      CustomForm.textField(context,
                                          leading: _pinGmapsIcon,
                                          leadingAndHintTextSpacing:
                                              _leadingAndHintTextSpacing,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            DecimalTextInputFormatter(
                                                decimalRange: 2),
                                            _comaFormatter
                                          ],
                                          hintText: 'Masukkan Nilai',
                                          enabled: false,
                                          borderColor: _borderColor,
                                          controller: _keadaanBeratController,
                                          onEditingComplete: () =>
                                              _focusScope.nextFocus())
                                    ]),
                              )
                            : SizedBox(),
                        Padding(
                          padding: EdgeInsets.only(top: _paddingTop),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomForm.textFieldLabel(context,
                                    label: 'Keadaan (Puso) (ha)',
                                    color: CustomColors.eLaporBlack,
                                    fontSize: _textFieldLabelFontSize,
                                    fontWeight: _textFieldLabelFontWeight),
                                SizedBox(height: _labelAndFieldSpace),
                                CustomForm.textField(context,
                                    leading: _pinGmapsIcon,
                                    leadingAndHintTextSpacing:
                                        _leadingAndHintTextSpacing,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      DecimalTextInputFormatter(
                                          decimalRange: 2),
                                      _comaFormatter
                                    ],
                                    hintText: 'Masukkan Nilai',
                                    enabled: false,
                                    borderColor: _borderColor,
                                    controller: _keadaanPusoController,
                                    onEditingComplete: () =>
                                        _focusScope.nextFocus())
                              ]),
                        ),
                        (widget.keadaanSurut)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomForm.textFieldLabel(context,
                                          label: 'Keadaan (Surut) (ha)',
                                          color: CustomColors.eLaporBlack,
                                          fontSize: _textFieldLabelFontSize,
                                          fontWeight:
                                              _textFieldLabelFontWeight),
                                      SizedBox(height: _labelAndFieldSpace),
                                      CustomForm.textField(context,
                                          leading: _pinGmapsIcon,
                                          leadingAndHintTextSpacing:
                                              _leadingAndHintTextSpacing,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            DecimalTextInputFormatter(
                                                decimalRange: 2),
                                            _comaFormatter
                                          ],
                                          hintText: 'Masukkan Nilai',
                                          enabled: false,
                                          borderColor: _borderColor,
                                          controller: _keadaanSurutController,
                                          onEditingComplete: () =>
                                              _focusScope.nextFocus())
                                    ]),
                              )
                            : SizedBox(),
                        (widget.keadaanPulih)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomForm.textFieldLabel(context,
                                          label: 'Keadaan (Pulih) (ha)',
                                          color: CustomColors.eLaporBlack,
                                          fontSize: _textFieldLabelFontSize,
                                          fontWeight:
                                              _textFieldLabelFontWeight),
                                      SizedBox(height: _labelAndFieldSpace),
                                      CustomForm.textField(context,
                                          leading: _pinGmapsIcon,
                                          leadingAndHintTextSpacing:
                                              _leadingAndHintTextSpacing,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            DecimalTextInputFormatter(
                                                decimalRange: 2),
                                            _comaFormatter
                                          ],
                                          hintText: 'Masukkan Nilai',
                                          enabled: false,
                                          borderColor: _borderColor,
                                          controller: _keadaanPulihController,
                                          onEditingComplete: () =>
                                              _focusScope.nextFocus())
                                    ]),
                              )
                            : SizedBox(),
                        (widget.keadaanJumlah)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomForm.textFieldLabel(context,
                                          label: 'Keadaan (Jumlah) (ha)',
                                          color: CustomColors.eLaporBlack,
                                          fontSize: _textFieldLabelFontSize,
                                          fontWeight:
                                              _textFieldLabelFontWeight),
                                      SizedBox(height: _labelAndFieldSpace),
                                      CustomForm.textField(context,
                                          leading: _pinGmapsIcon,
                                          leadingAndHintTextSpacing:
                                              _leadingAndHintTextSpacing,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            DecimalTextInputFormatter(
                                                decimalRange: 2),
                                            _comaFormatter
                                          ],
                                          hintText: 'Masukkan Nilai',
                                          borderColor: _borderColor,
                                          enabled: false,
                                          controller: _keadaanJumlahController,
                                          onEditingComplete: () =>
                                              _focusScope.nextFocus())
                                    ]),
                              )
                            : SizedBox(),
                        (_showPeriodeOkmarAsep)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomForm.textFieldLabel(context,
                                          label: 'Periode (Okmar/asep)',
                                          color: CustomColors.eLaporBlack,
                                          fontSize: _textFieldLabelFontSize,
                                          fontWeight:
                                              _textFieldLabelFontWeight),
                                      SizedBox(height: _labelAndFieldSpace),
                                      CustomForm.textField(context,
                                          leading: _pinGmapsIcon,
                                          leadingAndHintTextSpacing:
                                              _leadingAndHintTextSpacing,
                                          maxLength: 5,
                                          enabled: false,
                                          hintText: 'Masukkan Nilai',
                                          borderColor: _borderColor,
                                          controller:
                                              _periodeOkmarAsepController)
                                    ]),
                              )
                            : SizedBox(),
                        (_showTHMT)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomForm.textFieldLabel(context,
                                          label: 'th mt',
                                          color: CustomColors.eLaporBlack,
                                          fontSize: _textFieldLabelFontSize,
                                          fontWeight:
                                              _textFieldLabelFontWeight),
                                      SizedBox(height: _labelAndFieldSpace),
                                      CustomForm.textField(context,
                                          leading: _pinGmapsIcon,
                                          leadingAndHintTextSpacing:
                                              _leadingAndHintTextSpacing,
                                          maxLength: 9,
                                          hintText: 'Masukkan Nilai',
                                          enabled: false,
                                          borderColor: _borderColor,
                                          controller: _thMTController)
                                    ]),
                              )
                            : SizedBox(),
                        (_showMTMKMH)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomForm.textFieldLabel(context,
                                          label: 'MT (MK/MH)',
                                          color: CustomColors.eLaporBlack,
                                          fontSize: _textFieldLabelFontSize,
                                          fontWeight:
                                              _textFieldLabelFontWeight),
                                      SizedBox(height: _labelAndFieldSpace),
                                      CustomForm.textField(context,
                                          leading: _pinGmapsIcon,
                                          leadingAndHintTextSpacing:
                                              _leadingAndHintTextSpacing,
                                          maxLength: 2,
                                          hintText: 'Masukkan Nilai',
                                          enabled: false,
                                          borderColor: _borderColor,
                                          controller: _mtMKMHController)
                                    ]),
                              )
                            : SizedBox(),
                        (_showSubround)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomForm.textFieldLabel(context,
                                          label: 'subround',
                                          color: CustomColors.eLaporBlack,
                                          fontSize: _textFieldLabelFontSize,
                                          fontWeight:
                                              _textFieldLabelFontWeight),
                                      SizedBox(height: _labelAndFieldSpace),
                                      CustomForm.textField(context,
                                          leading: _pinGmapsIcon,
                                          leadingAndHintTextSpacing:
                                              _leadingAndHintTextSpacing,
                                          maxLength: 3,
                                          hintText: 'Masukkan Nilai',
                                          enabled: false,
                                          borderColor: _borderColor,
                                          controller: _subRoundController)
                                    ]),
                              )
                            : SizedBox(),
                        (_action == DPIAndOPTAction.add ||
                                _action == DPIAndOPTAction.edit)
                            ? Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Button.submitButton(context, 'SIMPAN',
                                    () async {
                                  Map<String, dynamic> _dataLogin =
                                      await AkunFuture.getDataLogin();
                                  int _userID = _dataLogin[SPKey.idUser];
                                  int _userProvinsi =
                                      _dataLogin[SPKey.provinsiUser];
                                  int _userKabupaten =
                                      _dataLogin[SPKey.kabupatenKotaUser];

                                  Map<String, dynamic> _dataDPI = {
                                    'photo': _foto,
                                    'user': _userID,
                                    'bulan': _bulanController.text,
                                    'tahun': _tahunController.text,
                                    'lat': _latitudeController.text,
                                    'lng': _longitudeController.text,
                                    'provinsi': _userProvinsi,
                                    'kabupaten': _userKabupaten,
                                    'kecamatan': _kecamatanWilKerSelected,
                                    'desa': _desaWilKerSelected,
                                    'komoditas': _komoditasSelected,
                                    'varietas': _varietasController.text,
                                    'umur_persemaian':
                                        _umurPersemaianController.text,
                                    'luas_persemaian':
                                        _luasPersemaianController.text,
                                    'umur_tanam': _umurTanamController.text,
                                    'luas_tanam': _luasTanamController.text,
                                    'periode': _periodeSelected,
                                    'penyebab': _penyebabController.text,
                                    'penanganan': _penangananController.text,
                                    'luas_tambah_puso':
                                        _luasTambahPusoController.text,
                                    'keadaan_puso': _keadaanPusoController.text,
                                    'periode_okmar_asep':
                                        _periodeOkmarAsepController.text,
                                    'th_mt': _thMTController.text,
                                    'mt_mk_mh': _mtMKMHController.text,
                                    'subround': _subRoundController.text,
                                    'visited_at': _visitedAtController.text
                                  };

                                  if (widget.tinggiBanjir) {
                                    _dataDPI['curah_hujan'] =
                                        _curahHujanController.text;
                                    _dataDPI['tinggi_banjir'] =
                                        _tinggiBanjirController.text;
                                  }
                                  if (widget.luasTambahPulih) {
                                    _dataDPI['luas_tambah_pulih'] =
                                        _luasTambahPulihController.text;
                                  }
                                  if (widget.sisaTerkena) {
                                    _dataDPI['sisa_terkena'] =
                                        _sisaTerkenaController.text;
                                  }
                                  if (widget.sisaTerkenaMenjadiRingan) {
                                    _dataDPI['sisa_terkena_menjadi_ringan'] =
                                        _sisaTerkenaMenjadiRinganController
                                            .text;
                                  }
                                  if (widget.sisaTerkenaMenjadiSedang) {
                                    _dataDPI['sisa_terkena_menjadi_sedang'] =
                                        _sisaTerkenaMenjadiSedangController
                                            .text;
                                  }
                                  if (widget.sisaTerkenaMenjadiBerat) {
                                    _dataDPI['sisa_terkena_menjadi_berat'] =
                                        _sisaTerkenaMenjadiBeratController.text;
                                  }
                                  if (widget.sisaTerkenaMenjadiPuso) {
                                    _dataDPI['sisa_terkena_menjadi_puso'] =
                                        _sisaTerkenaMenjadiPusoController.text;
                                  }
                                  if (widget.sisaTerkenaMenjadiSurut) {
                                    _dataDPI['sisa_terkena_menjadi_surut'] =
                                        _sisaTerkenaMenjadiSurutController.text;
                                  }
                                  if (widget.sisaTerkenaMenjadiPulih) {
                                    _dataDPI['sisa_terkena_menjadi_pulih'] =
                                        _sisaTerkenaMenjadiPulihController.text;
                                  }
                                  if (widget.sisaTerkenaJumlah) {
                                    _dataDPI['sisa_terkena_jumlah'] =
                                        _sisaTerkenaJumlahController.text;
                                  }
                                  if (widget.luasTambahTerkena) {
                                    _dataDPI['luas_tambah_terkena'] =
                                        _luasTambahTerkenaController.text;
                                  }
                                  if (widget.luasTambahRingan) {
                                    _dataDPI['luas_tambah_ringan'] =
                                        _luasTambahRinganController.text;
                                  }
                                  if (widget.luasTambahSedang) {
                                    _dataDPI['luas_tambah_sedang'] =
                                        _luasTambahSedangController.text;
                                  }
                                  if (widget.luasTambahBerat) {
                                    _dataDPI['luas_tambah_berat'] =
                                        _luasTambahBeratController.text;
                                  }
                                  if (widget.luasTambahSurut) {
                                    _dataDPI['luas_tambah_surut'] =
                                        _luasTambahSurutController.text;
                                  }
                                  if (widget.luasTambahJumlah) {
                                    _dataDPI['luas_tambah_jumlah'] =
                                        _luasTambahJumlahController.text;
                                  }
                                  if (widget.keadaanTerkena) {
                                    _dataDPI['keadaan_terkena'] =
                                        _keadaanTerkenaController.text;
                                  }
                                  if (widget.keadaanRingan) {
                                    _dataDPI['keadaan_ringan'] =
                                        _keadaanRinganController.text;
                                  }
                                  if (widget.keadaanSedang) {
                                    _dataDPI['keadaan_sedang'] =
                                        _keadaanSedangController.text;
                                  }
                                  if (widget.keadaanBerat) {
                                    _dataDPI['keadaan_berat'] =
                                        _keadaanBeratController.text;
                                  }
                                  if (widget.keadaanSurut) {
                                    _dataDPI['keadaan_surut'] =
                                        _keadaanSurutController.text;
                                  }
                                  if (widget.keadaanPulih) {
                                    _dataDPI['keadaan_pulih'] =
                                        _keadaanPulihController.text;
                                  }
                                  if (widget.keadaanJumlah) {
                                    _dataDPI['keadaan_jumlah'] =
                                        _keadaanJumlahController.text;
                                  }
                                  if (_idLaporan != null &&
                                      _action == DPIAndOPTAction.edit) {
                                    _dataDPI['id'] = _idLaporan;
                                  }

                                  print(_dataDPI['visited_at']);
                                  widget.onSubmit(_dataDPI);
                                },
                                    color: CustomColors.eLaporGreen,
                                    isBusy: !_isBtnSubmitActive,
                                    trailing: Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        color: CustomColors.eLaporWhite)))
                            : SizedBox(),
                      ]),
                ),
              )
            : Center(
                child: Loading(
                    loadingTitle: 'Tunggu Sebentar',
                    loadingSubTitle: 'Aplikasi sedang mengambil data')));
  }
}
