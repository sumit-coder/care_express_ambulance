import 'package:flutter/material.dart';

class BtnName extends StatelessWidget {
  const BtnName(
      {Key? key,
      required this.tapFun,
      required this.btnName,
      required this.btnColor})
      : super(key: key);

  final VoidCallback tapFun;
  final String btnName;
  final Color btnColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: btnColor,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: tapFun,
        child: Container(
          width: 300,
          height: 50,
          decoration: BoxDecoration(
              // color: Colors.purple,
              // borderRadius: BorderRadius.circular(10),
              ),
          child: Center(
            child: Text(
              btnName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
