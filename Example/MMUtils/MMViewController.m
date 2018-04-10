//
//  MMViewController.m
//  MMUtils
//
//  Created by anotherchase@gmail.com on 04/09/2018.
//  Copyright (c) 2018 anotherchase@gmail.com. All rights reserved.
//

#import "MMViewController.h"
#import <MMUtils/MMReachabilityHelper.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface MMViewController ()

@property (nonatomic, strong) UILabel *statusLabel;

@end

@implementation MMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 100) / 2.0, 100, 100, 100)];
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.statusLabel];
    
    RAC(self.statusLabel, text) = [RACObserve(ReachabilityHelper, networkStatus) map:^(NSNumber *networkStatus) {
        return networkStatus.integerValue == NotReachable ? @"无网络" : @"有网络";
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
