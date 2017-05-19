//
//  CustomData.h
//  ActionLog
//
//  Created by Hardik Davda on 9/14/16.
//  Copyright © 2016 SLP-World. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AllMethods.h"
@interface CustomData : NSObject
@property(nonatomic,retain) NSString *strErrorTitle;
@property(nonatomic,retain) NSString *strErrorMessage;

@property(nonatomic,retain) NSString *strPropertyAddress;
@property(nonatomic,retain) NSString *strId;
@property(nonatomic,retain) NSString *strDay;
@property(nonatomic,retain) NSString *strAssigneName;
@property(nonatomic,retain) NSString *strStatus;
@property(nonatomic,retain) NSString *strDueDate;
@property(nonatomic,retain) NSString *strWorkDate;
@property(nonatomic,retain) NSString *strWorkDateColor;
@property(nonatomic,retain) NSString *strReviceDateColor;
@property(nonatomic,retain) NSString *strAssignyId;
@property(nonatomic,retain) NSString *strViewCount;
@property(nonatomic,retain) NSString *strProgress;
@property(nonatomic,retain) NSString *strKey;
@property(nonatomic,retain) NSString *strCompanyId;
@property(nonatomic,retain) NSString *strDepartmentId;
@property(nonatomic,retain) NSString *strDepartmentName;
@property(nonatomic,retain) NSString *strIsCheck;
@property(nonatomic,retain) NSString *strDescription;
@property(nonatomic,retain) NSString *strActionUserName;
@property(nonatomic,retain) NSString *strAssignUserName;
@property(nonatomic,retain) NSString *strRevisedDate;
@property(nonatomic,retain) NSString *strDashboardDueDate;
@property(nonatomic,retain) NSString *strCreatedDate;
@property(nonatomic,retain) NSString *strActionLogTitle;
@property(nonatomic,retain) NSString *strAssignTo;
@property(nonatomic,retain) NSString *strPercentageCompleted;
@property(nonatomic,retain) NSString *strCreatedBy;
@property(nonatomic,retain) NSString *strNoteCount;
@property(nonatomic,retain) NSString *strSubTaskId;
@property(nonatomic,retain) NSString *strSubTaskName;
@property(nonatomic,retain) NSString *strFrom;
@property(nonatomic,retain) NSString *strNotesReadStatus;
@property(nonatomic,retain) NSString *strDepartmentStatus;
@property(nonatomic,retain) NSString *strCompanyName;
@property(nonatomic,retain) NSString *strMobileNumber;
@property(nonatomic,retain) NSString *strUserEmail;
@property(nonatomic,retain) NSString *strUserId;
@property(nonatomic,retain) NSString *strUserStatus;
@property(nonatomic,retain) NSString *strUserType;
@property(nonatomic,retain) NSString *strUserName;
@property(nonatomic,retain) NSString *strTimezoneId;
@property(nonatomic,retain) NSString *strTimezoneName;
@property(nonatomic,retain) NSString *strTimezoneCode;
@property(nonatomic,retain) NSString *strColor;
@property(nonatomic,retain) NSString *strFirstName;
@property(nonatomic,retain) NSString *strLastName;
@property(nonatomic,retain) NSString *strAllow;
@property(nonatomic,retain) NSString *strTagId;
@property(nonatomic,retain) NSString *strAssigneCompanyId;
@property(nonatomic,retain) NSString *strWebImagePath;

@property(nonatomic,retain) NSString *webLogin;
@property(nonatomic,retain) NSString *webLogOut;
@property(nonatomic,retain) NSString *webForgotPassword;
@property(nonatomic,retain) NSString *webChangePassword;
@property(nonatomic,retain) NSString *webList;
@property(nonatomic,retain) NSString *webDashboard;
@property(nonatomic,retain) NSString *webSearchFilter;
@property(nonatomic,retain) NSString *webCompany;
@property(nonatomic,retain) NSString *webForApprvalCount;

@property(nonatomic,retain) NSString *webDepartment;
@property(nonatomic,retain) NSString *webCreatedBy;
@property(nonatomic,retain) NSString *webAssignTo;
@property(nonatomic,retain) NSString *webStatus;
@property(nonatomic,retain) NSString *webDueDate;
@property(nonatomic,retain) NSString *webDueFrom;
@property(nonatomic,retain) NSString *webDueTo;
@property(nonatomic,retain) NSString *webChangeActionStatus;
@property(nonatomic,retain) NSString *webAddAction;
@property(nonatomic,retain) NSString *webActionHistory;
@property(nonatomic,retain) NSString *webSubTaskList;
@property(nonatomic,retain) NSString *webAddUpdateSubTask;
@property(nonatomic,retain) NSString *webReorderTask;
@property(nonatomic,retain) NSString *webEditProfile;
@property(nonatomic,retain) NSString *webProfileUpdate;

@property(nonatomic,retain) NSString *webUpdateAction;
@property(nonatomic,retain) NSString *webPostNote;
@property(nonatomic,retain) NSString *webUserList;
@property(nonatomic,retain) NSString *webUserUpdate;
@property(nonatomic,retain) NSString *webDepartmentList;
@property(nonatomic,retain) NSString *webTimezoneList;
@property(nonatomic,retain) NSString *webTagList;

@property(nonatomic,retain) NSString *strCatName;

@property(nonatomic,retain) UIButton *btnTESTING;
@property(nonatomic,retain) UILabel *lblTESTING;
@property(nonatomic,retain) UIImageView *imgTESTING;

@property(nonatomic) double Width;
@property(nonatomic) CGRect FINALFRAME;
@property(nonatomic) CGRect FINALFRAMELABLE;

//Form

@property(nonatomic,retain) NSString *strSubtask;
@property(nonatomic,retain) NSString *strPlaceHolder;



 @end
