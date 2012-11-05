//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Michael Ottavi-Brannon on 10/29/12.
//  Copyright (c) 2012 Michael Ottavi-Brannon. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"
#import "Math.h"


@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic) BOOL enterHasBeenPressed;
@property (nonatomic,strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize nightMode = _nightMode;
@synthesize readout = _readout;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize enterHasBeenPressed;
@synthesize brain = _brain;


- (CalculatorBrain *)brain {
    if(!_brain) _brain = [[CalculatorBrain alloc]init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digit = [sender currentTitle];
    if(self.userIsInTheMiddleOfEnteringANumber)
    {
        NSRange range = [self.display.text rangeOfString:@"."];
        //Check to see if any more periods can be entered
        if(range.location != NSNotFound && [digit isEqualToString:@"."])
        {
            NSLog(@"There is . here already");
        }
        else
        {
            self.display.text = [self.display.text stringByAppendingString: digit];
        }
    }
    //Here the user is leading their calculations with a decimal
    else if([digit isEqualToString:@"."] && self.enterHasBeenPressed == NO)
    {
        self.display.text = [self.display.text stringByAppendingString:digit];
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    //Here the user is leading their calculations with a decimal AFTER pressing enter
    else if([digit isEqualToString:@"."] && self.enterHasBeenPressed == YES)
    {
        self.display.text = @"0.";
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    //Here the user is not in the middle of entering a number and they are entering a number.
    else
    {
        NSRange range = [self.display.text rangeOfString:@"."];
        //Check to see if any more periods can be entered
        if(range.location != NSNotFound && [digit isEqualToString:@"."] && self.enterHasBeenPressed == NO)
        {
            NSLog(@"There is already a period here");
        }
        
        else
        {
            self.display.text = digit;
            self.userIsInTheMiddleOfEnteringANumber = YES;
        }
    }
        
    //The readout will match the display initially
    if(self.enterHasBeenPressed == NO)
    {
        self.readout.text = self.display.text;
    }

    //The display will append the displays readout
    else {self.readout.text = [self.readout.text stringByAppendingString:digit];}
    
//    self.enterHasBeenPressed = NO;
}

- (IBAction)clearPressed:(UIButton *)sender {
    //If the user presses "C," we clear the readout and set the display to 0
    self.display.text = @"0";
    self.readout.text = @"";
    [self.brain clearDisplay];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.enterHasBeenPressed = NO;
}

- (IBAction)enterPressed { 
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.enterHasBeenPressed = YES;
    
    //Make sure that the app does not crash when user presses ENTER or an operation
    if(self.readout.text.length > 0){
        //Here we check if the preceding character was a space and allow the entry of a space or not
        if([[self.readout.text substringFromIndex:self.readout.text.length-1] isEqualToString:@" "])
        {
            NSLog(@"There is already a space here");
        }
        //Here, there is no space preceding it so we append a space
        else
        {
            self.readout.text = [self.readout.text stringByAppendingString:@" "];
        }
    } else {}
}

//Night Mode Controls
- (IBAction)nightMode:(UISwitch *)sender {
    if(sender.on){
        self.nightMode.text = @"Night Mode is ON";
    } else if(!sender.on){
        self.nightMode.text = @"Night Mode is OFF";
    }
    
}



- (IBAction)operationPressed:(UIButton *)sender {
    if(self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];
    double result = [self.brain performOperation: sender.currentTitle];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    
    //Make sure that the app does not crash when user presses ENTER or an operation
    if(self.readout.text.length > 0){
        //Here we check if the preceding character was a space and allow the entry of a space or not
        if([[self.readout.text substringFromIndex:self.readout.text.length-1] isEqualToString:@" "])
        {
            self.readout.text = [self.readout.text stringByAppendingString:sender.currentTitle];
            self.readout.text = [self.readout.text stringByAppendingString:@" "];

        }
        //Here, there is no space preceding it so we append a space BEFORE and after
        else
        {
        self.readout.text = [self.readout.text stringByAppendingString:@" "];
        self.readout.text = [self.readout.text stringByAppendingString:sender.currentTitle];
        self.readout.text = [self.readout.text stringByAppendingString:@" "];

        }
    }
    //Here the first character the user entered is pi
    else if([sender.currentTitle isEqualToString:@"π"])
    {
        self.readout.text = [self.readout.text stringByAppendingString:sender.currentTitle];
        self.readout.text = [self.readout.text stringByAppendingString:@" "];

    }
    
    
}

@end
