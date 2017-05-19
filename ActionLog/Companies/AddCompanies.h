//
//  AddCompanies.h
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
@interface AddCompanies : UIViewController<UITextFieldDelegate>{
    AllMethods *Methods;
    IBOutlet UITextField *txtCompanyName;
    IBOutlet UITextField *txtCompanyAbbreviation;
    IBOutlet UITextField *txtDepartmentName;
    IBOutlet UITextField *txtTimeZone;
    IBOutlet UITextField *txtFirstName;
    IBOutlet UITextField *txtLastName;
    IBOutlet UITextField *txtEmail;
    IBOutlet UITextField *txtPassword;
    IBOutlet UITextField *txtConfirmPassword;
    IBOutlet UITextField *txtMobile;
    IBOutlet UITextField *txtWebsite;
    IBOutlet UITextField *txtUnitNo;
    IBOutlet UITextField *txtStreetName;
    IBOutlet UITextField *txtStreetType;
    IBOutlet UITextField *txtState;
    IBOutlet UITextField *txtSuburb;
    IBOutlet UITextField *txtPostCode;
    
    
    IBOutlet UIView *viewSuperAdminTab;
    IBOutlet UIView *viewAdminTab;
    IBOutlet UIView *viewTab;

    
}
- (IBAction)Add:(id)sender;
- (IBAction)Cancel:(id)sender;
- (IBAction)StreetType:(id)sender;
- (IBAction)State:(id)sender;
- (IBAction)Suburb:(id)sender;
- (IBAction)ChooesProfile:(id)sender;
- (IBAction)TimeZone:(id)sender;
- (IBAction)Dashboard:(id)sender;
- (IBAction)Archived:(id)sender;
- (IBAction)Companies:(id)sender;
- (IBAction)User:(id)sender;
@end
