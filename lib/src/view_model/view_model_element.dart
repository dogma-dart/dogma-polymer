// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [ViewModelElement] mixin.
library dogma_polymer.src.view_model.view_model_element;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:async';
import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_polymer/model.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Mixin for creating a Polymer element that displays a [Model].
///
/// The [ViewModelElement] listens for events from a child [ModelElement] and
/// then updates the view being displayed.
///
/// A custom element using the [ViewModelElement] behavior will need to
/// override the [onModelChanged] method. When a
/// [ModelElement.modelChangedEvent] is received the method is called with the
/// model contained in the element.
abstract class ViewModelElement<Model> {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// Stream subscription for model change events.
  StreamSubscription<html.CustomEvent> _modelChangeSubscription;

  //---------------------------------------------------------------------
  // Element
  //---------------------------------------------------------------------

  html.ElementEvents get on;

  //---------------------------------------------------------------------
  // PolymerElement
  //---------------------------------------------------------------------

  void attached() {
    // Subscription should always be null at this point
    assert(_modelChangeSubscription == null);

    var eventStream =
       on[ModelElement.modelChangedEvent] as Stream<html.CustomEvent>;

    eventStream.listen(_onModelChanged);
  }

  void detached() {
    // Subscription should never be null at this point
    assert(_modelChangeSubscription != null);

    _modelChangeSubscription.cancel();
    _modelChangeSubscription = null;
  }

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  void onModelChanged(Model model);

  //---------------------------------------------------------------------
  // Private methods
  //---------------------------------------------------------------------

  void _onModelChanged(html.CustomEvent event) {
    var modelElement = event.target as ModelElement<Model>;

    onModelChanged(modelElement.model);
  }
}
