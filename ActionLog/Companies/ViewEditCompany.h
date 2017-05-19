//
//  ViewEditCompany.h
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

@interface ViewEditCompany : UIViewController<UITextFieldDelegate>{
    AllMethods *Methods;
    IBOutlet UITextField *txtCompanyName;
    IBOutlet UITextField *txtCompanyAbbreviation;
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
- (IBAction)Update:(id)sender;
- (IBAction)GoBack:(id)sender;
- (IBAction)Cancel:(id)sender;
- (IBAction)StreetType:(id)sender;
- (IBAction)State:(id)sender;
- (IBAction)Suburb:(id)sender;
- (IBAction)ChooesProfile:(id)sender;
- (IBAction)Edit:(id)sender;
- (IBAction)Dashboard:(id)sender;
- (IBAction)Archived:(id)sender;
- (IBAction)Companies:(id)sender;
- (IBAction)User:(id)sender;
@end
