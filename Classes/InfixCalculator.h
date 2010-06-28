//
//  InfixCalculator.h
//  infix-expression-calculator
//
//  Created by Samuel Tribehou on 28/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InfixToPostfix.h"
#import "PostfixCalculator.h"

@interface InfixCalculator : NSObject {
	InfixToPostfix *itp;
	PostfixCalculator *postCalc;
}

- (InfixCalculator*) init;
- (void) dealloc;
- (NSDecimalNumber*) computeExpression: (NSString*) infixExpression;

@end
