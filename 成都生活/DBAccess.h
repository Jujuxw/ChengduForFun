//
//  DBAccess.h
//  成都生活
//
//  Created by juju on 2017/3/13.
//  Copyright © 2017年 刘晓微. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "User.h"
@interface DBAccess : NSObject

//- (NSMutableArray *)getAllUsers;
+ (void)closeDatabase;
+ (sqlite3 *)initializeDatabase;
//- (void)createEditableDatabase:(int)phoneNumber name:(NSString *)name password:(NSString *)password;
//- (void)insertDatabase:(int)phoneNumber name:(NSString *)name password:(NSString *)password;
@end
