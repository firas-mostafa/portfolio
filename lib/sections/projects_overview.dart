import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import '../constants/content.dart';

// Projects overview section with app logos and links
class ProjectsOverviewSection extends StatelessComponent {
  const ProjectsOverviewSection({super.key});

  @override
  Component build(BuildContext context) {
    return section(id: 'projects', classes: 'projects-overview', [
      div(classes: 'projects-header', [
        span(classes: 'section-label', [Component.text('Selected Work // 03')]),
        h2(classes: 'section-title', [
          strong([Component.text('SELECTED')]),
          Component.text(' WORKS'),
        ]),
      ]),
      
      div(classes: 'projects-grid', [
        for (final p in projects)
          a(href: '#project-${p.index}', classes: 'project-card-link project-${p.index}', [
            div(classes: 'project-card-preview', [
              // Logo
              div(classes: 'project-icon', [
                img(src: 'images/${p.index == '01' ? 'ursa_logo.png' : p.index == '02' ? 'test_logo.png' : 'ag_logo.png'}', alt: '${p.name} Logo'),
              ]),
              
              // Project name
              h3(classes: 'project-card-name', [Component.text(p.name)]),
              
              // Description (truncated)
              div(classes: 'project-card-desc', [
                Component.text(
                  p.desc.length > 120 ? '${p.desc.substring(0, 120)}...' : p.desc,
                ),
              ]),
              
              // Tech tags (4 max)
              div(classes: 'project-card-tech', [
                for (final t in p.tech.take(4))
                  span(classes: 'tech-tag', [Component.text(t)]),
              ]),
            ]),
          ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
        css('.projects-overview').styles(
          minHeight: 100.vh,
          display: Display.flex,
          flexDirection: FlexDirection.column,
          justifyContent: JustifyContent.center,
          padding: Padding.symmetric(horizontal: 24.px, vertical: 80.px),
          raw: {
            'scroll-snap-align': 'start',
            'scroll-snap-stop': 'always',
            'box-sizing': 'border-box',
          },
        ),
        
        css('.projects-header').styles(
          display: Display.flex,
          flexDirection: FlexDirection.column,
          gap: Gap.all(12.px),
          width: 100.percent,
          maxWidth: 1200.px,
          margin: Margin.only(bottom: 48.px),
          raw: {
            'margin-left': 'auto',
            'margin-right': 'auto',
          },
        ),
        
        css('.section-label').styles(
          fontFamily: const FontFamily.list([FontFamily('JetBrains Mono'), FontFamilies.monospace]),
          fontSize: 10.px,
          letterSpacing: 5.px,
          textTransform: TextTransform.upperCase,
          color: const Color('rgba(255,255,255,0.4)'),
          display: Display.block,
          margin: Margin.only(bottom: 12.px),
        ),
        
        css('.section-title').styles(
          fontFamily: const FontFamily.list([FontFamily('Montserrat'), FontFamilies.sansSerif]),
          fontWeight: FontWeight.w700,
          fontSize: 8.vw,
          letterSpacing: (-2).px,
          textTransform: TextTransform.upperCase,
          margin: Margin.zero,
          color: const Color('rgba(255,255,255,0.3)'),
        ),
        
        css('.section-title strong').styles(
          color: Colors.white,
          fontWeight: FontWeight.w900,
        ),
        
        css('.projects-grid').styles(
          display: Display.grid,
          gap: Gap.all(24.px),
          width: 100.percent,
          maxWidth: 1200.px,
          raw: {
            'grid-template-columns': '1fr',
            'margin-left': 'auto',
            'margin-right': 'auto',
          },
        ),
        
        css('.project-card-link').styles(
          textDecoration: const TextDecoration(line: TextDecorationLine.none),
          color: Color.inherit,
          flex: Flex(grow: 1, basis: Unit.zero),
          display: Display.flex,
        ),
        
        css('.project-card-preview').styles(
          display: Display.flex,
          flexDirection: FlexDirection.column,
          gap: Gap.all(16.px),
          padding: Padding.all(36.px),
          minHeight: 300.px,
          width: 100.percent,
          backgroundColor: const Color('rgba(14, 14, 14, 0.7)'),
          border: Border.all(color: const Color('rgba(255,255,255,0.08)'), width: 1.px, style: BorderStyle.solid),
          raw: {
            'position': 'relative',
            'overflow': 'hidden',
            'border-radius': '16px',
            'backdrop-filter': 'blur(16px)',
            '-webkit-backdrop-filter': 'blur(16px)',
            'box-shadow': '0 10px 30px rgba(0, 0, 0, 0.4), inset 0 1px 0 rgba(255, 255, 255, 0.12)',
            'transition': 'all 0.4s cubic-bezier(0.16, 1, 0.3, 1)',
          },
        ),
        
        // Gradient reflection line at top of cut glass
        css('.project-card-preview::before').styles(
          content: '""',
          position: Position.absolute(top: Unit.zero, left: Unit.zero, right: Unit.zero),
          height: 1.px,
          raw: {
            'background': 'linear-gradient(90deg, transparent 0%, rgba(255, 255, 255, 0.3) 50%, transparent 100%)',
            'pointer-events': 'none',
          },
        ),
        
        css('.project-card-link:hover .project-card-preview').styles(
          raw: {
            'transform': 'translateY(-6px)',
          },
        ),

        // Brand Glow: 01 Ursa (Cyan)
        css('.project-01 .project-card-preview').styles(
          raw: {
            'background': 'radial-gradient(circle at 20% 0%, rgba(0, 210, 255, 0.07) 0%, rgba(13, 15, 18, 0.75) 70%)',
            'border-color': 'rgba(0, 210, 255, 0.15)',
          },
        ),
        css('.project-01:hover .project-card-preview').styles(
          raw: {
            'background': 'radial-gradient(circle at 20% 0%, rgba(0, 210, 255, 0.14) 0%, rgba(15, 20, 25, 0.85) 70%)',
            'border-color': 'rgba(0, 210, 255, 0.45)',
            'box-shadow': '0 20px 45px -10px rgba(0, 210, 255, 0.18), 0 15px 30px rgba(0, 0, 0, 0.5), inset 0 1px 0 rgba(0, 210, 255, 0.3)',
          },
        ),
        css('.project-01 .project-icon').styles(
          raw: {
            'box-shadow': '0 0 25px rgba(0, 210, 255, 0.25)',
            'border': '1px solid rgba(0, 210, 255, 0.3)',
          },
        ),

        // Brand Glow: 02 TasteCraft AI (Teal)
        css('.project-02 .project-card-preview').styles(
          raw: {
            'background': 'radial-gradient(circle at 20% 0%, rgba(0, 200, 180, 0.07) 0%, rgba(12, 18, 18, 0.75) 70%)',
            'border-color': 'rgba(0, 200, 180, 0.15)',
          },
        ),
        css('.project-02:hover .project-card-preview').styles(
          raw: {
            'background': 'radial-gradient(circle at 20% 0%, rgba(0, 200, 180, 0.14) 0%, rgba(14, 22, 22, 0.85) 70%)',
            'border-color': 'rgba(0, 200, 180, 0.45)',
            'box-shadow': '0 20px 45px -10px rgba(0, 200, 180, 0.18), 0 15px 30px rgba(0, 0, 0, 0.5), inset 0 1px 0 rgba(0, 200, 180, 0.3)',
          },
        ),
        css('.project-02 .project-icon').styles(
          backgroundColor: const Color('transparent'),
          raw: {
            'box-shadow': 'none',
            'border': 'none',
            'border-radius': '0',
            'width': '72px',
            'height': '72px',
          },
        ),

        // Brand Glow: 03 AgriSphere (Emerald Green)
        css('.project-03 .project-card-preview').styles(
          raw: {
            'background': 'radial-gradient(circle at 20% 0%, rgba(0, 230, 118, 0.07) 0%, rgba(12, 17, 14, 0.75) 70%)',
            'border-color': 'rgba(0, 230, 118, 0.15)',
          },
        ),
        css('.project-03:hover .project-card-preview').styles(
          raw: {
            'background': 'radial-gradient(circle at 20% 0%, rgba(0, 230, 118, 0.14) 0%, rgba(14, 24, 18, 0.85) 70%)',
            'border-color': 'rgba(0, 230, 118, 0.45)',
            'box-shadow': '0 20px 45px -10px rgba(0, 230, 118, 0.18), 0 15px 30px rgba(0, 0, 0, 0.5), inset 0 1px 0 rgba(0, 230, 118, 0.3)',
          },
        ),
        css('.project-03 .project-icon').styles(
          backgroundColor: const Color('transparent'),
          raw: {
            'box-shadow': 'none',
            'border': 'none',
            'border-radius': '0',
            'width': '72px',
            'height': '72px',
          },
        ),
        
        css('.project-number').styles(
          fontFamily: const FontFamily.list([FontFamily('JetBrains Mono'), FontFamilies.monospace]),
          fontSize: 11.px,
          color: const Color('rgba(255,255,255,0.4)'),
          letterSpacing: 2.px,
          margin: Margin.only(bottom: 8.px),
        ),
        
        css('.project-icon').styles(
          width: 64.px,
          height: 64.px,
          display: Display.flex,
          alignItems: AlignItems.center,
          justifyContent: JustifyContent.center,
          backgroundColor: const Color('#1a1a1a'),
          margin: Margin.only(bottom: 20.px),
          raw: {
            'flex-shrink': '0',
            'border-radius': '50%',
            'overflow': 'hidden',
          },
        ),
        
        css('.project-icon img').styles(
          width: 100.percent,
          height: 100.percent,
          raw: {'object-fit': 'cover'},
        ),
        
        css('.project-number').styles(
          fontFamily: const FontFamily.list([FontFamily('Montserrat'), FontFamilies.sansSerif]),
          fontWeight: FontWeight.w900,
          fontSize: 32.px,
          color: Colors.white,
        ),
        
        css('.project-card-info').styles(
          flex: Flex(grow: 1),
          display: Display.flex,
          flexDirection: FlexDirection.column,
          gap: Gap.all(12.px),
        ),
        
        css('.project-card-name').styles(
          fontFamily: const FontFamily.list([FontFamily('Montserrat'), FontFamilies.sansSerif]),
          fontWeight: FontWeight.w700,
          fontSize: 24.px,
          letterSpacing: (-0.5).px,
          margin: Margin.only(bottom: 16.px),
          color: Colors.white,
        ),
        
        css('.project-card-desc').styles(
          fontSize: 14.px,
          fontWeight: FontWeight.w300,
          lineHeight: 1.6.em,
          color: const Color('rgba(255,255,255,0.6)'),
          margin: Margin.only(bottom: 20.px),
        ),
        
        css('.project-card-tech').styles(
          display: Display.flex,
          flexWrap: FlexWrap.wrap,
          gap: Gap.all(8.px),
        ),
        
        css('.tech-tag').styles(
          fontFamily: const FontFamily.list([FontFamily('JetBrains Mono'), FontFamilies.monospace]),
          fontSize: 10.px,
          padding: Padding.symmetric(horizontal: 10.px, vertical: 5.px),
          backgroundColor: const Color('rgba(255,255,255,0.05)'),
          border: Border.all(color: const Color('rgba(255,255,255,0.15)'), width: 1.px, style: BorderStyle.solid),
          color: const Color('rgba(255,255,255,0.7)'),
          raw: {'border-radius': '6px'},
        ),
        
        // Responsive
        css.media(MediaQuery.screen(minWidth: 768.px), [
          css('.projects-overview').styles(
            padding: Padding.only(left: 240.px, right: 120.px, top: 80.px, bottom: 80.px),
          ),
          
          css('.projects-grid').styles(
            raw: {'grid-template-columns': 'repeat(3, 1fr)'},
          ),
        ]),
      ];
}
