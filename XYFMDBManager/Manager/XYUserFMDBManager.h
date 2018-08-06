//
//  XYUserFMDBManager.h
//  XYFMDBManager
//
//  Created by htouhui on 2018/8/3.
//  Copyright © 2018年 htouhui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYUserFMDBManager : NSObject


#pragma mark - 创建表
/**
 创建表
 */
- (void)createDataTable;

#pragma mark - 插入数据
/**
 插入数据
 */
- (void)insertUserInfo;

#pragma mark - 更新数据
/**
 更新数据
 */
- (void)updateUserInfo;

#pragma mark - 查找数据
/**
 查找数据
 */
- (void)queryAllUserInfo;

#pragma mark - 删除数据
/**
 删除数据
 */
- (void)deleteUserInfo;

@end
