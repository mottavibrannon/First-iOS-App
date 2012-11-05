//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Michael Ottavi-Brannon on 10/29/12.
//  Copyright (c) 2012 Michael Ottavi-Brannon. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic,strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain
@synthesize operandStack = _operandStack;
- (NSMutableArray *) operandStack{
    //Lazy Instantiation
    if(!_operandStack){
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}

- (void) pushOperand:(double)operand {
    [self.operandStack addObject: [NSNumber numberWithDouble:operand]];
}

- (void) clearDisplay {
    [self.operandStack removeAllObjects];
}

- (double) popOperand {
    NSNumber *operandObject =  [self.operandStack lastObject];
    if(operandObject){
        [self.operandStack removeLastObject];
    }
    return [operandObject doubleValue];
}
- (double) performOperation:(NSString *)operation {

    double result = 0;
    
    if([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    } else if([operation isEqualToString:@"*"]){
        result = [self popOperand] * [self popOperand];
    } else if([operation isEqualToString:@"-"]){
        double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;
    } else if([operation isEqualToString:@"/"]){
        double divisor = [self popOperand];
        if(divisor){
            result = [self popOperand] / divisor;
        }
    } else if([operation isEqualToString:@"sin"]){
        result = sin([self popOperand]);
    } else if([operation isEqualToString:@"cos"]){
        result = cos([self popOperand]);
    } else if([operation isEqualToString:@"sqrt"]){
        result = sqrt([self popOperand]);
    } else if([operation isEqualToString:@"π"]){
        [self pushOperand:M_PI];
        result = [self popOperand];
    }
    
    [self pushOperand:result];
    
    return result;
}
@end
