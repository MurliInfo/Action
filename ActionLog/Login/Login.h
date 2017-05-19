//
//  Login.h
//  ActionLog
//
//  Created by Hardik Davda on 9/14/16.
//  Copyright © 2016 SLP-World. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dashboard.h"
#import <CoreLocation/CoreLocation.h>


@interface Login : UIViewController<UITextFieldDelegate,CLLocationManagerDelegate>{
    AllMethods *Methods;
    CLLocationManager *locationManager;
    IBOutlet UIImageView *img;
    IBOutlet UIView *viewForgotPassword;
    
    IBOutlet UITextField *txtEmail;
    
    IBOutlet UILabel *lblUSerEmail;
    IBOutlet UILabel *lblPassword;
    IBOutlet UITextField *txtUserEmail;
    IBOutlet UITextField *txtPassword;
}

- (IBAction)userLogin:(id)sender;
- (IBAction)Forgotpassword:(id)sender;
- (IBAction)Cancel:(id)sender;
- (IBAction)Submit:(id)sender;

@end
