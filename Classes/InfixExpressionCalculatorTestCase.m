//
//  TestTestCase.m
//  calc
//
//  Created by Samuel Tribehou on 24/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#define USE_APPLICATION_UNIT_TEST 1


#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>

#import "PostfixCalculator.h"
#import "SimpleStack.h"
#import "InfixToPostfix.h"
#import "InfixCalculator.h"

@interface OperationTestCase : SenTestCase {
	
}
@end


@implementation OperationTestCase

#if USE_APPLICATION_UNIT_TEST    

- (void) testStack{
	SimpleStack * stack = [[SimpleStack alloc] init];
	
	[stack push: @"a"];
	[stack push: @"b"];
	
	STAssertEquals([stack size],
						 2,
						 @"Stack size should have been 2", nil);
	
	NSString* item = [[stack pop] autorelease];
	STAssertEqualObjects(item,
						@"b",
						 @"Stack pop gave wrong item ??", nil);
	[stack pop];
	STAssertEquals([stack empty],
						 YES,
						 @"Stack should be empty", nil);
	
	
	[stack release];
}	


- (void) testPostfixComputation{
	PostfixCalculator *postfix = [[PostfixCalculator  alloc] init];
	  
	NSDecimalNumber * result = [postfix compute:@"5.202343 1 2 + 4 * + -3 -"];
	NSDecimalNumber * expected = [NSDecimalNumber decimalNumberWithString:@"20.202343"];

	STAssertEqualObjects(result, expected,
						 @"Postfix calculation error : unexpected result");
	
	[postfix release];
}

- (void) testInfixToPostfix{

	InfixToPostfix *itp = [[InfixToPostfix alloc] init];
	NSString * result = [itp parseInfix:@"5 + ((123.2243224545 hgh + 2) *4) - -3  "];
	NSString * expected = @"5 123.2243224545 2 + 4 * + -3 -";
	
	
	STAssertEqualObjects(result, expected,
						 @"Infix to Postfix conversion error");

	
	STAssertFalse([itp hasBalancedBrackets: @"(("],
						 @"Infix to postfix : mismatched brackets not detected");
	
	STAssertTrue([itp hasBalancedBrackets: @"()"], 
				   @"Infix to postfix : matching brackets reported as unbalanced");

	expected = nil;
	result = [itp parseInfix: @"("];
	
	STAssertEqualObjects(result, expected,
						 @"Infix to postfix : mismatched brackets not detected");
	
	[itp release];
}

- (void) testCalculator{
	InfixCalculator * calc = [[InfixCalculator alloc] init];
	NSDecimalNumber * expected = [NSDecimalNumber decimalNumberWithString: @"42"];
	NSDecimalNumber * result = [calc computeExpression: @"(10.5656565656 * 2 + ((40 / 4) *4) / 4 *2 +20 *4 -78 - 0.5656565656 *2)"];
	
	STAssertEqualObjects(result, expected,
						 @"Calculator result error");

	expected = nil;
	result = [calc computeExpression: @"(45345(2454"];
	STAssertEqualObjects(expected, result, @"Calculator should have returned null to an unbalanced expression");
	
	[calc release];
}

#endif


@end
