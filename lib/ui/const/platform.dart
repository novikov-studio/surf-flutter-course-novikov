import 'dart:io';

import 'package:flutter/cupertino.dart';

final platformScrollPhysics = Platform.isIOS
    ? const BouncingScrollPhysics()
    : const ClampingScrollPhysics();
