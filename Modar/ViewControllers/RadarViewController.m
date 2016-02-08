//
//  RadarViewController.m
//  Modar
//
//  Created by Cihan Emre Kisakurek (Company) on 08/02/16.
//  Copyright (c) 2016 cekisakurek. All rights reserved.
//

#import "RadarViewController.h"
#import "BLEDiscoveryViewController.h"
#import "MDLocationManager.h"
#import "MDBLEManager.h"
#import "MDAngleView.h"


@implementation RadarViewController


- (void)loadView
{
    [super loadView];
    
    MDAngleView *angleView = [[MDAngleView alloc] initWithFrame:CGRectMake(50, 150, 300, 150)];
    [angleView setAngle:20];
    [self.view addSubview:angleView];
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [MDBLEManager sharedManager];
    
    
    UIBarButtonItem *discoveryItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(presentDiscoveryViewController:)];
    
    self.navigationItem.rightBarButtonItem = discoveryItem;
    
}


- (void)presentDiscoveryViewController:(id)sender
{
    BLEDiscoveryViewController *viewController = [[BLEDiscoveryViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self.navigationController presentViewController:navigationController animated:YES completion:^{
        
    }];
}

@end
