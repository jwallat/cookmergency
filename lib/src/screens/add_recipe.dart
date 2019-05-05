import "package:flutter/material.dart";
import "package:direct_select/direct_select.dart";

class AddRecipe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Recipe"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              const Text(
                "Title",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                maxLength: 50,
              ),
              Divider(),
              const Text(
                "Type",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(),
              Divider(),
              const Text(
                "Preparation text",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                minLines: 4,
                maxLines: 4,
              ),
              Divider(),
              const Text(
                "Image Url",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                maxLength: 300,
              ),
              Divider(),
              const Text(
                "Ingredients",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(),
              Row(
                children: <Widget>[
                  RaisedButton(
                    child: const Text("Submit"),
                    onPressed: () => <dynamic>{},
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.end,
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          margin: const EdgeInsets.all(8),
        ),
      ),
    );
  }
}
