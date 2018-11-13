//
//  LocationHelper.h
//  iOSwifi
//
//  Created by Stone on 2018/11/13.
//  Copyright © 2018 Stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

UIKIT_EXTERN NSString *const STLocationHelpDidChangeAuthorizationStatussNotication;

typedef void(^UpdateLocationsBlock)(CLLocation *location, NSError *error);

@interface LocationHelper : NSObject<CLLocationManagerDelegate>

@property (assign, nonatomic) BOOL useForProvinceQQGroups;

@property (assign, nonatomic) BOOL hasUpdated;

@property (nonatomic, copy)   UpdateLocationsBlock updateLocationsBlock;

+ (LocationHelper *) sharedInstance;

- (void)startLocationWithBlock:(UpdateLocationsBlock)block;

- (void)stopLocation;

+ (void)relocationIfNeed;

@end
