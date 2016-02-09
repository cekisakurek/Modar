//
//  MDWeatherView.h
//  Modar
//
//  Created by Cihan Emre Kisakurek (Company) on 09/02/16.
//  Copyright (c) 2016 cekisakurek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDWeatherView : UIView

@property (assign,nonatomic) double weather;
@property (strong,nonatomic) NSURL *iconURL;

@end
