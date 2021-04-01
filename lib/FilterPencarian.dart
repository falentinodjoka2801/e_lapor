import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:flutter/material.dart';

import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:e_lapor/libraries/SizeConfig.dart';

import 'package:e_lapor/globalWidgets/CustomForm.dart';

import 'package:e_lapor/FakeData/Wilayah.dart';

class FilterPencarian extends StatefulWidget {
  _FilterPencarianState createState() => _FilterPencarianState();
}

class _FilterPencarianState extends State<FilterPencarian> {
  dynamic _provinsiSelected = '',
      _kotaKabupatenSelected = '',
      _kecamatanSelected = '',
      _kelurahanSelected = '';

  List _provinsiState = [];
  List _kotaKabupatenState = [];
  List _kecamatanState = [];
  List _kelurahanState = [];

  void initState() {
    super.initState();
    initialization();
  }

  Future<void> initialization() async {
    List _decodedProvinsi = await Wilayah.getProvinsi();
    setState(() {
      _provinsiState = _decodedProvinsi;
    });
  }

/*
jika suatu dropdownbutton memiliki value yang tidak ada di dalam list item, maka akan error.
contohnya karena valuenya tidak dirubah, sementara item item dalam dropdownbutton tidak ada yang punya value tsb, maka akan error
 */
  Widget build(BuildContext context) {
    SizeConfig().initSize(context);

    double _paddingTop = SizeConfig.horizontalBlock * 4.0;
    double _labelAndFormSpacing = SizeConfig.horizontalBlock * 2.5;
    double _leadingAndHintTextSpacing = SizeConfig.horizontalBlock * 5.25;

    List<DropdownMenuItem> _provinsi =
        Wilayah.dropdownMenuItemBuilder(_provinsiState);
    List<DropdownMenuItem> _kotaKabupaten =
        Wilayah.dropdownMenuItemBuilder(_kotaKabupatenState);
    List<DropdownMenuItem> _kecamatan =
        Wilayah.dropdownMenuItemBuilder(_kecamatanState);
    List<DropdownMenuItem> _kelurahan =
        Wilayah.dropdownMenuItemBuilder(_kelurahanState);

    Image _leading = Image.asset(ClientPath.laporanIconPath + '/pin-gmaps.png');

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
              CustomForm.selectBox(context,
                  defaultOptionText: 'Pilih Provinsi',
                  defaultOptionValue: '',
                  leading: _leading,
                  leadingAndHintTextSpacing: _leadingAndHintTextSpacing,
                  items: _provinsi,
                  value: _provinsiSelected,
                  borderColor: CustomColors.eLaporGreen,
                  borderWidth: 2.0, onChanged: (newValue) async {
                Map<String, dynamic> _whereKotaKabupaten = {
                  'entity': 'idProvinsi',
                  'value': newValue
                };
                List _decodedKotaKabupaten =
                    await Wilayah.getKabupatenKota(where: _whereKotaKabupaten);

                setState(() {
                  _kotaKabupatenState = _decodedKotaKabupaten;
                  _provinsiSelected = newValue;
                  _kotaKabupatenSelected = '';
                  _kecamatanSelected = '';
                  _kelurahanSelected = '';

                  _kecamatanState = [];
                  _kelurahanState = [];
                });
              })
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
              CustomForm.selectBox(context,
                  defaultOptionText: 'Pilih Kota/Kabupaten',
                  defaultOptionValue: '',
                  leading: _leading,
                  leadingAndHintTextSpacing: _leadingAndHintTextSpacing,
                  items: _kotaKabupaten,
                  value: _kotaKabupatenSelected,
                  borderColor: CustomColors.eLaporGreen,
                  borderWidth: 2.0, onChanged: (newValue) async {
                Map<String, dynamic> _whereKecamatan = {
                  'entity': 'idKabupatenKota',
                  'value': newValue
                };
                List _decodedKecamatan =
                    await Wilayah.getKecamatan(where: _whereKecamatan);
                setState(() {
                  _kecamatanState = _decodedKecamatan;
                  _kotaKabupatenSelected = newValue;
                  _kecamatanSelected = '';
                  _kelurahanSelected = '';

                  _kelurahanState = [];
                });
              })
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
                  defaultOptionValue: '',
                  leading: _leading,
                  leadingAndHintTextSpacing: _leadingAndHintTextSpacing,
                  items: _kecamatan,
                  value: _kecamatanSelected,
                  borderColor: CustomColors.eLaporGreen,
                  borderWidth: 2.0, onChanged: (newValue) async {
                Map<String, dynamic> _whereKelurahan = {
                  'entity': 'idKecamatan',
                  'value': newValue
                };
                List _decodedKelurahan =
                    await Wilayah.getKelurahan(where: _whereKelurahan);
                setState(() {
                  _kelurahanState = _decodedKelurahan;
                  _kecamatanSelected = newValue;
                  _kelurahanSelected = '';
                });
              })
            ],
          )),
      Padding(
          padding: EdgeInsets.only(top: _paddingTop),
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
                  defaultOptionValue: '',
                  leading: _leading,
                  leadingAndHintTextSpacing: _leadingAndHintTextSpacing,
                  items: _kelurahan,
                  value: _kelurahanSelected,
                  borderColor: CustomColors.eLaporGreen,
                  borderWidth: 2.0, onChanged: (newValue) {
                setState(() {
                  _kelurahanSelected = newValue;
                });
              })
            ],
          )),
    ]);
  }
}
