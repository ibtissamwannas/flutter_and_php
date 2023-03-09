import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class CardNotes extends StatelessWidget {
  final void Function()? ontap2;
  final void Function()? ontap;
  final String title;
  final String content;
  final String image;
  const CardNotes(
      {super.key,
      required this.title,
      required this.content,
      this.ontap2,
      required this.image,
      this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap2,
      child: Card(
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Image.network(
                  "$image",
                  width: 100,
                  height: 100,
                )),
            Expanded(
                flex: 2,
                child: ListTile(
                  title: Text("$title"),
                  subtitle: Text("$content"),
                  trailing: InkWell(
                    onTap: ontap,
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
