//
//  AddSubtask.h
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
#import "Users.h"
#import "CustomCell.h"
#import "CustomData.h"
#import "DropDownListView.h"

@interface AddSubtask : UIViewController<UITextViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,kDropDownListViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>    {
    AllMethods *Methods;
    DropDownListView * Dropobj;
    
    IBOutlet UITableView *table;
    IBOutlet UITableView *table1;
    IBOutlet UIDatePicker *myPicker;
    IBOutlet UIPickerView *picker;
    IBOutlet UIView *viewTag;
    IBOutlet UIView *viewTagPluse;
    IBOutlet UIView *viewTagSearch;
    IBOutlet UIImageView *imgBoder;
    //IBOutlet UIView *viewTagSearch;

    IBOutlet UIView *viewInfo;
    IBOutlet UITextField *txtPercenatages;
    IBOutlet UIView *viewPercenatages;
    IBOutlet UIView *viewRevisedDate;
  //  IBOutlet UITextView *txtTitle;
    IBOutlet UILabel *txtTitle;

    IBOutlet UILabel *lblTEST;
    IBOutlet UILabel *lblTEST1;

    IBOutlet UIScrollView *scroll;
    IBOutlet UIView *viewFull;
    IBOutlet UIView *viewInformation;
    IBOutlet UIView *viewNote;
    IBOutlet UIView *viewList;
    IBOutlet UIView *viewFilter;
    IBOutlet UIView *viewSubtask;
    IBOutlet UIView *viewComment;
    IBOutlet UIView *viewSubtaskNotes;
    //
    IBOutlet UILabel *lblTitle;
    IBOutlet UILabel *lblCreatedBy;
    IBOutlet UILabel *lblAssignTo;
    IBOutlet UILabel *lblDueDate;
    IBOutlet UILabel *lblCreatedDate;
    IBOutlet UILabel *lblReviceDate;
    IBOutlet UILabel *lblCompleted;
    IBOutlet UILabel *lblPalaceholder;
    
    IBOutlet UITextView *txtComments;
    IBOutlet UIView *viewSuperAdminTab;
    IBOutlet UIView *viewAdminTab;
    IBOutlet UIView *viewTab;

    IBOutlet UITextField *txtAllSatus;
    IBOutlet UITextField *txtSubTask;
    
    IBOutlet UIButton *btnParcentages;
    IBOutlet UIButton *btnRevisedDate;
    IBOutlet UIButton *btnAssighnTo;
    
    IBOutlet UIButton *btnDelete;
    IBOutlet UIButton *btnTag;
    IBOutlet UIButton *btnAddSubtask;
    IBOutlet UIButton *btnPostNotes;
    IBOutlet UIButton *btnUploadFile;
    IBOutlet UIButton *btnSelectSatus;
    
    IBOutlet UILabel *lblUpload;
    IBOutlet UILabel *lblTest;
    IBOutlet UILabel *lblSubtaskSize;
    IBOutlet UILabel *lblChange;
    IBOutlet UILabel *lblAdd;
    IBOutlet UILabel *lblPlus;
    IBOutlet UILabel *lblWorkDate;

    IBOutlet UILabel *lblDatePickerLable;
    IBOutlet UIImageView *imgSelect;
    NSMutableArray *arrayGetDetail;
    NSString *getActionLogId;
    NSString *getStatus;
    NSString *getActionLogTitle;
}
@property(nonatomic,retain) NSMutableArray *arrayGetDetail;
@property(nonatomic,retain) NSString *getStatus;

@property(nonatomic,retain) NSString *getActionLogId;
@property(nonatomic,retain) NSString *getActionLogTitle;

-(IBAction)EditInfo:(id)sender;
-(IBAction)EditSubtask:(id)sender;
- (IBAction)ReviceDate:(id)sender;
- (IBAction)Completed:(id)sender;
- (IBAction)AddSubtask:(id)sender;
- (IBAction)Back:(id)sender;

- (IBAction)UploadFIle:(id)sender;
- (IBAction)Dashboard:(id)sender;
- (IBAction)Archived:(id)sender;
- (IBAction)Companies:(id)sender;
- (IBAction)User:(id)sender;

@end
