#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Script to generate NSKeyedArchiver property list (plist) test files.

Requires MacOS and pyobjc.
"""

import datetime
import sys

from Foundation import NSKeyedArchiver


if __name__ == '__main__':
  test_dict = {
      'MyArray': [],
      'MyBool': True,
      'MyData': b'DATA\n',
      'MyDate': datetime.datetime(2024, 2, 12, 18, 40, 49),
      'MyDictionary': {},
      'MyFloat': 2.7,
      'MyInteger': 98,
      'MyString': 'Some string'}

  NSKeyedArchiver.archiveRootObject_toFile_(
      test_dict, 'NSKeyedArchiver.plist')

  sys.exit(0)
