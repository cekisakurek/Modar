//
//  MDMotionManager.m
//  Modar
//
//  Created by Cihan Emre Kisakurek (Company) on 08/02/16.
//  Copyright (c) 2016 cekisakurek. All rights reserved.
//

#import "MDMotionManager.h"

@interface MDMotionManager ()

@property (strong) CMMotionManager *motionManager;

@end

@implementation MDMotionManager

+ (instancetype)sharedManager
{
    static dispatch_once_t once;
    static MDMotionManager *sharedFoo;
    dispatch_once(&once, ^ { sharedFoo = [[self alloc] init]; });
    return sharedFoo;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.motionManager = [[CMMotionManager alloc] init];
    }
    return self;
}

- (void)startUpdating
{
    if (self.motionManager.deviceMotionAvailable) {
        
        self.motionManager.deviceMotionUpdateInterval = 0.1;
        
        // For use in the montionManager's handler to prevent strong reference cycle
        __weak typeof(self) weakSelf = self;
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [self.motionManager startDeviceMotionUpdatesToQueue:queue
                                                withHandler:^(CMDeviceMotion *motion, NSError *error) {
                                                    
                                                    // Get the attitude of the device
                                                    //CMAttitude *attitude = motion.attitude;
                                                    
                                                    // Get the pitch (in radians) and convert to degrees.
//                                                    NSLog(@"%f", attitude.pitch * 180.0/M_PI);
//                                                    weakSelf.angle = attitude.pitch * 180.0/M_PI;
                                                    double rotation = atan2(motion.gravity.x, motion.gravity.y) - M_PI;
                                                    //weakSelf.angle = attitude.pitch * 180.0/M_PI;
                                                    weakSelf.angle = rotation;
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        // Update some UI
                                                    });
                                                    
                                                }];
        
        NSLog(@"Device motion started");
    }
    else {
        NSLog(@"Device motion unavailable");
    }
}

- (void)stopUpdating
{
    [self.motionManager stopDeviceMotionUpdates];
}

@end
