//
//  DBAccess.m
//  成都生活
//
//  Created by juju on 2017/3/13.
//  Copyright © 2017年 刘晓微. All rights reserved.
//

#import "DBAccess.h"

sqlite3 *database;
@implementation DBAccess

+ (sqlite3 *)initializeDatabase {
    
    if (!database) {
        //获取document路径
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        //获取数据库文件路径
        NSString *dbpath = [docPath stringByAppendingPathComponent:@"PersonInfo.db"];
        //管理文件的类
        NSFileManager *fm = [NSFileManager defaultManager];
        //判断document是否有这个文件
        if (![fm fileExistsAtPath:dbpath]) {
            NSString *boundlePath = [[NSBundle mainBundle] pathForResource:@"PersonInfo" ofType:@"db"];
            NSError *error = nil;
            BOOL result = [fm copyItemAtPath:boundlePath toPath:dbpath error:&error];
            if (!result) {
                NSLog(@"错啦：%@", error);
            }
        }
        NSLog(@"文件在哪里呢：%@", dbpath);
        sqlite3_open([dbpath UTF8String], &database);
    }
    return database;
    
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"PersonInfo" ofType:@"db"];
//    
//    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
//        NSLog(@"Opening Database");
//    }else {
//        sqlite3_close(database);
//        NSAssert1(0, @"Failed to open database '%s'.", sqlite3_errmsg(database));
//    }
}

+ (void)closeDatabase {
    
    sqlite3_close(database);
    database = nil;
    if (sqlite3_close(database) != SQLITE_OK) {
        NSAssert1(0, @"Failed to close database '%s'.", sqlite3_errmsg(database));
    }
}

/**
- (NSMutableArray *)getAllUsers {
    NSMutableArray *users = [[NSMutableArray alloc] init];
    const char *sql = "SELECT USER.NAME, USER.PASSWORD, USER.PHONENUMBER FROM USER";
    sqlite3_stmt *statement;
    int sqlResult = sqlite3_prepare_v2(database, sql, -1, &statement, NULL);
    if (sqlResult == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            User *user = [[User alloc] init];
            char *name = (char *)sqlite3_column_text(statement, 1);
            char *password = (char *)sqlite3_column_text(statement, 2);
            int phoneNumber = sqlite3_column_int(statement, 0);
            
            user.name = name ? [NSString stringWithUTF8String:name] : @"";
            user.password = password ? [NSString stringWithUTF8String:password] : @"";
            user.phoneNumber = phoneNumber;
            
            [users addObject:user];
        }
        sqlite3_finalize(statement);
    }else {
        NSLog(@"Problem with the database");
        NSLog(@"%d", sqlResult);
    }
    return users;
}

- (void)createEditableDatabase:(int)phoneNumber name:(NSString *)name password:(NSString *)password {
    BOOL success;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"%@",paths);
    NSString *documentDir = [paths objectAtIndex:0];
    NSString *writableDatabase = [documentDir stringByAppendingString:@"PersonInfo.db"];
    success = [fileManager fileExistsAtPath:writableDatabase];
    if (success) {
        return;
    }
    NSString *defaultPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"PersonInfo.db"];
    success = [fileManager copyItemAtPath:defaultPath toPath:writableDatabase error:&error];
    if (!success) {
        NSAssert1(0, @"Failed to create writable database file: '%@'", [error localizedDescription]);
    }
//    NSString *sql = [NSString stringWithFormat:@"INSERT INTO USER('PHONENUMBER', 'Name', 'PASSWORD') VALUES('%d', '%@', '%@')", phoneNumber, name, password];
//    char *err = NULL;
//    sqlite3_open([writableDatabase UTF8String], &database);
//    int result = sqlite3_exec(database, sql.UTF8String, NULL, NULL, &err);
//    if (result == SQLITE_OK) {
//        NSLog(@"添加数据成功");
//    }else {
//        NSLog(@"添加数据失败%s",err);
//    }
}
 
 **/
@end
