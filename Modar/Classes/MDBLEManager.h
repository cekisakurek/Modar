//
//  MDBLEManager.h
//  Modar
//
//  Created by Cihan Emre Kisakurek (Company) on 08/02/16.
//  Copyright (c) 2016 cekisakurek. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreBluetooth;

@class MDBLELidarSensor;

@interface MDBLEManager : NSObject

@property (strong) NSMutableSet *discoveredPeripherals;
@property (strong) NSMutableSet *connectedPeripherals;

+ (instancetype)sharedManager;
- (void)startScanning;

- (void)connectToSensor:(MDBLELidarSensor *)sensor;

@end


@interface MDBLELidarSensor : NSObject 

@property (assign,getter=isConnected) BOOL connected;

@property (assign) double distance;

- (NSString *)name;

@end