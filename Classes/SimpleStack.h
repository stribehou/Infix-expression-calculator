/***
 Copyright (c) 2010 Samuel Tribehou.
 Licensed under: whatever license you want.
 ***/


#import <Foundation/Foundation.h>


@interface SimpleStack : NSObject {
	NSMutableArray *array;
}

- (SimpleStack*) init;
- (void) dealloc;
- (void) push:(id) object;
- (id) pop;
- (int) size;
- (void) print;
- (BOOL) empty;
- (id) peek;

@end

