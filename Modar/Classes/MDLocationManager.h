//
//  MDLocationManager.h
//  Modar
//
//  Created by Cihan Emre Kisakurek (Company) on 08/02/16.
//  Copyright (c) 2016 cekisakurek. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@interface MDLocationManager : NSObject

@property (assign) double speed; // in kilometer per hour
@property (strong) CLLocation *location;

@end
