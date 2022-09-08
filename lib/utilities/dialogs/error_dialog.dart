import 'package:flutter/cupertino.dart';
import 'package:onurun/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
      context: context,
      title: 'An error occurred',
      content: text,
      optionsBuilder: () => {
            // burası sanırım anonim fonksiyon
            'OK': null,
          });
}
