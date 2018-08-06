//
//  XYFMDBManager.m
//  XYFMDBManager
//
//  Created by htouhui on 2018/8/2.
//  Copyright © 2018年 htouhui. All rights reserved.
//

#import "XYFMDBManager.h"



#ifdef DEBUG
#define DBLog(...) NSLog(__VA_ARGS__)
#define DBMethod() NSLog(@"%s", __func__)
#else
#define DBLog(...)
#define DBMethod()
#endif

#define PATH_OF_DOCUMENT_FOLDER    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

@interface XYFMDBManager ()

@property (nonatomic, strong) FMDatabase *db; //!< 数据库

@end

@implementation XYFMDBManager


+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static XYFMDBManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [super allocWithZone:zone];
        [manager createDataBaseWithName:@"data.sqlite"];
    });
    
    return manager;
}

+ (instancetype)shareManager
{
    return [[self alloc] init];
}

#pragma mark - 创建数据库
- (void)createDataBaseWithName:(NSString *)dataBaseName
{
    NSString *path = [self pathOfDataBaseWithDataBaseName:[NSString stringWithFormat:@"%@",dataBaseName]];
    DBLog(@"path = %@", path);
    self.db = [FMDatabase databaseWithPath:path];
}

#pragma mark - 创建表
- (BOOL)createTableWithSql:(NSString *)sql
{
    if ([self.db open]) {
        BOOL result = [self.db executeUpdate:sql];
        if (result) {
            DBLog(@"数据表创建成功");
        }else
        {
            DBLog(@"数据表创建失败");
        }
        [self.db close];
        
        return result;
    }else
    {
        DBLog(@"数据库打开失败");
        return NO;
    }
}

#pragma mark - 添加数据
- (BOOL)insertDataWithSql:(NSString *)sql values:(NSArray *)values
{
    if ([self.db open]) {
        
        BOOL result = [self.db executeUpdate:sql withArgumentsInArray:values];
        
        if (result) {
            DBLog(@"插入数据成功");
        }else
        {
            DBLog(@"插入数据失败");
        }
        [self.db close];
        
        return result;
        
    }else
    {
        DBLog(@"数据库打开失败");
        return NO;
    }
}

#pragma mark - 更新数据
- (BOOL)updateDataWithSql:(NSString *)sql values:(NSArray *)values
{
    if ([self.db open]) {
        BOOL result = [self.db executeUpdate:sql withArgumentsInArray:values];
        if (result) {
            DBLog(@"更新数据成功");
        }else
        {
            DBLog(@"更新数据失败");
        }
        [self.db close];
        return result;
        
    }else
    {
        DBLog(@"数据库打开失败");
        return NO;
    }
}


#pragma mark - 删除数据
- (BOOL)deleteDataWithSql:(NSString *)sql values:(NSArray *)values
{
    if ([self.db open]) {
        BOOL result = [self.db executeUpdate:sql withArgumentsInArray:values];
        if (result) {
            DBLog(@"删除数据成功");
        }else
        {
            DBLog(@"删除数据失败");
        }
        [self.db close];
        
        return result;
        
    }else
    {
        DBLog(@"数据库打开失败");
        return NO;
    }
}

#pragma mark - 查找数据
- (BOOL)queryDataWithSql:(NSString *)sql values:(NSArray *)values completionBlock:(void (^)(FMResultSet *result))completionBlock
{
    if ([self.db open]) {
        FMResultSet *result = [self.db executeQuery:sql withArgumentsInArray:values];
        
        // 回调
        !completionBlock ? : completionBlock(result);
        
        [self.db close];

        return YES;
    }else
    {
        DBLog(@"数据库打开失败");
        return NO;
    }
}

#pragma mark - 根据条件查找数据是否存在
- (BOOL)itemDataIsExistsWithTableName:(NSString *)tableName primaryKey:(NSString *)primaryKey values:(NSArray *)values completionBlock:(void (^)(FMResultSet *result))completionBlock

{
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where %@ = ?",tableName,primaryKey];
    if ([self.db open]) {
        FMResultSet *result = [self.db executeQuery:sql withArgumentsInArray:values];
        
        // 回调
        !completionBlock ? : completionBlock(result);
        
        NSMutableArray *arr = @[].mutableCopy;
        while ([result next]) {
            NSString *value = [result stringForColumn:primaryKey];
            [arr addObject:value];
        }
        [self.db close];
        
        if (arr.count > 0) {
            return YES;
        }else
        {
            return NO;
        }
        
    }else
    {
        DBLog(@"数据库打开失败");
        return NO;
    }
}

#pragma mark - 判断数据库是否已经创建
- (BOOL)dateBaseIsExistsWithDataBaseName:(NSString *)dataBaseName
{
    
    NSString * path = [self pathOfDataBaseWithDataBaseName:[NSString stringWithFormat:@"%@.sqlite",dataBaseName]];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        return NO;
    }else{
        return YES;
    }
}

#pragma mark - 获取路径
- (NSString *)pathOfDataBaseWithDataBaseName:(NSString *)dataBaseName
{
    NSString * doc = PATH_OF_DOCUMENT_FOLDER;
    NSString * path = [doc stringByAppendingPathComponent:dataBaseName];
    return path;
}

@end
