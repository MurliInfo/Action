//
//  ChangePassword.h
//  ActionLog
//
//  Created by Hardik Davda on 2/10/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dashboard.h"
#import "AllMethods.h"
#import "AllWebServices.h"

@interface ChangePassword : UIViewController<UITextFieldDelegate>
{
    IBOutlet UITextField *txtCurrentPassword;
    IBOutlet UITextField *txtNewPassword;
    IBOutlet UITextField *txtConfirmPassword;
}

-(IBAction)Update:(id)sender;
-(IBAction)Cancel:(id)sender;
-(IBAction)Back:(id)sender;
@end
