//
//  PostfixParser.m
//  iphoneCalc
//
//  Created by Samuel Tribehou on 27/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PostfixCalculator.h"


@implementation PostfixCalculator

- (PostfixCalculator*) init{
	self = [super init];
	if (self){
		operators = [NSArray arrayWithObjects: @"+", @"-", @"*", @"/", nil];
		[operators retain];
	}
	
	return self;
}

- (void) dealloc{
	[operators release];
	[super dealloc];
}


- (NSDecimalNumber*) compute:(NSString*) postfixExpression{
	stack = [[SimpleStack alloc] init];
	NSString* strippedExpression = [postfixExpression stringByTrimmingCharactersInSet:
									[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	NSArray *tokens = [strippedExpression componentsSeparatedByString: @" "];
	
	for(NSString* token in tokens){

		if ([operators containsObject:token]){
			// operator found : unstack 2 operands and use them as operator arguments
			NSDecimalNumber* secondOperand = (NSDecimalNumber*) [stack pop];
     		NSDecimalNumber* firstOperand= (NSDecimalNumber*) [stack pop];

			
			if (! (firstOperand && secondOperand)){
				NSLog(@"Not enough operands on stack for given operator");
				return nil;
			}
			
			// compute result, and push it back on the stack

			NSDecimalNumber * result =  [self computeOperator:token 
											 withFirstOperand: firstOperand 
											withSecondOperand:secondOperand];

			if (result == [NSDecimalNumber notANumber])
				return result; // an error occured during operator calculation, bail early
			
			  [stack push:result];
			
		} else {
			//number found, push it on the stack 
			NSDecimalNumber * operand = [NSDecimalNumber decimalNumberWithString : token];
			[stack push: operand];
		}
	}
	
	
	if ([stack size] != 1){
		NSLog(@"Error : Invalid RPN expression. Stack contains %d elements after computing expression, only one should remain.", 
			  [stack size]);
		return nil;
	} else {
		NSDecimalNumber * result = [[[stack pop] retain] autorelease];
		[stack release];
		return result;
	}
}

- (NSDecimalNumber *) computeOperator:(NSString*) operator
					 withFirstOperand:(NSDecimalNumber*) firstOperand withSecondOperand:(NSDecimalNumber*) secondOperand{
	NSDecimalNumber * result;
	
	if ([operator compare: @"+"] == 0) {
		result = [firstOperand decimalNumberByAdding: secondOperand];
	}else if ([operator compare: @"*"] == 0) {
		result = [firstOperand decimalNumberByMultiplyingBy: secondOperand];
	} else if ([operator compare: @"-"] == 0) {
		result = [firstOperand decimalNumberBySubtracting: secondOperand];
	}
	else if ([operator compare: @"/"] == 0) {
		if ([[NSDecimalNumber zero] compare: secondOperand] == NSOrderedSame){
			NSLog(@"Divide by zero !");
			return [NSDecimalNumber notANumber];
		}
		else 
			result = [firstOperand decimalNumberByDividingBy: secondOperand];	}
	
	return result;
}

@end