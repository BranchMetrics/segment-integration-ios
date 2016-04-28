#import "SEGTuneIntegrationFactory.h"
#import "SEGTuneIntegration.h"

@implementation SEGTuneIntegrationFactory

+ (instancetype)instance
{
    static dispatch_once_t once;
    static SEGTuneIntegrationFactory *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    return self;
}

- (id<SEGIntegration>)createWithSettings:(NSDictionary *)settings forAnalytics:(SEGAnalytics *)analytics
{
    return [[SEGTuneIntegration alloc] initWithSettings:settings];
}

- (NSString *)key
{
    return @"TUNE";
}

@end