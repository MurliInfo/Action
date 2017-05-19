//
//  AllWebServices.h
//  ActionLog
//
//  Created by Hardik Davda on 9/14/16.
//  Copyright © 2016 SLP-World. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomData.h"
@interface AllWebServices : NSObject
-(NSMutableArray *)WebLogin;
-(NSMutableArray *)WebDashboard;
-(NSMutableArray *)WebAddAction;
-(NSMutableArray *)WebAddSubTask;
-(NSMutableArray *)WebArchived;
-(NSMutableArray *)WebCompanies;
-(NSMutableArray *)WebAddcompany;
-(NSMutableArray *)WebEditCompany;
-(NSMutableArray *)WebUser;
-(NSMutableArray *)WebAddUser;
-(NSMutableArray *)EditProfile;

@end
