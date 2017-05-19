//
//  AddUsers.h
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
#import "Users.h"
#import "CustomCell.h"
#import "CustomData.h"

@interface AddUsers : UIViewController<UITextFieldDelegate,UIScrollViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    AllMethods *Methods;
    IBOutlet UIPickerView *picker;
    IBOutlet UIScrollView *scroll;
    IBOutlet UITextField *txtTimeZone;
    IBOutlet UITextField *txtType;
    IBOutlet UITextField *txtDepartment;
    IBOutlet UITextField *txtCompany;
    IBOutlet UITextField *txtFirstName;
    IBOutlet UITextField *txtLastName;
    IBOutlet UITextField *txtEmail;
    IBOutlet UITextField *txtPassword;
    IBOutlet UITextField *txtConfirmPassword;
    IBOutlet UITextField *txtMobile;
    IBOutlet UITextField *txtSearchDropdown;
    IBOutlet UILabel *lblTitelUser;

    IBOutlet UIView *viewMain;
    IBOutlet UIView *viewAll;
    IBOutlet UIView *viewTimezone;
    IBOutlet UIView *viewType;
    IBOutlet UIView *viewDepartment;
    IBOutlet UIView *viewCompany;
    
    IBOutlet UIView *viewPickerView;

    IBOutlet UILabel *lblCount1;
    IBOutlet UILabel *lblCount2;
    
    
    IBOutlet UIView *viewSuperAdminTab;
    IBOutlet UIView *viewAdminTab;
    IBOutlet UIView *viewTab;
    NSMutableArray *arrayGet;
    NSString *strGet;
    
    IBOutlet UIButton *btnDepartment;
    IBOutlet UIButton *btnType;
    IBOutlet UIButton *btnComapny;
    
    IBOutlet UIImageView *imgDepartment;
    IBOutlet UIImageView *imgType;
    IBOutlet UIImageView *imgComapny;
    
    IBOutlet UIImageView *imgDepartmentD;
    IBOutlet UIImageView *imgTypeD;
    IBOutlet UIImageView *imgComapnyD;
    
    IBOutlet UIButton *btnAdd;
    IBOutlet UILabel *lblPassword;
    IBOutlet UILabel *lblConfermPassword;
    
}
@property(nonatomic,retain) NSMutableArray *arrayGet;
@property(nonatomic,retain) NSString *strGet;

@property NSMutableArray *filltereList;

- (IBAction)searchTitleChaneg:(id)sender;

- (IBAction)SelectTimezone:(id)sender;
- (IBAction)SelectType:(id)sender;
- (IBAction)SelectDepartment:(id)sender;

- (IBAction)Add:(id)sender;
- (IBAction)Cancel:(id)sender;
- (IBAction)Done:(id)sender;

- (IBAction)Dashboard:(id)sender;
- (IBAction)Archived:(id)sender;
- (IBAction)Companies:(id)sender;
- (IBAction)User:(id)sender;

@end
