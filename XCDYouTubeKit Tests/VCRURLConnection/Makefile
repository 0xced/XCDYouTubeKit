CONFIGURATION ?= "Debug"
BUILD_DIR = $(shell pwd)/build

clean:
	$(XCMD) clean
	rm -rf $(BUILD_DIR)

_test:
	xctool -sdk $(SDK) \
               -project VCRURLConnection.xcodeproj \
	       -scheme $(SCHEME) \
               -configuration $(CONFIGURATION) \
	       CONFIGURATION_BUILD_DIR=$(BUILD_DIR) \
	       test

test_ios:
	$(MAKE) SDK=iphonesimulator SCHEME=Tests-iOS _test

test_osx:
	$(MAKE) SDK=macosx SCHEME=Tests-OSX _test

test:
	$(MAKE) test_ios test_osx


