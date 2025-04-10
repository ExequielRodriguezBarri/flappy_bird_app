import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'my_game.dart';

class Pipe extends SpriteComponent with HasGameRef<MyGame> {
  final bool isTop;
  final String pipeColor;
  static final Map<String, Sprite> _pipeSprites = {};

  Pipe({
    required Vector2 position,
    required Vector2 size,
    this.isTop = false,
    this.pipeColor = 'green',
  }) : super(
          position: position,
          size: size,
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    if (!_pipeSprites.containsKey(pipeColor)) {
      _pipeSprites[pipeColor] =
          await gameRef.loadSprite('pipe-$pipeColor.png');
    }

    sprite = _pipeSprites[pipeColor];

    if (isTop) {
      scale.y = -1;
      position.y -= size.y;
    }

    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    position += Vector2(-speed * dt, 0);

    if (position.x + size.x < 0) {
      removeFromParent();
    }

    super.update(dt);
  }
}
