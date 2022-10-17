import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:lgpdjus/app/core/extension/iterable.dart';
import 'package:lgpdjus/app/shared/logger/log.dart';
import 'package:lgpdjus/common/extensions/xfile.dart';
import 'package:lgpdjus/common/widgets/snackbar.dart';
import 'package:lgpdjus/features/quiz/domain/entity/quiz_answer.dart';

class CameraPage extends StatefulWidget {
  CameraPage(LensDirection? lensDirection, {Key? key})
      : this.lensDirection = lensDirection?.direction,
        super(key: key);

  final CameraLensDirection? lensDirection;

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> with SnackBarHandler {
  CameraController? cameraController;
  late List<CameraDescription> cameras;
  XFile? imageFile;

  Color get randomColor {
    var colorHex = new Random().nextDouble() * 0xFFFFFF;
    return Color(colorHex.toInt()).withOpacity(1.0);
  }

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  _initCamera() {
    availableCameras().then((cameras) {
      this.cameras = cameras;
      if (cameras.isEmpty) {
        error('Camera is empty');
        return;
      }
      var index = cameras.indexWhere(
        (element) => element.lensDirection == widget.lensDirection,
      );
      if (index == -1) {
        index = 0;
      }
      _onNewCameraSelected(cameras[index]);
    }).then((_) {
      if (!mounted) return;
      setState(() {});
    }).catchError(catchErrorLogger);
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController?.value.isInitialized != true) {
      return Container();
    }
    return ColoredBox(
      color: Colors.black87,
      child: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            imageFile == null
                ? Center(child: CameraPreview(cameraController!))
                : Image.file(File(imageFile!.path), fit: BoxFit.contain),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: EdgeInsets.all(8),
                child: _buildChangeCameraButton(),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(16),
                child: _buildButtons(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget? _buildChangeCameraButton() {
    if (imageFile != null) return null;
    return IconButton(
      icon: Icon(
        Icons.flip_camera_ios_outlined,
      ),
      color: Color(0xFF3C3C3B),
      iconSize: 32,
      onPressed: _onChangeCameraPressed,
    );
  }

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: listOfNotNull([
        _buildCancelPictureButton(),
        _buildTakePictureButton(),
        _buildConfirmPictureButton(),
      ]),
    );
  }

  Widget? _buildTakePictureButton() {
    if (imageFile != null) return null;

    return ElevatedButton(
      onPressed: _onTakePictureButtonPressed,
      child: Icon(
        Icons.camera_alt_outlined,
        color: Color(0xFF3C3C3B),
        size: 40,
      ),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(
          side: BorderSide(color: Color(0xFF3C3C3B), width: 2),
        ),
        padding: EdgeInsets.all(20),
        primary: Color(0x80FFFFFF), // <-- Button color
        // onPrimary: Colors.red, // <-- Splash color
      ),
    );
  }

  Widget? _buildCancelPictureButton() {
    if (imageFile == null) return null;

    return ElevatedButton(
      onPressed: _onCancelPictureButtonPressed,
      child: Icon(
        Icons.close,
        color: Color(0xFF3C3C3B),
        size: 32,
      ),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(
          side: BorderSide(color: Color(0xFF3C3C3B), width: 2),
        ),
        padding: EdgeInsets.all(20),
        primary: Color(0x80FFFFFF), // <-- Button color
        // onPrimary: Colors.red, // <-- Splash color
      ),
    );
  }

  Widget? _buildConfirmPictureButton() {
    if (imageFile == null) return null;

    return ElevatedButton(
      onPressed: _onConfirmPictureButtonPressed,
      child: Icon(
        Icons.done,
        color: Color(0xFF3C3C3B),
        size: 32,
      ),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(
          side: BorderSide(color: Color(0xFF3C3C3B), width: 2),
        ),
        padding: EdgeInsets.all(20),
        primary: Color(0x80FFFFFF), // <-- Button color
        // onPrimary: Colors.red, // <-- Splash color
      ),
    );
  }

  void _onTakePictureButtonPressed() {
    _takePicture().then((XFile? file) {
      if (mounted) {
        setState(() {
          imageFile = file;
        });
        if (file != null) print('Picture saved to ${file.path}');
      }
    });
  }

  void _onCancelPictureButtonPressed() {
    imageFile?.delete();
    setState(() {
      imageFile = null;
    });
  }

  void _onConfirmPictureButtonPressed() {
    Navigator.pop(context, imageFile);
  }

  void _onChangeCameraPressed() {
    final cameraDescription = cameraController?.description;
    if (cameraDescription != null) {
      final int cameraId = cameras.indexOf(cameraDescription) + 1;
      if (cameraId < cameras.length) {
        _onNewCameraSelected(cameras[cameraId]);
      } else {
        _onNewCameraSelected(cameras[0]);
      }
    }
  }

  Future<XFile?> _takePicture() async {
    if (cameraController?.value.isInitialized != true) {
      print('Error: select a camera first.');
      return null;
    }

    if (cameraController!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      return await cameraController!.takePicture();
    } on CameraException catch (e, stack) {
      error(e, stack);
      return null;
    }
  }

  Future<void> _onNewCameraSelected(CameraDescription cameraDescription) async {
    if (cameraController != null) {
      await cameraController!.dispose();
    }
    final CameraController controller = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.jpeg,
      enableAudio: false,
    );
    cameraController = controller;

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        showSnackBarError('Camera error ${controller.value.errorDescription}');
      }
    });

    await controller.initialize();
    await controller.setFlashMode(FlashMode.off).catchError(catchErrorLogger);
  }
}

extension _LensDirection on LensDirection {
  CameraLensDirection get direction {
    switch (this) {
      case LensDirection.front:
        return CameraLensDirection.front;
      case LensDirection.back:
        return CameraLensDirection.back;
    }
  }
}
