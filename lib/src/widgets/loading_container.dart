import "package:flutter/material.dart";

class LoadingContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: buildContainer(),
          subtitle: buildContainer(),
        ),
        const Divider(),
      ],
    );
  }

  Widget buildContainer() {
    return Container(
      color: Colors.grey[300],
      width: 150.0,
      height: 24.0,
      margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
    );
  }
}
