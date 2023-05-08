import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: ListImagesCustom(),
        ),
      ),
    );
  }
}

class ListImagesCustom extends StatefulWidget {
  const ListImagesCustom({Key? key}) : super(key: key);

  @override
  State<ListImagesCustom> createState() => _ListImagesCustomState();
}

class _ListImagesCustomState extends State<ListImagesCustom> {
  final ValueNotifier<int?> selectedCardNotifier = ValueNotifier<int?>(null);
  List<String> dataImages = [
    'assets/images/img1.jpeg',
    'assets/images/img2.jpg',
    'assets/images/img3.jpg',
    'assets/images/img4.jpeg',
    'assets/images/img5.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CardImage(
            image: dataImages[index],
            width: 50,
          );
        },
        itemCount: dataImages.length,
      ),
    );
  }
}

class CardImage extends StatefulWidget {
  const CardImage(
      {required this.image,
      required this.width,
      this.widthExpanded = 180,
      this.height = 200,
      Key? key})
      : super(key: key);
  final String image;
  final double width;
  final double widthExpanded;
  final double height;

  @override
  State<CardImage> createState() => _CardImageState();
}

class _CardImageState extends State<CardImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _widthAnimation =
        Tween<double>(begin: widget.width, end: widget.widthExpanded).animate(
      CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOutCubic,
          reverseCurve: Curves.easeInOutCirc),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (details) {
        _animationController.forward();
      },
      onExit: (details) {
        _animationController.reverse();
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            height: widget.height,
            width: _widthAnimation.value,
            margin: const EdgeInsets.all(4),
            child: child,
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            widget.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
