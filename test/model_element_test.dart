// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

@TestOn('browser')
library dogma_polymer.model_element_test;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:async';
import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';
import 'package:test/test.dart';

import 'package:dogma_polymer/model_element.dart';

import 'src/test_model.dart';
import 'src/test_model_element.dart';
import 'src/wait.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

Future<Null> main() async {
  await initPolymer();

  print('Done waiting on polymer');

  var events;
  var subscription;

  setUp(() {
    print('SET UP');
    events = <html.CustomEvent>[];
    subscription = html.window.on[ModelElement.modelChangedEvent].listen(
        (event) { events.add(event); }
    );
  });

  tearDown(() {
    print('TEAR DOWN');
    subscription.cancel();
  });

  test('Attached event', () async {
    var element = new TestModelElement();
    element.model = new TestModel();

    // Add the element
    html.document.body.children.add(element);

    // Add a delay to ensure the element has been added
    await wait();

    // Expect a single event
    expect(events.length, 1);
    expect(events[0].target, element);

    // Remove the element
    html.document.body.children.remove(element);
  });

  test('Model changed event', () async {
    var element = new TestModelElement();

    // Add the element
    html.document.body.children.add(element);

    // Add a delay to ensure the element has been added
    await wait();

    // No events should have been fired
    expect(events.length, 0);

    // Fire some events
    var model = new TestModel();
    element.model = model;

    for (var i = 0; i < 10; ++i) {
      element.model = model;
    }

    // Add a delay to ensure the event has been propagated
    await wait();

    expect(events.length, 1);
    expect(events[0].target, element);

    // Remove the element
    html.document.body.children.remove(element);
  });
}
