#!/bin/bash

# This script is used to run the headless tests on an Android emulator create on the fly.
# Usage: ./headless_test.sh -t <test_command> -a <apk_path>
# Example:
#  sh headless_test.sh -t "maestro test test_maestro/counter_test.yaml" -a build/app/outputs/flutter-apk/app-release.apk

# 0. Parse arguments.

while getopts t:a: flag
do
    case "${flag}" in
        t) test_command=${OPTARG};;
        a) apk_path=${OPTARG};;
    esac
done

if [ -z "$test_command" ]
then
    echo "No test command provided. Please provide a test command using the -t flag."
    exit 1
fi

if [ -z "$apk_path" ]
then
    echo "No apk path provided. Please provide an apk path using the -a flag."
    exit 1
fi

# 1. Be sure to use Java 8 in order to use avdmanager.

#sudo apt-get install openjdk-8-jdk
#sudo update-alternatives --config java
#export PATH=${ls -td /usr/lib/jvm/java-8-openjdk-* | head -1}/bin:${PATH}

# 2. Create an Android Virtual Device (AVD) using avdmanager.

echo ""
echo "********************"
echo "*** Setup JAVA 8 ***"
echo "********************"
echo ""

# only for macos
#export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

echo ""
echo "*****************************"
echo "*** Headless test started ***"
echo "*****************************"
echo ""

echo ""
echo "********************************"
echo "*** Setting Android SDK path ***"
echo "********************************"
echo ""

# only for macos
#export ANDROID_SDK_ROOT=~/Library/Android/Sdk
# only for linux
#export ANDROID_SDK_ROOT=~/Android/Sdk
export ANDROID_EMULATOR_ROOT=${ANDROID_SDK_ROOT}/emulator
export ANDROID_TOOLS_ROOT=${ANDROID_SDK_ROOT}/tools/bin
export ANDROID_PLATFORM_TOOLS_ROOT=${ANDROID_SDK_ROOT}/platform-tools
export PATH=${ANDROID_SDK_ROOT}/emulator:${ANDROID_SDK_ROOT}/tools/bin:${ANDROID_SDK_ROOT}/platform-tools:${PATH}

echo ""
echo "********************"
echo "*** Creating AVD ***"
echo "********************"
echo ""

export ARCHITECTURE=x86_64
#export ARCHITECTURE=arm64-v8a

sdkmanager --install "system-images;android-30;google_apis;${ARCHITECTURE}"
avdmanager create avd --name headless-device --package "system-images;android-30;google_apis;${ARCHITECTURE}" --device "pixel" --tag "google_apis" --abi "${ARCHITECTURE}"

# 3. Start the AVD using emulator with the -no-window option.

echo ""
echo "********************"
echo "*** Starting AVD ***"
echo "********************"
echo ""

# -no-window option will run the emulator without UI
# -delay-adb option will wait for the boot fully complete when running adb wait-for-device
emulator -avd headless-device -no-window -delay-adb -dns-server 8.8.8.8 &
#emulator -avd headless-device -delay-adb -dns-server 8.8.8.8 &

# wait for emulator to start

echo ""
echo "*************************************"
echo "*** Waiting for emulator to start ***"
echo "*************************************"
echo ""

adb wait-for-device

# 4. Install the apk using adb.

echo ""
echo "**********************"
echo "*** Installing APK ***"
echo "**********************"
echo ""

adb install $apk_path

adb logcat -d com.xpeho.yaki > logcat.txt &

# 5. Run the tests using maestro.

echo ""
echo "*********************"
echo "*** Running tests ***"
echo "*********************"
echo ""

# execute test command string
eval $test_command

# 6. Stop the AVD using adb.

echo ""
echo "********************"
echo "*** Stopping AVD ***"
echo "********************"
echo ""

adb emu kill &

# 7. Delete the AVD using avdmanager.

echo ""
echo "********************"
echo "*** Deleting AVD ***"
echo "********************"
echo ""

avdmanager delete avd --name headless-device

echo ""
echo "**************************"
echo "*** Headless test done ***"
echo "**************************"
echo ""

exit 0