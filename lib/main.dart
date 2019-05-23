import 'package:flutter/material.dart';

import 'package:audioplayers/audio_cache.dart';

void main() => runApp(Vehicles());


class VehicleOverlay extends ModalRoute<Widget> {
  final vehicleImage;
  final vehicleSound;

  VehicleOverlay(this.vehicleImage, this.vehicleSound);

  @override
  Duration get transitionDuration => Duration(milliseconds: 100);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.8);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
      type: MaterialType.transparency,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(child: Image.asset('./assets/images/$vehicleImage')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}

class Vehicles extends StatelessWidget {
  static AudioCache player = AudioCache(prefix: 'audio/vehicles/');

  void _showVehicleDetail(BuildContext context, vehicleImage, vehicleSound) {
    Navigator.of(context).push(VehicleOverlay(vehicleImage, vehicleSound));
    // Navigator.push(context, MaterialPageRoute(builder: (context) => VehicleOverlay(vehicleImage: vehicleImage, vehicleSound: vehicleSound))));
  }

  void _playSound(String vehicleSound) {
    player.play("$vehicleSound");
  }

  Expanded _buildVehicle(context, vehicleImage, vehicleSound) {
    return Expanded(
      child: InkWell(
        child: Image.asset('./assets/images/$vehicleImage', fit: BoxFit.fill),
        onTap: () {
          _showVehicleDetail(context, vehicleImage, vehicleSound);
          _playSound(vehicleSound);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) => Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Container(
                  color: Colors.amberAccent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _buildVehicle(context, 'f1.jpg', 'f1.wav'),
                      _buildVehicle(context, 'jet.jpg', 'jet.wav'),
                      _buildVehicle(context, 'ship.jpg', 'ship.wav'),
                      _buildVehicle(context, 'fly.jpg', 'fly.wav'),
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }
}