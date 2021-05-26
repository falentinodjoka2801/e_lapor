import 'package:e_lapor/Future/Akun/AkunFuture.dart';
import 'package:e_lapor/Future/DPIFuture.dart';
import 'package:e_lapor/Future/LaporanFuture.dart';
import 'package:e_lapor/globalWidgets/Alert.dart';
import 'package:e_lapor/globalWidgets/Button.dart';
import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:e_lapor/libraries/SPKey.dart';
import 'package:flutter/material.dart';

import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:e_lapor/libraries/SizeConfig.dart';

import 'package:e_lapor/globalWidgets/CustomForm.dart';

import 'package:e_lapor/FakeData/Wilayah.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterPencarian extends StatefulWidget {
  final String currentTab;
  final void Function(List dataFilter, Map<String, int> filterData)
      dataFiltered;
  final void Function(List dataFiltered) onBersihkan;
  final Map<String, int> currentFilter;
  FilterPencarian(
      {@required this.currentTab,
      @required this.dataFiltered,
      @required this.onBersihkan,
      @required this.currentFilter});
  _FilterPencarianState createState() => _FilterPencarianState();
}

class _FilterPencarianState extends State<FilterPencarian> {
  TextEditingController _provinsiController = TextEditingController();
  TextEditingController _kotaKabupatenController = TextEditingController();

  List _kelurahanState = [];
  List _kecamatanState = [];

  int _kecamatanSelected = 0;
  int _kelurahanSelected = 0;

  bool _isButtonTerapkanBusy = false;
  bool _isButtonBersihkanFilterBusy = false;

  void initState() {
    super.initState();
    _initialization();
  }

  Future<LaporanResponse> _terapkanFilter(
      {int idKecamatan, int idKelurahan}) async {
    String _currentTab = widget.currentTab;

    Map<String, dynamic> _dataLogin = await AkunFuture.getDataLogin();
    int _activeUserID = _dataLogin[SPKey.idUser];
    int _idProvinsi = _dataLogin[SPKey.provinsiUser];
    int _idKabupatenKota = _dataLogin[SPKey.kabupatenKotaUser];

    LaporanResponse _laporanResponse = await LaporanFuture.getLaporan(
        idUser: _activeUserID,
        status: _currentTab,
        idProvinsi: _idProvinsi,
        idKabupatenKota: _idKabupatenKota,
        idKecamatan:
            (idKecamatan != null && idKecamatan != 0) ? idKecamatan : null,
        idKelurahan:
            (idKelurahan != null && idKelurahan != 0) ? idKelurahan : null);

    return _laporanResponse;
  }

  Future<void> _initialization() async {
    Map<String, dynamic> _dataLogin = await AkunFuture.getDataLogin();
    int _idUser = _dataLogin[SPKey.idUser];
    int _idProvinsiUser = _dataLogin[SPKey.provinsiUser];
    int _idKabupatenKotaUser = _dataLogin[SPKey.kabupatenKotaUser];

    Map<String, int> _currentFilter = widget.currentFilter;
    int _filterKecamatan, _filterKelurahan;

    if (_currentFilter != null) {
      _filterKecamatan = _currentFilter['kecamatan'];
      _filterKelurahan = _currentFilter['kelurahan'];

      _filterKecamatan = (_filterKecamatan != null && _filterKecamatan != 0)
          ? _filterKecamatan
          : null;
      _filterKelurahan = (_filterKelurahan != null && _filterKelurahan != 0)
          ? _filterKelurahan
          : null;
    }

    List _kWK = await DPIFuture.getKecamatanWilayahKerja(
        idProvinsi: _idProvinsiUser,
        idKabupaten: _idKabupatenKotaUser,
        idUser: _idUser);
    _kWK = _kWK.map((kecamatan) => kecamatan['kecamatan']).toList();

    List _kelurahan = [];
    if (_filterKecamatan != null) {
      List _dWK = await DPIFuture.getDesaWilayahKerja(
          idProvinsi: _idProvinsiUser,
          idKabupaten: _idKabupatenKotaUser,
          idKecamatan: _filterKecamatan);
      _dWK = _dWK.map((desa) => desa['desa']).toList();

      _kelurahan = _dWK;
    }

    setState(() {
      _kecamatanState = _kWK;
      if (_filterKecamatan != null) {
        _kecamatanSelected = _filterKecamatan;
        _kelurahanState = _kelurahan;
        _kelurahanSelected = _filterKelurahan;
      }
      _provinsiController.text = _dataLogin[SPKey.provinsiUserString];
      _kotaKabupatenController.text = _dataLogin[SPKey.kabupatenKotaUserString];
    });
  }

  void dispose() {
    super.dispose();
    _provinsiController.dispose();
    _kotaKabupatenController.dispose();
  }

  Widget build(BuildContext context) {
    SizeConfig().initSize(context);

    double _paddingTop = SizeConfig.horizontalBlock * 4.0;
    double _labelAndFormSpacing = SizeConfig.horizontalBlock * 2.5;
    double _leadingAndHintTextSpacing = SizeConfig.horizontalBlock * 5.25;

    List<DropdownMenuItem> _kecamatan = Wilayah.dropdownMenuItemBuilder(
        _kecamatanState,
        textIndex: 'name',
        valueIndex: 'id');
    List<DropdownMenuItem> _kelurahan = Wilayah.dropdownMenuItemBuilder(
        _kelurahanState,
        textIndex: 'name',
        valueIndex: 'id');

    Widget _leading = SvgPicture.asset(ClientPath.svgPath + '/map-pin.svg',
        color: CustomColors.dangerColor);

    Color _borderColor = CustomColors.eLaporGreen;

    return Column(children: [
      Padding(
          padding: EdgeInsets.only(top: _paddingTop),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomForm.textFieldLabel(context,
                  label: 'PROVINSI',
                  letterSpacing: 1.5,
                  color: CustomColors.eLaporBlack),
              SizedBox(height: _labelAndFormSpacing),
              CustomForm.textField(context,
                  hintText: 'Provinsi',
                  controller: _provinsiController,
                  borderColor: _borderColor,
                  enabled: false)
            ],
          )),
      Padding(
          padding: EdgeInsets.only(top: _paddingTop),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomForm.textFieldLabel(context,
                  label: 'KOTA/KABUPATEN',
                  letterSpacing: 1.5,
                  color: CustomColors.eLaporBlack),
              SizedBox(height: _labelAndFormSpacing),
              CustomForm.textField(context,
                  hintText: 'Kabupaten Kota',
                  controller: _kotaKabupatenController,
                  borderColor: _borderColor,
                  enabled: false)
            ],
          )),
      Padding(
          padding: EdgeInsets.only(top: _paddingTop),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomForm.textFieldLabel(context,
                  label: 'KECAMATAN',
                  letterSpacing: 1.5,
                  color: CustomColors.eLaporBlack),
              SizedBox(height: _labelAndFormSpacing),
              CustomForm.selectBox(context,
                  defaultOptionText: 'Pilih Kecamatan',
                  defaultOptionValue: 0,
                  leading: _leading,
                  leadingAndHintTextSpacing: _leadingAndHintTextSpacing,
                  items: _kecamatan,
                  value: _kecamatanSelected,
                  borderColor: _borderColor, onChanged: (selected) async {
                Map<String, dynamic> _dataLogin =
                    await AkunFuture.getDataLogin();
                int _provinsiUser = _dataLogin[SPKey.provinsiUser];
                int _kabupatenUser = _dataLogin[SPKey.kabupatenKotaUser];

                List _dWK = await DPIFuture.getDesaWilayahKerja(
                    idProvinsi: _provinsiUser,
                    idKabupaten: _kabupatenUser,
                    idKecamatan: selected);
                _dWK = _dWK.map((desa) => desa['desa']).toList();

                setState(() {
                  _kecamatanSelected = selected;
                  _kelurahanSelected = 0;
                  _kelurahanState = _dWK;
                });
              })
            ],
          )),
      Padding(
          padding: EdgeInsets.only(top: _paddingTop, bottom: _paddingTop),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomForm.textFieldLabel(context,
                  label: 'DESA',
                  letterSpacing: 1.5,
                  color: CustomColors.eLaporBlack),
              SizedBox(height: _labelAndFormSpacing),
              CustomForm.selectBox(context,
                  defaultOptionText: 'Pilih Desa/Kelurahan',
                  defaultOptionValue: 0,
                  leading: _leading,
                  leadingAndHintTextSpacing: _leadingAndHintTextSpacing,
                  items: _kelurahan,
                  value: _kelurahanSelected,
                  borderColor: _borderColor, onChanged: (selected) {
                setState(() {
                  _kelurahanSelected = selected;
                });
              })
            ],
          )),
      Button.submitButton(context, 'TERAPKAN', () async {
        setState(() {
          _isButtonTerapkanBusy = true;
        });

        LaporanResponse _terapkanFilterResponse = await _terapkanFilter(
            idKecamatan: _kecamatanSelected, idKelurahan: _kelurahanSelected);
        if (_terapkanFilterResponse.statusCode == 200) {
          List _dataFiltered = _terapkanFilterResponse.laporan;

          Map<String, int> _filterData = {
            'kecamatan': _kecamatanSelected,
            'kelurahan': _kelurahanSelected
          };
          widget.dataFiltered(_dataFiltered, _filterData);
        } else {
          await Alert.alertServerBermasalah(context);
        }

        setState(() {
          _isButtonTerapkanBusy = false;
        });
      },
          color: CustomColors.eLaporGreen,
          isBusy: _isButtonTerapkanBusy,
          trailing: Icon(Icons.arrow_forward_ios_sharp,
              color: CustomColors.eLaporWhite)),
      SizedBox(height: 5.0),
      Button.submitButton(context, 'BERSIHKAN FILTER', () async {
        setState(() {
          _isButtonBersihkanFilterBusy = true;
        });

        LaporanResponse _terapkanFilterResponse = await _terapkanFilter();
        if (_terapkanFilterResponse.statusCode == 200) {
          List _dataFiltered = _terapkanFilterResponse.laporan;
          widget.onBersihkan(_dataFiltered);
        } else {
          await Alert.alertServerBermasalah(context);
        }

        setState(() {
          _isButtonBersihkanFilterBusy = false;
        });
      },
          isBusy: _isButtonBersihkanFilterBusy,
          color: CustomColors.eLaporRed,
          outline: true,
          useBorder: false),
    ]);
  }
}
