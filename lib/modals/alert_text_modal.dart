import 'package:final_year_project/constant.dart';
import 'package:flutter/material.dart';

class AlertTextModal extends StatefulWidget {
  final String alertContent;
  VoidCallback onClick;

  AlertTextModal({Key? key, required this.alertContent, required this.onClick})
      : super(key: key);

  @override
  _AlertTextModalState createState() => _AlertTextModalState();
}

class _AlertTextModalState extends State<AlertTextModal> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: SizedBox(
          height: 150,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: CloseButton(
                  onPressed: widget.onClick,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.alertContent,
                    style: modalContent,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
