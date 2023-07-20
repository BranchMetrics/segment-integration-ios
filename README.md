This repo is deprecated

# Segment-Tune

[![Version](https://img.shields.io/cocoapods/v/Segment-Tune.svg?style=flat)](http://cocoapods.org/pods/Segment-Tune)
[![License](https://img.shields.io/cocoapods/l/Segment-Tune.svg?style=flat)](http://cocoapods.org/pods/Segment-Tune)
[![Platform](https://img.shields.io/cocoapods/p/Segment-Tune.svg?style=flat)](http://cocoapods.org/pods/Segment-Tune)

## Setup

Use the TuneIntegration factory when initializing Segment in your application:

```
SEGAnalyticsConfiguration *config = [SEGAnalyticsConfiguration configurationWithWriteKey:@"SEGMENT_WRITE_KEY"];
[config use:[SEGTuneIntegrationFactory instance]];
[SEGAnalytics setupWithConfiguration:config];
```

## Usage

### Installs and App Opens

Measuring installs with TUNE is automatically wired into this integration, so you don't need to worry about adding anything for that.

To measure app opens from deeplinks, add the following to your `AppDelegate`:

```
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    // when the app is opened due to a deep link, call the Tune deep link setter
    [Tune handleOpenURL:url options:options];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    // when the app is opened due to a deep link, call the Tune deep link setter
    [Tune handleOpenURL:url sourceApplication:sourceApplication];
    return YES;
}
```

### Identify Users

`SEGAnalytics identify:`
will set user id in TUNE. If present, the email, phone, and username fields will automatically set corresponding user identifier fields in TUNE, to be sent with any future events.

`SEGAnalytics reset:`
will reset any user identifiers set by identify.

### Track Actions

`SEGAnalytics track:`
will measure events in TUNE. If present, the revenue, currency, orderId, productId, and category fields will automatically map to corresponding fields for the event in TUNE.

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

Segment-Tune is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Segment-Tune"
```

## Author

John Gu, johng@tune.com

## License

Segment-Tune is available under the MIT license. See the LICENSE file for more info.
