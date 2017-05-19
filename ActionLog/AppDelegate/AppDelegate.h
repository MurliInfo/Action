//
//  AppDelegate.h
//  ActionLog
//
//  Created by Hardik Davda on 9/14/16.
//  Copyright © 2016 SLP-World. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllMethods.h"
#import "AllWebServices.h"
//#import "Macro.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    NSString *STRDATEFORMATE;
    NSString *STRWEBDATEFORMATE;
    NSString *WEBPATH;
    NSString *STRUSERTYPE;
    NSString *STRTOKEN;
    NSString *STRUSERNAME;
    NSString *ISAPPROVE;
    NSString *STRUSERID;
    NSString *LOG;

    NSMutableArray *ARRAYTAG;
    NSMutableArray *ARRAYWORKDATE;
    NSMutableArray *ARRAYTAGVALUE;
    NSMutableArray *ARRAYCREATEDBY;
    NSMutableArray *ARRAYASSIGNTO;
   // NSMutableArray *ARRAYCREATEDBY;
    NSMutableArray *ARRAYDEPARTMENT;
    NSMutableArray *ARRAYOVERDUE;
    NSMutableArray *ARRAYCOMPANY;
    
    NSUserDefaults *sesson;

}
@property(strong,nonatomic) NSString *LOG;
@property(strong,nonatomic) NSMutableArray *ARRAYCOMPANY;
@property(strong,nonatomic) NSMutableArray *ARRAYOVERDUE;
@property(strong,nonatomic) NSMutableArray *ARRAYTAG;
@property(strong,nonatomic) NSMutableArray *ARRAYTAGVALUE;
@property(strong,nonatomic) NSMutableArray *ARRAYCREATEDBY;
@property(strong,nonatomic) NSMutableArray *ARRAYASSIGNTO;
@property(strong,nonatomic) NSMutableArray *ARRAYFULLASSIGNTO;
@property(strong,nonatomic) NSMutableArray *ARRAYUSERLIST;
@property(strong,nonatomic) NSMutableArray *ARRAYDEPARTMENT;
@property(strong,nonatomic) NSMutableArray *ARRAYWORKDATE;
@property(nonatomic,retain) NSString *sesson1;

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic) NSString *ISAPPROVE;
@property(strong,nonatomic) NSString *STRCREATEDBY;
@property(strong,nonatomic) NSString *STRUSERID;
@property(strong,nonatomic) NSString *STRCOMPANYID;


@property(strong,nonatomic) NSString *STRTOKEN;
@property(strong,nonatomic) NSString *STRUSERNAME;
@property(strong,nonatomic) NSString *WEBPATH;
@property(strong,nonatomic) NSString *STRDATEFORMATE;
@property(strong,nonatomic) NSString *STRWEBDATEFORMATE;
@property(strong,nonatomic) NSString *STRUSERTYPE;
@end

