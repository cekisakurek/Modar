//
//  MDWeatherView.m
//  Modar
//
//  Created by Cihan Emre Kisakurek (Company) on 09/02/16.
//  Copyright (c) 2016 cekisakurek. All rights reserved.
//

#import "MDWeatherView.h"

@interface MDWeatherView ()

@property (strong) UILabel *weatherLabel;
@property (strong) UIImageView *weatherImageView;

@end

@implementation MDWeatherView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.weatherImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width - self.bounds.size.height, 0, self.bounds.size.height, self.bounds.size.height)];
        [self addSubview:self.weatherImageView];
        
        self.weatherLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width - self.bounds.size.height, self.bounds.size.height)];
        self.weatherLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.weatherLabel.font = [UIFont systemFontOfSize:50];
        [self addSubview:self.weatherLabel];
        
        
        
    }
    return self;
}

- (void)setWeather:(double)weather
{
    _weather = weather;
    int w = ceil(_weather);
    NSLog(@"w:%d",w);
    self.weatherLabel.text = [NSString stringWithFormat:@"%@ : %d",NSLocalizedString(@"Temp", nil),w];
    [self setNeedsDisplay];
}

- (void)setIconURL:(NSURL *)iconURL
{
    _iconURL = iconURL;
    
    __weak MDWeatherView *weakRef = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^{
                       NSData *imageData = [NSData dataWithContentsOfURL:iconURL];
                       
                       //This is your completion handler
                       dispatch_sync(dispatch_get_main_queue(), ^{
                           //If self.image is atomic (not declared with nonatomic)
                           // you could have set it directly above
                           weakRef.weatherImageView.image = [UIImage imageWithData:imageData];
                           
                       });
                   });
    
}

@end
