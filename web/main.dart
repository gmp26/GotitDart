// Copyright (c) 2014, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:async';

import 'package:gotit/nav_menu.dart';
import 'package:gotit/reverser.dart';
import 'package:route_hierarchical/client.dart';

import 'package:polymer/polymer.dart';

void main() {
  initNavMenu();

  // Webapps need routing to listen for changes to the URL.
  var router = new Router();
  router.root
    ..addRoute(name: 'home', path: '/', enter: loadHome)
    ..addRoute(name: 'show', path: '/show/:viewName', enter: loadView);
  router.listen();
}

void loadHome(RouteEvent e) {
  loadViewNamed("home");
}

void loadView(RouteEvent e) {
  loadViewNamed(e.parameters['viewName']);
}

void loadViewNamed(String viewName) {
  Element view = querySelector("#view");
  HttpRequest.getString("/views/$viewName.html")
    ..then((resp) {
      List<Element> cs = view.children;
      while (cs.isNotEmpty) cs.removeLast();
      cs.add(new Element.html(resp));
    });
}

