//
//  SEGTuneIntegrationTests.m
//  SEGTuneIntegrationTests
//
//  Created by John Gu on 04/15/2016.
//  Copyright (c) 2016 John Gu. All rights reserved.
//

#import "SEGTuneIntegration.h"
#import "SEGTuneIntegrationFactory.h"
#import <OCMock/OCMock.h>

@import XCTest;

@interface SEGTuneIntegrationTests : XCTestCase

@end

@implementation SEGTuneIntegrationTests

SEGTuneIntegration *integration;

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    NSDictionary* settings = @{ @"advertiserId" : @"877",
                                @"conversionKey" : @"8c14d6bbe466b65211e781d62e301eec" };
    
    integration = [[SEGTuneIntegration alloc] initWithSettings:settings];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testIntegrationConstructor
{
    XCTAssertNotNil(integration);
}

- (void)testFactory
{
    integration = (SEGTuneIntegration *)[[SEGTuneIntegrationFactory alloc]
                                         createWithSettings:@{ @"advertiserId" : @"877",
                                                               @"conversionKey" : @"8c14d6bbe466b65211e781d62e301eec" }
                                         forAnalytics:nil];
    
    XCTAssertNotNil(integration);
}

- (void)testMeasureSession
{
    id mockTune = OCMClassMock([Tune class]);
    SEL selector = @selector(measureSession);
    XCTAssertTrue([[Tune class] respondsToSelector:selector]);
    OCMStub(ClassMethod([mockTune methodForSelector:selector]));
    
    [integration applicationDidBecomeActive];
    
    [[NSRunLoop mainRunLoop] runUntilDate:
     [NSDate dateWithTimeIntervalSinceNow:0.01]];
    // Verify measureSession was called
    OCMVerify([mockTune measureSession]);
}

- (void)testIdentify
{
    SEGIdentifyPayload* payload = [[SEGIdentifyPayload alloc]
                                   initWithUserId:@"userId"
                                   anonymousId:@"anonymousId"
                                   traits:@{ @"email" : @"foo@bar.com",
                                             @"phone" : @"123-456-7890",
                                             @"username" : @"mrsparkle" }
                                   context:nil
                                   integrations:nil];
    
    id mockTune = OCMClassMock([Tune class]);
    SEL setUserIdSelector = @selector(setUserId:);
    SEL setPhoneNumberSelector = @selector(setPhoneNumber:);
    SEL setUserEmailSelector = @selector(setUserEmail:);
    SEL setUserNameSelector = @selector(setUserName:);
    
    // Mock user identifier setters
    XCTAssertTrue([[Tune class] respondsToSelector:setUserIdSelector]);
    OCMStub(ClassMethod([mockTune methodForSelector:setUserIdSelector]));
    XCTAssertTrue([[Tune class] respondsToSelector:setPhoneNumberSelector]);
    OCMStub(ClassMethod([mockTune methodForSelector:setPhoneNumberSelector]));
    XCTAssertTrue([[Tune class] respondsToSelector:setUserEmailSelector]);
    OCMStub(ClassMethod([mockTune methodForSelector:setUserEmailSelector]));
    XCTAssertTrue([[Tune class] respondsToSelector:setUserNameSelector]);
    OCMStub(ClassMethod([mockTune methodForSelector:setUserNameSelector]));
    
    [integration identify:payload];
    
    // Verify that user identifier setters are called
    [[NSRunLoop mainRunLoop] runUntilDate:
     [NSDate dateWithTimeIntervalSinceNow:0.01]];
    OCMVerify([mockTune setUserId:payload.userId]);
    OCMVerify([mockTune setPhoneNumber:payload.traits[@"phone"]]);
    OCMVerify([mockTune setUserEmail:payload.traits[@"email"]]);
    OCMVerify([mockTune setUserName:payload.traits[@"username"]]);
}

- (void)testTrack
{
    SEGTrackPayload* payload = [[SEGTrackPayload alloc]
                                initWithEvent:@"testEvent"
                                properties:@{ @"revenue" : @"0.99",
                                              @"currency" : @"CAD"}
                                context:nil
                                integrations:nil];
    
    id mockTune = OCMClassMock([Tune class]);
    SEL selector = @selector(measureEvent:);
    XCTAssertTrue([[Tune class] respondsToSelector:selector]);
    OCMStub(ClassMethod([mockTune methodForSelector:selector]));
    
    [integration track:payload];
    
    [[NSRunLoop mainRunLoop] runUntilDate:
     [NSDate dateWithTimeIntervalSinceNow:0.01]];
    // Verify measureEvent was called
    OCMVerify([mockTune measureEvent:OCMOCK_ANY]);
}

- (void)testReset
{
    id mockTune = OCMClassMock([Tune class]);
    SEL setUserIdSelector = @selector(setUserId:);
    SEL setPhoneNumberSelector = @selector(setPhoneNumber:);
    SEL setUserEmailSelector = @selector(setUserEmail:);
    SEL setUserNameSelector = @selector(setUserName:);
    
    // Mock user identifier setters
    XCTAssertTrue([[Tune class] respondsToSelector:setUserIdSelector]);
    OCMStub(ClassMethod([mockTune methodForSelector:setUserIdSelector]));
    XCTAssertTrue([[Tune class] respondsToSelector:setPhoneNumberSelector]);
    OCMStub(ClassMethod([mockTune methodForSelector:setPhoneNumberSelector]));
    XCTAssertTrue([[Tune class] respondsToSelector:setUserEmailSelector]);
    OCMStub(ClassMethod([mockTune methodForSelector:setUserEmailSelector]));
    XCTAssertTrue([[Tune class] respondsToSelector:setUserNameSelector]);
    OCMStub(ClassMethod([mockTune methodForSelector:setUserNameSelector]));
    
    [integration reset];
    
    // Verify that user identifiers are cleared
    [[NSRunLoop mainRunLoop] runUntilDate:
     [NSDate dateWithTimeIntervalSinceNow:0.01]];
    OCMVerify([mockTune setUserId:nil]);
    OCMVerify([mockTune setPhoneNumber:nil]);
    OCMVerify([mockTune setUserEmail:nil]);
    OCMVerify([mockTune setUserName:nil]);
}

@end

