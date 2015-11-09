// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library dogma_polymer.test.src.test_model_element;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';
import 'package:dogma_polymer/src/model/model_element.dart';

import 'test_model.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Tag name for the class.
const String _tagName = 'dp-test-model';

@PolymerRegister(_tagName)
class TestModelElement extends PolymerElement with ModelElement<TestModel> {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The name of the tag.
  static const String customTagName = _tagName;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [TestModelElement] class.
  factory TestModelElement()
      => new html.Element.tag(customTagName) as TestModelElement;

  /// Creates an instance of the [TestModelElement] class.
  ///
  /// This constructor should not be called directly. Instead use the default
  /// constructor.
  TestModelElement.created()
      : super.created();
}
