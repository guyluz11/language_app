import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselAtom extends StatefulWidget {
  const CarouselAtom({
    required this.items, required this.height, super.key,
    this.viewportFraction = 0.9,
    this.enlargeCenterPage = true,
    this.onPageChanged,
  });

  final List<Widget> items;
  final double height;
  final double viewportFraction;
  final bool enlargeCenterPage;
  final void Function(int index, CarouselPageChangedReason reason)?
      onPageChanged;

  @override
  State<CarouselAtom> createState() => _CarouselAtomState();
}

class _CarouselAtomState extends State<CarouselAtom> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CarouselSlider(
            options: CarouselOptions(
              height: widget.height,
              viewportFraction: widget.viewportFraction,
              enlargeCenterPage: widget.enlargeCenterPage,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
                widget.onPageChanged?.call(index, reason);
              },
            ),
            items: widget.items,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.items.asMap().entries.map((entry) {
            return Container(
              width: 8.0,
              height: 8.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary.withAlpha(
                      _current == entry.key ? 230 : 102,
                    ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
