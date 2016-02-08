//
//  BLEDiscoveryViewController.m
//  Modar
//
//  Created by Cihan Emre Kisakurek (Company) on 08/02/16.
//  Copyright (c) 2016 cekisakurek. All rights reserved.
//

#import "BLEDiscoveryViewController.h"
#import "MDBLEManager.h"

@implementation BLEDiscoveryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(selectionDone:)];
    
    self.navigationItem.rightBarButtonItem = doneItem;
}


- (void)selectionDone:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[MDBLEManager sharedManager] peripherals] count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    
    MDBLELidarSensor *sensor = [[[MDBLEManager sharedManager]peripherals] allObjects][indexPath.row];
    cell.textLabel.text = sensor.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MDBLELidarSensor *sensor = [[[MDBLEManager sharedManager]peripherals] allObjects][indexPath.row];
    [[MDBLEManager sharedManager] connectToSensor:sensor];
}

@end
