import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';

class AppImageData {
  static const String _imagesPath = 'assets/images/';
  static const String image1 = '${_imagesPath}image1.png';
  static const String image2 = '${_imagesPath}image2.png';
  static const String image3 = '${_imagesPath}image3.png';
  static const String image4 = '${_imagesPath}image4.png';
  static const String image5 = '${_imagesPath}image5.png';
  static const String image6 = '${_imagesPath}image6.png';
}

class AppImages extends StatefulWidget {
  final String? path;
  final String? file;
  final Uint8List? bytes;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final bool isLoaded;
  
  const AppImages({
    super.key,
    this.path,
    this.height,
    this.width,
    this.fit,
    this.bytes,
    this.file,
    this.isLoaded = true,
  }) : assert(path != null || bytes != null || file != null);

  @override
  State<AppImages> createState() => _AppImagesState();
}

class _AppImagesState extends State<AppImages> with AutomaticKeepAliveClientMixin {
  bool get isNetwork => widget.path?.startsWith('http') ?? false;
  bool get isAsset => widget.path?.startsWith('assets') ?? false;
  bool get isFile => widget.file != null;
  bool get isMemory => widget.bytes != null;
  Uint8List? data;
  bool loadingImages = false;

  @override
  void initState() {
    _getImageBytes();
    super.initState();
  }

  void _getImageBytes() async {
    log('getting Image bytes');
    if (isNetwork && widget.isLoaded) {
      setState(() {
        loadingImages = true;
      });
      try {
        final response = await NetworkAssetBundle(Uri.parse(widget.path!))
            .load(widget.path!);
        setState(() {
          data = response.buffer.asUint8List();
          loadingImages = false;
        });
      } catch (e) {
        setState(() {
          loadingImages = false;
        });
      }
    } else if (isMemory) {
      setState(() {
        data = widget.bytes;
      });
    }
  }

  Widget _errorWidget() {
    return Container(
      height: widget.height,
      width: widget.width,
      color: Colors.grey.withOpacity(0.4),
      child: const Center(
        child: Icon(
          Icons.image,
          color: Colors.red,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (data != null) {
      return Image.memory(
        data!,
        height: widget.height,
        width: widget.width,
        fit: widget.fit,
        errorBuilder: (context, error, stackTrace) {
          return _errorWidget();
        },
      );
    } else if (isNetwork && loadingImages) {
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: widget.height,
          width: widget.width,
          color: Colors.grey,
        ),
      );
    } else if (isNetwork && !widget.isLoaded) {
      return Image.network(
        widget.path!,
        height: widget.height,
        width: widget.width,
        fit: widget.fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: widget.height,
              width: widget.width,
              color: Colors.grey,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return _errorWidget();
        },
      );
    } else if (isAsset) {
      return Image.asset(
        widget.path!,
        height: widget.height,
        width: widget.width,
        fit: widget.fit,
        errorBuilder: (context, error, stackTrace) {
          return _errorWidget();
        },
      );
    } else if (isFile) {
      return Image.file(
        File(widget.file!),
        height: widget.height,
        width: widget.width,
        fit: widget.fit,
        errorBuilder: (context, error, stackTrace) {
          return _errorWidget();
        },
      );
    }
    return _errorWidget();
  }

  @override
  bool get wantKeepAlive => true;
} 