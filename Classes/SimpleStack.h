//
//  Stack.h
//  iphoneCalc
//
//  Created by Samuel Tribehou on 27/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

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

