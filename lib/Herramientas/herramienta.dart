import 'package:flutter/material.dart';

Widget divider(double size) {
  return SizedBox(
    height: size,
  );
}

bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(p);

  return regExp.hasMatch(em);
}

Widget childText(
    String texto, double fontSize, FontWeight fontWeight, Color color) {
  return Text(
    texto,
    style: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}

Widget imagen() {
  return Image(
    image: AssetImage('img/LOGO_2.png'),
    height: 150.0,
  );
}

InputDecoration inputDecoration(String hintText, String labelText, Icon icon) {
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    hintText: hintText,
    labelText: labelText,
    suffixIcon: icon,
  );
}

Widget crearLoading(isloading) {
  if (isloading) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
          ],
        ),
        SizedBox(height: 15.0)
      ],
    );
  } else {
    return Container();
  }
}

void mostrarAlerta(
    BuildContext context, String titulo, String contenido, String ruta) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text(titulo),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Text(contenido)],
          ),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, ruta);
              },
              child: Text('OK'),
            )
          ],
        );
      });
}
