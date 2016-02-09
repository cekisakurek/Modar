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
#import "MDMotionManager.h"
#import "MDAngleView.h"
#import "FBKVOController.h"
#import "MDSpeedView.h"
#import "MDDistanceView.h"
#import "MDWeatherManager.h"
#import "MDWeatherView.h"

@interface RadarViewController ()
@property (strong) FBKVOController *KVOController;
@end

@implementation RadarViewController



- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.KVOController = [FBKVOController controllerWithObserver:self];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    MDSpeedView *speedView = [[MDSpeedView alloc] initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, 100)];
    [self.view addSubview:speedView];
    
    MDDistanceView *distanceView = [[MDDistanceView alloc] initWithFrame:CGRectMake(0, 150, self.view.bounds.size.width, 100)];
    [self.view addSubview:distanceView];

    MDWeatherView *weatherView = [[MDWeatherView alloc] initWithFrame:CGRectMake(0, 260, self.view.bounds.size.width, 100)];
    [self.view addSubview:weatherView];
    
    
    MDAngleView *angleView = [[MDAngleView alloc] initWithFrame:CGRectMake(50, 370, 300, 150)];
    [self.view addSubview:angleView];
    
    [self.KVOController observe:[MDMotionManager sharedManager] keyPath:@"angle" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew block:^(RadarViewController *weakRef, MDMotionManager *motionManager, NSDictionary *change) {
        
        angleView.angle = motionManager.angle;
    }];
    
    [self.KVOController observe:[MDLocationManager sharedManager] keyPath:@"speed" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew block:^(RadarViewController *weakRef, MDLocationManager *locationManager, NSDictionary *change) {
        speedView.speed = locationManager.speed;
    }];
    
    [self.KVOController observe:[MDLocationManager sharedManager] keyPath:@"stoppingDistance" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew block:^(RadarViewController *weakRef, MDLocationManager *locationManager, NSDictionary *change) {
        distanceView.distance = locationManager.stoppingDistance;
    }];
    
    [self.KVOController observe:[MDWeatherManager sharedManager] keyPath:@"tempetureMax" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew block:^(RadarViewController *weakRef, MDWeatherManager *weatherManager, NSDictionary *change) {
        
        weatherView.weather = weatherManager.tempetureMax;
        weatherView.iconURL = weatherManager.weatherIconURL;

        
    }];
 
    //
    
    [[MDWeatherManager sharedManager] fetchWeatherWithLatitude:52.509441 longitude:13.378927];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [MDBLEManager sharedManager];
    [[MDMotionManager sharedManager] startUpdating];
    
    
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
