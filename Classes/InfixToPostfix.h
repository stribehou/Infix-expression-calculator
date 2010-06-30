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
	NSDictionary * operatorPrecedence;
}

- (InfixToPostfix*) init;
- (void) dealloc;

- (NSString*) parseInfix: (NSString*) infixExpression;

@end
