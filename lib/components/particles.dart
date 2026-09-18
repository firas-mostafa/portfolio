import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

// Interactive particle background: a fixed <canvas> plus a client-side script
// that animates ambient particles + a mouse trail with connecting lines.
class ParticleBackground extends StatelessComponent {
  const ParticleBackground({super.key});

  @override
  Component build(BuildContext context) {
    // The canvas element; the animation is started from main.client.dart.
    return Component.element(
      tag: 'canvas', 
      id: 'bg-canvas',
      attributes: {'data-initialized': 'false'},
    );
  }

  @css
  static List<StyleRule> get styles => [
        css('#bg-canvas').styles(
          width: 100.vw,
          height: 100.vh,
          raw: {
            'position': 'fixed',
            'top': '0',
            'left': '0',
            'z-index': '0',
            'pointer-events': 'none',
            'display': 'block',
          },
        ),
      ];
}
