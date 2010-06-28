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
			// token is an operator, pop all operators of higher or equal precedence off the stack, and append them to the output
			NSString *op = [opStack peek];
			while (op && [operators containsObject:op] && 
				   [self precedenceOf: op isHigherOrEqualThan: token]) {
				[output appendString: [NSString stringWithFormat: @"%@ ", [opStack pop]]];
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
				[output appendString: [NSString stringWithFormat: @"%@ ", op]];
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
			[output appendString: [NSString stringWithFormat: @"%@ ", token]];
		}
		
		[opStack print];
		
	}
	
	//pop remaining operators off the stack, and append them to the output
	while (! [opStack empty]) {
		[output appendString: [NSString stringWithFormat: @"%@ ", [opStack pop]]];
	}
	
	[opStack release];
	
	return [output stringByTrimmingCharactersInSet:
			[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


- (NSArray*) tokenize: (NSString*) expression {
	NSMutableArray * tokens = [NSMutableArray arrayWithCapacity:[expression length]];
	
	unichar c;
	NSMutableString * numberBuf = [NSMutableString stringWithCapacity: 5];
	int length = [expression length];
	BOOL lastTokenWasAnOperator = NO;
	
	for (int i = 0; i< length; i++){
		c = [expression characterAtIndex: i];
		switch (c) {
			case '+':
			case '/':
			case '*':
				lastTokenWasAnOperator = YES;
				[self addNumber: numberBuf andToken: c toTokens:tokens];
				break;
			case '(':
		    case ')':
				lastTokenWasAnOperator = NO;
				[self addNumber: numberBuf andToken: c toTokens:tokens];
				break;
			case '-':
				if (lastTokenWasAnOperator){
					lastTokenWasAnOperator = NO;
					[numberBuf appendString : [NSString stringWithCharacters: &c length:1]];	
				} else {
					lastTokenWasAnOperator = YES;
					[self addNumber: numberBuf andToken: c toTokens:tokens];
				}

				break;
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '8':
			case '9':
			case '0':
				lastTokenWasAnOperator = NO;
				[numberBuf appendString : [NSString stringWithCharacters: &c length:1]];
			case ' ':
				break;
			default:
				NSLog(@"Unsupported character in input expression : %c, discarding.", c);
				break;
		}
	}
	if ([numberBuf length] > 0)
		[tokens addObject:  [NSString stringWithString: numberBuf]];
	
	NSLog(@"tokens : [ %@ ]", [tokens componentsJoinedByString: @" , "]);	
	return tokens;
}

- (void) addNumber:(NSMutableString*) numberBuf andToken:(unichar) token toTokens : (NSMutableArray*) tokens{
	if ([numberBuf length] > 0){
		[tokens addObject:  [NSString stringWithString: numberBuf]];
		[numberBuf setString:@""];
	}
	[tokens addObject: [NSString stringWithCharacters: &token length:1]];			
}


- (BOOL) precedenceOf: (NSString*) operator isHigherOrEqualThan: (NSString*) otherOperator{
	return  [self precedenceOf: operator]  >=  [self precedenceOf: otherOperator];
}

- (NSUInteger) precedenceOf: (NSString*) operator{
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
