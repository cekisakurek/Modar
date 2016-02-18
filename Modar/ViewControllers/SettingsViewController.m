//
//  SettingsViewController.m
//  Modar
//
//  Created by Cihan Emre Kisakurek (Company) on 09/02/16.
//  Copyright (c) 2016 cekisakurek. All rights reserved.
//

#import "SettingsViewController.h"
#import "BLEDiscoveryViewController.h"
@interface SettingsViewController ()
@property (strong) NSArray *options;
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.options = @[NSLocalizedString(@"Pairing", nil),
                     NSLocalizedString(@"Weather Tracking enabled", nil),
                     NSLocalizedString(@"Location Tracking enabled", nil),
                     NSLocalizedString(@"Friction Multiplier", nil),
                     NSLocalizedString(@"Help", nil)];
    
    
    // pair
    // weather
    // location
    // help
    
    // enable motion for angle
    //
    
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.options.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    NSString *option = self.options[indexPath.row];
    cell.textLabel.text = option;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        BLEDiscoveryViewController *viewController = [[BLEDiscoveryViewController alloc] initWithStyle:UITableViewStylePlain];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end
