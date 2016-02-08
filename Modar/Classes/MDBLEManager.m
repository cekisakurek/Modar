//
//  MDBLEManager.m
//  Modar
//
//  Created by Cihan Emre Kisakurek (Company) on 08/02/16.
//  Copyright (c) 2016 cekisakurek. All rights reserved.
//

#import "MDBLEManager.h"

#define RWT_BLE_SERVICE_UUID		[CBUUID UUIDWithString:@"6E400001-B5A3-F393-E0A9-E50E24DCCA9E"]
#define RWT_POSITION_CHAR_UUID		[CBUUID UUIDWithString:@"BF45E40A-DE2A-4BC8-BBA0-E5D6065F1B4B"]


@interface MDBLELidarSensor () <CBPeripheralDelegate>

@property (strong,nonatomic)CBPeripheral *peripheral;
@property (strong, nonatomic) CBCharacteristic *characteristic;

+ (instancetype)sensorWithPeripheral:(CBPeripheral *)peripheral;
- (void)startDiscoveringServices;
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

- (void)connectToSensor:(MDBLELidarSensor *)sensor
{
    [self.centralManager connectPeripheral:sensor.peripheral options:nil];
}

- (void)startScanning
{
    [self.centralManager scanForPeripheralsWithServices:nil options:nil];
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    
    MDBLELidarSensor *sensor = [MDBLELidarSensor sensorWithPeripheral:peripheral];
    [self.peripherals addObject:sensor];
    
    
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"connected:%@",peripheral);
    for (MDBLELidarSensor *sensor in self.peripherals) {
        if ([sensor.peripheral isEqual:peripheral]) {
            [sensor startDiscoveringServices];
        }
    }
    
    
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"disconnected:%@",peripheral);
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
            [self startScanning];
            
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


- (NSString *)name
{
    return self.peripheral.name;
}

+ (instancetype)sensorWithPeripheral:(CBPeripheral *)peripheral
{
    MDBLELidarSensor *sensor = [[MDBLELidarSensor alloc] init];
    sensor.peripheral = peripheral;
    peripheral.delegate = sensor;
    return sensor;
}

- (void)startDiscoveringServices
{
    [self.peripheral discoverServices:nil];
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
        [peripheral discoverCharacteristics:uuidsForBTService forService:service];

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
//        self.characteristic = characteristic;
//        self.connected = YES;
        [peripheral setNotifyValue:YES forCharacteristic:characteristic];
    }

}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error
{
    NSLog(@"%@ %@ %@",peripheral,characteristic,characteristic.value);
//    [peripheral readValueForCharacteristic:characteristic];
}

@end