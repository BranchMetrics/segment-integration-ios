#import <Foundation/Foundation.h>
#import <Analytics/SEGIntegrationFactory.h>

@interface SEGTuneIntegrationFactory : NSObject<SEGIntegrationFactory>

+ (instancetype)instance;

@end