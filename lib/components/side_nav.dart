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
        // Mobile default: a compact horizontal bar pinned to the bottom.
        css('.side-nav').styles(
          display: Display.flex,
          position: Position.fixed(left: Unit.zero, right: Unit.zero, bottom: 16.px),
          flexDirection: FlexDirection.row,
          justifyContent: JustifyContent.center,
          alignItems: AlignItems.center,
          gap: Gap.all(6.px),
          zIndex: ZIndex(50),
          raw: {
            'width': 'fit-content',
            'margin': '0 auto',
            'padding': '8px 10px',
            'background': 'rgba(18, 18, 18, 0.7)',
            'border': '1px solid rgba(255, 255, 255, 0.1)',
            'border-radius': '999px',
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
          raw: {'padding': '8px 12px', 'border-radius': '999px'},
        ),
        // The expanding line is a desktop affordance only.
        css('.nav-line').styles(
          display: Display.none,
          height: 1.px,
          width: 16.px,
          backgroundColor: const Color('rgba(255,255,255,0.2)'),
          raw: {'transition': 'width .4s cubic-bezier(.16,1,.3,1), background .3s'},
        ),
        css('.nav-label').styles(
          fontFamily: const FontFamily.list([FontFamily('JetBrains Mono'), FontFamilies.monospace]),
          fontSize: 11.px,
          letterSpacing: 2.px,
          textTransform: TextTransform.upperCase,
          color: const Color('rgba(255,255,255,0.55)'),
          raw: {'transition': 'color .3s'},
        ),
        css('.nav-item:hover .nav-label, .nav-item.active .nav-label').styles(color: Colors.white),
        // Active pill highlight on mobile bar.
        css('.nav-item.active').styles(
          backgroundColor: const Color('rgba(255,255,255,0.1)'),
        ),
        css.media(MediaQuery.screen(minWidth: 768.px), [
          // Desktop: vertical glass pill on the left, with expanding lines.
          css('.side-nav').styles(
            flexDirection: FlexDirection.column,
            gap: Gap.all(20.px),
            zIndex: ZIndex(10),
            raw: {
              'left': '32px',
              'right': 'auto',
              'top': '0',
              'bottom': '0',
              'width': 'auto',
              'height': 'fit-content',
              'margin': 'auto 0',
              'padding': '24px 18px',
              'border-radius': '32px',
              'background': 'rgba(18, 18, 18, 0.55)',
            },
          ),
          css('.nav-item').styles(raw: {'padding': '0', 'border-radius': '0'}),
          css('.nav-item.active').styles(backgroundColor: Colors.transparent),
          css('.nav-line').styles(display: Display.block),
          css('.nav-item:hover .nav-line, .nav-item.active .nav-line').styles(
            width: 48.px,
            backgroundColor: Colors.white,
          ),
          css('.nav-label').styles(color: const Color('rgba(255,255,255,0.4)')),
        ]),
      ];
}
