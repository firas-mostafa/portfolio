/// The entrypoint for the **server** environment.
library;

import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';

import 'app.dart';
import 'main.server.options.dart';

void main() {
  Jaspr.initializeApp(
    options: defaultServerOptions,
  );

  runApp(Document(
    title:
        'Firas Mostafa | Full-Stack & AI Engineer | Flutter, Django & LLMs',
    meta: {
      'viewport': 'width=device-width, initial-scale=1.0',
      'title':
          'Firas Mostafa | Full-Stack & AI Engineer | Flutter, Django & LLMs',
      'description':
          'Portfolio of Firas Mostafa, a Full-Stack & AI Engineer who builds Flutter apps, Django REST APIs, and the machine-learning and LLM/RAG systems that power them.',
      'keywords':
          'Firas Mostafa, Full-Stack Engineer, AI Engineer, Flutter Developer, Django Developer, Machine Learning, LLM, RAG Pipelines, Dart, Python, REST APIs, Clean Architecture',
      'author': 'Firas Mostafa',
      'robots': 'index, follow',
      'google-site-verification':
          'asaUKWYFhREUpDVzOJJ64IIwFdBzpTL6zVDQRfNoFZU',
    },
    head: [
      // Ambient glow layer: a registered custom property lets the glow color
      // transition smoothly as the active project section changes (set from JS).
      Component.element(tag: 'style', children: [
        RawText('''
@property --glow {
  syntax: '<color>';
  inherits: true;
  initial-value: rgba(255, 255, 255, 0.04);
}
:root { --glow: rgba(255, 255, 255, 0.04); transition: --glow 1s ease; }
.ambient-glow {
  position: fixed;
  inset: 0;
  z-index: 0;
  pointer-events: none;
  background: radial-gradient(55% 50% at 50% 32%, var(--glow) 0%, transparent 70%);
}
@media (prefers-reduced-motion: reduce) { :root { transition: none; } }
'''),
      ]),

      link(rel: 'canonical', href: 'https://firas-mostafa.github.io/portfolio/'),

      // Open Graph Tags
      meta(attributes: {'property': 'og:type', 'content': 'website'}),
      meta(
        attributes: {
          'property': 'og:url',
          'content': 'https://firas-mostafa.github.io/portfolio/',
        },
      ),
      meta(
        attributes: {
          'property': 'og:site_name',
          'content': 'Firas Mostafa — Software Engineer Portfolio',
        },
      ),
      meta(
        attributes: {
          'property': 'og:title',
          'content':
              'Firas Mostafa | Full-Stack & AI Engineer',
        },
      ),
      meta(
        attributes: {
          'property': 'og:description',
          'content':
              'Explore Flutter apps, Django REST APIs, and the machine-learning and LLM/RAG systems behind them, built by Firas Mostafa.',
        },
      ),
      meta(
        attributes: {
          'property': 'og:image',
          'content':
              'https://firas-mostafa.github.io/portfolio/images/ursa_logo.png',
        },
      ),
      meta(
        attributes: {
          'property': 'og:image:alt',
          'content':
              'Firas Mostafa - Full-Stack & AI Engineer',
        },
      ),
      meta(attributes: {'property': 'og:locale', 'content': 'en_US'}),

      // Twitter Card Tags
      meta(attributes: {'name': 'twitter:card', 'content': 'summary_large_image'}),
      meta(
        attributes: {
          'name': 'twitter:url',
          'content': 'https://firas-mostafa.github.io/portfolio/',
        },
      ),
      meta(
        attributes: {
          'name': 'twitter:title',
          'content':
              'Firas Mostafa | Full-Stack & AI Engineer',
        },
      ),
      meta(
        attributes: {
          'name': 'twitter:description',
          'content':
              'Full-Stack & AI Engineer building Flutter apps, Django REST APIs, and the ML/LLM systems that power them.',
        },
      ),
      meta(
        attributes: {
          'name': 'twitter:image',
          'content':
              'https://firas-mostafa.github.io/portfolio/images/ursa_logo.png',
        },
      ),
      meta(
        attributes: {
          'name': 'twitter:image:alt',
          'content':
              'Firas Mostafa - Full-Stack & AI Engineer',
        },
      ),

      // Web Fonts & Icons
      link(rel: 'preconnect', href: 'https://fonts.googleapis.com'),
      link(
        rel: 'preconnect',
        href: 'https://fonts.gstatic.com',
        attributes: {'crossorigin': ''},
      ),
      link(
        rel: 'stylesheet',
        href:
            'https://fonts.googleapis.com/css2?family=Inter:wght@300;400&family=JetBrains+Mono:wght@400&family=Montserrat:wght@700;800;900&display=swap',
      ),

      // Structured Data (JSON-LD)
      script(
        attributes: {'type': 'application/ld+json'},
        content: '''
{
  "@context": "https://schema.org",
  "@type": "Person",
  "name": "Firas Mostafa",
  "url": "https://firas-mostafa.github.io/portfolio/",
  "image": "https://firas-mostafa.github.io/portfolio/images/ursa_logo.png",
  "jobTitle": "Full-Stack & AI Engineer",
  "description": "Full-Stack & AI Engineer who builds Flutter apps, Django REST APIs, and the machine-learning and LLM/RAG systems that power them.",
  "sameAs": [
    "https://github.com/firas-mostafa",
    "https://linkedin.com/in/firasmostafa"
  ],
  "knowsAbout": [
    "Flutter",
    "Dart",
    "Django",
    "REST APIs",
    "Python",
    "AI/RAG Pipelines",
    "Clean Architecture",
    "Machine Learning",
    "PostgreSQL",
    "Docker"
  ]
}
''',
      ),
    ],
    body: App(),
  ));
}
