//
//  EditProfile.h
//  ActionLog
//
//  Created by Hardik Davda on 2/9/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

//#import "Archived.h"
//#import "Companies.h"
#import "Dashboard.h"
//#import "AddUsers.h"
#import "CustomCell.h"
#import "CustomData.h"
#import "DropDownListView.h"

@interface EditProfile : UIViewController<UITextFieldDelegate,UIScrollViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
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
    
    IBOutlet UIView *viewSuperAdminTab;
    IBOutlet UIView *viewAdminTab;
    IBOutlet UIView *viewTab;
   NSString *strGet;
    
    IBOutlet UILabel *lblCount1;
    IBOutlet UILabel *lblCount2;
    
    
    IBOutlet UIImageView *imgCompany;
    IBOutlet UIImageView *imgType;
    IBOutlet UIImageView *imgDepartment;

    IBOutlet UIImageView *imgCompanyDisebal;
    IBOutlet UIImageView *imgTypeDisebal;
    IBOutlet UIImageView *imgDepartmentDisebal;

    
    IBOutlet UIButton *btnAdd;
    IBOutlet UIButton *btnCompany;
    IBOutlet UIButton *btnType;
    IBOutlet UIButton *btnDepartment;
    IBOutlet UILabel *lblPassword;
    IBOutlet UILabel *lblConfermPassword;
    
}
@property(nonatomic,retain) NSMutableArray *arrayGet;
@property(nonatomic,retain) NSString *strGet;

@property NSMutableArray *filltereList;

//- (IBAction)searchTitleChaneg:(id)sender;

- (IBAction)SelectTimezone:(id)sender;
- (IBAction)SelectType:(id)sender;
- (IBAction)SelectDepartment:(id)sender;
- (IBAction)SelectCompany:(id)sender;
- (IBAction)Add:(id)sender;
- (IBAction)Cancel:(id)sender;
- (IBAction)Done:(id)sender;
//
//- (IBAction)Dashboard:(id)sender;
//- (IBAction)Archived:(id)sender;
//- (IBAction)Companies:(id)sender;
//- (IBAction)User:(id)sender;

@end
