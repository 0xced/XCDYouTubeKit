//
//  Copyright (c) 2013-2015 Cédric Luthi. All rights reserved.
//

// Explanation on http://stackoverflow.com/questions/30938525/xctest-exception-when-using-keyvalueobservingexpectationforobjectkeypathhandle

#import <objc/runtime.h>

__attribute__((constructor)) void WorkaroundXCKVOExpectationUnregistrationRaceCondition(void);
__attribute__((constructor)) void WorkaroundXCKVOExpectationUnregistrationRaceCondition(void)
{
	SEL _safelyUnregisterSEL = sel_getUid("_safelyUnregister");
	Method safelyUnregister = class_getInstanceMethod(objc_lookUpClass("_XCKVOExpectation"), _safelyUnregisterSEL);
	void (*_safelyUnregisterIMP)(id, SEL) = (__typeof__(_safelyUnregisterIMP))method_getImplementation(safelyUnregister);
	method_setImplementation(safelyUnregister, imp_implementationWithBlock(^(id self) {
		@synchronized(self)
		{
			_safelyUnregisterIMP(self, _safelyUnregisterSEL);
		}
	}));
}
