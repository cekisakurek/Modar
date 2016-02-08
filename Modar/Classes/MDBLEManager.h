//
//  MDBLEManager.h
//  Modar
//
//  Created by Cihan Emre Kisakurek (Company) on 08/02/16.
//  Copyright (c) 2016 cekisakurek. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreBluetooth;

@interface MDBLEManager : NSObject

@property (strong) NSMutableSet *peripherals;

@end


@interface MDBLELidarSensor : NSObject 

@property (assign,getter=isConnected) BOOL connected;

@property (assign) double distance;

@end