import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {
  final String heroID;
  final String photoURL;
  const ImageViewer({
    Key? key,
    required this.heroID,
    required this.photoURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          child: Center(
            child: Hero(
              tag: heroID,
              child: SizedBox.expand(
                child: Image.network(photoURL),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
