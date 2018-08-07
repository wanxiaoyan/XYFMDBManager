//
//  XYFMDBManager.h
//  XYFMDBManager
//
//  Created by htouhui on 2018/8/2.
//  Copyright © 2018年 htouhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface XYFMDBManager : NSObject

+ (instancetype)shareManager;

#pragma mark - 创建表
/**
 创建表
 */
- (BOOL)createTableWithSql:(NSString *)sql;

#pragma mark - 添加数据
/**
 添加数据
 */
- (BOOL)insertDataWithSql:(NSString *)sql values:(NSArray *)values;

#pragma mark - 更新数据
/**
 更新数据
 */
- (BOOL)updateDataWithSql:(NSString *)sql values:(NSArray *)values;

#pragma mark - 删除数据
/**
 删除数据
 */
- (BOOL)deleteDataWithSql:(NSString *)sql values:(NSArray *)values;


#pragma mark - 查找数据
/**
 查找数据
 */
- (BOOL)queryDataWithSql:(NSString *)sql values:(NSArray *)values completionBlock:(void (^)(FMResultSet *result))completionBlock;

#pragma mark - 根据条件查找数据是否存在
/**
 根据条件查找数据是否存在
 */
- (BOOL)itemDataIsExistsWithTableName:(NSString *)tableName primaryKey:(NSString *)primaryKey values:(NSArray *)values completionBlock:(void (^)(FMResultSet *result))completionBlock;



#pragma mark - 多线程插入数据
/**
 多线程插入数据
 */
- (BOOL)insertDataByMulThreadWithSql:(NSString *)sql values:(NSArray *)values;

#pragma mark - 多线程更新数据
/**
 多线程更新数据
 */
- (BOOL)updateDataByMulThreadWithSql:(NSString *)sql values:(NSArray *)values;

#pragma mark - 多线程删除数据
/**
 多线程删除数据
 */
- (BOOL)deleteDataByMulThreadWithSql:(NSString *)sql values:(NSArray *)values;


/**
 多线程根据条件查找数据是否存在

 */
- (BOOL)itemDataIsExistsByMulThreadWithTableName:(NSString *)tableName primaryKey:(NSString *)primaryKey values:(NSArray *)values completionBlock:(void (^)(FMResultSet *result))completionBlock;




@end
