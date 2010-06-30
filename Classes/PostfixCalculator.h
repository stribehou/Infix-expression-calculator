//
//  PostfixParser.h
//  iphoneCalc
//
//  Created by Samuel Tribehou on 27/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimpleStack.h";

@interface PostfixCalculator : NSObject {
	NSArray* operators;
	SimpleStack* stack;
}


- (PostfixCalculator*) init;
- (void) dealloc;
- (NSDecimalNumber *) compute:(NSString*) postfixExpression;
@end
