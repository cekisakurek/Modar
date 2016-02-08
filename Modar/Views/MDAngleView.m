//
//  MDAngleView.m
//  Modar
//
//  Created by Cihan Emre Kisakurek (Company) on 08/02/16.
//  Copyright (c) 2016 cekisakurek. All rights reserved.
//

#import "MDAngleView.h"

/** Degrees to Radian **/
#define degreesToRadians( degrees ) ( ( degrees ) / 180.0 * M_PI )

/** Radians to Degrees **/
#define radiansToDegrees( radians ) ( ( radians ) * ( 180.0 / M_PI ) )

@import CoreGraphics;

@interface MDAngleView ()

@property (strong) UIView *angleView;

@end

@implementation MDAngleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
        
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 2)];
        bottomView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        bottomView.backgroundColor = [UIColor redColor];
        [self addSubview:bottomView];
        
        self.angleView = bottomView;
        
        UIView *angleView = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.size.width/2.0, 0, 2, self.bounds.size.height)];
        angleView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        angleView.backgroundColor = [UIColor blackColor];
        [self addSubview:angleView];
    }
    return self;
}

- (void)setAngle:(double)angle
{
    _angle = angle;
    self.angleView.transform = CGAffineTransformMakeRotation(degreesToRadians(_angle));
    [self setNeedsDisplay];
    
}


@end
