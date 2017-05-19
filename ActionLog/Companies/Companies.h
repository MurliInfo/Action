//
//  Companies.h
//  ActionLog
//
//  Created by Hardik Davda on 9/14/16.
//  Copyright © 2016 SLP-World. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "Dashboard.h"
#import "Archived.h"
#import "Users.h"
#import "CustomCell.h"
#import "CustomData.h"
#import "UIImage+animatedGIF.h"
#import "AppDelegate.h"
#import "CustomeCellSubtask.h"
@interface Companies : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    AllMethods *Methods;
    IBOutlet UITableView *table;
    IBOutlet UITextField *txtSearch;
    IBOutlet UITextField *txtStatus;
    
    
    IBOutlet UIView *viewSuperAdminTab;
    IBOutlet UIView *viewAdminTab;
    IBOutlet UIView *viewTab;

}

- (IBAction)AddCompany:(id)sender;
- (IBAction)searchStatus:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)Dashboard:(id)sender;
- (IBAction)Archived:(id)sender;
- (IBAction)Companies:(id)sender;
- (IBAction)User:(id)sender;
@end
