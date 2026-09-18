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
    title: 'Firas Mostafa — Full-Stack & AI Engineer',
    meta: {
      'description':
          'Firas Mostafa — Full-Stack & AI Engineer. Flutter, Django, Python, LangChain. '
              'Building intelligent applications end-to-end.',
      'viewport': 'width=device-width, initial-scale=1.0',
    },
    head: [
      link(rel: 'preconnect', href: 'https://fonts.googleapis.com'),
      link(rel: 'preconnect', href: 'https://fonts.gstatic.com', attributes: {'crossorigin': ''}),
      link(
        rel: 'stylesheet',
        href:
            'https://fonts.googleapis.com/css2?family=Inter:wght@100;300;400;500;700&family=JetBrains+Mono:wght@100;500;900&family=Montserrat:wght@100;600;700;900&display=swap',
      ),
    ],
    body: App(),
  ));
}
