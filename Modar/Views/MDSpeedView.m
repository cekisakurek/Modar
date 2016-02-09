//
//  MDSpeedView.m
//  Modar
//
//  Created by Cihan Emre Kisakurek (Company) on 09/02/16.
//  Copyright (c) 2016 cekisakurek. All rights reserved.
//

#import "MDSpeedView.h"

@interface MDSpeedView ()
@property (strong) UILabel *speedLabel;
@end

@implementation MDSpeedView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.speedLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.speedLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.speedLabel.font = [UIFont systemFontOfSize:50];
        [self addSubview:self.speedLabel];
    }
    return self;
}


- (void)setSpeed:(double)speed
{
    _speed = speed;
    self.speedLabel.text = [NSString stringWithFormat:@"%@ : %.1f",NSLocalizedString(@"Speed", nil),_speed];
}



@end
