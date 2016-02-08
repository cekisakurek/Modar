//
//  MDLocationManager.m
//  Modar
//
//  Created by Cihan Emre Kisakurek (Company) on 08/02/16.
//  Copyright (c) 2016 cekisakurek. All rights reserved.
//

#import "MDLocationManager.h"

@interface MDLocationManager () <CLLocationManagerDelegate>

@property (strong) CLLocationManager *manager;

@end


@implementation MDLocationManager

+ (instancetype)sharedManager
{
    static dispatch_once_t once;
    static MDLocationManager *sharedFoo;
    dispatch_once(&once, ^ { sharedFoo = [[self alloc] init]; });
    return sharedFoo;
}


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.manager = [[CLLocationManager alloc] init];
        self.manager.delegate = self;
        self.manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;

    }
    return self;
}

- (void)startUpdatingLocation
{
    [self.manager startUpdatingLocation];
}

- (void)stopUpdatingLocation
{
    [self.manager stopUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [manager location];
    self.location = location;
    if (location.speed)
    {
        self.speed = location.speed * 3.6;
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

@end
