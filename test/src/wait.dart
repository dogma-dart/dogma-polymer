// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library dogma_polymer.test.src.wait;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:async';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Waits for the specified number of [milliseconds] before returning.
///
/// Used to wait with tests that interact with Polymer and the DOM.
Future wait([int milliseconds = 50]) {
  return new Future.delayed(new Duration(milliseconds: milliseconds));
}
