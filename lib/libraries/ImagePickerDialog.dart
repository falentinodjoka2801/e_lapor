import 'package:flutter/material.dart'
    show
        showModalBottomSheet,
        BuildContext,
        SafeArea,
        Container,
        Wrap,
        ListTile,
        Navigator,
        Text;
import 'package:image_picker/image_picker.dart';

import 'package:e_lapor/libraries/SizeConfig.dart';

class ImagePickerDialog {
  static Future<ImageSource> showImagePicker(BuildContext context,
      {bool isDismissible = false}) async {
    // return ImageSource.camera;

    return showModalBottomSheet(
      context: context,
      isDismissible: isDismissible,
      builder: (context) {
        return SafeArea(
            child: Container(
                child: Wrap(children: [
          ListTile(
            title: Text('From Camera'),
            onTap: () {
              Navigator.pop(context, ImageSource.camera);
            },
          ),
          ListTile(
            title: Text('From Gallery'),
            onTap: () {
              Navigator.pop(context, ImageSource.gallery);
            },
          )
        ])));
      },
    );
  }

  static Future<PickedFile> takePicture(
    BuildContext context,
    ImageSource imageSource,
  ) async {
    SizeConfig().initSize(context);

    try {
      PickedFile imageFile =
          await ImagePicker().getImage(source: imageSource, imageQuality: 50);

      return imageFile;
    } catch (e) {
      return null;
    }
  }
}
