//
//  Archived.h
//  ActionLog
//
//  Created by Hardik Davda on 9/14/16.
//  Copyright © 2016 SLP-World. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "Dashboard.h"
#import "Companies.h"
#import "Users.h"
#import "CustomCell.h"
#import "CustomData.h"
#import "CustomData.h"
#import "UIImage+animatedGIF.h"
#import "AppDelegate.h"
#import "DropDownListView.h"

@interface Archived : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,kDropDownListViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    
    AllMethods *Methods;
    DropDownListView * Dropobj;
    IBOutlet UIPickerView *picker;
    IBOutlet UIDatePicker *myPicker;
    IBOutlet UIButton *btnCheckAll;
    IBOutlet UIImageView *imgChekApply;
    IBOutlet UITextField *txtArchived;
    
    IBOutlet UITableView *tableSearch;
    IBOutlet UITableView *table;
    IBOutlet UIView *viewFull;
    IBOutlet UIView *viewFullAll;

    IBOutlet UIView *viewDate;
    IBOutlet UIView *viewSuperAdminSearch;
    IBOutlet UIView *viewAdminSearch;
    IBOutlet UIView *viewSearch;
    IBOutlet UIView *viewTitleSearch;
    IBOutlet UIView *viewAdvanceSearch;
    IBOutlet UIView *viewListAction;
    IBOutlet UIView *viewTag;
    IBOutlet UIView *viewTagSearch;
    IBOutlet UIView *viewAction;
    IBOutlet UIView *viewSuperAdminTab;
    IBOutlet UIView *viewAdminTab;
    IBOutlet UIView *viewTab;
    
    IBOutlet UIView *viewSearchData; // For Advance Serarch
    
    IBOutlet UILabel *lblCount1;
    IBOutlet UILabel *lblCount2;
    
    IBOutlet UIButton *btnTitleCancel;
    IBOutlet UIButton *btnCancelTitle;
    IBOutlet UILabel *lblCancelTitle;
    IBOutlet UIImageView *imgCancelTitle;
    IBOutlet UIImageView *imgTitleBoader;
    
    IBOutlet UIView *viewUserSearch;
    IBOutlet UIView *viewSearchButton;
    
    IBOutlet UIButton *btnSearchUser;
    IBOutlet UIButton *btnCancelUser;
    IBOutlet UIButton *btnResetUser;
    
    IBOutlet UIButton *btnAddTag;
    IBOutlet UIButton *btnCloseTag;
    IBOutlet UITextField *txtSearchUser;
    IBOutlet UITextField *txtSearchTitle;
    IBOutlet UITextField *txtSACompany;
    IBOutlet UITextField *txtSACreatedBy;
    IBOutlet UITextField *txtSADepartment;
    IBOutlet UITextField *txtSADueFromDate;
    IBOutlet UITextField *txtSADueToDate;
    IBOutlet UITextField *txtSAAssignTo;
    
    IBOutlet UITextField *txtADepartment;
    IBOutlet UITextField *txtACreatedBy;
    IBOutlet UITextField *txtADueFromDate;
    IBOutlet UITextField *txtADueToDate;

    IBOutlet UITextField *txtAAssignTo;
    IBOutlet UITextField *txtUAssignTo;
    
    IBOutlet UITextField *txtUCreatedBy;
    IBOutlet UITextField *txtUDueFromDate;
    IBOutlet UITextField *txtUDueToDate;
    
    IBOutlet UIImageView *imgBoder;
    
    IBOutlet UITextField *txtSAStatus;
    IBOutlet UITextField *txtSADueDate;
    IBOutlet UITextField *txtUDueDate;
    IBOutlet UITextField *txtUStatus;
    IBOutlet UITextField *txtTagSearch;
    IBOutlet UILabel *lblAdvanceSearchCollaps;
    IBOutlet UIImageView *imgAdvanceSearchCollapse;
    IBOutlet UIButton *btnAdvanceSearchCollapse;
    IBOutlet UITextField *txtCompany;
    IBOutlet UITextField *txtDepartment;
    IBOutlet UITextField *txtDueFromDate;
    IBOutlet UITextField *txtDueToDate;
    IBOutlet UITextField *txtAssignTo;
}

@property NSMutableArray *filltereList;

//- (IBAction)TextChangeTag:(id)sender;

- (IBAction)SaveTag:(id)sender;
- (IBAction)CancelTag:(id)sender;
- (IBAction)CancelTitleSearch:(id)sender;

- (IBAction)DropDownSearch:(id)sender;
- (IBAction)AdvanceSearch:(id)sender;
- (IBAction)Reset:(id)sender;
- (IBAction)Back:(id)sender;

- (IBAction)Dashboard:(id)sender;
- (IBAction)Archived:(id)sender;
- (IBAction)Companies:(id)sender;
- (IBAction)User:(id)sender;

@end
