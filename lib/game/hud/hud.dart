import 'package:flame/components.dart';
import 'package:flameforge/game/soccerGame.dart';

class Hud extends Component with HasGameRef<SoccerGame> {
  Hud({super.children, super.priority});

  @override
  Future<void>? onLoad() {
    final scoreTextComponent = TextComponent(
        text: '${gameRef.globalScore.value}',
        position: Vector2(gameRef.gameSize.x/2,20),
        anchor: Anchor.center,
        scale: Vector2(1, 1) / 5,
        );

    gameRef.globalScore.addListener(() {
      scoreTextComponent.text=gameRef.globalScore.value.toString();
    });

    add(scoreTextComponent);
    return super.onLoad();
  }
}
