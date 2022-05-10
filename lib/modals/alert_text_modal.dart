import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/constant.dart';
import 'package:flutter/material.dart';

class AlertTextModal extends StatefulWidget {
  final String alertContent;
  final VoidCallback onClick;

  const AlertTextModal(
      {Key? key, required this.alertContent, required this.onClick})
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

class YesNoAlertModal extends StatefulWidget {
  final String alertContent;
  final VoidCallback closeOnClick;
  final VoidCallback yesOnClick;
  final VoidCallback noOnClick;

  const YesNoAlertModal(
      {Key? key,
      required this.alertContent,
      required this.closeOnClick,
      required this.yesOnClick,
      required this.noOnClick})
      : super(key: key);

  @override
  _YesNoAlertModalState createState() => _YesNoAlertModalState();
}

class _YesNoAlertModalState extends State<YesNoAlertModal> {
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
                  onPressed: widget.closeOnClick,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                child: SizedBox(
                  height: 40,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.alertContent,
                      style: modalContent,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 30,
                      child: PurpleTextButton(
                        buttonText: 'Yes',
                        onClick: widget.yesOnClick,
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      height: 30,
                      child: PurpleTextButton(
                        buttonText: 'No',
                        onClick: widget.noOnClick,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
