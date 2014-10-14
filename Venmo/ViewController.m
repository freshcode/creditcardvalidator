//
//  ViewController.m
//  Venmo
//
//  Created by Richard Lung on 2/3/14.
//  Copyright (c) 2014 BetterPet, Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    Card *card;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    card = [[Card alloc] init];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *nonNumberSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    
    if ([string rangeOfCharacterFromSet:nonNumberSet].location != NSNotFound)
    {
        return NO;
    }
    
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if(textField == _cardNumberTextField) {
        return [self checkCardNumberWithString:newText];
    }
    
    else if(textField == _expDateTextField){
        return [self checkExpDateWithString:newText];
    }
    
    else {
        return [self checkCVVWithString:newText];
    }
}

- (BOOL) checkCardNumberWithString:(NSString*) newText {
    
    //Prevent the user from entering too many digits. 15 for AMEX, 16 for the rest
    if(newText.length > [card cardLength]) return NO;
    
    cardType ct = [card getCardType];
    
    //update the number of the card
    [card setCardNumberWithString:newText];
    
    //check if any changes to the card type, update the image if there is
    if(ct != [card getCardType]) {
        self.cardImageView.image = [card getCardImage];
        self.cvvImageView.image = [card getCVVImage];
    }

    //Prevent the user from entering more text if the first six digits don't match one of the networks.
    return (newText.length == 7 && ([card getCardType] == cardTypeGENERIC)) ? NO : YES;
    

}

- (BOOL) checkExpDateWithString:(NSString*) newText {
    if(newText.length > 4) return NO;
    [card setExpDateWithString:newText];
    //Prevent the user from entering an invalid expiration date.
    return [card shouldExpDateContinue];
}

- (BOOL) checkCVVWithString:(NSString*) newText {
    //Prevent the user from entering CVV that is too long.
    // AMEX should be 4, and the REST is 3
    if(newText.length > [card cvvLength]) return NO;
    
    [card setCVVWithString:newText];
    
    return YES;
    
}



- (IBAction)submitCreditCard:(id)sender {
    UIAlertView *alert;
    if([card isCardValid] && [card isLuhnValid] && [card isCVVValid] && [card isExpDateValid]) {
        [_cardNumberTextField resignFirstResponder];
        [_cvvTextField resignFirstResponder];
        [_expDateTextField resignFirstResponder];
        
        alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Your credit card info has been added successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        
    }
    else if (![card isCardValid] || ![card isLuhnValid]) {
        alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Your credit card number is incorrect." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [_cardNumberTextField becomeFirstResponder];
    }
    
    else if (![card isExpDateValid]) {
        alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Your expiration date is incomplete." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [_expDateTextField becomeFirstResponder];
        
    }
    else {
        alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Your CVV number is incorrect." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [_cvvTextField becomeFirstResponder];
    }
    
}
@end
