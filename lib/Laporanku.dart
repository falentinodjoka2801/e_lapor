import 'package:flutter/material.dart';

import 'package:e_lapor/libraries/SizeConfig.dart';
import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:e_lapor/libraries/ClientPath.dart';

import 'package:e_lapor/globalWidgets/CustomBottomNavigationBar.dart';
import 'package:e_lapor/globalWidgets/CustomNavigation.dart';
import 'package:e_lapor/globalWidgets/Button.dart';
import 'package:e_lapor/globalWidgets/Alert.dart';

import 'package:e_lapor/FilterPencarian.dart';

class LaporanKu extends StatefulWidget {
  @override
  _LaporanKuState createState() => _LaporanKuState();
}

class _LaporanKuState extends State<LaporanKu> with TickerProviderStateMixin {
  Widget build(BuildContext context) {
    SizeConfig().initSize(context);

    List<Widget> _actions = [
      IconButton(
          icon:
              Icon(Icons.filter_list_outlined, color: CustomColors.eLaporWhite),
          onPressed: () async {
            Widget _body = FilterPencarian();
            Widget _actions = Column(children: [
              Button.submitButton(context, 'TERAPKAN', () {},
                  color: CustomColors.eLaporGreen,
                  trailing: Icon(Icons.arrow_forward_ios_sharp,
                      color: CustomColors.eLaporWhite)),
              SizedBox(height: 5.0),
              Button.submitButton(context, 'BERSIHKAN FILTER', () {},
                  color: CustomColors.eLaporRed,
                  outline: true,
                  useBorder: false),
            ]);
            await Alert.widgetComponent(context,
                icon: ClientPath.iconPath + '/search.png',
                body: _body,
                actions: _actions);
          })
    ];
    return Scaffold(
      backgroundColor: CustomColors.eLaporWhite,
      appBar: CustomNavigation.appBar(
          title: 'Laporan Ku',
          backgroundColor: CustomColors.eLaporGreen,
          actions: _actions),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfig.horizontalBlock * 4.0),
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(top: 7.5),
            child: TabBar(
                isScrollable: true,
                onTap: (value) {},
                indicatorColor: CustomColors.eLaporGreen,
                indicatorWeight: 3.5,
                labelColor: CustomColors.eLaporGreen,
                unselectedLabelColor: CustomColors.eLaporBlack,
                labelStyle: TextStyle(fontWeight: FontWeight.w700),
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
                controller:
                    TabController(length: 4, vsync: this, initialIndex: 0),
                tabs: [
                  Tab(child: Text('PENDING (8)')),
                  Tab(child: Text('DALAM PENGECEKAN (1)')),
                  Tab(child: Text('TELAH DIVERIFIKASI (10)')),
                  Tab(child: Text('DITOLAK (1)'))
                ]),
          ),
          Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 10,
                  itemBuilder: (_listViewContext, _index) {
                    return Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.horizontalBlock * 4.0),
                        child: Card(
                            margin: EdgeInsets.zero,
                            elevation: 3.5,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Color(0XFFCBD2D9), width: 1.5),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Padding(
                              padding: EdgeInsets.all(
                                  SizeConfig.horizontalBlock * 4.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('20 Januari 2021',
                                        style: TextStyle(
                                            color: CustomColors.eLaporBlack,
                                            fontSize:
                                                SizeConfig.horizontalBlock *
                                                    3.0,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(height: 2.0),
                                    Text('Laporan OPT',
                                        style: TextStyle(
                                            color: CustomColors.eLaporBlack,
                                            fontSize:
                                                SizeConfig.horizontalBlock *
                                                    5.0,
                                            fontWeight: FontWeight.w700)),
                                    SizedBox(height: 3.5),
                                    Row(children: [
                                      Icon(Icons.pin_drop_outlined,
                                          color: CustomColors.eLaporRed),
                                      SizedBox(
                                          width:
                                              SizeConfig.horizontalBlock * 3.0),
                                      Text('Teluk Bideun',
                                          style: TextStyle(
                                              color: CustomColors.eLaporBlack,
                                              fontSize:
                                                  SizeConfig.horizontalBlock *
                                                      3.5,
                                              fontWeight: FontWeight.w500))
                                    ])
                                  ]),
                            )));
                  })),
        ]),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
