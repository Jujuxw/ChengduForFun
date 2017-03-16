//
//  DatabaseHelper.m
//  成都生活
//
//  Created by juju on 2017/3/14.
//  Copyright © 2017年 刘晓微. All rights reserved.
//

#import "DatabaseHelper.h"

@implementation DatabaseHelper

+ (NSMutableArray *)getAllUsers {
    
    sqlite3 *db = [DBAccess initializeDatabase];
    sqlite3_stmt *stmt = nil;
    char *sql = "SELECT * FROM USER";
    int result = sqlite3_prepare_v2(db, sql, -1, &stmt, NULL);
    
    NSMutableArray *userArr = [NSMutableArray array];
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            char *phoneNumber = (char *)sqlite3_column_text(stmt, 0);
            char *name = (char *)sqlite3_column_text(stmt, 1);
            char *password = (char *)sqlite3_column_text(stmt, 2);
            
            User *user = [[User alloc] init];
            user.phoneNumber = phoneNumber ? [NSString stringWithUTF8String:phoneNumber] : @"";
            user.name = name ? [NSString stringWithUTF8String:name] : @"";
            user.password = password ? [NSString stringWithUTF8String:password] : @"";
            
            [userArr addObject:user];
        }
    }
    //释放stmt指针
    sqlite3_finalize(stmt);
    //关闭数据库
    [DBAccess closeDatabase];
    return userArr;
}

+ (BOOL)insertUser:(User *)user {
    sqlite3 *db = [DBAccess initializeDatabase];
    sqlite3_stmt *stmt = nil;
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO USER ('PHONENUMBER', 'Name', 'PASSWORD') VALUES ('%@', '%@', '%@')", user.phoneNumber, user.name, user.password];
    
//    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
//    char *error = NULL;
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        if (sqlite3_step(stmt) == SQLITE_DONE) {
            sqlite3_finalize(stmt);
            [DBAccess closeDatabase];
            return YES;
        }
    }
    sqlite3_finalize(stmt);
    [DBAccess closeDatabase];
    return NO;
}

@end
