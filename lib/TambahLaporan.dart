import 'dart:convert';
import 'dart:io';

import 'package:e_lapor/Laporanku.dart';
import 'package:e_lapor/Navigation/TabItem.dart';
import 'package:e_lapor/globalWidgets/Loading.dart';
import 'package:e_lapor/libraries/DecimalTextInputFormatter.dart';
import 'package:e_lapor/libraries/ServerPath.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

import 'package:e_lapor/Beranda.dart';
import 'package:e_lapor/globalWidgets/Alert.dart';
import 'package:e_lapor/globalWidgets/Button.dart';

import 'package:e_lapor/Future/Akun/AkunFuture.dart';
import 'package:e_lapor/Future/DPIFuture.dart';
import 'package:e_lapor/Future/OPTFuture.dart';
import 'package:e_lapor/globalWidgets/CustomForm.dart';
import 'package:e_lapor/globalWidgets/CustomNavigation.dart';
import 'package:e_lapor/libraries/ImagePickerDialog.dart';
import 'package:e_lapor/libraries/LocalStorage.dart';
import 'package:e_lapor/libraries/SPKey.dart';

import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:e_lapor/libraries/SizeConfig.dart';

import 'package:e_lapor/FakeData/Wilayah.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:metadata/metadata.dart' as metaData;

enum TambahLaporanState { add, edit, detail }

class TambahLaporan extends StatefulWidget {
  final TabItem tabItem;
  final int idLaporan;
  final TambahLaporanState state;
  TambahLaporan({@required this.tabItem, this.idLaporan, this.state});
  _TambahLaporanState createState() => _TambahLaporanState();
}

class _TambahLaporanState extends State<TambahLaporan> {
  PickedFile _pickedFileState;

  TextEditingController _curahHujanController = TextEditingController();
  TextEditingController _varietasController = TextEditingController();
  TextEditingController _umurTanamanController = TextEditingController();
  TextEditingController _luasTanamController = TextEditingController();

  TextEditingController _sspsRingan = TextEditingController();
  TextEditingController _sspsSedang = TextEditingController();
  TextEditingController _sspsBerat = TextEditingController();
  TextEditingController _sspsPuso = TextEditingController();
  TextEditingController _jumlahSSPSController = TextEditingController();
  TextEditingController _luasTerkendaliController = TextEditingController();
  TextEditingController _luasPanenController = TextEditingController();

  TextEditingController _ltspplRingan = TextEditingController();
  TextEditingController _ltspplSedang = TextEditingController();
  TextEditingController _ltspplBerat = TextEditingController();
  TextEditingController _ltspplPuso = TextEditingController();
  TextEditingController _jumlahLTSPPLController = TextEditingController();

  TextEditingController _pestisidaKimiaController = TextEditingController();
  TextEditingController _pestisidaHayatiController = TextEditingController();
  TextEditingController _eradikasiController = TextEditingController();
  TextEditingController _caraLainController = TextEditingController();
  TextEditingController _jumlahLuasPengendalian = TextEditingController();

  TextEditingController _lKSPPLRinganController = TextEditingController();
  TextEditingController _lKSPPLSedangController = TextEditingController();
  TextEditingController _lKSPPLBeratController = TextEditingController();
  TextEditingController _lKSPPLPusoController = TextEditingController();
  TextEditingController _jumlahLKSPPLController = TextEditingController();

  TextEditingController _thMTController = TextEditingController();
  TextEditingController _periodeOkmarAsepController = TextEditingController();
  TextEditingController _mtMKMHController = TextEditingController();
  TextEditingController _subRoundController = TextEditingController();
  TextEditingController _visitedAtController = TextEditingController();

  TextEditingController _provinsiUserController = TextEditingController();
  TextEditingController _kabupatenKotaUserController = TextEditingController();

  TextEditingController _tahunController = TextEditingController();
  TextEditingController _bulanController = TextEditingController();

  int _kecamatanSelected = 0, _kelurahanSelected = 0;
  int _komoditasSelected = 0;
  int _optSelected = 0;
  int _kriteriaOPTSelected = 0;

  List _kecamatanState = [];
  List _kelurahanState = [];
  List _komoditasState = [];
  List _kriteriaOPTState = [];
  List _periodeState = [];
  List _optState = [];

  List<Map<String, dynamic>> _periode = [
    {'text': 'Periode I', 'value': '1'},
    {'text': 'Periode II', 'value': '2'}
  ];

  String _periodeSelected = '';

  bool _isButtonSaveBusy = false;
  bool _showTahun = false;
  bool _showBulan = false;
  bool _showLatitude = false;
  bool _showLongitude = false;
  bool _showOkmarAsep = false;
  bool _showTHMT = false;
  bool _showMTMKMH = false;
  bool _showSubround = false;

  String _latitudeState, _longitudeState, _fotoPath;

  String _kecamatanSelectedString = '',
      _kelurahanSelectedString = '',
      _komoditasSelectedString = '',
      _kriteriaOPTSelectedString = '',
      _optSelectedString = '',
      _periodeSelectedString = '';

  void initState() {
    super.initState();
    _initialization();
  }

  void dispose() {
    super.dispose();

    _curahHujanController.dispose();
    _varietasController.dispose();
    _umurTanamanController.dispose();
    _luasTanamController.dispose();
    _sspsRingan.dispose();
    _sspsSedang.dispose();
    _sspsBerat.dispose();
    _sspsPuso.dispose();
    _jumlahSSPSController.dispose();
    _luasTerkendaliController.dispose();
    _luasPanenController.dispose();

    _ltspplRingan.dispose();
    _ltspplSedang.dispose();
    _ltspplBerat.dispose();
    _ltspplPuso.dispose();
    _jumlahLTSPPLController.dispose();

    _pestisidaKimiaController.dispose();
    _pestisidaHayatiController.dispose();
    _eradikasiController.dispose();
    _caraLainController.dispose();
    _jumlahLuasPengendalian.dispose();

    _lKSPPLRinganController.dispose();
    _lKSPPLSedangController.dispose();
    _lKSPPLBeratController.dispose();
    _lKSPPLPusoController.dispose();
    _jumlahLKSPPLController.dispose();

    _thMTController.dispose();
    _periodeOkmarAsepController.dispose();
    _mtMKMHController.dispose();
    _subRoundController.dispose();
    _visitedAtController.dispose();

    _provinsiUserController.dispose();
    _kabupatenKotaUserController.dispose();

    _tahunController.dispose();
    _bulanController.dispose();
  }

  Future<void> _getOPT(
      {@required int komoditas, @required int kriteria}) async {
    if (komoditas != null && kriteria != null) {
      if (komoditas != 0 && kriteria != 0) {
        List _opt =
            await OPTFuture.getOPT(komoditas: komoditas, kriteria: kriteria);
        setState(() {
          _optState = _opt;
        });
      }
    }
  }

  Future<void> _initialization() async {
    int _idLaporan = widget.idLaporan;
    TambahLaporanState _state = widget.state;

    bool _isIDLaporanNull = _idLaporan == null;
    bool _isStateNull = _state == null;

    if (!_isIDLaporanNull && !_isStateNull) {
      await _editAndDetailLaporanInitialization();
    } else {
      await _addLaporanInitialization();
    }
  }

  Future<void> _editAndDetailLaporanInitialization() async {
    int _idLaporan = widget.idLaporan;

    Map<String, dynamic> _detailLaporan =
        await OPTFuture.getDetailLaporanOPT(id: _idLaporan);

    if (_detailLaporan != null) {
      Map<String, dynamic> _dataLogin = await AkunFuture.getDataLogin();

      int _idProvinsiUser = _dataLogin[SPKey.provinsiUser];
      int _idKabupatenKotaUser = _dataLogin[SPKey.kabupatenKotaUser];
      int _idUser = _dataLogin[SPKey.idUser];

      List _kecamatanWilKer = await DPIFuture.getKecamatanWilayahKerja(
          idProvinsi: _idProvinsiUser,
          idKabupaten: _idKabupatenKotaUser,
          idUser: _idUser);
      _kecamatanWilKer =
          _kecamatanWilKer.map((kecamatan) => kecamatan['kecamatan']).toList();

      List _idKecamatanWilker =
          _kecamatanWilKer.map((kecamatan) => kecamatan['id']).toList();

      int _kecamatanTerpilih = _detailLaporan['kecamatan']['id'];

      int _komoditasTerpilih = _detailLaporan['komoditas']['id'];

      int _kriteriaTerpilih = _detailLaporan['kriteria']['id'];
      int _desaTerpilih = _detailLaporan['desa']['id'];
      int _optTerpilih = _detailLaporan['opt']['id'];
      String _periodeTerpilih = _detailLaporan['periode'];
      String _curahHujan = _detailLaporan['curah_hujan'];
      String _varietas = _detailLaporan['varietas'];
      dynamic _luasTanam = _detailLaporan['luas'];
      int _umurTanam = _detailLaporan['umur'];

      String _sisaSeranganRingan = _detailLaporan['sisa_serangan_ringan'];
      String _sisaSeranganSedang = _detailLaporan['sisa_serangan_sedang'];
      String _sisaSeranganBerat = _detailLaporan['sisa_serangan_berat'];
      String _sisaSeranganPuso = _detailLaporan['sisa_serangan_puso'];
      String _sisaSeranganJumlah = _detailLaporan['sisa_serangan_jumlah'];
      String _sisaSeranganTerkendali =
          _detailLaporan['sisa_serangan_terkendali'];
      String _sisaSeranganPanen = _detailLaporan['sisa_serangan_panen'];

      String _luasTambahSeranganRingan =
          _detailLaporan['luas_tambah_serangan_ringan'];
      String _luasTambahSeranganSedang =
          _detailLaporan['luas_tambah_serangan_sedang'];
      String _luasTambahSeranganBerat =
          _detailLaporan['luas_tambah_serangan_berat'];
      String _luasTambahSeranganPuso =
          _detailLaporan['luas_tambah_serangan_puso'];
      String _luasTambahSeranganJumlah =
          _detailLaporan['luas_tambah_serangan_jumlah'];

      String _luasPengendalianKimia = _detailLaporan['luas_pengendalian_kimia'];
      String _luasPengendalianHayati =
          _detailLaporan['luas_pengendalian_hayati'];
      String _luasPengendalianEradiksi =
          _detailLaporan['luas_pengendalian_eradiksi'];
      String _luasPengendalianCaraLain =
          _detailLaporan['luas_pengendalian_cara_lain'];
      String _luasPengendalianJumlah =
          _detailLaporan['luas_pengendalian_jumlah'];

      String _luasKeadaanRingan = _detailLaporan['luas_keadaan_ringan'];
      String _luasKeadaanSedang = _detailLaporan['luas_keadaan_sedang'];
      String _luasKeadaanBerat = _detailLaporan['luas_keadaan_berat'];
      String _luasKeadaanPuso = _detailLaporan['luas_keadaan_puso'];
      String _luasKeadaanJumlah = _detailLaporan['luas_keadaan_jumlah'];

      String _okmarAsep = _detailLaporan['periode_okmar_asep'];
      String _thMT = _detailLaporan['th_mt'];
      String _mtMKMH = _detailLaporan['mt_mk_mh'];
      String _subRound = _detailLaporan['subround'];

      String _tahun = _detailLaporan['tahun'];
      String _bulan = _detailLaporan['bulan'].toString();
      String _provinsi = _detailLaporan['provinsi']['name'];
      String _kabupaten = _detailLaporan['kabupaten']['name'];

      List _komoditas = await DPIFuture.getKomoditas();
      List _kriteria = await OPTFuture.getKriteria();

      List _desaWilKer = await DPIFuture.getDesaWilayahKerja(
          idProvinsi: _idProvinsiUser,
          idKabupaten: _idKabupatenKotaUser,
          idKecamatan: _kecamatanTerpilih);
      _desaWilKer = _desaWilKer.map((desa) => desa['desa']).toList();

      if (!_idKecamatanWilker.contains(_kecamatanTerpilih)) {
        _kecamatanTerpilih = 0;
        _desaTerpilih = 0;
      }

      List _opt = await OPTFuture.getOPT(
          komoditas: _komoditasTerpilih, kriteria: _kriteriaTerpilih);

      String _fotoLaporan = _detailLaporan['photo'];

      setState(() {
        _showBulan = true;
        _showTahun = true;
        _showLatitude = true;
        _showLongitude = true;
        _showOkmarAsep = true;
        _showTHMT = true;
        _showMTMKMH = true;
        _showSubround = true;

        _latitudeState = _detailLaporan['lat'];
        _longitudeState = _detailLaporan['lng'];

        _komoditasState = _komoditas;
        _komoditasSelected = _komoditasTerpilih;
        _komoditasSelectedString = _detailLaporan['komoditas']['name'];

        _kriteriaOPTState = _kriteria;
        _kriteriaOPTSelected = _kriteriaTerpilih;
        _kriteriaOPTSelectedString = _detailLaporan['kriteria']['name'];

        _kecamatanState = _kecamatanWilKer;
        _kecamatanSelected = _kecamatanTerpilih;
        _kecamatanSelectedString = _detailLaporan['kecamatan']['name'];

        _kelurahanState = _desaWilKer;
        _kelurahanSelected = _desaTerpilih;
        _kelurahanSelectedString = _detailLaporan['desa']['name'];

        _optState = _opt;
        _optSelected = _optTerpilih;
        _optSelectedString = _detailLaporan['opt']['name'];

        _periodeState = _periode;
        _periodeSelected = _periodeTerpilih;
        _periodeSelectedString = _detailLaporan['periode'];

        _fotoPath = _fotoLaporan;

        _curahHujanController.text = _curahHujan;
        _varietasController.text = _varietas;
        _umurTanamanController.text = _umurTanam.toString();
        _luasTanamController.text = _luasTanam.toString();
        _sspsRingan.text = _sisaSeranganRingan;
        _sspsSedang.text = _sisaSeranganSedang;
        _sspsBerat.text = _sisaSeranganBerat;
        _sspsPuso.text = _sisaSeranganPuso;
        _jumlahSSPSController.text = _sisaSeranganJumlah;
        _luasTerkendaliController.text = _sisaSeranganTerkendali;
        _luasPanenController.text = _sisaSeranganPanen;

        _ltspplRingan.text = _luasTambahSeranganRingan;
        _ltspplSedang.text = _luasTambahSeranganSedang;
        _ltspplBerat.text = _luasTambahSeranganBerat;
        _ltspplPuso.text = _luasTambahSeranganPuso;
        _jumlahLTSPPLController.text = _luasTambahSeranganJumlah;

        _pestisidaKimiaController.text = _luasPengendalianKimia;
        _pestisidaHayatiController.text = _luasPengendalianHayati;
        _eradikasiController.text = _luasPengendalianEradiksi;
        _caraLainController.text = _luasPengendalianCaraLain;
        _jumlahLuasPengendalian.text = _luasPengendalianJumlah;

        _lKSPPLRinganController.text = _luasKeadaanRingan;
        _lKSPPLSedangController.text = _luasKeadaanSedang;
        _lKSPPLBeratController.text = _luasKeadaanBerat;
        _lKSPPLPusoController.text = _luasKeadaanPuso;
        _jumlahLKSPPLController.text = _luasKeadaanJumlah;

        _thMTController.text = _thMT;
        _periodeOkmarAsepController.text = _okmarAsep;
        _mtMKMHController.text = _mtMKMH;
        _subRoundController.text = _subRound;

        _provinsiUserController.text = _provinsi;
        _kabupatenKotaUserController.text = _kabupaten;
        _tahunController.text = _tahun;
        _bulanController.text = _bulan.toString();
      });
    }
  }

  Future<void> _addLaporanInitialization() async {
    Map<String, dynamic> _dataLogin = await AkunFuture.getDataLogin();

    int _idProvinsiUser = _dataLogin[SPKey.provinsiUser];
    int _idKabupatenKotaUser = _dataLogin[SPKey.kabupatenKotaUser];
    int _idUser = _dataLogin[SPKey.idUser];

    _provinsiUserController.text = _dataLogin[SPKey.provinsiUserString];
    _kabupatenKotaUserController.text =
        _dataLogin[SPKey.kabupatenKotaUserString];

    List _komoditas = await DPIFuture.getKomoditas();
    List _kriteria = await OPTFuture.getKriteria();

    List _kecamatanWilKer = await DPIFuture.getKecamatanWilayahKerja(
        idProvinsi: _idProvinsiUser,
        idKabupaten: _idKabupatenKotaUser,
        idUser: _idUser);

    _kecamatanWilKer =
        _kecamatanWilKer.map((kecamatan) => kecamatan['kecamatan']).toList();

    setState(() {
      _komoditasState = _komoditas;
      _kriteriaOPTState = _kriteria;
      _periodeState = _periode;
      _kecamatanState = _kecamatanWilKer;
    });
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
          _pickedFileState = pickedFile;
          _showBulan = true;
          _showTahun = true;
          _showLatitude = true;
          _showLongitude = true;
          _showOkmarAsep = true;
          _showTHMT = true;
          _showMTMKMH = true;
          _showSubround = true;

          _latitudeState = _latitude;
          _longitudeState = _longitude;

          _periodeOkmarAsepController.text = _pOA;
          _thMTController.text = _thMT;
          _mtMKMHController.text = _mtMKMH;
          _subRoundController.text = _subRound;
          _tahunController.text = _tahun.toString();
          _bulanController.text = _bulan.toString();
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

  void _calculateJumlahSisaSerangan() {
    double _intSPSSRingan =
        (_sspsRingan.text.length >= 1) ? double.parse(_sspsRingan.text) : 0;
    double _intSPSSSedang =
        (_sspsSedang.text.length >= 1) ? double.parse(_sspsSedang.text) : 0;
    double _intSPSSBerat =
        (_sspsBerat.text.length >= 1) ? double.parse(_sspsBerat.text) : 0;
    double _intSPSSPuso =
        (_sspsPuso.text.length >= 1) ? double.parse(_sspsPuso.text) : 0;
    _jumlahSSPSController.text =
        (_intSPSSRingan + _intSPSSSedang + _intSPSSBerat + _intSPSSPuso)
            .toString();
  }

  void _calculateLuasTambahSerangan() {
    double _intLTSPPLRingan =
        (_ltspplRingan.text.length >= 1) ? double.parse(_ltspplRingan.text) : 0;
    double _intLTSPPLSedang =
        (_ltspplSedang.text.length >= 1) ? double.parse(_ltspplSedang.text) : 0;
    double _intLTSPPLBerat =
        (_ltspplBerat.text.length >= 1) ? double.parse(_ltspplBerat.text) : 0;
    double _intLTSPPLPuso =
        (_ltspplPuso.text.length >= 1) ? double.parse(_ltspplPuso.text) : 0;
    _jumlahLTSPPLController.text =
        (_intLTSPPLRingan + _intLTSPPLSedang + _intLTSPPLBerat + _intLTSPPLPuso)
            .toString();
  }

  void _calculateJumlahLuasPengendalian() {
    double _intPestisidaHayati = (_pestisidaHayatiController.text.length >= 1)
        ? double.parse(_pestisidaHayatiController.text)
        : 0;
    double _intPestisidaKimia = (_pestisidaKimiaController.text.length >= 1)
        ? double.parse(_pestisidaKimiaController.text)
        : 0;
    double _intEradikasi = (_eradikasiController.text.length >= 1)
        ? double.parse(_eradikasiController.text)
        : 0;
    double _intCaraLain = (_caraLainController.text.length >= 1)
        ? double.parse(_caraLainController.text)
        : 0;
    _jumlahLuasPengendalian.text = (_intPestisidaHayati +
            _intPestisidaKimia +
            _intEradikasi +
            _intCaraLain)
        .toString();
  }

  void _calculateJumlahLuasKeadaan() {
    double _doubleSPSSRingan =
        (_sspsRingan.text.length >= 1) ? double.parse(_sspsRingan.text) : 0;
    double _doubleSPSSSedang =
        (_sspsSedang.text.length >= 1) ? double.parse(_sspsSedang.text) : 0;
    double _doubleSPSSBerat =
        (_sspsBerat.text.length >= 1) ? double.parse(_sspsBerat.text) : 0;
    double _doubleSPSSPuso =
        (_sspsPuso.text.length >= 1) ? double.parse(_sspsPuso.text) : 0;

    double _doubleLTSPPLRingan =
        (_ltspplRingan.text.length >= 1) ? double.parse(_ltspplRingan.text) : 0;
    double _doubleLTSPPLSedang =
        (_ltspplSedang.text.length >= 1) ? double.parse(_ltspplSedang.text) : 0;
    double _doubleLTSPPLBerat =
        (_ltspplBerat.text.length >= 1) ? double.parse(_ltspplBerat.text) : 0;
    double _doubleLTSPPLPuso =
        (_ltspplPuso.text.length >= 1) ? double.parse(_ltspplPuso.text) : 0;

    double _m = _doubleSPSSRingan + _doubleLTSPPLRingan;
    double _n = _doubleSPSSSedang + _doubleLTSPPLSedang;
    double _o = _doubleSPSSBerat + _doubleLTSPPLBerat;
    double _p = _doubleSPSSPuso + _doubleLTSPPLPuso;

    _lKSPPLRinganController.text = _m.toString();
    _lKSPPLSedangController.text = _n.toString();
    _lKSPPLBeratController.text = _o.toString();
    _lKSPPLPusoController.text = _p.toString();
    _jumlahLKSPPLController.text = (_m + _n + _o + _p).toString();
  }

  Widget build(BuildContext context) {
    SizeConfig().initSize(context);

    double _widthAndHeightImageBPTP = SizeConfig.horizontalBlock * 72.5;
    double _iconAndTitleSpace = SizeConfig.horizontalBlock * 3.15;
    double _paddingTop = SizeConfig.horizontalBlock * 4.0;
    double _labelAndFormSpacing = SizeConfig.horizontalBlock * 2.5;
    double _leadingAndHintTextSpacing = SizeConfig.horizontalBlock * 5.25;

    Color _borderColor = CustomColors.eLaporBlack;

    TextStyle _titleStyle = TextStyle(
        fontSize: SizeConfig.horizontalBlock * 5.0,
        color: CustomColors.eLaporBlack,
        fontWeight: FontWeight.w700);

    int _idLaporan = widget.idLaporan;
    TambahLaporanState _state = widget.state;

    String _appBarTitle = 'Tambah Laporan';
    bool _isInputEnabled = true;
    bool _showUploadImageButton = true;

    if (_state == TambahLaporanState.detail) {
      _isInputEnabled = false;
      _showUploadImageButton = false;
      _appBarTitle = 'Detail Laporan';
    }

    if (_state == TambahLaporanState.edit) {
      _appBarTitle = 'Edit Laporan';
    }

    Widget _pinGmapsIcon = SvgPicture.asset(ClientPath.svgPath + '/map-pin.svg',
        width: SizeConfig.horizontalBlock * 5.5,
        color: CustomColors.dangerColor);

    List<DropdownMenuItem> _kecamatan = Wilayah.dropdownMenuItemBuilder(
        _kecamatanState,
        textIndex: 'name',
        valueIndex: 'id');
    List<DropdownMenuItem> _kelurahan = Wilayah.dropdownMenuItemBuilder(
        _kelurahanState,
        textIndex: 'name',
        valueIndex: 'id');
    List<DropdownMenuItem> _komoditas = Wilayah.dropdownMenuItemBuilder(
        _komoditasState,
        textIndex: 'name',
        valueIndex: 'id');
    List<DropdownMenuItem> _kriteriaOPT = Wilayah.dropdownMenuItemBuilder(
        _kriteriaOPTState,
        textIndex: 'name',
        valueIndex: 'id');
    List<DropdownMenuItem> _periode = Wilayah.dropdownMenuItemBuilder(
        _periodeState,
        textIndex: 'text',
        valueIndex: 'value');

    List<DropdownMenuItem> _opt = Wilayah.dropdownMenuItemBuilder(_optState,
        textIndex: 'name', valueIndex: 'id');

    FocusScopeNode _focusScope = FocusScope.of(context);

    bool _readyToShow = true;
    if (_state == TambahLaporanState.detail ||
        _state == TambahLaporanState.edit) {
      _readyToShow = (_fotoPath == null) ? false : true;
    }

    TabItem _tabItem = widget.tabItem;

    TextInputFormatter _comaFormatter =
        FilteringTextInputFormatter.deny(RegExp(','));

    return Scaffold(
        appBar: CustomNavigation.appBar(
            appBarContext: context, title: _appBarTitle),
        body: (_readyToShow)
            ? Stack(children: [
                Positioned(
                  top: -_widthAndHeightImageBPTP / 2 + kToolbarHeight,
                  left: SizeConfig.horizontalBlock * 50.0 -
                      (_widthAndHeightImageBPTP / 2),
                  child: Container(
                    width: _widthAndHeightImageBPTP,
                    height: _widthAndHeightImageBPTP,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                AssetImage(ClientPath.iconPath + '/bptp.png'))),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      right: SizeConfig.leftAndRightContentContainerPadding,
                      left: SizeConfig.leftAndRightContentContainerPadding),
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(52, 195, 105, 0.95)),
                ),
                Positioned(
                  top: 0.0,
                  left: 0.0,
                  right: 0.0,
                  bottom: 0.0,
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)),
                      child: Container(
                          padding: EdgeInsets.only(
                              top: SizeConfig.horizontalBlock * 5.0,
                              right: SizeConfig
                                  .leftAndRightContentContainerPadding,
                              left: SizeConfig
                                  .leftAndRightContentContainerPadding),
                          decoration:
                              BoxDecoration(color: CustomColors.eLaporWhite),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom: SizeConfig.horizontalBlock * 5.0),
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(children: [
                                      _pinGmapsIcon,
                                      SizedBox(width: _iconAndTitleSpace),
                                      Text('Laporan OPT', style: _titleStyle)
                                    ]),
                                    Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Container(
                                          color: CustomColors.eLaporBlack,
                                          height: 0.35,
                                        )),
                                    (_state == TambahLaporanState.detail ||
                                            _state == TambahLaporanState.edit)
                                        ? Padding(
                                            padding: EdgeInsets.only(
                                                top: _paddingTop),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                  minHeight: SizeConfig
                                                          .horizontalBlock *
                                                      45.0),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: SizeConfig
                                                          .horizontalBlock *
                                                      10.0),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.contain,
                                                      image: (_pickedFileState !=
                                                              null)
                                                          ? FileImage(File(
                                                              _pickedFileState
                                                                  .path))
                                                          : NetworkImage(ServerPath
                                                                  .apiBaseURL +
                                                              '/elapor/' +
                                                              _fotoPath)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  color: Color(0X5534C369)),
                                            ))
                                        : (_pickedFileState != null)
                                            ? Padding(
                                                padding: EdgeInsets.only(
                                                    top: _paddingTop),
                                                child: Container(
                                                  constraints: BoxConstraints(
                                                      minHeight: SizeConfig
                                                              .horizontalBlock *
                                                          45.0),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: SizeConfig
                                                              .horizontalBlock *
                                                          10.0),
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          fit: BoxFit.contain,
                                                          image: FileImage(File(
                                                              _pickedFileState
                                                                  .path))),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                      color: Color(0X5534C369)),
                                                ))
                                            : SizedBox(),
                                    (_showUploadImageButton)
                                        ? Padding(
                                            padding: EdgeInsets.only(
                                                top: _paddingTop),
                                            child: Button.submitButton(
                                                context, 'PILIH/AMBIL FOTO',
                                                () async {
                                              ImageSource _imageSource =
                                                  await ImagePickerDialog
                                                      .showImagePicker(context);
                                              PickedFile _pickedFile =
                                                  await ImagePickerDialog
                                                      .takePicture(context,
                                                          _imageSource);
                                              if (_pickedFile != null) {
                                                File _file =
                                                    File(_pickedFile.path);
                                                List<int> _filesIntBytes =
                                                    _file.readAsBytesSync();
                                                metaData.CallBack _callBack =
                                                    metaData.MetaData.exifData(
                                                        _filesIntBytes);

                                                if (_callBack != null) {
                                                  dynamic _exifData =
                                                      _callBack.exifData;
                                                  if (_exifData != null) {
                                                    await _setData(context,
                                                        pickedFile: _pickedFile,
                                                        imageSource:
                                                            _imageSource,
                                                        decodedExifData:
                                                            _exifData);
                                                  }
                                                }
                                              }
                                            },
                                                color: CustomColors.eLaporGreen,
                                                trailing: Icon(
                                                    Icons
                                                        .arrow_forward_ios_sharp,
                                                    color: CustomColors
                                                        .eLaporWhite)))
                                        : SizedBox(),
                                    SizedBox(height: 7.0),
                                    Column(children: [
                                      (_showBulan)
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  top: _paddingTop),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  CustomForm.textFieldLabel(
                                                      context,
                                                      label: 'Bulan',
                                                      letterSpacing: 1.5,
                                                      color: CustomColors
                                                          .eLaporBlack),
                                                  SizedBox(
                                                      height:
                                                          _labelAndFormSpacing),
                                                  CustomForm.textField(context,
                                                      borderColor: _borderColor,
                                                      enabled: false,
                                                      hintText:
                                                          'Masukkan Nilai',
                                                      leading: _pinGmapsIcon,
                                                      leadingAndHintTextSpacing:
                                                          _leadingAndHintTextSpacing,
                                                      controller:
                                                          _bulanController)
                                                ],
                                              ))
                                          : SizedBox(),
                                      (_showTahun)
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  top: _paddingTop),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  CustomForm.textFieldLabel(
                                                      context,
                                                      label: 'Tahun',
                                                      letterSpacing: 1.5,
                                                      color: CustomColors
                                                          .eLaporBlack),
                                                  SizedBox(
                                                      height:
                                                          _labelAndFormSpacing),
                                                  CustomForm.textField(context,
                                                      borderColor: _borderColor,
                                                      enabled: false,
                                                      hintText:
                                                          'Masukkan Nilai',
                                                      leading: _pinGmapsIcon,
                                                      leadingAndHintTextSpacing:
                                                          _leadingAndHintTextSpacing,
                                                      controller:
                                                          _tahunController)
                                                ],
                                              ))
                                          : SizedBox(),
                                      (_showLatitude)
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  top: _paddingTop),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  CustomForm.textFieldLabel(
                                                      context,
                                                      label: 'Latitude',
                                                      letterSpacing: 1.5,
                                                      color: CustomColors
                                                          .eLaporBlack),
                                                  SizedBox(
                                                      height:
                                                          _labelAndFormSpacing),
                                                  CustomForm.readOnlyTextField(
                                                      context,
                                                      value: _latitudeState,
                                                      borderColor: _borderColor,
                                                      leading: _pinGmapsIcon,
                                                      leadingAndHintTextSpacing:
                                                          _leadingAndHintTextSpacing),
                                                ],
                                              ))
                                          : SizedBox(),
                                      (_showLongitude)
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  top: _paddingTop),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  CustomForm.textFieldLabel(
                                                      context,
                                                      label: 'Longitude',
                                                      letterSpacing: 1.5,
                                                      color: CustomColors
                                                          .eLaporBlack),
                                                  SizedBox(
                                                      height:
                                                          _labelAndFormSpacing),
                                                  CustomForm.readOnlyTextField(
                                                      context,
                                                      value: _longitudeState,
                                                      borderColor: _borderColor,
                                                      leading: _pinGmapsIcon,
                                                      leadingAndHintTextSpacing:
                                                          _leadingAndHintTextSpacing),
                                                ],
                                              ))
                                          : SizedBox(),
                                      Padding(
                                          padding:
                                              EdgeInsets.only(top: _paddingTop),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'PROVINSI',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              CustomForm.textField(context,
                                                  borderColor: _borderColor,
                                                  leading: _pinGmapsIcon,
                                                  leadingAndHintTextSpacing:
                                                      _leadingAndHintTextSpacing,
                                                  hintText: 'Masukkan Nilai',
                                                  enabled: false,
                                                  controller:
                                                      _provinsiUserController)
                                            ],
                                          )),
                                      Padding(
                                          padding:
                                              EdgeInsets.only(top: _paddingTop),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'KOTA/KABUPATEN',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              CustomForm.textField(context,
                                                  borderColor: _borderColor,
                                                  leading: _pinGmapsIcon,
                                                  leadingAndHintTextSpacing:
                                                      _leadingAndHintTextSpacing,
                                                  hintText: 'Masukkan Nilai',
                                                  enabled: false,
                                                  controller:
                                                      _kabupatenKotaUserController)
                                            ],
                                          )),
                                      Padding(
                                          padding:
                                              EdgeInsets.only(top: _paddingTop),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'KECAMATAN',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              (_isInputEnabled)
                                                  ? CustomForm.selectBox(
                                                      context,
                                                      defaultOptionText:
                                                          'Pilih Kecamatan',
                                                      defaultOptionValue: 0,
                                                      leading: _pinGmapsIcon,
                                                      leadingAndHintTextSpacing:
                                                          _leadingAndHintTextSpacing,
                                                      items: _kecamatan,
                                                      value: _kecamatanSelected,
                                                      borderColor: CustomColors
                                                          .eLaporBlack,
                                                      borderWidth:
                                                          1.0,
                                                      onChanged:
                                                          (newValue) async {
                                                      setState(() {
                                                        _kelurahanState = [];
                                                        _kelurahanSelected = 0;
                                                      });

                                                      Map<String, dynamic>
                                                          _dataLogin =
                                                          await AkunFuture
                                                              .getDataLogin();
                                                      int _idProvinsi =
                                                          _dataLogin[SPKey
                                                              .provinsiUser];
                                                      int _idKabupaten =
                                                          _dataLogin[SPKey
                                                              .kabupatenKotaUser];

                                                      List _kelurahanWilKer =
                                                          await DPIFuture
                                                              .getDesaWilayahKerja(
                                                                  idProvinsi:
                                                                      _idProvinsi,
                                                                  idKabupaten:
                                                                      _idKabupaten,
                                                                  idKecamatan:
                                                                      _kecamatanSelected);
                                                      _kelurahanWilKer =
                                                          _kelurahanWilKer
                                                              .map((desa) =>
                                                                  desa['desa'])
                                                              .toList();

                                                      setState(() {
                                                        _kelurahanState =
                                                            _kelurahanWilKer;
                                                        _kecamatanSelected =
                                                            newValue;
                                                        _kelurahanSelected = 0;
                                                      });
                                                    })
                                                  : CustomForm.readOnlyTextField(
                                                      context,
                                                      leading: _pinGmapsIcon,
                                                      leadingAndHintTextSpacing:
                                                          _leadingAndHintTextSpacing,
                                                      value:
                                                          _kecamatanSelectedString,
                                                      borderColor: _borderColor)
                                            ],
                                          )),
                                      Padding(
                                          padding:
                                              EdgeInsets.only(top: _paddingTop),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'DESA/KELURAHAN',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              (_isInputEnabled)
                                                  ? CustomForm.selectBox(
                                                      context,
                                                      defaultOptionText:
                                                          'Pilih Desa/Kelurahan',
                                                      defaultOptionValue: 0,
                                                      leading: _pinGmapsIcon,
                                                      leadingAndHintTextSpacing:
                                                          _leadingAndHintTextSpacing,
                                                      items: _kelurahan,
                                                      enabled: _isInputEnabled,
                                                      value: _kelurahanSelected,
                                                      borderColor: CustomColors
                                                          .eLaporBlack,
                                                      borderWidth: 1.0,
                                                      onChanged: (newValue) {
                                                      setState(() {
                                                        _kelurahanSelected =
                                                            newValue;
                                                      });
                                                    })
                                                  : CustomForm.readOnlyTextField(
                                                      context,
                                                      leading: _pinGmapsIcon,
                                                      leadingAndHintTextSpacing:
                                                          _leadingAndHintTextSpacing,
                                                      value:
                                                          _kelurahanSelectedString,
                                                      borderColor: _borderColor)
                                            ],
                                          )),
                                      Padding(
                                          padding:
                                              EdgeInsets.only(top: _paddingTop),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'Komoditas',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              (_isInputEnabled)
                                                  ? CustomForm.selectBox(
                                                      context,
                                                      defaultOptionText:
                                                          'Pilih Komoditas',
                                                      defaultOptionValue: 0,
                                                      leading: _pinGmapsIcon,
                                                      enabled: _isInputEnabled,
                                                      leadingAndHintTextSpacing:
                                                          _leadingAndHintTextSpacing,
                                                      items: _komoditas,
                                                      value: _komoditasSelected,
                                                      borderColor: CustomColors
                                                          .eLaporBlack,
                                                      borderWidth:
                                                          1.0,
                                                      onChanged:
                                                          (newValue) async {
                                                      await _getOPT(
                                                          komoditas: newValue,
                                                          kriteria:
                                                              _kriteriaOPTSelected);
                                                      setState(() {
                                                        _komoditasSelected =
                                                            newValue;
                                                      });
                                                    })
                                                  : CustomForm.readOnlyTextField(
                                                      context,
                                                      leading: _pinGmapsIcon,
                                                      leadingAndHintTextSpacing:
                                                          _leadingAndHintTextSpacing,
                                                      value:
                                                          _komoditasSelectedString,
                                                      borderColor: _borderColor)
                                            ],
                                          )),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'Varietas',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              CustomForm.textField(context,
                                                  leading: _pinGmapsIcon,
                                                  enabled: _isInputEnabled,
                                                  leadingAndHintTextSpacing:
                                                      _leadingAndHintTextSpacing,
                                                  borderColor: _borderColor,
                                                  maxLength: 100,
                                                  hintText: 'Masukkan Nilai',
                                                  controller:
                                                      _varietasController,
                                                  onEditingComplete: () {
                                                _focusScope.nextFocus();
                                              })
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'HST (hari)',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              CustomForm.textField(context,
                                                  leading: _pinGmapsIcon,
                                                  enabled: _isInputEnabled,
                                                  leadingAndHintTextSpacing:
                                                      _leadingAndHintTextSpacing,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    DecimalTextInputFormatter(
                                                        decimalRange: 2),
                                                    _comaFormatter
                                                  ],
                                                  borderColor: _borderColor,
                                                  hintText: 'Masukkan Nilai',
                                                  controller:
                                                      _umurTanamanController,
                                                  onEditingComplete: () {
                                                _focusScope.nextFocus();
                                              })
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'Luas Tanam (ha)',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              CustomForm.textField(context,
                                                  leading: _pinGmapsIcon,
                                                  enabled: _isInputEnabled,
                                                  leadingAndHintTextSpacing:
                                                      _leadingAndHintTextSpacing,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    DecimalTextInputFormatter(
                                                        decimalRange: 2),
                                                    _comaFormatter
                                                  ],
                                                  borderColor: _borderColor,
                                                  hintText: 'Masukkan Nilai',
                                                  controller:
                                                      _luasTanamController,
                                                  onEditingComplete: () {
                                                _focusScope.nextFocus();
                                              })
                                            ]),
                                      ),
                                      Padding(
                                          padding:
                                              EdgeInsets.only(top: _paddingTop),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'Kriteria OPT',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              (_isInputEnabled)
                                                  ? CustomForm.selectBox(
                                                      context,
                                                      defaultOptionText:
                                                          'Pilih Kriteria OPT',
                                                      defaultOptionValue: 0,
                                                      enabled: _isInputEnabled,
                                                      leading: _pinGmapsIcon,
                                                      leadingAndHintTextSpacing:
                                                          _leadingAndHintTextSpacing,
                                                      items: _kriteriaOPT,
                                                      value:
                                                          _kriteriaOPTSelected,
                                                      borderColor: CustomColors
                                                          .eLaporBlack,
                                                      borderWidth:
                                                          1.0,
                                                      onChanged:
                                                          (newValue) async {
                                                      await _getOPT(
                                                          komoditas:
                                                              _komoditasSelected,
                                                          kriteria: newValue);
                                                      setState(() {
                                                        _kriteriaOPTSelected =
                                                            newValue;
                                                      });
                                                    })
                                                  : CustomForm.readOnlyTextField(
                                                      context,
                                                      leading: _pinGmapsIcon,
                                                      leadingAndHintTextSpacing:
                                                          _leadingAndHintTextSpacing,
                                                      value:
                                                          _kriteriaOPTSelectedString,
                                                      borderColor: _borderColor)
                                            ],
                                          )),
                                      Padding(
                                          padding:
                                              EdgeInsets.only(top: _paddingTop),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'Jenis OPT',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              (_isInputEnabled)
                                                  ? CustomForm.selectBox(
                                                      context,
                                                      defaultOptionText:
                                                          'Pilih OPT',
                                                      defaultOptionValue: 0,
                                                      leading: _pinGmapsIcon,
                                                      enabled: _isInputEnabled,
                                                      leadingAndHintTextSpacing:
                                                          _leadingAndHintTextSpacing,
                                                      items: _opt,
                                                      value: _optSelected,
                                                      borderColor: CustomColors
                                                          .eLaporBlack,
                                                      borderWidth: 1.0,
                                                      onChanged: (newValue) {
                                                      setState(() {
                                                        _optSelected = newValue;
                                                      });
                                                    })
                                                  : CustomForm.readOnlyTextField(
                                                      context,
                                                      leading: _pinGmapsIcon,
                                                      leadingAndHintTextSpacing:
                                                          _leadingAndHintTextSpacing,
                                                      value: _optSelectedString,
                                                      borderColor: _borderColor)
                                            ],
                                          )),
                                      Padding(
                                          padding:
                                              EdgeInsets.only(top: _paddingTop),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'Periode Laporan',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              (_isInputEnabled)
                                                  ? CustomForm.selectBox(
                                                      context,
                                                      defaultOptionText:
                                                          'Pilih Periode',
                                                      defaultOptionValue: '',
                                                      leading: _pinGmapsIcon,
                                                      enabled: _isInputEnabled,
                                                      leadingAndHintTextSpacing:
                                                          _leadingAndHintTextSpacing,
                                                      items: _periode,
                                                      value: _periodeSelected,
                                                      borderColor: CustomColors
                                                          .eLaporBlack,
                                                      borderWidth: 1.0,
                                                      onChanged: (newValue) {
                                                      setState(() {
                                                        _periodeSelected =
                                                            newValue;
                                                      });
                                                    })
                                                  : CustomForm.readOnlyTextField(
                                                      context,
                                                      leading: _pinGmapsIcon,
                                                      leadingAndHintTextSpacing:
                                                          _leadingAndHintTextSpacing,
                                                      value:
                                                          _periodeSelectedString,
                                                      borderColor: _borderColor)
                                            ],
                                          )),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label:
                                                      'Curah Hujan (mm/hari)',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              CustomForm.textField(context,
                                                  leading: _pinGmapsIcon,
                                                  enabled: _isInputEnabled,
                                                  leadingAndHintTextSpacing:
                                                      _leadingAndHintTextSpacing,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    DecimalTextInputFormatter(
                                                        decimalRange: 2),
                                                    _comaFormatter
                                                  ],
                                                  borderColor: _borderColor,
                                                  maxLength: 100,
                                                  hintText: 'Masukkan Nilai',
                                                  controller:
                                                      _curahHujanController,
                                                  onEditingComplete: () {
                                                _focusScope.nextFocus();
                                              })
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label:
                                                      'Sisa Serangan (Ringan) (ha)',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              CustomForm.textField(context,
                                                  leading: _pinGmapsIcon,
                                                  enabled: _isInputEnabled,
                                                  leadingAndHintTextSpacing:
                                                      _leadingAndHintTextSpacing,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    DecimalTextInputFormatter(
                                                        decimalRange: 2),
                                                    _comaFormatter
                                                  ],
                                                  borderColor: _borderColor,
                                                  hintText: 'Masukkan Nilai',
                                                  controller: _sspsRingan,
                                                  onEditingComplete: () {
                                                _calculateJumlahSisaSerangan();
                                                _calculateJumlahLuasKeadaan();
                                                _focusScope.nextFocus();
                                              }, onChange: (value) {
                                                _calculateJumlahSisaSerangan();
                                                _calculateJumlahLuasKeadaan();
                                              })
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label:
                                                      'Sisa Serangan (Sedang) (ha)',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              CustomForm.textField(context,
                                                  leading: _pinGmapsIcon,
                                                  enabled: _isInputEnabled,
                                                  leadingAndHintTextSpacing:
                                                      _leadingAndHintTextSpacing,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    DecimalTextInputFormatter(
                                                        decimalRange: 2),
                                                    _comaFormatter
                                                  ],
                                                  borderColor: _borderColor,
                                                  hintText: 'Masukkan Nilai',
                                                  controller: _sspsSedang,
                                                  onEditingComplete: () {
                                                _calculateJumlahSisaSerangan();
                                                _calculateJumlahLuasKeadaan();
                                                _calculateJumlahLuasKeadaan();
                                                _focusScope.nextFocus();
                                              }, onChange: (value) {
                                                _calculateJumlahSisaSerangan();
                                                _calculateJumlahLuasKeadaan();
                                              })
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label:
                                                      'Sisa Serangan (Berat) (ha)',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              CustomForm.textField(context,
                                                  leading: _pinGmapsIcon,
                                                  enabled: _isInputEnabled,
                                                  leadingAndHintTextSpacing:
                                                      _leadingAndHintTextSpacing,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    DecimalTextInputFormatter(
                                                        decimalRange: 2),
                                                    _comaFormatter
                                                  ],
                                                  borderColor: _borderColor,
                                                  hintText: 'Masukkan Nilai',
                                                  controller: _sspsBerat,
                                                  onEditingComplete: () {
                                                _calculateJumlahSisaSerangan();
                                                _calculateJumlahLuasKeadaan();
                                                _calculateJumlahLuasKeadaan();
                                                _focusScope.nextFocus();
                                              }, onChange: (value) {
                                                _calculateJumlahSisaSerangan();
                                                _calculateJumlahLuasKeadaan();
                                              })
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label:
                                                      'Sisa Serangan (Puso) (ha)',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              CustomForm.textField(context,
                                                  leading: _pinGmapsIcon,
                                                  enabled: _isInputEnabled,
                                                  leadingAndHintTextSpacing:
                                                      _leadingAndHintTextSpacing,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    DecimalTextInputFormatter(
                                                        decimalRange: 2),
                                                    _comaFormatter
                                                  ],
                                                  borderColor: _borderColor,
                                                  hintText: 'Masukkan Nilai',
                                                  controller: _sspsPuso,
                                                  onEditingComplete: () {
                                                _calculateJumlahSisaSerangan();
                                                _calculateJumlahLuasKeadaan();
                                                _calculateJumlahLuasKeadaan();
                                                _focusScope.nextFocus();
                                              }, onChange: (value) {
                                                _calculateJumlahSisaSerangan();
                                                _calculateJumlahLuasKeadaan();
                                              })
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label:
                                                      'Sisa Serangan (Jumlah) (ha)',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              CustomForm.textField(context,
                                                  leading: _pinGmapsIcon,
                                                  leadingAndHintTextSpacing:
                                                      _leadingAndHintTextSpacing,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    DecimalTextInputFormatter(
                                                        decimalRange: 2),
                                                    _comaFormatter
                                                  ],
                                                  enabled: false,
                                                  borderColor: _borderColor,
                                                  hintText:
                                                      'Jumlah Sisa Serangan',
                                                  controller:
                                                      _jumlahSSPSController)
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'Luas Terkendali (ha)',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              CustomForm.textField(context,
                                                  leading: _pinGmapsIcon,
                                                  leadingAndHintTextSpacing:
                                                      _leadingAndHintTextSpacing,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    DecimalTextInputFormatter(
                                                        decimalRange: 2),
                                                    _comaFormatter
                                                  ],
                                                  borderColor: _borderColor,
                                                  hintText: 'Masukkan Nilai',
                                                  enabled: _isInputEnabled,
                                                  controller:
                                                      _luasTerkendaliController,
                                                  onEditingComplete: () {
                                                _calculateJumlahLuasKeadaan();
                                                _calculateJumlahLuasKeadaan();
                                                _focusScope.nextFocus();
                                              }, onChange: (value) {
                                                _calculateLuasTambahSerangan();
                                                _calculateJumlahLuasKeadaan();
                                              })
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'Luas Panen (ha)',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              CustomForm.textField(context,
                                                  leading: _pinGmapsIcon,
                                                  enabled: _isInputEnabled,
                                                  leadingAndHintTextSpacing:
                                                      _leadingAndHintTextSpacing,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    DecimalTextInputFormatter(
                                                        decimalRange: 2),
                                                    _comaFormatter
                                                  ],
                                                  borderColor: _borderColor,
                                                  hintText: 'Masukkan Nilai',
                                                  controller:
                                                      _luasPanenController,
                                                  onEditingComplete: () {
                                                _calculateJumlahLuasKeadaan();
                                                _focusScope.nextFocus();
                                              }, onChange: (value) {
                                                _calculateLuasTambahSerangan();
                                                _calculateJumlahLuasKeadaan();
                                              })
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label:
                                                      'LUAS TAMBAH (Ringan) (ha)',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              CustomForm.textField(context,
                                                  leading: _pinGmapsIcon,
                                                  enabled: _isInputEnabled,
                                                  leadingAndHintTextSpacing:
                                                      _leadingAndHintTextSpacing,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    DecimalTextInputFormatter(
                                                        decimalRange: 2),
                                                    _comaFormatter
                                                  ],
                                                  borderColor: _borderColor,
                                                  hintText: 'Masukkan Nilai',
                                                  controller: _ltspplRingan,
                                                  onEditingComplete: () {
                                                _calculateLuasTambahSerangan();
                                                _calculateJumlahLuasKeadaan();
                                                _focusScope.nextFocus();
                                              }, onChange: (value) {
                                                _calculateLuasTambahSerangan();
                                                _calculateJumlahLuasKeadaan();
                                              })
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label:
                                                      'LUAS TAMBAH (Sedang) (ha)',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              CustomForm.textField(context,
                                                  leading: _pinGmapsIcon,
                                                  enabled: _isInputEnabled,
                                                  leadingAndHintTextSpacing:
                                                      _leadingAndHintTextSpacing,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    DecimalTextInputFormatter(
                                                        decimalRange: 2),
                                                    _comaFormatter
                                                  ],
                                                  borderColor: _borderColor,
                                                  hintText: 'Masukkan Nilai',
                                                  controller: _ltspplSedang,
                                                  onEditingComplete: () {
                                                _calculateLuasTambahSerangan();
                                                _calculateJumlahLuasKeadaan();
                                                _focusScope.nextFocus();
                                              }, onChange: (value) {
                                                _calculateLuasTambahSerangan();
                                                _calculateJumlahLuasKeadaan();
                                              })
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label:
                                                      'LUAS TAMBAH (Berat) (ha)',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              CustomForm.textField(context,
                                                  leading: _pinGmapsIcon,
                                                  enabled: _isInputEnabled,
                                                  leadingAndHintTextSpacing:
                                                      _leadingAndHintTextSpacing,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    DecimalTextInputFormatter(
                                                        decimalRange: 2),
                                                    _comaFormatter
                                                  ],
                                                  borderColor: _borderColor,
                                                  hintText: 'Masukkan Nilai',
                                                  controller: _ltspplBerat,
                                                  onEditingComplete: () {
                                                _calculateLuasTambahSerangan();
                                                _calculateJumlahLuasKeadaan();
                                                _focusScope.nextFocus();
                                              }, onChange: (value) {
                                                _calculateLuasTambahSerangan();
                                                _calculateJumlahLuasKeadaan();
                                              })
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label:
                                                      'LUAS TAMBAH (Puso) (ha)',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              CustomForm.textField(context,
                                                  leading: _pinGmapsIcon,
                                                  enabled: _isInputEnabled,
                                                  leadingAndHintTextSpacing:
                                                      _leadingAndHintTextSpacing,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    DecimalTextInputFormatter(
                                                        decimalRange: 2),
                                                    _comaFormatter
                                                  ],
                                                  borderColor: _borderColor,
                                                  hintText: 'Masukkan Nilai',
                                                  controller: _ltspplPuso,
                                                  onEditingComplete: () {
                                                _calculateLuasTambahSerangan();
                                                _calculateJumlahLuasKeadaan();
                                                _focusScope.nextFocus();
                                              }, onChange: (value) {
                                                _calculateLuasTambahSerangan();
                                                _calculateJumlahLuasKeadaan();
                                              })
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label:
                                                      'Luas Tambah (Jumlah) (ha)',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              CustomForm.textField(context,
                                                  leading: _pinGmapsIcon,
                                                  leadingAndHintTextSpacing:
                                                      _leadingAndHintTextSpacing,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    DecimalTextInputFormatter(
                                                        decimalRange: 2),
                                                    _comaFormatter
                                                  ],
                                                  enabled: false,
                                                  borderColor: _borderColor,
                                                  hintText: 'Masukkan Nilai',
                                                  controller:
                                                      _jumlahLTSPPLController)
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label:
                                                      'Luas Pengendalian (Kimia) (ha)',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              CustomForm.textField(context,
                                                  leading: _pinGmapsIcon,
                                                  enabled: _isInputEnabled,
                                                  leadingAndHintTextSpacing:
                                                      _leadingAndHintTextSpacing,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    DecimalTextInputFormatter(
                                                        decimalRange: 2),
                                                    _comaFormatter
                                                  ],
                                                  borderColor: _borderColor,
                                                  hintText: 'Masukkan Nilai',
                                                  controller:
                                                      _pestisidaKimiaController,
                                                  onEditingComplete: () {
                                                _calculateJumlahLuasKeadaan();
                                                _focusScope.nextFocus();
                                              }, onChange: (value) {
                                                _calculateJumlahLuasPengendalian();
                                                _calculateJumlahLuasKeadaan();
                                              })
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label:
                                                      'Luas Pengendalian (Hayati) (ha)',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              CustomForm.textField(context,
                                                  leading: _pinGmapsIcon,
                                                  enabled: _isInputEnabled,
                                                  leadingAndHintTextSpacing:
                                                      _leadingAndHintTextSpacing,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    DecimalTextInputFormatter(
                                                        decimalRange: 2),
                                                    _comaFormatter
                                                  ],
                                                  borderColor: _borderColor,
                                                  hintText: 'Masukkan Nilai',
                                                  controller:
                                                      _pestisidaHayatiController,
                                                  onEditingComplete: () {
                                                _calculateJumlahLuasKeadaan();
                                                _focusScope.nextFocus();
                                              }, onChange: (value) {
                                                _calculateJumlahLuasPengendalian();
                                                _calculateJumlahLuasKeadaan();
                                              })
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label:
                                                      'Luas Pengendalian (Eradiksi) (ha)',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              CustomForm.textField(context,
                                                  leading: _pinGmapsIcon,
                                                  enabled: _isInputEnabled,
                                                  leadingAndHintTextSpacing:
                                                      _leadingAndHintTextSpacing,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    DecimalTextInputFormatter(
                                                        decimalRange: 2),
                                                    _comaFormatter
                                                  ],
                                                  borderColor: _borderColor,
                                                  hintText: 'Masukkan Nilai',
                                                  controller:
                                                      _eradikasiController,
                                                  onEditingComplete: () {
                                                _calculateJumlahLuasKeadaan();
                                                _focusScope.nextFocus();
                                              }, onChange: (value) {
                                                _calculateJumlahLuasPengendalian();
                                                _calculateJumlahLuasKeadaan();
                                              })
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label:
                                                      'Luas Pengendalian (Cara Lain) (ha)',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              CustomForm.textField(context,
                                                  leading: _pinGmapsIcon,
                                                  enabled: _isInputEnabled,
                                                  leadingAndHintTextSpacing:
                                                      _leadingAndHintTextSpacing,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    DecimalTextInputFormatter(
                                                        decimalRange: 2),
                                                    _comaFormatter
                                                  ],
                                                  borderColor: _borderColor,
                                                  hintText: 'Masukkan Nilai',
                                                  controller:
                                                      _caraLainController,
                                                  onEditingComplete: () {
                                                _calculateJumlahLuasKeadaan();
                                                _focusScope.nextFocus();
                                              }, onChange: (value) {
                                                _calculateJumlahLuasPengendalian();
                                                _calculateJumlahLuasKeadaan();
                                              })
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label:
                                                      'Luas Pengendalian (Jumlah) (ha)',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              CustomForm.textField(context,
                                                  leading: _pinGmapsIcon,
                                                  leadingAndHintTextSpacing:
                                                      _leadingAndHintTextSpacing,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    DecimalTextInputFormatter(
                                                        decimalRange: 2),
                                                    _comaFormatter
                                                  ],
                                                  borderColor: _borderColor,
                                                  enabled: false,
                                                  hintText: 'Masukkan Nilai',
                                                  controller:
                                                      _jumlahLuasPengendalian)
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label:
                                                      'Luas Keadaan (Ringan) (ha)',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              CustomForm.textField(context,
                                                  leading: _pinGmapsIcon,
                                                  leadingAndHintTextSpacing:
                                                      _leadingAndHintTextSpacing,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    DecimalTextInputFormatter(
                                                        decimalRange: 2),
                                                    _comaFormatter
                                                  ],
                                                  borderColor: _borderColor,
                                                  hintText: 'Masukkan Nilai',
                                                  enabled: false,
                                                  controller:
                                                      _lKSPPLRinganController,
                                                  onEditingComplete: () {
                                                _calculateJumlahLuasKeadaan();
                                                _focusScope.nextFocus();
                                              })
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label:
                                                      'Luas Keadaan (Sedang) (ha)',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              CustomForm.textField(context,
                                                  leading: _pinGmapsIcon,
                                                  leadingAndHintTextSpacing:
                                                      _leadingAndHintTextSpacing,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    DecimalTextInputFormatter(
                                                        decimalRange: 2),
                                                    _comaFormatter
                                                  ],
                                                  enabled: false,
                                                  borderColor: _borderColor,
                                                  hintText: 'Masukkan Nilai',
                                                  controller:
                                                      _lKSPPLSedangController,
                                                  onEditingComplete: () {
                                                _calculateJumlahLuasKeadaan();
                                                _focusScope.nextFocus();
                                              })
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label:
                                                      'Luas Keadaan (Berat) (ha)',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              CustomForm.textField(context,
                                                  leading: _pinGmapsIcon,
                                                  leadingAndHintTextSpacing:
                                                      _leadingAndHintTextSpacing,
                                                  enabled: false,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    DecimalTextInputFormatter(
                                                        decimalRange: 2),
                                                    _comaFormatter
                                                  ],
                                                  borderColor: _borderColor,
                                                  hintText: 'Masukkan Nilai',
                                                  controller:
                                                      _lKSPPLBeratController,
                                                  onEditingComplete: () {
                                                _calculateJumlahLuasKeadaan();
                                                _focusScope.nextFocus();
                                              })
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label:
                                                      'Luas Keadaan (Puso) (ha)',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              CustomForm.textField(context,
                                                  leading: _pinGmapsIcon,
                                                  leadingAndHintTextSpacing:
                                                      _leadingAndHintTextSpacing,
                                                  enabled: false,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    DecimalTextInputFormatter(
                                                        decimalRange: 2),
                                                    _comaFormatter
                                                  ],
                                                  borderColor: _borderColor,
                                                  hintText: 'Masukkan Nilai',
                                                  controller:
                                                      _lKSPPLPusoController,
                                                  onEditingComplete: () {
                                                _calculateJumlahLuasKeadaan();
                                                _focusScope.nextFocus();
                                              })
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label:
                                                      'Luas Keadaan (Jumlah) (ha)',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              CustomForm.textField(context,
                                                  leading: _pinGmapsIcon,
                                                  leadingAndHintTextSpacing:
                                                      _leadingAndHintTextSpacing,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    DecimalTextInputFormatter(
                                                        decimalRange: 2),
                                                    _comaFormatter
                                                  ],
                                                  enabled: false,
                                                  borderColor: _borderColor,
                                                  hintText: 'Luas Keadaan',
                                                  controller:
                                                      _jumlahLKSPPLController)
                                            ]),
                                      ),
                                      (_showOkmarAsep)
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  top: _paddingTop),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomForm.textFieldLabel(
                                                        context,
                                                        label:
                                                            'Periode (okmar/asep)',
                                                        color: CustomColors
                                                            .eLaporBlack),
                                                    SizedBox(
                                                        height:
                                                            _labelAndFormSpacing),
                                                    CustomForm.textField(
                                                        context,
                                                        leading: _pinGmapsIcon,
                                                        leadingAndHintTextSpacing:
                                                            _leadingAndHintTextSpacing,
                                                        maxLength: 5,
                                                        enabled: false,
                                                        hintText:
                                                            'Masukkan Nilai',
                                                        borderColor:
                                                            _borderColor,
                                                        controller:
                                                            _periodeOkmarAsepController)
                                                  ]),
                                            )
                                          : SizedBox(),
                                      (_showTHMT)
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  top: _paddingTop),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomForm.textFieldLabel(
                                                        context,
                                                        label: 'th mt',
                                                        color: CustomColors
                                                            .eLaporBlack),
                                                    SizedBox(
                                                        height:
                                                            _labelAndFormSpacing),
                                                    CustomForm.textField(
                                                        context,
                                                        leading: _pinGmapsIcon,
                                                        leadingAndHintTextSpacing:
                                                            _leadingAndHintTextSpacing,
                                                        maxLength: 9,
                                                        enabled: false,
                                                        hintText:
                                                            'Masukkan Nilai',
                                                        borderColor:
                                                            _borderColor,
                                                        controller:
                                                            _thMTController)
                                                  ]),
                                            )
                                          : SizedBox(),
                                      (_showMTMKMH)
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  top: _paddingTop),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomForm.textFieldLabel(
                                                        context,
                                                        label: 'MT (MK/MH)',
                                                        color: CustomColors
                                                            .eLaporBlack),
                                                    SizedBox(
                                                        height:
                                                            _labelAndFormSpacing),
                                                    CustomForm.textField(
                                                        context,
                                                        leading: _pinGmapsIcon,
                                                        leadingAndHintTextSpacing:
                                                            _leadingAndHintTextSpacing,
                                                        maxLength: 2,
                                                        enabled: false,
                                                        hintText:
                                                            'Masukkan Nilai',
                                                        borderColor:
                                                            _borderColor,
                                                        controller:
                                                            _mtMKMHController)
                                                  ]),
                                            )
                                          : SizedBox(),
                                      (_showSubround)
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  top: _paddingTop),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomForm.textFieldLabel(
                                                        context,
                                                        label: 'subround',
                                                        color: CustomColors
                                                            .eLaporBlack),
                                                    SizedBox(
                                                        height:
                                                            _labelAndFormSpacing),
                                                    CustomForm.textField(
                                                        context,
                                                        leading: _pinGmapsIcon,
                                                        leadingAndHintTextSpacing:
                                                            _leadingAndHintTextSpacing,
                                                        maxLength: 3,
                                                        enabled: false,
                                                        hintText:
                                                            'Masukkan Nilai',
                                                        borderColor:
                                                            _borderColor,
                                                        controller:
                                                            _subRoundController)
                                                  ]),
                                            )
                                          : SizedBox(),
                                    ]),
                                    (_isInputEnabled)
                                        ? Padding(
                                            padding: EdgeInsets.only(
                                                top: _paddingTop),
                                            child: Button.submitButton(
                                                context,
                                                (_idLaporan != null)
                                                    ? 'SIMPAN PERUBAHAN'
                                                    : 'SIMPAN', () async {
                                              setState(() {
                                                _isButtonSaveBusy = true;
                                              });
                                              Widget _icon = SvgPicture.asset(
                                                  ClientPath.svgPath +
                                                      '/danger.svg');
                                              String _title =
                                                  'Harap Tentukan Foto!';
                                              String _message =
                                                  'Isi foto terlebih dahulu !';
                                              Widget _actions = Button.button(
                                                  context, 'Coba Lagi', () {
                                                Navigator.pop(context);
                                              },
                                                  color:
                                                      CustomColors.dangerColor,
                                                  outline: true);

                                              bool _inputOK;
                                              if (_state ==
                                                  TambahLaporanState.add) {
                                                _inputOK =
                                                    _pickedFileState != null;
                                              } else {
                                                _inputOK = true;
                                              }

                                              if (_inputOK) {
                                                String _savePath =
                                                    (_idLaporan != null)
                                                        ? ServerPath
                                                            .updaetOPTPath
                                                        : ServerPath
                                                            .saveOPTPath;

                                                Uri _url = Uri.parse(
                                                    ServerPath.apiBaseURL +
                                                        '/' +
                                                        _savePath);
                                                MultipartRequest _request =
                                                    MultipartRequest(
                                                        'POST', _url);

                                                if (_pickedFileState != null) {
                                                  if (_idLaporan != null) {
                                                    _request.files.add(
                                                        MultipartFile
                                                            .fromString(
                                                                'photo',
                                                                _pickedFileState
                                                                    .path));
                                                  } else {
                                                    _request.files.add(
                                                        await MultipartFile
                                                            .fromPath(
                                                                'photo',
                                                                _pickedFileState
                                                                    .path));
                                                  }
                                                }

                                                Map<String, dynamic>
                                                    _dataLogin =
                                                    await AkunFuture
                                                        .getDataLogin();
                                                int _userID =
                                                    _dataLogin[SPKey.idUser];
                                                int _provinsiUser = _dataLogin[
                                                    SPKey.provinsiUser];
                                                int _kabupatenKotaUser =
                                                    _dataLogin[SPKey
                                                        .kabupatenKotaUser];

                                                int _bulan = int.parse(
                                                    _bulanController.text);
                                                int _tahun = int.parse(
                                                    _tahunController.text);

                                                Map<String, dynamic>
                                                    _dataToSend = {
                                                  'user': _userID,
                                                  'bulan': _bulan,
                                                  'tahun': _tahun,
                                                  'lat': _latitudeState,
                                                  'lng': _longitudeState,
                                                  'provinsi': _provinsiUser,
                                                  'kabupaten':
                                                      _kabupatenKotaUser,
                                                  'kecamatan':
                                                      _kecamatanSelected,
                                                  'desa': _kelurahanSelected,
                                                  'komoditas':
                                                      _komoditasSelected,
                                                  'curah_hujan':
                                                      _curahHujanController
                                                          .text,
                                                  'varietas':
                                                      _varietasController.text,
                                                  'umur': _umurTanamanController
                                                      .text,
                                                  'luas':
                                                      _luasTanamController.text,
                                                  'kriteria':
                                                      _kriteriaOPTSelected,
                                                  'opt': _optSelected,
                                                  'periode': _periodeSelected,
                                                  'sisa_serangan_ringan':
                                                      _sspsRingan.text,
                                                  'sisa_serangan_sedang':
                                                      _sspsSedang.text,
                                                  'sisa_serangan_berat':
                                                      _sspsBerat.text,
                                                  'sisa_serangan_puso':
                                                      _sspsPuso.text,
                                                  'sisa_serangan_jumlah':
                                                      _jumlahSSPSController
                                                          .text,
                                                  'sisa_serangan_luas_terkendali':
                                                      _luasTerkendaliController
                                                          .text,
                                                  'sisa_serangan_luas_panen':
                                                      _luasPanenController.text,
                                                  'luas_tambah_serangan_ringan':
                                                      _ltspplRingan.text,
                                                  'luas_tambah_serangan_sedang':
                                                      _ltspplSedang.text,
                                                  'luas_tambah_serangan_berat':
                                                      _ltspplBerat.text,
                                                  'luas_tambah_serangan_puso':
                                                      _ltspplPuso.text,
                                                  'luas_tambah_serangan_jumlah':
                                                      _jumlahLTSPPLController
                                                          .text,
                                                  'luas_pengendalian_kimia':
                                                      _pestisidaKimiaController
                                                          .text,
                                                  'luas_pengendalian_hayati':
                                                      _pestisidaHayatiController
                                                          .text,
                                                  'luas_pengendalian_eradiksi':
                                                      _eradikasiController.text,
                                                  'luas_pengendalian_cara_lain':
                                                      _caraLainController.text,
                                                  'luas_pengendalian_jumlah':
                                                      _jumlahLuasPengendalian
                                                          .text,
                                                  'luas_keadaan_ringan':
                                                      _lKSPPLRinganController
                                                          .text,
                                                  'luas_keadaan_sedang':
                                                      _lKSPPLSedangController
                                                          .text,
                                                  'luas_keadaan_berat':
                                                      _lKSPPLBeratController
                                                          .text,
                                                  'luas_keadaan_puso':
                                                      _lKSPPLPusoController
                                                          .text,
                                                  'luas_keadaan_jumlah':
                                                      _jumlahLKSPPLController
                                                          .text,
                                                  'periode_okmar_asep':
                                                      _periodeOkmarAsepController
                                                          .text,
                                                  'th_mt': _thMTController.text,
                                                  'mt_mk_mh':
                                                      _mtMKMHController.text,
                                                  'subround':
                                                      _subRoundController.text,
                                                  'visited_at':
                                                      _visitedAtController.text
                                                };

                                                if (_idLaporan != null) {
                                                  _dataToSend['id'] =
                                                      _idLaporan;
                                                }

                                                _dataToSend
                                                    .forEach((key, value) {
                                                  if (key.toLowerCase() !=
                                                      'photo') {
                                                    _request.fields[key] =
                                                        value.toString();
                                                  }
                                                });

                                                StreamedResponse _response =
                                                    await _request.send();

                                                Response _httpResponse =
                                                    await Response.fromStream(
                                                        _response);
                                                Map<String, dynamic>
                                                    _decodedBody = jsonDecode(
                                                        _httpResponse.body);
                                                String _status =
                                                    _decodedBody['status'];
                                                _message =
                                                    _decodedBody['message'];

                                                Color _iconColor =
                                                    CustomColors.dangerColor;
                                                String _iconPath = 'danger.svg';
                                                _title = 'Gagal!';
                                                String _buttonText =
                                                    'Coba Lagi!';
                                                bool _success = false;
                                                if (_status.toLowerCase() ==
                                                    'success') {
                                                  _iconColor =
                                                      CustomColors.eLaporGreen;
                                                  _iconPath =
                                                      'check-circle.svg';
                                                  _title = 'Berhasil !';
                                                  _buttonText = 'OK';
                                                  _success = true;
                                                }

                                                _icon = SvgPicture.asset(
                                                    ClientPath.svgPath +
                                                        '/$_iconPath');

                                                _actions = Button.button(
                                                    context, _buttonText, () {
                                                  Widget _routeTo = Beranda();
                                                  if (_tabItem ==
                                                      TabItem.laporanKu) {
                                                    _routeTo = LaporanKu();
                                                  }

                                                  if (_success) {
                                                    Navigator
                                                        .pushAndRemoveUntil(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (_) =>
                                                                    _routeTo),
                                                            (route) => false);
                                                  } else {
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                    color: _iconColor,
                                                    outline: true);
                                              }
                                              setState(() {
                                                _isButtonSaveBusy = false;
                                              });

                                              await Alert.textComponent(context,
                                                  icon: _icon,
                                                  title: _title,
                                                  subTitle: _message,
                                                  actions: _actions);
                                            },
                                                color: CustomColors.eLaporGreen,
                                                isBusy: _isButtonSaveBusy,
                                                trailing: Icon(
                                                    Icons
                                                        .arrow_forward_ios_sharp,
                                                    color: CustomColors
                                                        .eLaporWhite)),
                                          )
                                        : SizedBox()
                                  ]),
                            ),
                          ))),
                ),
              ])
            : Center(
                child: Loading(
                    loadingTitle: 'Tunggu Sebentar',
                    loadingSubTitle: 'Aplikasi sedang mengambil data')));
  }
}
