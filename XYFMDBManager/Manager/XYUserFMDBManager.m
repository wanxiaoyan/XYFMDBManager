//
//  XYUserFMDBManager.m
//  XYFMDBManager
//
//  Created by htouhui on 2018/8/3.
//  Copyright © 2018年 htouhui. All rights reserved.
//

#import "XYUserFMDBManager.h"
#import "XYFMDBManager.h"
#import "User.h"

static NSString *const kCREATETABLE = @"create table if not exists user_table  ('user_id' INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT NOT NULL,age INTEGER NOT NULL)"; //!< 创建用户表
static NSString *const kINSERTUSERINFO = @"insert into user_table (user_id,name,age) values(?,?,?)"; //!< 插入用户信息
static NSString *const kUPDATEUSERINFO = @"update user_table set name = ?,age = ? where user_id = ?"; //!< 更新用户信息
static NSString *const kUPDATEUSERINFO_KEY = @"update user_table set age = ? where user_id = ?"; //!< 更新用户具体的信息
static NSString *const kSELECTALLUSERINFO = @"select * from user_table"; //!< 查询所有用户信息
static NSString *const kDELETEUSERINFO = @"delete from user_table where user_id = ?"; //!< 删除用户信息

@interface XYUserFMDBManager ()

@end


@implementation XYUserFMDBManager


#pragma mark - 创建表
- (void)createDataTable
{
    NSString *sql = kCREATETABLE;
    [[XYFMDBManager shareManager] createTableWithSql:sql];
}

#pragma mark - 插入数据
- (void)insertUserInfo
{
    for (int i = 0; i < 5; i++) {
        NSString *sql = kINSERTUSERINFO;
        NSArray *values = @[@(i),[NSString stringWithFormat:@"张三 %d",i + 1], @(20 + i)];
        
        if ([[XYFMDBManager shareManager] itemDataIsExistsWithTableName:@"user_table" primaryKey:@"user_id" values:@[@(i)] completionBlock:nil]) {
            // 存在  更新
            values = @[[NSString stringWithFormat:@"张三 %d",i + 1], @(20 + i),@(i)];
            sql = kUPDATEUSERINFO;
            [[XYFMDBManager shareManager] updateDataWithSql:sql values:values];
        }else
        {
            // 不存在 插入
            [[XYFMDBManager shareManager] insertDataWithSql:sql values:values];
        }
        
    }
}

#pragma mark - 更新数据
- (void)updateUserInfo
{
    NSString *sql = kUPDATEUSERINFO_KEY;
    NSArray *values = @[@(100),@(0)];
    
    [[XYFMDBManager shareManager] updateDataWithSql:sql values:values];
}

#pragma mark - 查找数据
- (void)queryAllUserInfo
{
    NSMutableArray *dataArr = @[].mutableCopy;
    NSString *sql = kSELECTALLUSERINFO;
    [[XYFMDBManager shareManager] queryDataWithSql:sql values:@[] completionBlock:^(FMResultSet *result) {
        while ([result next]) {
            User *user = [[User alloc] init];
            user.user_id = [result intForColumn:@"user_id"];
            user.name = [result stringForColumn:@"name"];
            user.age = [result intForColumn:@"age"];
            [dataArr addObject:user];
        }
        
        NSLog(@"dataArr.count = %ld",dataArr.count);
    }];
}

#pragma mark - 删除数据
- (void)deleteUserInfo
{
    NSString *sql = kDELETEUSERINFO;
    NSArray *values = @[@"4"];
    
    [[XYFMDBManager shareManager] deleteDataWithSql:sql values:values];
}


@end
