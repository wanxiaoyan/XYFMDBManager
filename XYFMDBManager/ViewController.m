//
//  ViewController.m
//  XYFMDBManager
//
//  Created by htouhui on 2018/8/2.
//  Copyright © 2018年 htouhui. All rights reserved.
//

#import "ViewController.h"
#import "XYUserFMDBManager.h"

@interface ViewController ()

@property (nonatomic, strong) XYUserFMDBManager *userDBManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userDBManager = [[XYUserFMDBManager alloc] init];
    // 建表
    [self.userDBManager createDataTable];
    
    [self normalOperationDB];
    
    [self multhreadOperationDB];

}

#pragma mark - 正常操作数据库
- (void)normalOperationDB
{
    self.userDBManager = [[XYUserFMDBManager alloc] init];
    // 建表
    [self.userDBManager createDataTable];
    
    // 插入数据
    [self.userDBManager insertUserInfo];

    // 更新数据
    [self.userDBManager updateUserInfo];
    
    // 查找数据
    [self.userDBManager queryAllUserInfo];
    
    // 删除数据
    [self.userDBManager deleteUserInfo];
}

#pragma mark - 多线程操作数据库
- (void)multhreadOperationDB
{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_async(group, queue, ^{
        [self.userDBManager insertUserInfoByMulThreadWithValues:@[@100,@"李四100",@26]];
    });
    
    dispatch_group_async(group, queue, ^{
        [self.userDBManager insertUserInfoByMulThreadWithValues:@[@101,@"李四101",@26]];
    });
    dispatch_group_async(group, queue, ^{
        [self.userDBManager insertUserInfoByMulThreadWithValues:@[@102,@"李四103",@26]];
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self.userDBManager queryAllUserInfo];
    });
}


@end
