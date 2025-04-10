import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'my_game.dart';

class Bird extends SpriteComponent with HasGameRef<MyGame>, CollisionCallbacks {
  final double jumpVelocity = 250;
  double currentVelocityY = 0;
  final double bottom;
  final Function() onGameOver;
  final String birdColor; // <-- Add this
  bool isGameOver = false;

  Bird({
    required Vector2 position,
    required Vector2 size,
    required this.bottom,
    required this.onGameOver,
    this.birdColor = 'yellow', // default to yellow
  }) : super(
          position: position,
          size: size,
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    // Use birdColor to determine sprite
    sprite = await gameRef.loadSprite('${birdColor}bird-midflap.png');
    add(RectangleHitbox());
    return super.onLoad();
  }

  void jump() {
    currentVelocityY = -jumpVelocity;
  }

  @override
  void update(double dt) {
    currentVelocityY += gravity * dt;
    position.y += currentVelocityY * dt;
    position.y = position.y.clamp(size.y / 2, bottom - size.y / 2);
    super.update(dt);
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (!isGameOver) {
      isGameOver = true;
      super.onCollisionStart(intersectionPoints, other);
      print('Player collided with ${other.runtimeType}');
      onGameOver();
    }
  }
}
