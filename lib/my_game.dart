import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

import 'bird.dart';
import 'pipe.dart';

const speed = 80;
const gapInSeconds = 2.5;
const gravity = 900;

class MyGame extends FlameGame with TapDetector, HasCollisionDetection {
  late Bird character;
  late double baseHeight;
  late Sprite baseSprite;
  double delta = 0;
  final List<SpriteComponent> bases = [];

  final Function() onGameOver;

  MyGame({required this.onGameOver});

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final sprite = await loadSprite('background-day.png');

    Pipe.pipeSprite ??= await loadSprite('pipe-green.png');

    final background1 = SpriteComponent()..sprite = sprite;
    add(background1);

    baseSprite = await loadSprite('base.png');
    final base1 = SpriteComponent()..sprite = baseSprite;
    baseHeight = base1.size.y;

    character = Bird(
      position: Vector2(100, size.y / 2),
      size: Vector2(50, 35),
      bottom: (size.y - baseHeight / 2),
      onGameOver: onGameOver,
    )..debugMode = true;
    Pipe pipe =
        Pipe(position: Vector2(size.x / 2, size.y / 2), size: Vector2(55, 100))
          ..debugMode = true;
    add(character);
    add(pipe);

    reloadBases();
  }

  @override
  void onTapDown(TapDownInfo info) {
    character.jump();
  }

  @override
  void update(double dt) {
    delta += dt;

    if (delta > gapInSeconds) {
      delta %= gapInSeconds;
      final newPipe =
          Pipe(position: Vector2(size.x, size.y / 2), size: Vector2(50, 200));
      add(newPipe);
      reloadBases();
    }

    super.update(dt);
  }

  void reloadBases() {
    for (final base in bases) {
      base.removeFromParent();
    }
    bases.clear();

    final base1 = SpriteComponent()..sprite = baseSprite;
    base1.position = Vector2(0, size.y - (base1.size.y / 2));
    bases.add(base1);
    add(base1);
  }
}
