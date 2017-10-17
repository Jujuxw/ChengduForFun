//
//  DatabaseHelper.h
//  成都生活
//
//  Created by juju on 2017/3/14.
//  Copyright © 2017年 刘晓微. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "DBAccess.h"
#import "User.h"

@interface DatabaseHelper : NSObject

+ (BOOL)insertUser:(User *)user;
+ (NSMutableArray *)getAllUsers;

@end
