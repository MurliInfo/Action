//
//  ChangePassword.m
//  ActionLog
//
//  Created by Hardik Davda on 2/10/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

#import "ChangePassword.h"

@interface ChangePassword ()
{
    AllMethods *methods;
    NSString *urlChangePassword;
}
@end

@implementation ChangePassword

- (void)viewDidLoad {
    [super viewDidLoad];
    methods = [[AllMethods alloc]init];
    [self webservices];
    // Do any additional setup after loading the view.
}

-(IBAction)Update:(id)senderP{
    if([@"Empty" isEqualToString:[methods whitSpace:[txtCurrentPassword text]]]){
        [self showUiAlertWithMessage:@"Please enter Current password" andtitle:@""];
    }else
    if([@"Empty" isEqualToString:[methods whitSpace:[txtNewPassword text]]]){
        [self showUiAlertWithMessage:@"Please enter New password" andtitle:@""];
    }else
    if([@"Empty" isEqualToString:[methods whitSpace:[txtConfirmPassword text]]]){
        [self showUiAlertWithMessage:@"Please enter Confirm password" andtitle:@""];
    }else
    if(txtNewPassword.text.length <6){
        [self showUiAlertWithMessage:@"Please enter at least 6 characters" andtitle:@""];
    }else
    if(![txtNewPassword.text isEqualToString:txtConfirmPassword.text]){
        [self showUiAlertWithMessage:@"New password and confirm password does not match" andtitle:@""];
    }else{
        NSString *strParameter;
        strParameter = [@"oldpassword=" stringByAppendingString:[txtCurrentPassword.text stringByAppendingString:[@"&newpassword=" stringByAppendingString:txtNewPassword.text ]]];// stringByAppendingString:[@"" stringByAppendingString:txtConfirmPassword.text]]]]];
        NSDictionary *dataDictionary = [[NSDictionary alloc]init];
        dataDictionary = [methods WebServerData:urlChangePassword andPostParameter:strParameter];
        NSLog(@"chaneg password %@",dataDictionary);
        bool status = [[dataDictionary objectForKey:@"status"] boolValue];
        if(status){
            NSArray *dataAry = [dataDictionary objectForKey:@"info"];
            for (NSDictionary *dic in dataAry){
                NSLog(@"Dict %@",dic);
            }
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            NSArray *dataAry = [dataDictionary objectForKey:@"info"];
            for (NSDictionary *dic in dataAry){
                [self showUiAlertWithMessage:[dic objectForKey:@"error_message"] andtitle:@""];
            }
        }
        
    }
}

-(IBAction)Cancel:(id)sender{
    //Dashboard *second = [self.storyboard instantiateViewControllerWithIdentifier:@"dashboard"];
    [self.navigationController popViewControllerAnimated:YES];
 //   [self.navigationController popToViewController:second animated:YES];
//    
//    EditProfile *second=[self.storyboard instantiateViewControllerWithIdentifier:@"editprofile"] ;
//    [self.navigationController pushViewController:second animated:YES];
}

-(IBAction)Back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)showUiAlertWithMessage:(NSString *)message andtitle:(NSString *)title{
    UIAlertView *obj=[[UIAlertView alloc]initWithTitle:@""
                                               message:message
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles: nil];
    [obj show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)webservices{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    AllWebServices *web = [[AllWebServices alloc]init];
    array = [web WebLogin];
    urlChangePassword = [[array objectAtIndex:0]webChangePassword];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
