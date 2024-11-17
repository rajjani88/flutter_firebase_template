import 'package:flutter/material.dart';

class ImageSelectionBottomSheet extends StatelessWidget {
  final VoidCallback onGallerySelected;
  final VoidCallback onCameraSelected;

  const ImageSelectionBottomSheet({
    Key? key,
    required this.onGallerySelected,
    required this.onCameraSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Image',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Select from Gallery'),
            onTap: onGallerySelected,
          ),
          ListTile(
            leading: const Icon(Icons.camera),
            title: const Text('Select from Camera'),
            onTap: onCameraSelected,
          ),
        ],
      ),
    );
  }
}
