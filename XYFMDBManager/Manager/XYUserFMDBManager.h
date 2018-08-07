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


#pragma mark - 多线插入数据

/**
 多线插入数据
 */
- (void)insertUserInfoByMulThreadWithValues:(NSArray *)values;

#pragma mark - 多线更新数据

/**
 多线更新数据
 */
- (void)updateUserInfoByMulThreadWithValues:(NSArray *)values;


#pragma mark - 多线程删除数据
/**
 多线程删除数据
 */
- (void)deleteUserInfoByMulThreadWithValues:(NSArray *)values;


@end
