import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

// Fixed vertical side navigation (desktop only). Anchor links to sections.
class SideNav extends StatelessComponent {
  const SideNav({super.key});

  static const _items = [
    ('home', 'Home'),
    ('stack', 'Stack'),
    ('projects', 'Work'),
    ('contact', 'Contact'),
  ];

  @override
  Component build(BuildContext context) {
    return nav(classes: 'side-nav', [
      for (final (id, label) in _items)
        a(href: '#$id', classes: 'nav-item', [
          span(classes: 'nav-line', []),
          span(classes: 'nav-label', [Component.text(label)]),
        ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
        css('.side-nav').styles(
          display: Display.none,
          position: Position.fixed(left: 32.px, top: Unit.zero, bottom: Unit.zero),
          flexDirection: FlexDirection.column,
          justifyContent: JustifyContent.center,
          gap: Gap.all(20.px),
          zIndex: ZIndex(10),
          raw: {
            'height': 'fit-content',
            'margin': 'auto 0',
            'padding': '24px 18px',
            'background': 'rgba(18, 18, 18, 0.55)',
            'border': '1px solid rgba(255, 255, 255, 0.08)',
            'border-radius': '32px',
            'backdrop-filter': 'blur(16px)',
            '-webkit-backdrop-filter': 'blur(16px)',
            'box-shadow': '0 12px 40px rgba(0, 0, 0, 0.5), inset 0 1px 0 rgba(255, 255, 255, 0.1)',
          },
        ),
        css('.nav-item').styles(
          display: Display.flex,
          alignItems: AlignItems.center,
          gap: Gap.all(12.px),
          cursor: Cursor.pointer,
        ),
        css('.nav-line').styles(
          height: 1.px,
          width: 16.px,
          backgroundColor: const Color('rgba(255,255,255,0.2)'),
          raw: {'transition': 'width .4s cubic-bezier(.16,1,.3,1), background .3s'},
        ),
        css('.nav-item:hover .nav-line').styles(
          width: 48.px,
          backgroundColor: Colors.white,
        ),
        css('.nav-label').styles(
          fontFamily: const FontFamily.list([FontFamily('JetBrains Mono'), FontFamilies.monospace]),
          fontSize: 10.px,
          letterSpacing: 2.px,
          textTransform: TextTransform.upperCase,
          color: const Color('rgba(255,255,255,0.3)'),
          raw: {'transition': 'color .3s'},
        ),
        css('.nav-item:hover .nav-label').styles(color: Colors.white),
        css.media(MediaQuery.screen(minWidth: 768.px), [
          css('.side-nav').styles(display: Display.flex),
        ]),
      ];
}
