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
						 @"Erreur stack", nil);
	
	NSString* item = [[stack pop] autorelease];
	STAssertEqualObjects(item,
						@"b",
						 @"Erreur stack : mauvais item après dépilage", nil);
	[stack pop];
	STAssertEquals([stack empty],
						 YES,
						 @"Erreur stack", nil);
	
	
	[stack release];
}	


- (void) testPostfixComputation{
	PostfixCalculator *postfix = [[PostfixCalculator  alloc] init];
	  
	NSDecimalNumber * result = [postfix compute:@"5 1 2 + 4 * + 3 -"];
	NSDecimalNumber * expected = [NSDecimalNumber decimalNumberWithString:@"14"];
	
	[result retain];
	[expected retain];	

	STAssertEqualObjects(result, expected,
						 @"Postfix calculation error : unexpected result");
	
	[postfix release];
}

- (void) testInfixToPostfix{

	InfixToPostfix *itp = [[InfixToPostfix alloc] init];
	NSString * result = [itp parseInfix:@"5 + ((123 + 2) *4) -3"];
	NSString * expected = @"5 123 2 + 4 * + 3 -";
	
	[result retain];
	[expected retain];	
	
	STAssertEqualObjects(result, expected,
						 @"Infix to Postfix conversion error");
	
	[itp release];
}


#endif


@end
