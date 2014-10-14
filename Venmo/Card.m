//
//  Card.m
//  Venmo
//
//  Created by Richard Lung on 2/3/14.
//  Copyright (c) 2014 BetterPet, Inc. All rights reserved.
//

#import "Card.h"

@implementation Card {

    NSString *number;
    NSString *cvv;
    NSString *expdate;

}

- (void) setCardNumberWithString:(NSString*) cardString {
    number = cardString;
}

- (void) setCVVWithString:(NSString *)cvvString {
    cvv = cvvString;
}

- (void) setExpDateWithString:(NSString *)expDateString {
    expdate = expDateString;
}

//the expected number of the card, AMEX is 15, rest is 16.
- (NSInteger) cardLength {
    self.ctype = [self getCardType];
    return (self.ctype == cardTypeAMEX ?  15 : 16);
}

//the expected number of the CVV, AMEX is 4, rest is 3.
- (NSInteger) cvvLength {
    self.ctype = [self getCardType];
    return (self.ctype == cardTypeAMEX ?  4 : 3);
}


//checking if the card is not generic and the card length
//is the same as expected length
- (BOOL) isCardValid {
    self.ctype = [self getCardType];
    return (self.ctype != cardTypeGENERIC && [number length] == [self cardLength]);
}

//checking if the cvv length is the same as expected
- (BOOL) isCVVValid {

    return ( [cvv length] == [self cvvLength]) ? YES : NO;

}

//check if the expiration date is valid by making sure it's not before february 2014.
//note for simplicity, I'm assuming it's only use in february 2014.
- (BOOL) isExpDateValid {
    
    if(expdate.length == 4) {
        //NSLog(@"here");
        NSString* firstTwoChars = [expdate substringWithRange:NSMakeRange(0, 2)];
        NSString* lastTwoChars = [expdate substringWithRange:NSMakeRange(2, 2)];
        NSInteger firstNumberRange = [firstTwoChars integerValue];
        NSInteger lastNumberRange = [lastTwoChars integerValue];
        if(firstNumberRange < 2) {
            //NSLog(@"should be gere with last number range %d", (int)lastNumberRange);
            return (lastNumberRange >= 15);
        }
        else {
            return (firstNumberRange >= 1 && firstNumberRange <= 12 && lastNumberRange >= 14);
        }
    }

    return NO;
}

//Prevent the user from entering an invalid expiration date.
- (BOOL) shouldExpDateContinue {
    if(expdate.length == 0) {
        return YES;
    }
    
    if(expdate.length == 1) {
        NSString* firstChar = [expdate substringWithRange:NSMakeRange(0, 1)];
        NSInteger numberRange = [firstChar integerValue];
        return (numberRange == 0 || numberRange == 1);
    }
    
    if(expdate.length == 2) {
        NSString* firstTwoChars = [expdate substringWithRange:NSMakeRange(0, 2)];
         NSInteger firstNumberRange = [firstTwoChars integerValue];
        return (firstNumberRange >= 1 && firstNumberRange <= 12);
    }
    
    if(expdate.length == 3) {
        NSString* firstTwoChars = [expdate substringWithRange:NSMakeRange(0, 2)];
        NSString* thirdChar = [expdate substringWithRange:NSMakeRange(2, 1)];
        NSInteger firstNumberRange = [firstTwoChars integerValue];
        NSInteger lastNumberRange = [thirdChar integerValue];
        return (firstNumberRange >= 1 && firstNumberRange <= 12 && lastNumberRange >= 1);
    }
    
    if(expdate.length == 4) {
        return [self isExpDateValid];
    }
    
    return NO;
    
}

- (UIImage*) getCardImage {
    self.ctype = [self getCardType];
    if(self.ctype == cardTypeAMEX) {
        return [UIImage imageNamed:@"VDKAmex"];
    }
    else if(self.ctype == cardTypeDINERSCLUB) {
        return [UIImage imageNamed:@"VDKDinersClub"];
    }
    else if(self.ctype == cardTypeDISCOVER) {
        return [UIImage imageNamed:@"VDKDiscover"];
    }
    else if(self.ctype == cardTypeJCB) {
        return [UIImage imageNamed:@"VDKJCB"];
    }
    else if(self.ctype == cardTypeMASTER) {
        return [UIImage imageNamed:@"VDKMastercard"];
    }
    else if(self.ctype == cardTypeVISA) {
        return [UIImage imageNamed:@"VDKVisa"];
    }
    return [UIImage imageNamed:@"VDKGenericCard"];
}

- (UIImage*) getCVVImage {
    self.ctype = [self getCardType];
    if(self.ctype == cardTypeAMEX) {
        return [UIImage imageNamed:@"VDKAmexCVV"];
    }
    return [UIImage imageNamed:@"VDKCVV"];
}

- (cardType) getCardType {
    
    /*
     -- SOURCE : http://en.wikipedia.org/wiki/Bank_card_number
     amex : 34, 37
     diners club : 54, 55
     discover : 6011, 622126-622925, 644-649, 65
     jcb 3528-3589
     master card: 50-55
     visa 4
     */

    if(number.length >= 1) {
        NSString* firstChar = [number substringWithRange:NSMakeRange(0, 1)];
        if([firstChar integerValue] == 4) return cardTypeVISA;
    }
    
    if(number.length >= 2) {
        NSString* firstTwoChars = [number substringWithRange:NSMakeRange(0, 2)];
        NSInteger numberRange = [firstTwoChars integerValue];
        if(numberRange == 34 || numberRange == 37) return cardTypeAMEX;
        if(numberRange == 54 || numberRange == 55) return cardTypeDINERSCLUB;
        //ASSUMPTION: diners club gets priority for the overlap with master card
        if(numberRange >= 50 && numberRange <= 55) return cardTypeMASTER;
        if(numberRange == 65) return cardTypeDISCOVER;
    }
    
    if(number.length >= 3) {
        NSString* firstThreeChars = [number substringWithRange:NSMakeRange(0, 3)];
        NSInteger numberRange = [firstThreeChars integerValue];
        if(numberRange >= 644 && numberRange <= 649) return cardTypeDISCOVER;
    }
    
    if(number.length >= 4) {
        NSString* firstFourChars = [number substringWithRange:NSMakeRange(0, 4)];
        NSInteger numberRange = [firstFourChars integerValue];
        if(numberRange >= 3528 && numberRange <= 3589) return cardTypeJCB;
        if(numberRange == 6011) return cardTypeDISCOVER;
    }
    
    if(number.length >= 6) {
        NSString* firstSixChars = [number substringWithRange:NSMakeRange(0, 6)];
        NSInteger numberRange = [firstSixChars integerValue];
        if(numberRange >= 622126 && numberRange <= 622925) return cardTypeDISCOVER;
    }
    
    return cardTypeGENERIC;
}

/*

 check valid luhn
 source : http://en.wikipedia.org/wiki/Luhn_algorithm
 */

- (BOOL)isLuhnValid
{
    BOOL odd = YES;
    int sum  = 0;
    NSMutableArray* digits = [NSMutableArray arrayWithCapacity:number.length];
    
    for (NSInteger i = [number length] - 1 ; i >= 0; i--) {
        [digits addObject:[NSString stringWithFormat:@"%c", [number characterAtIndex:i]]];
    }

    for (NSString* digitobj in digits) {
        NSInteger digit = [digitobj intValue];
        if (!odd) digit *= 2;
        if (digit > 9) digit -= 9;
        odd = !odd;
        sum += digit;
    }
    
    return sum % 10 == 0;
}


@end
