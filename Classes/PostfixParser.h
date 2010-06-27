//
//  PostfixParser.h
//  iphoneCalc
//
//  Created by Samuel Tribehou on 27/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimpleStack.h";

@interface PostfixParser : NSObject {
	NSArray* operators;
	SimpleStack* stack;
	BOOL hasErrors;
}

@property (readonly) BOOL hasErrors;

- (PostfixParser*) init;
- (void) dealloc;
- (NSDecimalNumber *) compute:(NSString*) postfixExpression;
- (NSDecimalNumber *) computeOperator:(NSString*) operator
withFirstOperand:(NSDecimalNumber*) firstOperand withSecondOperand:(NSDecimalNumber*) secondOperand;

@end
