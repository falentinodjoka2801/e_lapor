import 'package:flutter/material.dart';

import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:e_lapor/libraries/SizeConfig.dart';

import 'package:e_lapor/globalWidgets/CustomForm.dart';

class FilterPencarian extends StatefulWidget {
  _FilterPencarianState createState() => _FilterPencarianState();
}

class _FilterPencarianState extends State<FilterPencarian> {
  String _provinsiSelected;

  Widget build(BuildContext context) {
    SizeConfig().initSize(context);

    double _paddingTop = SizeConfig.horizontalBlock * 4.0;
    double _labelAndFormSpacing = SizeConfig.horizontalBlock * 2.5;
    double _leadingAndHintTextSpacing = SizeConfig.horizontalBlock * 5.25;

    List<DropdownMenuItem> _provinsi = [
      DropdownMenuItem(child: Text('Sumatera Utara'), value: 'Sumatera Utara'),
      DropdownMenuItem(child: Text('Sumatera Barat'), value: 'Sumatera Barat'),
      DropdownMenuItem(
          child: Text('Sumatera Selatan'), value: 'Sumatera Selatan')
    ];

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
                  leading: Icon(Icons.pin_drop_outlined,
                      color: CustomColors.eLaporIconColor),
                  leadingAndHintTextSpacing: _leadingAndHintTextSpacing,
                  items: _provinsi,
                  value: _provinsiSelected,
                  borderColor: CustomColors.eLaporGreen,
                  borderWidth: 2.0, onChanged: (newValue) {
                setState(() {
                  _provinsiSelected = newValue;
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
                  leading: Icon(Icons.pin_drop_outlined,
                      color: CustomColors.eLaporIconColor),
                  leadingAndHintTextSpacing: _leadingAndHintTextSpacing,
                  items: _provinsi,
                  value: _provinsiSelected,
                  borderColor: CustomColors.eLaporGreen,
                  borderWidth: 2.0, onChanged: (newValue) {
                setState(() {
                  _provinsiSelected = newValue;
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
                  leading: Icon(Icons.pin_drop_outlined,
                      color: CustomColors.eLaporIconColor),
                  leadingAndHintTextSpacing: _leadingAndHintTextSpacing,
                  items: _provinsi,
                  value: _provinsiSelected,
                  borderColor: CustomColors.eLaporGreen,
                  borderWidth: 2.0, onChanged: (newValue) {
                setState(() {
                  _provinsiSelected = newValue;
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
                  leading: Icon(Icons.pin_drop_outlined,
                      color: CustomColors.eLaporIconColor),
                  leadingAndHintTextSpacing: _leadingAndHintTextSpacing,
                  items: _provinsi,
                  value: _provinsiSelected,
                  borderColor: CustomColors.eLaporGreen,
                  borderWidth: 2.0, onChanged: (newValue) {
                setState(() {
                  _provinsiSelected = newValue;
                });
              })
            ],
          )),
    ]);
  }
}
