//
//  MDBLEManager.m
//  Modar
//
//  Created by Cihan Emre Kisakurek (Company) on 08/02/16.
//  Copyright (c) 2016 cekisakurek. All rights reserved.
//

#import "MDBLEManager.h"

#define RWT_BLE_SERVICE_UUID		[CBUUID UUIDWithString:@"B8E06067-62AD-41BA-9231-206AE80AB550"]
#define RWT_POSITION_CHAR_UUID		[CBUUID UUIDWithString:@"BF45E40A-DE2A-4BC8-BBA0-E5D6065F1B4B"]


@interface MDBLELidarSensor () <CBPeripheralDelegate>

@property (strong,nonatomic)CBPeripheral *peripheral;
@property (strong, nonatomic) CBCharacteristic *characteristic;

+ (instancetype)sensorWithPeripheral:(CBPeripheral *)peripheral;

@end


@interface MDBLEManager ()<CBCentralManagerDelegate>

@property (strong, nonatomic) CBCentralManager *centralManager;

@end

@implementation MDBLEManager


+ (instancetype)sharedManager
{
    static dispatch_once_t once;
    static MDBLEManager *sharedFoo;
    dispatch_once(&once, ^ { sharedFoo = [[self alloc] init]; });
    return sharedFoo;
}


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        dispatch_queue_t centralQueue = dispatch_queue_create("com.cekisakurek", DISPATCH_QUEUE_SERIAL);
        self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:centralQueue];
        self.peripherals = [NSMutableSet set];
    }
    return self;
}

- (void)startScanning
{
    [self.centralManager scanForPeripheralsWithServices:@[RWT_BLE_SERVICE_UUID] options:nil];
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    
    MDBLELidarSensor *sensor = [MDBLELidarSensor sensorWithPeripheral:peripheral];
    [self.peripherals addObject:sensor];
    
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
    switch (self.centralManager.state) {
        case CBCentralManagerStatePoweredOff:
        {
//            [self clearDevices];
            
            break;
        }
            
        case CBCentralManagerStateUnauthorized:
        {
            // Indicate to user that the iOS device does not support BLE.
            break;
        }
            
        case CBCentralManagerStateUnknown:
        {
            // Wait for another event
            break;
        }
            
        case CBCentralManagerStatePoweredOn:
        {
//            [self startScanning];
            
            break;
        }
            
        case CBCentralManagerStateResetting:
        {
//            [self clearDevices];
            break;
        }
            
        case CBCentralManagerStateUnsupported:
        {
            break;
        }
            
        default:
            break;
    }
    
}


@end


@implementation MDBLELidarSensor

+ (instancetype)sensorWithPeripheral:(CBPeripheral *)peripheral
{
    MDBLELidarSensor *sensor = [[MDBLELidarSensor alloc] init];
    sensor.peripheral = peripheral;
    peripheral.delegate = sensor;
    return sensor;
}

- (void)startDiscoveringServices
{
    [self.peripheral discoverServices:@[RWT_BLE_SERVICE_UUID]];
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    NSArray *services = nil;
    NSArray *uuidsForBTService = @[RWT_POSITION_CHAR_UUID];
    
    if (peripheral != self.peripheral) {
        //NSLog(@"Wrong Peripheral.\n");
        return ;
    }
    
    if (error != nil) {
        //NSLog(@"Error %@\n", error);
        return ;
    }
    
    services = [peripheral services];
    if (!services || ![services count]) {
        //NSLog(@"No Services");
        return ;
    }
    
    for (CBService *service in services) {
        if ([[service UUID] isEqual:RWT_BLE_SERVICE_UUID]) {
            [peripheral discoverCharacteristics:uuidsForBTService forService:service];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    NSArray     *characteristics    = [service characteristics];
    
    if (peripheral != self.peripheral) {
        //NSLog(@"Wrong Peripheral.\n");
        return ;
    }
    
    if (error != nil) {
        //NSLog(@"Error %@\n", error);
        return ;
    }
    
    for (CBCharacteristic *characteristic in characteristics) {
        if ([[characteristic UUID] isEqual:RWT_POSITION_CHAR_UUID]) {
            self.characteristic = characteristic;
            self.connected = YES;
        }
    }

}

@end