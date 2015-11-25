BUILD_DIR = $(shell pwd)/build

test:
	xcodebuild -sdk iphonesimulator \
	           -project VCRURLConnection.xcodeproj \
	    	   -scheme VCRURLConnection \
	           CONFIGURATION_BUILD_DIR=$(BUILD_DIR) \
	           build test

