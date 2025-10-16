import 'package:ekang_flutter/core/widgets/widgets.dart';

class SiEkangLoader extends StatefulWidget {

  final double width;
  final double height;

  const SiEkangLoader(this.width, this.height, {super.key});

  @override
  State<StatefulWidget> createState() => _SiEkangLoaderState();
}

class _SiEkangLoaderState extends State<SiEkangLoader> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: SizedBox(
          height: widget.width,
          width: widget.height,
          child: const CircularProgressIndicator(
            color: SiEkangColors.primary,
          ),
        ),
      ),
    );
  }
}
