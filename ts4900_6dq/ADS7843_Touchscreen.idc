# Copyright (C) 2012 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# Input Device Calibration File for the manta touch screen.
#

# Technically this device is internal, but
# we want the screen to turn on when pressed
# so we specify it is external so it wakes everything up
device.internal = 0

touch.deviceType = touchScreen
touch.orientationAware = 1
touch.size.calibration = geometric
touch.5pointcalib.xscale = −0.202514648
touch.5pointcalib.xymix = -−0.000411987
touch.5pointcalib.xoffset = 820.53302002
touch.5pointcalib.yxmix = −0.000198364
touch.5pointcalib.yscale = −0.157501221
touch.5pointcalib.yoffset = 620.973022461