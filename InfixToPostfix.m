//
//  InfixToPostfix.m
//  infix-expression-calculator
//
//  Created by Samuel Tribehou on 27/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "InfixToPostfix.h"


@implementation InfixToPostfix


- (InfixToPostfix*) init{
	self = [super init];
	if (self){
		operators = [NSArray arrayWithObjects: @"+", @"-", @"*", @"/", nil];
	}
	
	return self;
}

- (void) dealloc{
	[super dealloc];
}

- (NSString*) parseInfix: (NSString*) infixExpression{
	SimpleStack * opStack = [[SimpleStack alloc] init];
	NSMutableString * output = [NSMutableString stringWithCapacity:[infixExpression length]];
	
	[opStack print];
	
	NSArray * tokens = [self tokenize: infixExpression];
	for (NSString *token in tokens){
		NSLog(@"token : '%@'", token);
		if ([self precedenceOf:token] != 0){
			// token is as operator, pop all operators of higher or equal precedence off the stack, and append them to the output
			NSString *op = [opStack peek];
			while (op && [operators containsObject:op] && [self precedenceOf: op isHigherOrEqualThan: token]) {
				[output appendString: [NSString stringWithFormat: @" %@ ", [opStack pop]]];
				op = [opStack peek];
			}
			// then push the operator on the stack
			[opStack push:token];
			
			[opStack print];

		} else if ([token compare: @"("] ==0){
			// push opening brackets on the stack, will be dismissed later
			[opStack push:token];
		} else if ([token compare: @")"] ==0) {
			// closing bracket : 
			// pop operators off the stack and append them to the output while the popped element is not the opening bracket
			NSString  * op = [opStack pop];
		    while ( op  && ([op compare: @"("] != 0)){
				[output appendString: [NSString stringWithFormat: @" %@ ", op]];
				op = [opStack pop];
				NSLog(@"popped token : %@", token);
			}
			if ( ! op || ([op compare: @"("]  != 0)){
				NSLog(@"Error : unbalanced brackets in expression");
				return @"";
			}
		} else {
			//token is an operand, append it to the output
			NSLog(@"operand : %@", token);
			[output appendString: [NSString stringWithFormat: @" %@ ", token]];
		}
		
		[opStack print];
		
	}
	
	//pop remaining operators off the stack, and append them to the output
	while (! [opStack empty]) {
		[output appendString: [NSString stringWithFormat: @" %@ ", [opStack pop]]];
	}
	
//	[opStack release];
	
	return output;
}


- (NSArray*) tokenize: (NSString*) expression {
	
	//for now assume that each token is separated by one space
	NSString* strippedExpression = [expression stringByTrimmingCharactersInSet:
									[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	return [strippedExpression componentsSeparatedByString: @" "];
	
	//char c;
//	
//	for (int i = 0; i< [expression length]; i++)
//		c = [theString characterAtIndex: i];
}


- (BOOL) precedenceOf: (NSString*) operator isHigherOrEqualThan: (NSString*) otherOperator{
	return  [self precedenceOf: operator]  >=  [self precedenceOf: otherOperator];
}

- (NSUInteger) precedenceOf: (NSString*) operator{
	NSLog(@"precedence : %@", operator);
	if ([operator compare: @"+"] == 0 )
		return 1;
	else if ([operator compare: @"-"] == 0 )
		return 1;
	else if ([operator compare: @"*"] == 0 )
		return 2;
	else if ([operator compare: @"/"] == 0 )
		return 2;
	else {
		NSLog(@"Error: invalid operator");
		return 0;
	}

}


@end
