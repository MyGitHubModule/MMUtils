//
//  MMReachabilityHelper.m
//  MMUtils_Example
//
//  Created by chenjb on 2018/4/10.
//  Copyright © 2018年 anotherchase@gmail.com. All rights reserved.
//

#import "MMReachabilityHelper.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface MMReachabilityHelper ()

@property (nonatomic, strong) Reachability *reachability;
@property (nonatomic, assign, readwrite) NetworkStatus networkStatus;

@end

@implementation MMReachabilityHelper

+ (void)load {
    [MMReachabilityHelper sharedInstance];
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static MMReachabilityHelper *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self startMonitoring];
    }
    return self;
}

// 监听网络状态的变化
- (void)startMonitoring {
    self.reachability = Reachability.reachabilityForInternetConnection;
    
    RAC(self, networkStatus) = [[[[[NSNotificationCenter defaultCenter]
                                   rac_addObserverForName:kReachabilityChangedNotification object:nil]
                                  map:^(NSNotification *notification) {
                                      return @([notification.object currentReachabilityStatus]);
                                  }]
                                 startWith:@(self.reachability.currentReachabilityStatus)]
                                distinctUntilChanged];
    
    @weakify(self)
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @strongify(self)
        [self.reachability startNotifier];
    });
}

@end
