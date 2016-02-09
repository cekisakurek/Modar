//
//  MDWeatherManager.h
//  Modar
//
//  Created by Cihan Emre Kisakurek (Company) on 09/02/16.
//  Copyright (c) 2016 cekisakurek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDWeatherManager : NSObject

+ (instancetype)sharedManager;

@property (strong) NSURL *weatherIconURL;
@property (assign) double tempetureMin;
@property (assign) double tempetureMax;

@property (assign) double windSpeed;
@property (assign) double windDegree;

@property (assign) double rainVolume;

- (void)fetchWeatherWithLatitude:(double)latitude longitude:(double)longitude;

@end
