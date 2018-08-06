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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XYUserFMDBManager *userManage = [[XYUserFMDBManager alloc] init];
    // 建表
    [userManage createDataTable];
    
    // 插入数据
    [userManage insertUserInfo];
    
    // 更新数据
    [userManage updateUserInfo];
    
    // 查找数据
    [userManage queryAllUserInfo];
    
    // 删除数据
    [userManage deleteUserInfo];

}


@end
