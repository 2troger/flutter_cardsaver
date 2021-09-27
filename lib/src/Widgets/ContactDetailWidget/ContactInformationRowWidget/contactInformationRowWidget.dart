import 'package:flutter/material.dart';

class ContactInformationRowWidget extends StatefulWidget {
  ContactInformationRowWidget({
    Key key,
    this.labelText,
    @required this.valueText,
    @required this.updateText,
    this.inputType = TextInputType.text,
    @required this.suggestions,
  }) : super(key: key);

  final String labelText;
  final List<String> suggestions;
  final TextInputType inputType;
  final String valueText;
  final Function updateText;

  @override
  State createState() => ContactInformationRowWidgetState();
}

class ContactInformationRowWidgetState
    extends State<ContactInformationRowWidget> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.valueText);
    _controller.addListener(() {
      widget.updateText(_controller.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.done,
            keyboardType: widget.inputType,
            decoration: InputDecoration(labelText: widget.labelText),
            controller: _controller,
          ),
        ),
        (widget.suggestions.isNotEmpty
            ? Container(
                width: 40,
                child: RaisedButton(
                  onPressed: () async {
                    final selection = await showDialog<String>(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          title: Text("Suggestions from Image:"),
                          children: widget.suggestions.map((s) {
                            return SimpleDialogOption(
                              child: Text(s),
                              onPressed: () => Navigator.pop(context, s),
                            );
                          }).toList(),
                        );
                      },
                    );
                    if (selection != null) {
                      _controller.text = selection;
                    }
                  },
                ),
              )
            : Container()),
      ],
    );
  }
}
