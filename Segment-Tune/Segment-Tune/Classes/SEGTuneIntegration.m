//
//  SEGTuneIntegration.m
//  Tune Segment iOS Integration Version 1.0.0
//
//  Copyright (c) 2016 TUNE, Inc. All rights reserved.
//

#import "SEGTuneIntegration.h"
#import <Analytics/SEGAnalyticsUtils.h>

@implementation SEGTuneIntegration

- (instancetype)initWithSettings:(NSDictionary *)settings
{
    if (self = [super init]) {
        NSString *advertiserId = [settings objectForKey:@"advertiserId"];
        NSString *conversionKey = [settings objectForKey:@"conversionKey"];

        if (!advertiserId || advertiserId.length == 0) {
            @throw([NSException
                exceptionWithName:@"Tune Error"
                           reason:[NSString
                                      stringWithFormat:@"Tune: Please add "
                                                       @"Tune advertiser id in "
                                                       @"Segment settings."]
                         userInfo:nil]);
        }
        if (!conversionKey || conversionKey.length == 0) {
            @throw([NSException
                exceptionWithName:@"Tune Error"
                           reason:[NSString
                                      stringWithFormat:@"Tune: Please add "
                                                       @"Tune conversion key "
                                                       @"in Segment settings."]
                         userInfo:nil]);
        }

        [Tune initializeWithTuneAdvertiserId:advertiserId
                           tuneConversionKey:conversionKey];
        [Tune setDelegate:self];

        SEGLog(@"Tune initialized");
    }
    return self;
}

- (void)applicationDidBecomeActive
{
    // Attribution will not function without the measureSession call included
    [Tune measureSession];
    SEGLog(@"Calling Tune measureSession");
}

- (void)identify:(SEGIdentifyPayload *)payload
{
    [Tune setUserId:payload.userId];
    [Tune setPhoneNumber:payload.traits[@"phone"]];
    [Tune setUserEmail:payload.traits[@"email"]];
    [Tune setUserName:payload.traits[@"username"]];
    SEGLog(@"Setting Tune user identifiers");
}

- (void)track:(SEGTrackPayload *)payload
{
    TuneEvent *event = [TuneEvent eventWithName:payload.event];
    event.revenue = [[payload.properties valueForKey:@"revenue"] doubleValue];
    event.currencyCode = payload.properties[@"currency"];
    [Tune measureEvent:event];
    SEGLog(@"Calling Tune measureEvent with %@", payload.event);
}

- (void)reset
{
    [Tune setUserId:nil];
    [Tune setPhoneNumber:nil];
    [Tune setUserEmail:nil];
    [Tune setUserName:nil];
    SEGLog(@"Clearing Tune user identifiers");
}

- (void)tuneEnqueuedActionWithReferenceId:(NSString *)referenceId
{
    SEGLog(@"tuneEnqueuedActionWithReferenceId %@", referenceId);
}

- (void)tuneDidSucceedWithData:(NSData *)data
{
    SEGLog(@"tuneDidSucceedWithData %@", [NSString stringWithUTF8String:[data bytes]]);
}

- (void)tuneDidFailWithError:(NSError *)error
{
    SEGLog(@"tuneDidFailWithError %@", error);
}

@end