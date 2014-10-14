//
//  ViewController.h
//  Venmo
//
//  Created by Richard Lung on 2/3/14.
//  Copyright (c) 2014 BetterPet, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@interface ViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *cardImageView;
@property (weak, nonatomic) IBOutlet UITextField *cardNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *expDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *cvvTextField;
@property (weak, nonatomic) IBOutlet UIImageView *cvvImageView;
- (IBAction)submitCreditCard:(id)sender;

@end
