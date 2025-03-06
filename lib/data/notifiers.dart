import 'package:flutter/material.dart';

ValueNotifier<int> selectedPageNotifier = ValueNotifier(0);
ValueNotifier<bool> isDarkModeNotifier = ValueNotifier(true);

// valuenotifier hold data
// valueListenableBuilder listen to the data (don't need to call setState)