//
//  InfixToPostfix.h
//  infix-expression-calculator
//
//  Created by Samuel Tribehou on 27/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimpleStack.h"


@interface InfixToPostfix : NSObject {
	NSArray* operators;
	BOOL hasErrors;
	NSDictionary * operatorPrecedence;
}

- (InfixToPostfix*) init;
- (void) dealloc;
- (BOOL) precedenceOf : (NSString*) operator isHigherOrEqualThan: (NSString*) otherOperator;
- (NSString*) parseInfix: (NSString*) infixExpression;
- (NSArray*) tokenize: (NSString*) expression;
- (NSUInteger) precedenceOf: (NSString*) operator;
@end
