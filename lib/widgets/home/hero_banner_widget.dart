import 'dart:async';
import 'package:flutter/material.dart';
import 'package:moviefliix/data/banner_data.dart';
import 'package:moviefliix/widgets/home/banner_slide.dart';
import 'package:moviefliix/widgets/home/dot_indicators.dart';
import 'package:moviefliix/widgets/home/top_bar.dart';

class HeroBannerWidget extends StatefulWidget {
  const HeroBannerWidget({super.key});

  @override
  State<HeroBannerWidget> createState() => _HeroBannerCarouselState();
}

class _HeroBannerCarouselState extends State<HeroBannerWidget> {
  final PageController _pageController = PageController();
  late Timer _timer;
  int _currentPage = 0;

  final List<Map<String, String>> banners = bannerData;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!mounted) return;
      int nextPage = (_currentPage + 1) % banners.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });

    _pageController.addListener(() {
      final int page = _pageController.page?.round() ?? 0;
      if (_currentPage != page) {
        setState(() {
          _currentPage = page;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 490,
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController,
            itemCount: banners.length,
            itemBuilder: (context, index) {
              final banner = banners[index];
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 1.0;
                  if (_pageController.position.haveDimensions) {
                    value = _pageController.page! - index;
                    value = (1 - (value.abs() * 0.3)).clamp(0.7, 1.0);
                  }
                  return Center(
                    child: SizedBox(
                      height: Curves.easeOut.transform(value) * 490,
                      child: child,
                    ),
                  );
                },
                child: BannerSlide(banner: banner),
              );
            },
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SafeArea(child: TopBar()),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: DotIndicators(
            count: banners.length,
            currentIndex: _currentPage,
          ),
        ),
      ],
    );
  }
}
