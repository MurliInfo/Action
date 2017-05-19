//
//  AllWebServices.m
//  ActionLog
//
//  Created by Hardik Davda on 9/14/16.
//  Copyright © 2016 SLP-World. All rights reserved.
///
/*
Dashboard{
    https://retptyltd.com/actionlog_api/v1/user/getTimezone
        token
     2. https://retptyltd.com/actionlog_api/v1/user/getStreet
        token
     3. https://retptyltd.com/actionlog_api/v1/user/getState
        token
     4. https://retptyltd.com/actionlog_api/v1/user/getSuburb
        token
     5. https://retptyltd.com/actionlog_api/v1/actionlog/getAssignTo
        token
     6. https://retptyltd.com/actionlog_api/v1/actionlog/getCompanylist
        token
     7. https://retptyltd.com/actionlog_api/v1/actionlog/getDepartmentlist
        token
     8. https://retptyltd.com/actionlog_api/v1/actionlog/getActionLogStatusList
     token
     9. https://retptyltd.com/actionlog_api/v1/actionlog/getActionLogOverdueList
   token
}*/

#import "AllWebServices.h"

@implementation AllWebServices

NSMutableArray *ArryData;

-(NSMutableArray *)WebLogin{
    CustomData *cmd = [[CustomData alloc]init];
    ArryData = [[NSMutableArray alloc]init];
    cmd.webLogin = [appDelegate.WEBPATH stringByAppendingString:@"user/login"];
    cmd.webList = [appDelegate.WEBPATH stringByAppendingString:@"user/getAllUserEmail"];
    cmd.webForgotPassword = [appDelegate.WEBPATH stringByAppendingString:@"user/forgotPassword"];
    cmd.webChangePassword = [appDelegate.WEBPATH stringByAppendingString:@"user/changePassword"];
    [ArryData addObject:cmd];
    return ArryData;
}

-(NSMutableArray *)WebDashboard{
    CustomData *cmd = [[CustomData alloc]init];
    ArryData = [[NSMutableArray alloc]init];
    cmd.webForApprvalCount = [appDelegate.WEBPATH stringByAppendingString: @"actionlog/getApprovalCount"];
    cmd.webCompany = [appDelegate.WEBPATH stringByAppendingString: @"actionlog/getCompanylist"];
    cmd.webDepartment = [appDelegate.WEBPATH stringByAppendingString:@"actionlog/getDepartmentlist"];
    cmd.webCreatedBy =  [appDelegate.WEBPATH stringByAppendingString:@"actionlog/getAssignTo"];
    cmd.webAssignTo =  [appDelegate.WEBPATH stringByAppendingString:@"actionlog/getAssignTo"];
    cmd.webStatus   = [appDelegate.WEBPATH stringByAppendingString: @"actionlog/getActionLogStatusList"];
    cmd.webDueDate =  [appDelegate.WEBPATH stringByAppendingString:@"actionlog/getActionLogOverdueList"];
    cmd.webChangeActionStatus = [appDelegate.WEBPATH stringByAppendingString:@"actionlog/changeActionStatus"];
    cmd.webTagList = [appDelegate.WEBPATH stringByAppendingString:@"tag/getTagsList"];
    cmd.webDashboard = [appDelegate.WEBPATH stringByAppendingString:@"actionlog/getActionList"];
    cmd.webLogOut = [appDelegate.WEBPATH stringByAppendingString:@"users/logout"];
    [ArryData addObject:cmd];
    return ArryData;
}

-(NSMutableArray *)EditProfile{
    CustomData *cmd = [[CustomData alloc]init];
    ArryData = [[NSMutableArray alloc]init];
    cmd.webForApprvalCount = [appDelegate.WEBPATH stringByAppendingString: @"actionlog/getApprovalCount"];
    cmd.webUserUpdate =  [appDelegate.WEBPATH stringByAppendingString:@"user/userAction"];
    cmd.webDepartmentList = [appDelegate.WEBPATH stringByAppendingString:@"department/getAllDepartmentList"];
    cmd.webTimezoneList = [appDelegate.WEBPATH stringByAppendingString:@"user/getTimezone"];
    cmd.webCompany = [appDelegate.WEBPATH stringByAppendingString:@"actionlog/getCompanylist"];
    cmd.webEditProfile = [appDelegate.WEBPATH stringByAppendingString:@"user/getProfile"];
    cmd.webProfileUpdate = [appDelegate.WEBPATH stringByAppendingString:@"user/userProfile"];
    [ArryData addObject:cmd];
    return ArryData;
    
}

-(NSMutableArray *)WebAddAction{
    CustomData *cmd = [[CustomData alloc]init];
    ArryData = [[NSMutableArray alloc]init];
    cmd.webForApprvalCount = [appDelegate.WEBPATH stringByAppendingString: @"actionlog/getApprovalCount"];
    cmd.webAddAction =   [appDelegate.WEBPATH stringByAppendingString:@"actionlog/addAction"];
    cmd.webAssignTo =  [appDelegate.WEBPATH stringByAppendingString:@"actionlog/getAssignTo"];
    cmd.webUpdateAction = [appDelegate.WEBPATH stringByAppendingString:@"actionlog/updateAction"];
    cmd.webTagList = [appDelegate.WEBPATH stringByAppendingString:@"tag/getTagsList"];
    [ArryData addObject:cmd];
    return ArryData;
}

-(NSMutableArray *)WebAddSubTask{
    CustomData *cmd = [[CustomData alloc]init];
    ArryData = [[NSMutableArray alloc]init];
    cmd.webForApprvalCount = [appDelegate.WEBPATH stringByAppendingString: @"actionlog/getApprovalCount"];
    cmd.webActionHistory =[appDelegate.WEBPATH stringByAppendingString:@"actionlog/getActionHistory"];
    cmd.webSubTaskList = [appDelegate.WEBPATH stringByAppendingString:@"actionlog/getSubTaskList"];
    cmd.webAddUpdateSubTask = [appDelegate.WEBPATH stringByAppendingString:@"actionlog/updateSubTask"];
    cmd.webUpdateAction = [appDelegate.WEBPATH stringByAppendingString:@"actionlog/updateAction"];
    cmd.webAssignTo =  [appDelegate.WEBPATH stringByAppendingString:@"actionlog/getAssignTo"];
    cmd.webChangeActionStatus = [appDelegate.WEBPATH stringByAppendingString:@"actionlog/changeActionStatus"];
    cmd.webTagList = [appDelegate.WEBPATH stringByAppendingString:@"tag/getTagsList"];
    cmd.webPostNote =  [appDelegate.WEBPATH stringByAppendingString:@"actionlog/postNotes"];
    cmd.webReorderTask = [appDelegate.WEBPATH stringByAppendingString:@"actionlog/reorderTasks"];
    [ArryData addObject:cmd];
    return ArryData;
}

-(NSMutableArray *)WebArchived{
    CustomData *cmd = [[CustomData alloc]init];
    ArryData = [[NSMutableArray alloc]init];
    cmd.webForApprvalCount = [appDelegate.WEBPATH stringByAppendingString: @"actionlog/getApprovalCount"];
    [ArryData addObject:cmd];
    return ArryData;
}

-(NSMutableArray *)WebCompanies{
    CustomData *cmd = [[CustomData alloc]init];
    ArryData = [[NSMutableArray alloc]init];
    cmd.webForApprvalCount = [appDelegate.WEBPATH stringByAppendingString: @"actionlog/getApprovalCount"];
    [ArryData addObject:cmd];
    return ArryData;
}

-(NSMutableArray *)WebAddcompany{
    CustomData *cmd = [[CustomData alloc]init];
    ArryData = [[NSMutableArray alloc]init];
    cmd.webForApprvalCount = [appDelegate.WEBPATH stringByAppendingString: @"actionlog/getApprovalCount"];
    [ArryData addObject:cmd];
    return ArryData;
}

-(NSMutableArray *)WebEditCompany{
    CustomData *cmd = [[CustomData alloc]init];
    ArryData = [[NSMutableArray alloc]init];
    cmd.webForApprvalCount = [appDelegate.WEBPATH stringByAppendingString: @"actionlog/getApprovalCount"];
    [ArryData addObject:cmd];
    return ArryData;
}

-(NSMutableArray *)WebUser{
    CustomData *cmd = [[CustomData alloc]init];
    ArryData = [[NSMutableArray alloc]init];
    cmd.webForApprvalCount = [appDelegate.WEBPATH stringByAppendingString: @"actionlog/getApprovalCount"];
    cmd.webUserList =  [appDelegate.WEBPATH stringByAppendingString:@"user/getAllUserList"];
    cmd.webDepartmentList = [appDelegate.WEBPATH stringByAppendingString:@"department/getAllDepartmentList"];
    cmd.webDashboard = [appDelegate.WEBPATH stringByAppendingString:@"actionlog/getActionList"];
    cmd.webChangeActionStatus = [appDelegate.WEBPATH stringByAppendingString:@"user/userAction"];
    cmd.webCompany = [appDelegate.WEBPATH stringByAppendingString:@"actionlog/getCompanylist"];
    [ArryData addObject:cmd];
    return ArryData;
}

-(NSMutableArray *)WebAddUser{
    CustomData *cmd = [[CustomData alloc]init];
    ArryData = [[NSMutableArray alloc]init];
    cmd.webForApprvalCount = [appDelegate.WEBPATH stringByAppendingString: @"actionlog/getApprovalCount"];
    cmd.webUserUpdate =  [appDelegate.WEBPATH stringByAppendingString:@"user/userAction"];
    cmd.webDepartmentList = [appDelegate.WEBPATH stringByAppendingString:@"department/getAllDepartmentList"];
    cmd.webTimezoneList = [appDelegate.WEBPATH stringByAppendingString:@"user/getTimezone"];
    cmd.webCompany = [appDelegate.WEBPATH stringByAppendingString:@"actionlog/getCompanylist"];
//webUserUpdate
//webDepartmentList
    //webTimezoneList
    
    [ArryData addObject:cmd];
    return ArryData;
}

@end
