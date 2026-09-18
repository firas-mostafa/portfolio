import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import '../constants/content.dart';

// Each project becomes its own full-screen section for proper scroll-snap.
class ProjectSection extends StatelessComponent {
  final Project project;
  const ProjectSection({required this.project, super.key});

  @override
  Component build(BuildContext context) {
    final hasGallery = project.gallery.isNotEmpty;

    return section(id: 'project-${project.index}', classes: 'project-section', [
      div(classes: 'project-card', [
        div(classes: 'project-row', [
          // Text column
          div(classes: 'project-info', [
            span(classes: 'project-index', [Component.text(project.index)]),
            h3(classes: 'project-name', [Component.text(project.name)]),
            p(classes: 'project-desc', [Component.text(project.desc)]),
            div(classes: 'project-tech', [
              for (final t in project.tech) span(classes: 'tech-chip', [Component.text(t)]),
            ]),
            if (project.link != null)
              a(href: project.link!, target: Target.blank, classes: 'project-link', [
                Component.text('View on GitHub →'),
              ]),
          ]),
          
          // Media column (phone frame with Carousel or Video)
          div(classes: 'project-media', [
            div(classes: 'phone-frame', [
              if (project.isVideo)
                video(
                  classes: 'phone-media video-fit',
                  src: project.media,
                  autoplay: true,
                  loop: true,
                  muted: true,
                  attributes: {'playsinline': '', 'controls': 'false'},
                  [],
                )
              else if (hasGallery)
                _buildGalleryCarousel(project)
              else if (project.media.isNotEmpty)
                img(classes: 'phone-media image-fit', src: project.media, alt: '${project.name} preview')
              else
                div(classes: 'phone-placeholder', [Component.text(project.name)])
            ]),
          ]),
        ]),
      ]),
    ]);
  }

  Component _buildGalleryCarousel(Project proj) {
    final carouselId = 'carousel-${proj.index}';
    return div(
      id: carouselId,
      classes: 'carousel-container',
      attributes: {'data-count': '${proj.gallery.length}', 'data-index': '0'},
      [
        // Slides
        div(classes: 'carousel-slides', [
          for (var i = 0; i < proj.gallery.length; i++)
            img(
              classes: 'carousel-slide ${i == 0 ? 'active' : ''}',
              src: proj.gallery[i],
              alt: '${proj.name} slide ${i + 1}',
            )
        ]),
        
        // Navigation arrows
        if (proj.gallery.length > 1) ...[
          button(
            classes: 'carousel-btn carousel-prev',
            attributes: {'aria-label': 'Previous slide'},
            [Component.text('‹')],
          ),
          button(
            classes: 'carousel-btn carousel-next',
            attributes: {'aria-label': 'Next slide'},
            [Component.text('›')],
          ),
        ],
        
        // Indicators (dots)
        div(classes: 'carousel-indicators', [
          for (var i = 0; i < proj.gallery.length; i++)
            span(
              classes: 'dot ${i == 0 ? 'active' : ''}',
              attributes: {'data-index': '$i'},
              [],
            ),
        ]),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
        // Section container - full screen
        css('.project-section').styles(
          minHeight: 100.vh,
          display: Display.flex,
          flexDirection: FlexDirection.column,
          justifyContent: JustifyContent.center,
          padding: Padding.symmetric(horizontal: 24.px, vertical: 60.px),
          raw: {
            'scroll-snap-align': 'start',
            'scroll-snap-stop': 'always',
            'box-sizing': 'border-box',
          },
        ),
        
        css('.project-card').styles(
          width: 100.percent,
          maxWidth: 1100.px,
          raw: {'margin-left': 'auto', 'margin-right': 'auto'},
        ),
        
        css('.project-row').styles(
          display: Display.flex,
          flexDirection: FlexDirection.column,
          gap: Gap.all(40.px),
          alignItems: AlignItems.center,
          width: 100.percent,
        ),
        
        css('.project-index').styles(
          fontFamily: const FontFamily.list([FontFamily('JetBrains Mono'), FontFamilies.monospace]),
          fontSize: 14.px,
          color: const Color('rgba(255,255,255,0.4)'),
          display: Display.block,
          margin: Margin.only(bottom: 12.px),
        ),
        
        css('.project-name').styles(
          fontFamily: const FontFamily.list([FontFamily('Montserrat'), FontFamilies.sansSerif]),
          fontWeight: FontWeight.w800,
          fontSize: 36.px,
          letterSpacing: (-1).px,
          margin: Margin.zero,
          color: Colors.white,
        ),
        
        css('.project-desc').styles(
          fontSize: 15.px,
          fontWeight: FontWeight.w300,
          lineHeight: 1.6.em,
          color: const Color('rgba(255,255,255,0.6)'),
          margin: Margin.only(top: 16.px, bottom: 20.px),
          maxWidth: 520.px,
        ),
        
        css('.project-tech').styles(
          display: Display.flex,
          flexWrap: FlexWrap.wrap,
          gap: Gap.all(8.px),
        ),
        
        css('.tech-chip').styles(
          fontFamily: const FontFamily.list([FontFamily('JetBrains Mono'), FontFamilies.monospace]),
          fontSize: 11.px,
          padding: Padding.symmetric(horizontal: 12.px, vertical: 6.px),
          border: Border.all(color: const Color('rgba(255,255,255,0.2)'), width: 1.px, style: BorderStyle.solid),
          color: const Color('rgba(255,255,255,0.85)'),
          raw: {'border-radius': '999px', 'background': 'rgba(255,255,255,0.03)'},
        ),
        
        css('.project-link').styles(
          display: Display.inlineBlock,
          margin: Margin.only(top: 24.px),
          fontFamily: const FontFamily.list([FontFamily('JetBrains Mono'), FontFamilies.monospace]),
          fontSize: 13.px,
          color: Colors.white,
          textDecoration: const TextDecoration(line: TextDecorationLine.underline),
          raw: {'transition': 'opacity 0.3s'},
        ),
        
        css('.project-link:hover').styles(
          raw: {'opacity': '0.7'},
        ),
        
        // Phone frame - fixed aspect ratio 9:16
        css('.phone-frame').styles(
          width: 373.px,
          height: 786.px,
          padding: Padding.all(12.px),
          border: Border.all(color: const Color('rgba(255,255,255,0.25)'), width: 2.px, style: BorderStyle.solid),
          backgroundColor: const Color('#080808'),
          raw: {
            'border-radius': '44px',
            'transition': 'all .4s ease',
            'box-shadow': '0 20px 50px rgba(0,0,0,0.6)',
            'position': 'relative',
            'overflow': 'hidden',
          },
        ),
        
        css('.phone-frame:hover').styles(
          border: Border.all(color: Colors.white, width: 2.px, style: BorderStyle.solid),
          raw: {'transform': 'scale(1.02)'},
        ),
        
        css('.phone-media').styles(
          width: 100.percent,
          height: 100.percent,
          raw: {'border-radius': '32px', 'background': '#000'},
        ),
        
        css('.video-fit').styles(
          raw: {'object-fit': 'contain'},
        ),
        
        css('.image-fit').styles(
          raw: {'object-fit': 'contain'},
        ),
        
        // Carousel styling
        css('.carousel-container').styles(
          width: 100.percent,
          height: 100.percent,
          position: Position.relative(),
          raw: {'border-radius': '32px', 'overflow': 'hidden', 'background': '#000'},
        ),
        
        css('.carousel-slides').styles(
          width: 100.percent,
          height: 100.percent,
          position: Position.relative(),
        ),
        
        css('.carousel-slide').styles(
          width: 100.percent,
          height: 100.percent,
          position: Position.absolute(top: Unit.zero, left: Unit.zero),
          opacity: 0,
          raw: {
            'object-fit': 'contain',
            'transition': 'opacity 0.8s ease-in-out',
            'pointer-events': 'none',
          },
        ),
        
        css('.carousel-slide.active').styles(
          opacity: 1,
          raw: {'pointer-events': 'auto'},
        ),
        
        // Navigation arrows
        css('.carousel-btn').styles(
          width: 40.px,
          height: 40.px,
          backgroundColor: const Color('rgba(0,0,0,0.5)'),
          color: Colors.white,
          fontSize: 24.px,
          cursor: Cursor.pointer,
          raw: {
            'position': 'absolute',
            'top': '50%',
            'z-index': '10',
            'border': 'none',
            'transform': 'translateY(-50%)',
            'border-radius': '50%',
            'transition': 'all 0.3s ease',
            'backdrop-filter': 'blur(4px)',
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
          },
        ),
        
        css('.carousel-prev').styles(
          raw: {'left': '8px'},
        ),
        
        css('.carousel-next').styles(
          raw: {'right': '8px'},
        ),
        
        css('.carousel-btn:hover').styles(
          backgroundColor: const Color('rgba(255,255,255,0.9)'),
          color: const Color('#000'),
        ),
        
        // Indicators (dots) - default inside frame
        css('.carousel-indicators').styles(
          position: Position.absolute(bottom: 12.px, left: Unit.zero, right: Unit.zero),
          display: Display.flex,
          justifyContent: JustifyContent.center,
          gap: Gap.all(6.px),
          zIndex: ZIndex(5),
        ),
        
        // Move indicators outside frame for projects 02 & 03
        css('.project-section:nth-child(5) .carousel-indicators, .project-section:nth-child(6) .carousel-indicators').styles(
          raw: {
            'position': 'static',
            'margin-top': '16px',
          },
        ),
        
        css('.carousel-indicators .dot').styles(
          width: 6.px,
          height: 6.px,
          backgroundColor: const Color('rgba(255,255,255,0.3)'),
          cursor: Cursor.pointer,
          raw: {'border-radius': '50%', 'transition': 'all 0.3s ease'},
        ),
        
        css('.carousel-indicators .dot:hover').styles(
          backgroundColor: const Color('rgba(255,255,255,0.6)'),
        ),
        
        css('.carousel-indicators .dot.active').styles(
          width: 18.px,
          backgroundColor: Colors.white,
          raw: {'border-radius': '10px'},
        ),
        
        // Phone Placeholder
        css('.phone-placeholder').styles(
          width: 100.percent,
          height: 100.percent,
          display: Display.flex,
          alignItems: AlignItems.center,
          justifyContent: JustifyContent.center,
          backgroundColor: const Color('#1a1a1a'),
          color: const Color('rgba(255,255,255,0.4)'),
          fontFamily: const FontFamily.list([FontFamily('Montserrat'), FontFamilies.sansSerif]),
          fontWeight: FontWeight.w700,
          raw: {'border-radius': '32px'},
        ),
        
        // Responsive Desktop layout
        css.media(MediaQuery.screen(minWidth: 768.px), [
          css('.project-section').styles(
            padding: Padding.only(left: 240.px, right: 120.px, top: 80.px, bottom: 80.px),
          ),
          
          css('.project-row').styles(
            flexDirection: FlexDirection.row,
            gap: Gap.all(80.px),
            justifyContent: JustifyContent.spaceBetween,
          ),
          
          css('.project-info').styles(
            flex: Flex(grow: 1),
          ),
          
          css('.project-name').styles(
            fontSize: 48.px,
          ),
          
          css('.phone-frame').styles(
            width: 390.px,
            height: 822.px,
          ),
          
          // Make project 02 (TasteCraft) reverse layout
          css('.project-section:nth-child(5) .project-row').styles(
            raw: {'flex-direction': 'row-reverse'},
          ),
        ]),

        // ── Brand ambient glow per project page ──────────────────────────
        // Project 01 – Ursa (Cyan)
        css('#project-01').styles(
          raw: {
            'background': 'radial-gradient(ellipse 80% 60% at 15% 0%, rgba(0, 210, 255, 0.07) 0%, transparent 65%)',
          },
        ),
        css('#project-01 .project-index').styles(
          color: const Color('rgba(0, 210, 255, 0.7)'),
        ),
        css('#project-01 .project-name').styles(
          raw: {
            'background': 'linear-gradient(135deg, #ffffff 60%, rgba(0, 210, 255, 0.7) 100%)',
            '-webkit-background-clip': 'text',
            '-webkit-text-fill-color': 'transparent',
            'background-clip': 'text',
          },
        ),
        css('#project-01 .phone-frame').styles(
          raw: {
            'border-color': 'rgba(0, 210, 255, 0.3)',
            'box-shadow': '0 20px 60px rgba(0, 0, 0, 0.6), 0 0 60px rgba(0, 210, 255, 0.1)',
          },
        ),
        css('#project-01 .phone-frame:hover').styles(
          raw: {
            'border-color': 'rgba(0, 210, 255, 0.6)',
            'box-shadow': '0 25px 80px rgba(0, 0, 0, 0.7), 0 0 80px rgba(0, 210, 255, 0.18)',
          },
        ),

        // Project 02 – TasteCraft AI (Teal)
        css('#project-02').styles(
          raw: {
            'background': 'radial-gradient(ellipse 80% 60% at 85% 0%, rgba(0, 200, 180, 0.07) 0%, transparent 65%)',
          },
        ),
        css('#project-02 .project-index').styles(
          color: const Color('rgba(0, 200, 180, 0.7)'),
        ),
        css('#project-02 .project-name').styles(
          raw: {
            'background': 'linear-gradient(135deg, #ffffff 60%, rgba(0, 200, 180, 0.7) 100%)',
            '-webkit-background-clip': 'text',
            '-webkit-text-fill-color': 'transparent',
            'background-clip': 'text',
          },
        ),
        css('#project-02 .phone-frame').styles(
          raw: {
            'border-color': 'rgba(0, 200, 180, 0.3)',
            'box-shadow': '0 20px 60px rgba(0, 0, 0, 0.6), 0 0 60px rgba(0, 200, 180, 0.1)',
          },
        ),
        css('#project-02 .phone-frame:hover').styles(
          raw: {
            'border-color': 'rgba(0, 200, 180, 0.6)',
            'box-shadow': '0 25px 80px rgba(0, 0, 0, 0.7), 0 0 80px rgba(0, 200, 180, 0.18)',
          },
        ),

        // Project 03 – AgriSphere (Emerald)
        css('#project-03').styles(
          raw: {
            'background': 'radial-gradient(ellipse 80% 60% at 15% 0%, rgba(0, 230, 118, 0.07) 0%, transparent 65%)',
          },
        ),
        css('#project-03 .project-index').styles(
          color: const Color('rgba(0, 230, 118, 0.7)'),
        ),
        css('#project-03 .project-name').styles(
          raw: {
            'background': 'linear-gradient(135deg, #ffffff 60%, rgba(0, 230, 118, 0.7) 100%)',
            '-webkit-background-clip': 'text',
            '-webkit-text-fill-color': 'transparent',
            'background-clip': 'text',
          },
        ),
        css('#project-03 .phone-frame').styles(
          raw: {
            'border-color': 'rgba(0, 230, 118, 0.3)',
            'box-shadow': '0 20px 60px rgba(0, 0, 0, 0.6), 0 0 60px rgba(0, 230, 118, 0.1)',
          },
        ),
        css('#project-03 .phone-frame:hover').styles(
          raw: {
            'border-color': 'rgba(0, 230, 118, 0.6)',
            'box-shadow': '0 25px 80px rgba(0, 0, 0, 0.7), 0 0 80px rgba(0, 230, 118, 0.18)',
          },
        ),
      ];
}
