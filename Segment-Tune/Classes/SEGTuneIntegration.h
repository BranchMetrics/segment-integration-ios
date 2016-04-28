#import <Foundation/Foundation.h>
#import <Analytics/SEGIntegration.h>
#import <Tune/Tune.h>

@interface SEGTuneIntegration : NSObject<SEGIntegration, TuneDelegate>

@property(nonatomic, strong) NSDictionary *settings;

- (id)initWithSettings:(NSDictionary *)settings;

@end