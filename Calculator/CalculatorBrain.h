//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Michael Ottavi-Brannon on 10/29/12.
//  Copyright (c) 2012 Michael Ottavi-Brannon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject
- (void) clearDisplay;
- (void) pushOperand :(double)operand;
- (double) performOperation : (NSString *)operation;

@property (readonly) id program;
+ (double) runProgram:(id)program;
+ (NSString *) descriptionOfProgram:(id)program;

@end
