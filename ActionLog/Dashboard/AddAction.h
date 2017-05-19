//
//  AddAction.h
//  ActionLog
//
//  Created by Hardik Davda on 9/14/16.
//  Copyright © 2016 SLP-World. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AddSubtask.h"
#import "Archived.h"
#import "Companies.h"
#import "Users.h"
#import "CustomCell.h"
#import "CustomData.h"
#import "DropDownListView.h"
#import "ELCImagePickerHeader.h"

@interface AddAction : UIViewController<UITextViewDelegate,UITextFieldDelegate,UITextViewDelegate,kDropDownListViewDelegate,UIScrollViewDelegate,ELCImagePickerControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource>{
    
    IBOutlet UITableView *table;
    IBOutlet UIPickerView *picker;

    NSString *strISEDITE;
    IBOutlet UIDatePicker *myPicker;
    IBOutlet UIView *viewDate;
    IBOutlet UIScrollView *scroll;
    
    //IBOutlet UIScrollView *scrollView;
    AllMethods *Methods;
    DropDownListView * Dropobj;
    IBOutlet UIView *viewImage;
    IBOutlet UIView *viewTagAdd;

    IBOutlet UIView *viewTag;
    IBOutlet UIImageView *imgBoder;
    IBOutlet UIView *viewAll;
    IBOutlet UIView *viewMain;
    IBOutlet UIView *viewBrowser;
     IBOutlet UIView *viewAssignTo;
    IBOutlet UIView *viewButton;
    IBOutlet UIView *viewCollection;
    IBOutlet UIView *viewTagSearch;
    IBOutlet UIView *viewSubTask;
    IBOutlet UILabel *lblSelectedFile;
    IBOutlet UILabel *lblCount1;
    IBOutlet UILabel *lblCount2;
    
    IBOutlet UITextField *txtCreatedBy;
    IBOutlet UITextField *txtTitle;
    IBOutlet UITextField *txtDueDate;
    IBOutlet UITextField *txtWorkDate;
    IBOutlet UITextField *txtAssignTo;
    IBOutlet UITextView *txtDescription;
    IBOutlet UIImageView *imgSelect;
   
    IBOutlet UIView *viewSuperAdminTab;
    IBOutlet UIView *viewAdminTab;
    IBOutlet UIView *viewTab;
    
    
   
    
    
    IBOutlet UILabel *lblPalaceholder;
}
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, copy) NSArray *chosenImages;

@property(strong,nonatomic)IBOutlet NSString *strISEDITE;
- (IBAction)Browse:(id)sender;
- (IBAction)DueDate:(id)sender;
- (IBAction)AssignTo:(id)sender;

- (IBAction)Cancel:(id)sender;
- (IBAction)AddAndUpdate:(id)sender;
- (IBAction)Dashboard:(id)sender;
- (IBAction)Archived:(id)sender;
- (IBAction)Companies:(id)sender;
- (IBAction)User:(id)sender;
@end
