import 'package:ecommerce/core/base/state/base_state.dart';
import 'package:flutter/material.dart';

class VerificationCodeInput extends StatefulWidget {
  final int codeLength;
  final Function(String) onCodeSubmitted;

  VerificationCodeInput(
      {@required this.codeLength, @required this.onCodeSubmitted});

  @override
  _VerificationCodeInputState createState() => _VerificationCodeInputState();
}

class _VerificationCodeInputState extends BaseState<VerificationCodeInput> {
  List<FocusNode> _focusNodes;
  List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(widget.codeLength, (index) => FocusNode());
    _controllers =
        List.generate(widget.codeLength, (index) => TextEditingController());
  }

  @override
  void dispose() {
    for (int i = 0; i < widget.codeLength; i++) {
      _focusNodes[i].dispose();
      _controllers[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.codeLength,
        (index) => Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:3.0),
            child: TextFormField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              keyboardType: TextInputType.number,
              maxLength: 1,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(4.0),
                counterText: '',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  _focusNodes[index].unfocus();
                  if (index < widget.codeLength - 1) {
                    _focusNodes[index + 1].requestFocus();
                  }
                }
                String code = _getCode();
                if (code.length == widget.codeLength) {
                  widget.onCodeSubmitted(code);
                }
              },
              onSaved: (value) {
                String code = _getCode();
                if (code.length == widget.codeLength) {
                  widget.onCodeSubmitted(code);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  String _getCode() {
    String code = '';
    for (int i = 0; i < widget.codeLength; i++) {
      code += _controllers[i].text;
    }
    return code;
  }
}
