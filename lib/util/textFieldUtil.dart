import 'package:flutter/material.dart';

class TextFieldUtil{
// 여러줄 textformfield
  renderTextFormMultiField({
    required String label,
    required FormFieldSetter onSaved,
    required FormFieldValidator validator,
    required String originVal
  }) {
    assert(onSaved != null);
    assert(validator != null);

    return Column(
      children: [
        SizedBox(height: 20.0,),
        SizedBox(
            width: 280,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  onSaved: onSaved,
                  validator: validator,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  controller: TextEditingController(text: originVal),
                ),
              ],
            )
        )
      ],
    );
  }
  //textform widget 위젯 생성
  renderTextFormField({
    required String label,
    required FormFieldSetter onSaved,
    required FormFieldValidator validator,
    required String originVal
  }) {
    assert(onSaved != null);
    assert(validator != null);

    return Column(
      children: [
        SizedBox(height: 20.0,),
        SizedBox(
            width: 280,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  onSaved: onSaved,
                  validator: validator,
                  controller: TextEditingController(text: originVal),

                ),
              ],
            )
        )
      ],
    );
  }
}