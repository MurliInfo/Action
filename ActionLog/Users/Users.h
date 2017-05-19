//
//  Users.h
//  ActionLog
//
//  Created by Hardik Davda on 9/14/16.
//  Copyright © 2016 SLP-World. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "AddAction.h"
#import "AddSubtask.h"
#import "Archived.h"
#import "Companies.h"
#import "Dashboard.h"
#import "AddUsers.h"
#import "CustomCell.h"
#import "CustomData.h"


@interface Users : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>{
    AllMethods *Methods;
    IBOutlet UITableView *table;
    
    
    IBOutlet UITextField *txtDepartment;
    IBOutlet UITextField *txtType;
    IBOutlet UITextField *txtStatus;
    IBOutlet UITextField *txtTitelSearch;
    IBOutlet UITextField *txtApply;
    
    IBOutlet UITextField *txtSACompany;
    IBOutlet UITextField *txtSADepartment;
    IBOutlet UITextField *txtSAType;
    IBOutlet UITextField *txtSAStatus;
    IBOutlet UITextField *txtSATitelSearch;
    
    IBOutlet UILabel *lblCount1;
    IBOutlet UILabel *lblCount2;
    
    IBOutlet UIButton *btnCheckAll;
    IBOutlet UIImageView *imgChekApply;
    
    IBOutlet UIView *ViewTitleSearch;
    IBOutlet UIView *ViewAll;
    IBOutlet UIView *viewAdvanceSearch;
    IBOutlet UIView *viewAdvanceSearchSuperAdmin;
    IBOutlet UIView *viewListUser;

    IBOutlet UIView *viewSuperAdminTab;
    IBOutlet UIView *viewAdminTab;
    IBOutlet UIView *viewTab;
    IBOutlet UIView *viewSearch;
    IBOutlet UIView *viewAction;
   
}

@property NSMutableArray *filltereList;
- (IBAction)AddUser:(id)sender;
- (IBAction)AdvanceSearch:(id)sender;
- (IBAction)ApplyCheck:(id)sender;
- (IBAction)AllCheck:(id)sender;
- (IBAction)AllDropDown:(id)sender;
- (IBAction)Archived:(id)sender;
- (IBAction)CellCheck:(id)sender;
- (IBAction)Companies:(id)sender;
- (IBAction)Close:(id)sender;
- (IBAction)CloseTitleSearch:(id)sender;
- (IBAction)Dashboard:(id)sender;
- (IBAction)SearchTitleChange:(id)sender;
- (IBAction)Search:(id)sender;
- (IBAction)Reset:(id)sender;
- (IBAction)TitleSearch:(id)sender;
- (IBAction)User:(id)sender;

@end
