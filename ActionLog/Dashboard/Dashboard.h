//
//  Dashboard.h
//  ActionLog
//
//  Created by Hardik Davda on 9/14/16.
//  Copyright © 2016 SLP-World. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllMethods.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "AddAction.h"
#import "AddSubtask.h"
#import "Archived.h"
#import "Companies.h"
#import "Users.h"
#import "CustomCell.h"
#import "CustomData.h"
#import "DropDownListView.h"
#import "Login.h"
#import "EditProfile.h"
#import "ChangePassword.h"

@interface Dashboard : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,kDropDownListViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    AllMethods *Methods;
    IBOutlet UIPickerView *picker;
    IBOutlet UITextField *txtTagSearch;
    DropDownListView * Dropobj;
    IBOutlet UIDatePicker *myPicker;
    IBOutlet UITableView *tableSearch;
    IBOutlet UITableView *table;
    IBOutlet UIView *viewFull;
    IBOutlet UIView *viewFullAll;
    
    IBOutlet UIView *viewSearchData; // For Advance Serarch
    
    IBOutlet UIView *viewDate;
    IBOutlet UIImageView *imgNoteView;
    IBOutlet UIImageView *imgBoder;
//    IBOutlet UIView *viewSuperAdminSearch;
//    IBOutlet UIView *viewSuperAdminSearchForApproval;
//    IBOutlet UIView *viewUserDropDown;
    
//    IBOutlet UIView *viewAdminSearch;
//    IBOutlet UIView *viewSearch;
    IBOutlet UIView *viewTitleSearch;
    IBOutlet UIView *viewAdvanceSearch;
    IBOutlet UIView *viewListAction;
    
    IBOutlet UIView *viewUserSearch;
    IBOutlet UIView *viewSearchButton;

    IBOutlet UIView *viewSuperAdminTab;
    IBOutlet UIView *viewAdminTab;
    IBOutlet UIView *viewTab;
    IBOutlet UIView *viewTagSearch;
    IBOutlet UIView *viewTag;

    IBOutlet UIView *viewAction;
    IBOutlet UITextField *txtSearchUser;
    IBOutlet UITextField *txtSearchTitle;
    IBOutlet UITextField *txtSACompany;
    IBOutlet UITextField *txtSACreatedBy;
    IBOutlet UITextField *txtSADepartment;
    IBOutlet UITextField *txtSADueDate;
    IBOutlet UITextField *txtSADueFromDate;
    IBOutlet UITextField *txtSADueToDate;
    IBOutlet UITextField *txtSAAssignTo;
    IBOutlet UITextField *txtSAStatus;

    IBOutlet UITextField *txtSAFCompany;
    IBOutlet UITextField *txtSAFCreatedBy;
    IBOutlet UITextField *txtSAFDepartment;
    IBOutlet UITextField *txtSAFDueDate;
    IBOutlet UITextField *txtSAFDueFromDate;
    IBOutlet UITextField *txtSAFDueToDate;
    IBOutlet UITextField *txtSAFAssignTo;
    
    IBOutlet UITextField *txtADepartment;
    IBOutlet UITextField *txtACreatedBy;
    IBOutlet UITextField *txtADueDate;
    IBOutlet UITextField *txtADueFromDate;
    IBOutlet UITextField *txtADueToDate;
    IBOutlet UITextField *txtAAssignTo;
    IBOutlet UITextField *txtAStatus;

    IBOutlet UITextField *txtUCreatedBy;
    IBOutlet UITextField *txtUDueDate;
    IBOutlet UITextField *txtUDueFromDate;
    IBOutlet UITextField *txtUDueToDate;
    IBOutlet UITextField *txtUAssignTo;
    IBOutlet UITextField *txtUStatus;
    IBOutlet UITextField *txtArchived;

    IBOutlet UIImageView *imgChekApply;
    IBOutlet UIButton *btnCheckAll;
    
    IBOutlet UIImageView *imgApproval;
    IBOutlet UIImageView *imgDashboard;
    
    IBOutlet UIImageView *imgTitleBoader;
    IBOutlet UIImageView *imgCancelTitle;
    IBOutlet UIImageView *imgApprovalStaff;
    IBOutlet UIImageView *imgDashboardStaff;
    
    IBOutlet UIImageView *imgLogout;
    IBOutlet UIImageView *imgPlus;
    IBOutlet UIImageView *imgMenu;
    IBOutlet UIButton *btnPlus;
    IBOutlet UILabel *lbll;

    IBOutlet UIButton *btnTitleCancel;
    IBOutlet UIButton *btnLogout;
    IBOutlet UIButton *btnMenu;
    
    IBOutlet UIButton *btnAddTag;
    IBOutlet UIButton *btnCloseTag;
    
    IBOutlet UIButton *btnSearchUser;
    IBOutlet UIButton *btnCancelUser;
    IBOutlet UIButton *btnResetUser;
    
    IBOutlet UILabel *lblCancelTitle;
    IBOutlet UILabel *lblDashboard;
    IBOutlet UILabel *lblApproval;
    IBOutlet UILabel *lblApprovalStaff;
    IBOutlet UILabel *lblDashboardStaff;
    
    IBOutlet UILabel *lbl1;
    IBOutlet UILabel *lbl2;
    
    IBOutlet UILabel *lblCount1;
    IBOutlet UILabel *lblCount2;
    
    IBOutlet UIView *aView;
    IBOutlet UIView *viewDashoard;
    IBOutlet UIView *viewApproval;
    
    IBOutlet UIView *viewDashoardStaff;
    IBOutlet UIView *viewApprovalStaff;
    IBOutlet UILabel *lblTitle;
    
    
    IBOutlet UIButton *btnAdvanceSearchCollapse;
    
    
}
-(void)manageUser;
@property NSMutableArray *filltereList;

- (IBAction)TextChangeTag:(id)sender;
- (IBAction)SaveTag:(id)sender;
- (IBAction)CancelTag:(id)sender;


- (IBAction)DropDownSearch:(id)sender;
- (IBAction)AdvanceSearch:(id)sender;
- (IBAction)AddAction:(id)sender;
- (IBAction)Reset:(id)sender;
//- (IBAction)CompaniesList:(id)sender;
- (IBAction)AllCheck:(id)sender;
- (IBAction)ApplyCheck:(id)sender;
- (IBAction)CellCheck:(id)sender;


- (IBAction)Dashboard:(id)sender;
- (IBAction)Archived:(id)sender;
- (IBAction)Companies:(id)sender;
- (IBAction)User:(id)sender;


@end
