/***
 Copyright (c) 2010 Samuel Tribehou.
 Licensed under: whatever license you want.
 ***/


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
