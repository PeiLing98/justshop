import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/components/input_text_box.dart';
import 'package:final_year_project/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

class OrderStatusModal extends StatefulWidget {
  final VoidCallback preparingOnClick;
  final VoidCallback deliveredOnClick;
  const OrderStatusModal(
      {Key? key,
      required this.deliveredOnClick,
      required this.preparingOnClick})
      : super(key: key);

  @override
  _OrderStatusModalState createState() => _OrderStatusModalState();
}

class _OrderStatusModalState extends State<OrderStatusModal> {
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
          height: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25,
                child: Align(
                  alignment: Alignment.topRight,
                  child: CloseButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Change Order Status',
                      style: boldContentTitle,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'If the order is preparing now,',
                      style: ratingLabelStyle,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                        width: 80,
                        height: 30,
                        child: PurpleTextButton(
                            buttonText: 'Preparing',
                            onClick: widget.preparingOnClick)),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'If the order is delivered,',
                      style: ratingLabelStyle,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                        width: 80,
                        height: 30,
                        child: PurpleTextButton(
                            buttonText: 'Delivered',
                            onClick: widget.deliveredOnClick)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReviewModal extends StatefulWidget {
  final void Function(double) updateStars;
  final Function(String) reviewUpdate;
  final VoidCallback confirmOnClick;
  const ReviewModal(
      {Key? key,
      required this.updateStars,
      required this.confirmOnClick,
      required this.reviewUpdate})
      : super(key: key);

  @override
  _ReviewModalState createState() => _ReviewModalState();
}

class _ReviewModalState extends State<ReviewModal> {
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
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25,
                child: Align(
                  alignment: Alignment.topRight,
                  child: CloseButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'How many stars would you give this listing?',
                      style: boldContentTitle,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RatingBar.builder(
                      glow: false,
                      updateOnDrag: true,
                      initialRating: 1,
                      unratedColor: Colors.grey[300],
                      minRating: 1,
                      itemSize: 20,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: secondaryColor,
                      ),
                      onRatingUpdate: widget.updateStars,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'How do you review this listing?',
                      style: boldContentTitle,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    StringTextArea(
                        label: 'Write your review',
                        textLine: 4,
                        onChanged: widget.reviewUpdate),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                            width: 100,
                            height: 30,
                            child: PurpleTextButton(
                                buttonText: 'Confirm',
                                onClick: widget.confirmOnClick)),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShareSocialMediaModal extends StatefulWidget {
  final VoidCallback facebookOnClick;
  final VoidCallback instagramOnClick;
  final VoidCallback whatsappOnClick;
  const ShareSocialMediaModal(
      {Key? key,
      required this.facebookOnClick,
      required this.instagramOnClick,
      required this.whatsappOnClick})
      : super(key: key);

  @override
  _ShareSocialMediaModalState createState() => _ShareSocialMediaModalState();
}

class _ShareSocialMediaModalState extends State<ShareSocialMediaModal> {
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
          height: 180,
          child: Column(
            children: [
              SizedBox(
                height: 25,
                child: Align(
                  alignment: Alignment.topRight,
                  child: CloseButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              const Text(
                'Share With Others',
                style: boldContentTitle,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          onPressed: widget.facebookOnClick,
                          iconSize: 50,
                          icon: const Icon(FontAwesomeIcons.facebookSquare,
                              color: Color.fromRGBO(66, 103, 178, 1)),
                        ),
                        const Text(
                          'Facebook',
                          style: buttonLabelStyle,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: widget.instagramOnClick,
                          iconSize: 50,
                          icon: const Icon(FontAwesomeIcons.instagramSquare,
                              color: Color.fromRGBO(233, 89, 80, 1)),
                        ),
                        const Text(
                          'Instagram',
                          style: buttonLabelStyle,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: widget.whatsappOnClick,
                          iconSize: 50,
                          icon: const Icon(FontAwesomeIcons.whatsappSquare,
                              color: Color.fromRGBO(40, 209, 70, 1)),
                        ),
                        const Text(
                          'WhatsApp',
                          style: buttonLabelStyle,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
