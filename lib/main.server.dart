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
        'Firas Mostafa | Cross-Platform Mobile & Backend Software Engineer | Flutter & Django',
    meta: {
      'viewport': 'width=device-width, initial-scale=1.0',
      'title':
          'Firas Mostafa | Cross-Platform Mobile & Backend Software Engineer | Flutter & Django',
      'description':
          'Portfolio of Firas Mostafa, a Cross-Platform Mobile & Backend Software Engineer specializing in Flutter, Dart, Django, REST APIs, Python, Clean Architecture, and AI/RAG pipelines.',
      'keywords':
          'Firas Mostafa, Flutter Developer, Software Engineer Portfolio, Django Developer, Cross-Platform Mobile Developer, Backend Software Engineer, Dart, Python, REST APIs, AI/RAG Pipelines, Clean Architecture',
      'author': 'Firas Mostafa',
      'robots': 'index, follow',
      'google-site-verification':
          'asaUKWYFhREUpDVzOJJ64IIwFdBzpTL6zVDQRfNoFZU',
    },
    head: [
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
              'Firas Mostafa | Cross-Platform Mobile & Backend Software Engineer',
        },
      ),
      meta(
        attributes: {
          'property': 'og:description',
          'content':
              'Explore software engineering projects in Flutter, Dart, Django, REST APIs, AI/RAG pipelines, and Clean Architecture by Firas Mostafa.',
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
              'Firas Mostafa - Cross-Platform Mobile & Backend Software Engineer',
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
              'Firas Mostafa | Cross-Platform Mobile & Backend Software Engineer',
        },
      ),
      meta(
        attributes: {
          'name': 'twitter:description',
          'content':
              'Cross-Platform Mobile & Backend Software Engineer specializing in Flutter, Dart, Django, REST APIs, Python, and AI/RAG Pipelines.',
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
              'Firas Mostafa - Cross-Platform Mobile & Backend Software Engineer',
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
            'https://fonts.googleapis.com/css2?family=Inter:wght@100;300;400;500;700&family=JetBrains+Mono:wght@100;500;900&family=Montserrat:wght@100;600;700;900&display=swap',
      ),
      link(
        rel: 'stylesheet',
        href:
            'https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&display=swap',
      ),

      // Structured Data (JSON-LD)
      script(
        type: 'application/ld+json',
        [
          Component.text(
            '''
{
  "@context": "https://schema.org",
  "@type": "Person",
  "name": "Firas Mostafa",
  "url": "https://firas-mostafa.github.io/portfolio/",
  "image": "https://firas-mostafa.github.io/portfolio/images/ursa_logo.png",
  "jobTitle": "Cross-Platform Mobile & Backend Software Engineer",
  "description": "Cross-Platform Mobile & Backend Software Engineer specializing in Flutter, Dart, Django, REST APIs, Python, Clean Architecture, and AI/RAG pipelines.",
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
      ),
    ],
    body: App(),
  ));
}
