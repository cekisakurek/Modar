//
//  MDMotionManager.h
//  Modar
//
//  Created by Cihan Emre Kisakurek (Company) on 08/02/16.
//  Copyright (c) 2016 cekisakurek. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreMotion;

@interface MDMotionManager : NSObject

@property (assign) double angle;

+ (instancetype)sharedManager;

- (void)startUpdating;

@end
