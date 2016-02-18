//
//  MDWeatherManager.m
//  Modar
//
//  Created by Cihan Emre Kisakurek (Company) on 09/02/16.
//  Copyright (c) 2016 cekisakurek. All rights reserved.
//

#import "MDWeatherManager.h"

#define API_KEY @"2278d6fa561df6f1133dcbb5a4bfd72a"

@implementation MDWeatherManager

+ (instancetype)sharedManager
{
    static dispatch_once_t once;
    static MDWeatherManager *sharedFoo;
    dispatch_once(&once, ^ { sharedFoo = [[self alloc] init]; });
    return sharedFoo;
}

- (void)fetchWeatherWithLatitude:(double)latitude longitude:(double)longitude
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f&units=metric&lang=en&APPID=%@",latitude,longitude,API_KEY]];
    
    __weak MDWeatherManager *weakRef = self;
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                if (!error)
                {
                    NSError *parsingError;
                    NSDictionary *weather = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&parsingError];
                    if (!parsingError)
                    {
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            //If self.image is atomic (not declared with nonatomic)
                            // you could have set it directly above
                            for (NSDictionary *dict in weather[@"weather"]) {
                                weakRef.weatherIconURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png",dict[@"icon"]]];
                            }
                            weakRef.tempetureMin = [weather[@"main"][@"temp_min"] doubleValue];
                            weakRef.tempetureMax = [weather[@"main"][@"temp_max"] doubleValue];
                            weakRef.windSpeed = [weather[@"wind"][@"speed"] doubleValue];
                            weakRef.windDegree = [weather[@"wind"][@"deg"] doubleValue];
                            weakRef.rainVolume = [weather[@"rain"][@"3h"] doubleValue];
                        });
                    }
                }
                
            }] resume];
}


@end
