//
//  MMReachabilityHelper.h
//  MMUtils_Example
//
//  Created by chenjb on 2018/4/10.
//  Copyright © 2018年 anotherchase@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Reachability/Reachability.h>

#define ReachabilityHelper [MMReachabilityHelper sharedInstance]

/**
 网络状态监听工具类
 */
@interface MMReachabilityHelper : NSObject

@property (nonatomic, assign, readonly) NetworkStatus networkStatus;

// 返回一个单例
+ (instancetype)sharedInstance;

@end
