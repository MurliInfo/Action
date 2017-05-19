//
//  Login.m
//  ActionLog
//
//  Created by Hardik Davda on 9/14/16.
//  Copyright © 2016 SLP-World. All rights reserved.
//

#import "Login.h"

@interface Login (){
    NSString *webString;
    NSString *urlLogin;
    NSString *urlForgotPassword;
    NSString *urlList;
    NSMutableArray *arrayList;
}

@end

@implementation Login

NSUserDefaults *defaults;
NSString *dataA;
NSString *userName;
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    //slblDemo.text = @"hii \r\nhello";
    Methods = [[AllMethods alloc]init];
    viewForgotPassword.hidden = YES;
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];

    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(logOut:)
                                                 name:@"data"
                                               object:nil];
    
    if ([appDelegate.LOG isEqualToString:@"1"]){
        NSLog(@"LogOut");
        appDelegate.LOG = @"0";
        txtUserEmail.text = @"";
        txtPassword.text =@"";
        // NSString * str = @"LogOut";
        [defaults removeObjectForKey:@"stuts"];
        //[defaults removeObjectForKey:@"Logout"];
        [defaults removeObjectForKey:@"email"];
        [defaults removeObjectForKey:@"password"];
        [defaults removeObjectForKey:@"img"];
        [defaults removeObjectForKey:@"user"];
        [defaults synchronize];
        
        appDelegate.LOG = @"0";
        txtUserEmail.text = @"";
        txtPassword.text =@"";
        [defaults removeObjectForKey:@"email"];
        [defaults removeObjectForKey:@"password"];
        [defaults removeObjectForKey:@"img"];
        [defaults removeObjectForKey:@"user"];
        [defaults removeObjectForKey:@"stuts"];
        [defaults synchronize];
        dataA = @"logout";
        [defaults setObject:dataA forKey:@"stuts"];
        NSUserDefaults *defaultsa = [NSUserDefaults standardUserDefaults];
        [defaultsa setObject:dataA forKey:@"stuts"];
        [defaultsa synchronize];
    }
    [self WebServices];
   // NSLog(@"@All Data := %@",[Methods DateWithFormate:@"2016-09-19 12:35:45" andCurrentFormate:appDelegate.STRWEBDATEFORMATE andNewFormateDate:appDelegate.STRDATEFORMATE]);
    // Do any additional setup after loading the view.
}

- (UIStatusBarStyle)preferredStatusBarStyle{

    // [self setNeedsStatusBarAppearanceUpdate];
    return UIStatusBarStyleLightContent;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(nullable id)sender {
    if([@"Empty" isEqualToString:[Methods whitSpace:txtUserEmail.text]]){
        {
            
        }
    }
    else{
        NSLog(@"Not");
    }
    return YES;
}

#pragma -mark button Action Events
- (IBAction)userLogin:(id)sender{
    NSString *strStatus;
    appDelegate.ARRAYTAG = [[NSMutableArray alloc]init];
    appDelegate.ARRAYTAGVALUE = [[NSMutableArray alloc]init];
    appDelegate.ARRAYCREATEDBY = [[NSMutableArray alloc]init];
    appDelegate.ARRAYASSIGNTO = [[NSMutableArray alloc]init];
    appDelegate.ARRAYFULLASSIGNTO = [[NSMutableArray alloc]init];
    appDelegate.ARRAYDEPARTMENT = [[NSMutableArray alloc]init];
    appDelegate.ARRAYOVERDUE = [[NSMutableArray alloc]init];
    appDelegate.ARRAYCOMPANY = [[NSMutableArray alloc]init];
    
//    if([@"Empty" isEqualToString:[Methods whitSpace:txtUserEmail.text] ] ){
//        [self showUiAlertWithMessage:@"Please write proper email address" andtitle:@""];
//    }else if([@"Empty" isEqualToString:[Methods whitSpace:txtPassword.text]]){
//        [self showUiAlertWithMessage:@"Please write proper password" andtitle:@""];
//    }
//    else{
   // txtUserEmail.text = @"rohit@technobrave.com";
    //txtPassword.text = @"Techno2123";

    
 //   txtUserEmail.text = @"rohit@technobrave.com";
   // txtPassword.text = @"Techno2123";
  
    
    //txtUserEmail.text = @"kavit@technobrave.com";
    //txtUserEmail.text = @"kevin@retptyltd.com";
    //txtPassword.text = @"@dmin416";
    Methods = [[AllMethods alloc]init];
    NSString *parameter = [@"email=" stringByAppendingString:[txtUserEmail.text stringByAppendingString:[@"&password=" stringByAppendingString:txtPassword.text]]];
    
    NSDictionary *dataDictionary = [Methods  WebServerDataForLogin:urlLogin andPostParameter:parameter];
//
    NSLog(@"Login detail %@",dataDictionary);
         NSArray *dataAry = [dataDictionary objectForKey:@"info"];
            strStatus = [dataDictionary objectForKey:@"status"];

    NSLog(@"name %@",strStatus);//
    if([strStatus integerValue]){
        //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        for(NSDictionary *dic in dataAry){
            NSLog(@"name %@",[dic valueForKey:@"username"]);
            appDelegate.STRTOKEN =  [dic valueForKey:@"token"];
            appDelegate.STRUSERNAME = [dic valueForKey:@"username"];
            appDelegate.STRUSERID = [NSString stringWithFormat:@"%@",[dic valueForKey:@"user_id"]];
            appDelegate.STRCOMPANYID = [NSString stringWithFormat:@"%@",[dic valueForKey:@"user_company_id"]];
            int typee = [[dic valueForKey:@"user_type"] intValue];
            if(typee == 1){
                appDelegate.STRUSERTYPE = @"Super Admin";
               // [self showUiAlertWithMessage:@"" andtitle:@""];
            }else if(typee == 2){
                appDelegate.STRUSERTYPE = @"Admin";
            }else if(typee == 3){
                appDelegate.STRUSERTYPE = @"Staff";
            }
            else{
                appDelegate.STRUSERTYPE = @"Staff";
            }
            dataA = @"login";
            appDelegate.LOG = @"1";
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            appDelegate.sesson1 = strStatus;
            [defaults setObject:txtUserEmail.text forKey:@"email"];
            [defaults setObject:txtPassword.text forKey:@"password"];
            [defaults setObject:userName forKey:@"user"];
            [defaults setObject:dataA forKey:@"stuts"];
            //useremail
            [defaults setObject:appDelegate.STRTOKEN forKey:@"token"];
            [defaults setObject:appDelegate.STRUSERTYPE forKey:@"Type"];
            [defaults setObject:appDelegate.STRUSERNAME forKey:@"usename"];
            [defaults setObject:appDelegate.STRUSERID forKey:@"userid"];
            [defaults setObject:appDelegate.STRCOMPANYID forKey:@"companyId"];
            [defaults synchronize];
 
            int type = [[dic valueForKey:@"user_type"] intValue];
            if(type == 1){
                appDelegate.STRUSERTYPE = @"Super Admin";
                Dashboard *second=[self.storyboard instantiateViewControllerWithIdentifier:@"dashboard"] ;
                [self.navigationController pushViewController:second animated:YES];
                //[self showUiAlertWithMessage:@"" andtitle:@""];
            }else if(type == 2){
                appDelegate.STRUSERTYPE = @"Admin";
                Dashboard *second=[self.storyboard instantiateViewControllerWithIdentifier:@"dashboard"] ;
                [self.navigationController pushViewController:second animated:YES];
            }else if(type == 3){
                appDelegate.STRUSERTYPE = @"Staff";
                Dashboard *second=[self.storyboard instantiateViewControllerWithIdentifier:@"dashboard"] ;
                [self.navigationController pushViewController:second animated:YES];
            }
            else{
                appDelegate.STRUSERTYPE = @"Staff";
            }
        }
    }else{
        NSLog(@"Alert Array %@",dataAry);
        
        for(NSDictionary *dic in dataAry){
            [self showUiAlertWithMessage:[dic objectForKey:@"error_message"] andtitle:[dic objectForKey:@"error_title"]];
        }
//        if([strUser isEqualToString:@"Valid"]){
//            [self showUiAlertWithMessage:@"Please enter valid password" andtitle:@""];
//        }else{
//            [self showUiAlertWithMessage:@"Please enter valid user Email" andtitle:@""];
//        }
    }
}

-(void)pdf{
  
}

- (IBAction)Forgotpassword:(id)sender{
    viewForgotPassword.hidden = NO;
    
}

- (IBAction)Cancel:(id)sender{
    viewForgotPassword.hidden = YES;
}

- (IBAction)Submit:(id)sender{
   
    NSString *parameter = [@"email=" stringByAppendingString:txtEmail.text];
    NSDictionary *dataDictionary = [Methods  WebServerDataForLogin:urlForgotPassword andPostParameter:parameter];
    NSLog(@"Login detail %@",dataDictionary);
    NSArray *dataAry = [dataDictionary objectForKey:@"info"];
    bool strStatus = [dataDictionary objectForKey:@"status"];
   // NSLog(@"Responce := %@ \n error %@ =:==",dataAry,[dataDictionary objectForKey:@"error_message"]);
    
    if(strStatus){
        for(NSDictionary *dic in dataAry){
            [self showUiAlertWithMessage:[dic objectForKey:@"success_message"] andtitle:@""];
        }
    }
    else{
         viewForgotPassword.hidden = YES;
        for(NSDictionary *dic in dataAry){
            [self showUiAlertWithMessage:[dic objectForKey:@"success_message"] andtitle:@""];
        }
        
    }
}

#pragma -mark Userdefine Functions

-(void)WebServices{
    AllWebServices *web = [[AllWebServices alloc]init];
    
    NSMutableArray *array = [web WebLogin];
    urlLogin = [[array objectAtIndex:0]webLogin];
    urlList = [[array objectAtIndex:0]webList];
    urlForgotPassword = [[array objectAtIndex:0]webForgotPassword];
    
//    arrayList = [[NSMutableArray alloc]init];
//    //NSString *parameter = [@"token=" stringByAppendingString:appDelegate.STRTOKEN];
//    //NSDictionary *dataDictionary = [Methods  WebServerData:urlList andPostParameter:@""];
//  //  NSLog(@"All list  %@",dataDictionary);.
//    NSDictionary *dataDictionary;
//
//    {
//        NSURL *url;
//        url = [NSURL URLWithString:urlList];
//        NSMutableURLRequest *theRequest   = [[NSMutableURLRequest alloc] initWithURL:url];
//        [ theRequest setHTTPMethod: @"POST" ];
//        [ theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
//    //    NSString *postString = Parameter;
//        //[theRequest setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
//        NSError *errorReturned = nil;
//        NSURLResponse *theResponse =[[NSURLResponse alloc]init];
//        NSData *data;
//        data = [NSURLConnection sendSynchronousRequest:theRequest
//                                     returningResponse:&theResponse
//                                                 error:&errorReturned];
//        if (errorReturned){
//            // [self showUiAlertWithMessage:@"Please try to connect your network and try it again" andtitle:@"Alert"];
//        }
//        else{
//            dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errorReturned];
//            //NSString *retVal = [NSString stringWithUTF8String:[data bytes]];
//       //     NSLog(@"DATA From WEBSERVER %@",retVal);
//        }
//       
//    }
//    //  NSArray *dataAry = [dataDictionary objectForKey:@"info"];
//    // NSLog(@"Tag List +--- %@",dataAry);
//    NSArray *keys;
//    int i, count;
//    id key, value;
//    
//    NSDictionary *dict = [dataDictionary objectForKey:@"info"];
//    keys = [dict allKeys];
//    count =(int)[keys count];
//    for (i = 0; i < count; i++){
//        CustomData *cmd = [[CustomData alloc]init];
//        key = [keys objectAtIndex: i];
//        value = [dict objectForKey: key];
//        cmd.strKey =[NSString stringWithFormat:@"%@",key];
//        cmd.strStatus =[NSString stringWithFormat:@"%@",value];
//        cmd.strPropertyAddress =[NSString stringWithFormat:@"%@",value];
//        [arrayList addObject:cmd];
//    }

}

#pragma -mark uitextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{        // called when 'return' key pressed. return NO to ignore.
    [textField resignFirstResponder];
    return YES;
}

-(IBAction)DidChange :(UITextField *)theTextField{
    NSLog( @"text changed: %@", theTextField.text);
    if([@"Empty" isEqualToString:[Methods whitSpace:txtUserEmail.text]]){
        lblUSerEmail.hidden = NO;
    }
    else{
        lblUSerEmail.hidden = YES;
    }
    if([@"Empty" isEqualToString:[Methods whitSpace:txtPassword.text]]){
        lblPassword.hidden = NO;
    }else{
        lblPassword.hidden = YES;
    }
}

-(void)showUiAlertWithMessage:(NSString *)message andtitle:(NSString *)title{
    UIAlertView *obj=[[UIAlertView alloc]initWithTitle:title
                                               message:message
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles: nil];
    [obj show];
}


- (void)logOut:(NSNotification *) notification{
    NSLog(@"LogOut");
   // appDelegate.log = 0;
    txtUserEmail.text = @"";
    txtPassword.text =@"";
    NSString * str = @"LogOut";
    
    [defaults setObject:str forKey:@"stuts"];
    [defaults synchronize];
    
    
    //[defaults removeObjectForKey:@"Logout"];
    [defaults removeObjectForKey:@"email"];
    [defaults removeObjectForKey:@"password"];
    [defaults removeObjectForKey:@"img"];
    [defaults removeObjectForKey:@"user"];
    [defaults synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self parentViewController];
}


- (void)didReceiveMemoryWarning {//
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
