import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'dart:math';
import 'dart:math' as math;

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
  final String birdColor; // <-- added to allow color selection

  final Random random = Random();

  MyGame({
    required this.onGameOver,
    this.birdColor = 'yellow', // <-- default to yellow
  });

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final sprite = await loadSprite('background-day.png');
    Pipe.pipeSprite ??= await loadSprite('pipe-green.png');

    final imageSize = sprite.srcSize;
    final bgWidth = imageSize.x;
    final bgHeight = imageSize.y;
    final screenWidth = size.x;
    final numTiles = (screenWidth / bgWidth).ceil() + 1;

    for (int i = 0; i < numTiles; i++) {
      final bg = SpriteComponent()
        ..sprite = sprite
        ..size = Vector2(bgWidth, bgHeight)
        ..position = Vector2(i * bgWidth, 0);
      add(bg);
    }

    baseSprite = await loadSprite('base.png');
    final base1 = SpriteComponent()..sprite = baseSprite;
    baseHeight = base1.size.y;

    character = Bird(
      position: Vector2(100, size.y / 2),
      size: Vector2(50, 35),
      bottom: (size.y - baseSprite.srcSize.y / 2),
      onGameOver: onGameOver,
      birdColor: birdColor, // <-- passed to Bird
    )..debugMode = true;

    add(character);

    Pipe pipe = Pipe(
      position: Vector2(size.x / 2, size.y / 2),
      size: Vector2(55, 100),
    )..debugMode = true;

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
      spawnPipes();
      reloadBases();
    }

    super.update(dt);
  }

  void reloadBases() {
    for (final base in bases) {
      base.removeFromParent();
    }
    bases.clear();

    final baseWidth = baseSprite.srcSize.x;
    final baseHeight = baseSprite.srcSize.y;
    final visibleY = size.y - (baseHeight / 2);
    final numBaseTiles = (size.x / baseWidth).ceil() + 1;

    for (int i = 0; i < numBaseTiles; i++) {
      final baseTile = SpriteComponent()
        ..sprite = baseSprite
        ..size = Vector2(baseWidth, baseHeight)
        ..position = Vector2(i * baseWidth, visibleY);
      bases.add(baseTile);
      add(baseTile);
    }
  }

  void spawnPipes() {
    final pipeWidth = Pipe.pipeSprite!.srcSize.x;
    final pipeHeight = Pipe.pipeSprite!.srcSize.y;

    final gap = 100.0;
    final baseHeight = 20.0;
    final double minBottomCenter = gap + 1.5 * pipeHeight;
    final double maxBottomCenter = size.y - baseHeight - (pipeHeight / 2);
    final double allowedVariation = math.min(30.0, maxBottomCenter - minBottomCenter);

    final double bottomPipeCenterY = maxBottomCenter - random.nextDouble() * allowedVariation;
    final double topPipeCenterY = bottomPipeCenterY - gap;

    final bottomPipe = Pipe(
      position: Vector2(size.x + pipeWidth / 2, bottomPipeCenterY),
      size: Vector2(pipeWidth, pipeHeight),
      isTop: false,
    )..debugMode = true;
    add(bottomPipe);

    final topPipe = Pipe(
      position: Vector2(size.x + pipeWidth / 2, topPipeCenterY),
      size: Vector2(pipeWidth, pipeHeight),
      isTop: true,
    )..debugMode = true;
    add(topPipe);
  }
}
