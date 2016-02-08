//
//  BLEDiscoveryViewController.m
//  Modar
//
//  Created by Cihan Emre Kisakurek (Company) on 08/02/16.
//  Copyright (c) 2016 cekisakurek. All rights reserved.
//

#import "BLEDiscoveryViewController.h"

@implementation BLEDiscoveryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(selectionDone:)];
    
    self.navigationItem.rightBarButtonItem = doneItem;
}


- (void)selectionDone:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
