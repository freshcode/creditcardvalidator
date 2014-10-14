//
//  VenmoTests.m
//  VenmoTests
//
//  Created by Richard Lung on 2/3/14.
//  Copyright (c) 2014 BetterPet, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Card.h"

@interface VenmoTests : XCTestCase {
    Card *visa, *amex, *diner, *discover, *jcb, *master;
}

@end

@implementation VenmoTests

- (void)setUp
{
    [super setUp];
    
    visa = [[Card alloc] init];
    [visa setCardNumberWithString:@"4388576018410707"];
    [visa setExpDateWithString:@"0415"];
    [visa setCVVWithString:@"123"];
    
    amex = [[Card alloc] init];
    [amex setCardNumberWithString:@"37124123123111315"];
    [amex setExpDateWithString:@"0316"];
    [amex setCVVWithString:@"1234"];
    
    diner = [[Card alloc] init];
    [diner setCardNumberWithString:@"5521276221271111"];
    [diner setExpDateWithString:@"3010"];
    [diner setCVVWithString:@"1111"];
    
    discover = [[Card alloc] init];
    [discover setCardNumberWithString:@"6221276221271111"];
    [discover setExpDateWithString:@"1011"];
    [discover setCVVWithString:@"0"];
    
    jcb = [[Card alloc] init];
    [jcb setCardNumberWithString:@"35830276221271111"];
    [jcb setExpDateWithString:@"1020"];
    [jcb setCVVWithString:@"2"];
    
    
    master = [[Card alloc] init];
    [master setCardNumberWithString:@"51830276221271111"];
    [master setExpDateWithString:@"2030"];
    [master setCVVWithString:@"12345"];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCardTypes
{
    //Amex, Diners Club, Discover, JCB, MasterCard, Visa
    
    XCTAssertTrue([visa getCardType] == cardTypeVISA, @"Not VISA.");
    XCTAssertTrue([amex getCardType] == cardTypeAMEX, @"Not AMEX");
    XCTAssertTrue([diner getCardType] == cardTypeDINERSCLUB, @"Not DINERS");
    XCTAssertTrue([discover getCardType] == cardTypeDISCOVER, @"Not DINERS");
    XCTAssertTrue([jcb getCardType] == cardTypeJCB, @"Not JCB");
    XCTAssertTrue([master getCardType] == cardTypeMASTER, @"Not MASTER");
    XCTAssertFalse([visa getCardType] == cardTypeAMEX, @"Should Fail VISA != AMEX");
    XCTAssertFalse([discover getCardType] == cardTypeAMEX, @"Should Fail DISCOVER != AMEX");
    XCTAssertFalse([jcb getCardType] == cardTypeAMEX, @"Should Fail JCB != AMEX");
    
}

- (void) testExpirationDates
{
    XCTAssertTrue([visa isExpDateValid], @"VISA Exp Date Not Valid");
    XCTAssertTrue([amex isExpDateValid], @"AMEX Exp Date Not Valid");
    XCTAssertFalse([diner isExpDateValid], @"DINER Exp Date Valid");
    XCTAssertFalse([discover isExpDateValid], @"DISCOVER Exp Date Valid");
    XCTAssertTrue([jcb isExpDateValid], @"JCB Exp Date Not Valid");
    XCTAssertFalse([master isExpDateValid], @"MASTER Exp Date Valid");
    
}

- (void) testCVV {
    XCTAssertTrue([visa isCVVValid], @"VISA CVV Not Valid");
    XCTAssertTrue([amex isCVVValid], @"AMEX CVV Not Valid");
    XCTAssertFalse([diner isCVVValid], @"DINERS CVV Valid");
    XCTAssertFalse([discover isCVVValid], @"DISCOVER CVV Valid");
    XCTAssertFalse([jcb isCVVValid], @"JCB CVV Valid");
    XCTAssertFalse([master isCVVValid], @"MASTER CVV Valid");
    
}

- (void) testLuhn {
    XCTAssertTrue([visa isLuhnValid], @"VISA Luhn Not Valid");
    XCTAssertTrue([amex isLuhnValid], @"AMEX Luhn Not Valid");
    XCTAssertFalse([diner isLuhnValid], @"DINER Luhn Valid");
    XCTAssertFalse([discover isLuhnValid], @"DISCOVER Luhn Valid");
    XCTAssertFalse([jcb isLuhnValid], @"JCB Luhn Valid");
    XCTAssertFalse([master isLuhnValid], @"MASTER Luhn Valid");
}

- (void) testCardDigits {
    XCTAssertTrue([amex cardLength] == 15, @"AMEX length not 15");
    XCTAssertTrue([visa cardLength] == 16, @"VISA length not 16");
    
}


@end
