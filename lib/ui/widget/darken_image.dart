import 'package:flutter/material.dart';

class DarkenImage extends StatelessWidget {
  final String url;

  const DarkenImage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO(novikov): заменить на [CachedNetworkImage]
    return DecoratedBox(
      child: Image.network(
        url,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) =>
            loadingProgress == null
                ? child
                : Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).cardColor,
                      color: const Color(0xFF7C7E92),
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0x66252849), Color(0x083B3E5B)],
          begin: Alignment(0.5, -0.3125),
          end: Alignment(0.5, 1.6354),
        ),
        backgroundBlendMode: BlendMode.multiply,
      ),
      position: DecorationPosition.foreground,
    );
  }
}
