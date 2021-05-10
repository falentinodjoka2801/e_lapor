import 'package:flutter/material.dart' show required;

class NotifikasiObject {
  final int id;
  final int userID;

  final NotifikasiContent content;
  final String date;

  NotifikasiObject(
      {@required this.id,
      @required this.userID,
      @required this.content,
      @required this.date});
}

class NotifikasiContent {
  final int id;
  final String title;
  final String status;
  final String desa;
  final String notes;

  NotifikasiContent(
      {@required this.id,
      @required this.title,
      @required this.status,
      @required this.desa,
      @required this.notes});
}
