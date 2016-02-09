//
//  MDDistanceView.m
//  Modar
//
//  Created by Cihan Emre Kisakurek (Company) on 09/02/16.
//  Copyright (c) 2016 cekisakurek. All rights reserved.
//

#import "MDDistanceView.h"

@interface MDDistanceView ()
@property (strong) UILabel *distanceLabel;
@end

@implementation MDDistanceView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.distanceLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.distanceLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.distanceLabel.font = [UIFont systemFontOfSize:50];
        [self addSubview:self.distanceLabel];
    }
    return self;
}

- (void)setDistance:(double)distance
{
    _distance = distance;
    self.distanceLabel.text = [NSString stringWithFormat:@"%@ : %.1f",NSLocalizedString(@"Distance", nil),_distance];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
