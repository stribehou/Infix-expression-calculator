//
//  Stack.m
//  iphoneCalc
//
//  Created by Samuel Tribehou on 27/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SimpleStack.h"


@implementation SimpleStack

- (SimpleStack*) init{
	self = [super init];
	if (self){
		array = [[[NSMutableArray alloc] initWithCapacity:50] retain];	
	}
    return self;
}

- (void) dealloc{
	[super dealloc];
	[array release];
}

- (void) push:(id) object { [array addObject:object ];}

- (id) pop{
	if ([array count ] < 1)
		return nil;
	
	id item = [[[array lastObject] retain] autorelease];
	[array removeLastObject];
	return item;
}

- (int) size{ return [array count];}

- (void) print{
  NSLog(@"[ %@ ]", [array componentsJoinedByString: @" , "]);	
}

- (BOOL) empty { return [array count] == 0;}

- (id) peek{ 
	if ([array count] < 1)
		return nil;
	
	return [array lastObject];
}

@end
