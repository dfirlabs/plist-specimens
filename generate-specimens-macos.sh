#!/bin/bash
#
# Script to generate property list (plist) test files
# Requires MacOS and plutil

EXIT_SUCCESS=0;
EXIT_FAILURE=1;

# Checks the availability of a binary and exits if not available.
#
# Arguments:
#   a string containing the name of the binary
#
assert_availability_binary()
{
	local BINARY=$1;

	which ${BINARY} > /dev/null 2>&1;
	if test $? -ne ${EXIT_SUCCESS};
	then
		echo "Missing binary: ${BINARY}";
		echo "";

		exit ${EXIT_FAILURE};
	fi
}

assert_availability_binary plutil;

MACOS_VERSION=`sw_vers -productVersion`;
SHORT_VERSION=`echo "${MACOS_VERSION}" | sed 's/^\([0-9][0-9]*[.][0-9][0-9]*\).*$/\1/'`;

SPECIMENS_PATH="specimens/${MACOS_VERSION}";

if test -d ${SPECIMENS_PATH};
then
	echo "Specimens directory: ${SPECIMENS_PATH} already exists.";

	exit ${EXIT_FAILURE};
fi

mkdir -p ${SPECIMENS_PATH};

set -e;

plutil -create xml1 ${SPECIMENS_PATH}/xml1.plist
plutil -insert MyArray -array ${SPECIMENS_PATH}/xml1.plist
plutil -insert MyBool -bool "YES" ${SPECIMENS_PATH}/xml1.plist
plutil -insert MyData -data "REFUQQo=" ${SPECIMENS_PATH}/xml1.plist
plutil -insert MyDate -date "2024-02-12T18:40:49Z" ${SPECIMENS_PATH}/xml1.plist
plutil -insert MyDictionary -dictionary ${SPECIMENS_PATH}/xml1.plist
plutil -insert MyFloat -float 2.7 ${SPECIMENS_PATH}/xml1.plist
plutil -insert MyInteger -integer 98 ${SPECIMENS_PATH}/xml1.plist
plutil -insert MyString -string "Some string" ${SPECIMENS_PATH}/xml1.plist

plutil -convert binary1 -o ${SPECIMENS_PATH}/binary1.plist ${SPECIMENS_PATH}/xml1.plist

# Note that JSON format does not support date type.
# plutil -convert json -o ${SPECIMENS_PATH}/json.plist ${SPECIMENS_PATH}/xml1.plist

exit ${EXIT_SUCCESS};

