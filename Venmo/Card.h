//
//  Card.h
//  Venmo
//
//  Created by Richard Lung on 2/3/14.
//  Copyright (c) 2014 BetterPet, Inc. All rights reserved.
//


#import <Foundation/Foundation.h>

typedef enum {
    cardTypeAMEX,
    cardTypeDINERSCLUB,
    cardTypeDISCOVER,
    cardTypeJCB,
    cardTypeMASTER,
    cardTypeVISA,
    cardTypeGENERIC
}cardType;

@interface Card : NSObject


@property (nonatomic) cardType ctype;

- (void) setCardNumberWithString:(NSString*) cardString;
- (void) setExpDateWithString:(NSString*) expDateString;
- (void) setCVVWithString:(NSString*) cvvString;

- (BOOL) isCardValid;
- (BOOL) isExpDateValid;
- (BOOL) isCVVValid;
- (BOOL) shouldExpDateContinue;
- (BOOL )isLuhnValid;

- (NSInteger) cardLength;
- (NSInteger) cvvLength;

- (UIImage*) getCardImage;
- (UIImage*) getCVVImage;

- (cardType) getCardType;



@end
