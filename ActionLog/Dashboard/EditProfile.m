//
//  EditProfile.m
//  ActionLog
//
//  Created by Hardik Davda on 2/9/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

#import "EditProfile.h"

@interface EditProfile (){
    UIView *viewBackGround;
    UIView *viewLoader;
    NSTimer *timer;
    int key;
    NSString *urlUserUpdate;
    NSString *urlDepartmentList;
    NSString *urlTimezoneList;
    NSString *urlCompany;
     NSString *urlUserProfile;
    NSString *urlForApprovalCount;

    NSString *urlEditProfile;
    
    NSMutableArray *arrayDepartment;
    NSMutableArray *arrayCompanies;
    NSMutableArray *arrayTimeZone;
    NSMutableArray *arrayType;
    NSMutableArray *arrayPrint;
    NSMutableArray *arrayPrint1;
    NSMutableArray *arrayPrint2;
    NSMutableArray *arrayPrinting;
    NSString *SELECTPICKER;
    NSString *strDepartmentId;
    NSString *strCompanyId;
    NSString *strTypeId;
    NSString *strTimezoneId;
    CGRect FrameScroll;
}

@end

@implementation EditProfile

@synthesize arrayGet,strGet;
- (void)viewDidLoad {
    [super viewDidLoad];
    FrameScroll =  scroll.frame;
    viewPickerView.hidden = YES;
    imgType.hidden = NO;
    imgCompany.hidden = NO;
    imgDepartment.hidden = NO;
    
    imgTypeDisebal.hidden = YES;
    imgDepartmentDisebal.hidden = YES;
    imgCompanyDisebal.hidden = YES;
    
    [self manageSuperAdmin:appDelegate.STRUSERTYPE];
    
    [self setNeedsStatusBarAppearanceUpdate];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardOnScreen:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    // [self setNeedsStatusBarAppearanceUpdate];
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    Methods = [[AllMethods alloc]init];
    timer = [NSTimer scheduledTimerWithTimeInterval:.000001 target:self selector:@selector(initialize) userInfo:nil repeats:NO];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(stopGIF) userInfo:nil repeats:NO];

}

- (void)initialize{

    strCompanyId = @"00";
    [self WebServices];
    if([appDelegate.STRUSERTYPE isEqualToString:@"Staff"]){
        btnCompany.hidden = YES;
        btnDepartment.hidden = YES;
        btnType.hidden = YES;
        imgType.hidden = YES;
        imgCompany.hidden = YES;
        imgDepartment.hidden = YES;
        
        imgTypeDisebal.hidden = NO;
        imgDepartmentDisebal.hidden = NO;
        imgCompanyDisebal.hidden = NO;
        
    }else if([appDelegate.STRUSERTYPE isEqualToString:@"Admin"]){
        btnCompany.hidden = YES;
        strCompanyId = appDelegate.STRCOMPANYID;
        imgType.hidden = NO;
        imgCompany.hidden = YES;
        imgDepartment.hidden = NO;
        btnType.userInteractionEnabled = false;
        
//        imgTypeDisebal.hidden = YES;
//        imgDepartmentDisebal.hidden = YES;
        imgCompanyDisebal.hidden = NO;
        
        btnCompany.hidden = YES;
        btnDepartment.hidden = YES;
        btnType.hidden = YES;
        imgType.hidden = YES;
        imgCompany.hidden = YES;
        imgDepartment.hidden = YES;
        
        imgTypeDisebal.hidden = NO;
        imgDepartmentDisebal.hidden = NO;
        imgCompanyDisebal.hidden = NO;
        
        
        
        [self GetDepartment];
    }else if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
        [self GetCompany];
        imgType.hidden = YES;
        imgCompany.hidden = YES;
        imgDepartment.hidden = YES;
        btnType.userInteractionEnabled = false;
//        imgTypeDisebal.hidden = YES;
//        imgDepartmentDisebal.hidden = YES;
//        imgCompanyDisebal.hidden = YES;
        
        
        btnCompany.hidden = YES;
        btnDepartment.hidden = YES;
        btnType.hidden = YES;
        imgType.hidden = YES;
        imgCompany.hidden = YES;
        imgDepartment.hidden = YES;
        
        imgTypeDisebal.hidden = NO;
        imgDepartmentDisebal.hidden = NO;
        imgCompanyDisebal.hidden = NO;
        
    }
    
    
    
    
    scroll.contentSize = CGSizeMake(0, viewMain.frame.size.height);
   
    [self GetType];
    [self GetTimeZone];

    [self printGrid];
    
    viewPickerView.hidden = YES;
    
}

-(void)PrintText{
    
    for(int i=0;i<arrayTimeZone.count;i++){
        if([[[arrayTimeZone objectAtIndex:i]strTimezoneId] isEqualToString:[[arrayPrinting objectAtIndex:0]strTimezoneId]])
            txtTimeZone.text=[[arrayTimeZone objectAtIndex:i]strTimezoneName];
        strTimezoneId =[[arrayGet objectAtIndex:0]strTimezoneId];
    }
   // strTypeId = [[arrayPrinting objectAtIndex:0]strUserType];
//    if([[[arrayPrinting objectAtIndex:0]strUserType] isEqualToString:@"1"])
//        txtType.text = @"Super Admin";
//    if([[[arrayPrinting objectAtIndex:0]strUserType] isEqualToString:@"2"])
//        txtType.text = @"Admin";
//    if([[[arrayPrinting objectAtIndex:0]strUserType] isEqualToString:@"3"])
//        
        txtType.text =[[arrayPrinting objectAtIndex:0]strUserType];// @"Staff";
//    for(int i=0;i<arrayType.count;i++){
//        if([[[arrayType objectAtIndex:i]strUserId] isEqualToString:[[arrayPrinting objectAtIndex:0]strUserType]]){
//            strTypeId =[[arrayType objectAtIndex:i]strUserId];
//            
//        }
//    }
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
        if([[[arrayPrinting objectAtIndex:0]strUserType] isEqualToString:@"1"]){
        }else{
            for(int i=0;i<arrayCompanies.count;i++){
                
                if([[[arrayCompanies objectAtIndex:i]strCompanyId] isEqualToString:[[arrayGet objectAtIndex:0]strCompanyId]]){
                    NSLog(@"Company name %@",[[arrayCompanies objectAtIndex:i]strPropertyAddress]);
                    txtCompany.text=[[arrayCompanies objectAtIndex:i]strPropertyAddress];
                    strCompanyId = [[arrayGet objectAtIndex:0]strCompanyId];
                    [self GetDepartment];
                    break;
                }
            }
        }
    }
    for(int i=0;i<arrayDepartment.count;i++){
        if([[[arrayDepartment objectAtIndex:i]strDepartmentId] isEqualToString:[[arrayPrinting objectAtIndex:0]strDepartmentId]]){
            txtDepartment.text=[[arrayDepartment objectAtIndex:i]strDepartmentName];
            strDepartmentId = [[arrayPrinting objectAtIndex:0]strDepartmentId];
        }
    }
    strTimezoneId = [[arrayPrinting objectAtIndex:0]strTimezoneId];
    strDepartmentId = [[arrayPrinting objectAtIndex:0]strDepartmentId];
    strCompanyId = [[arrayPrinting objectAtIndex:0]strCompanyId];
    txtFirstName.text = [[arrayPrinting objectAtIndex:0]strFirstName];
    txtLastName.text = [[arrayPrinting objectAtIndex:0]strLastName];
    txtEmail.text = [[arrayPrinting objectAtIndex:0]strUserEmail];
    txtMobile.text = [[arrayPrinting objectAtIndex:0]strMobileNumber];
    txtCompany.text = [[arrayPrinting objectAtIndex:0]strCompanyName];
    txtDepartment.text = [[arrayPrinting objectAtIndex:0]strDepartmentName];
}

#pragma mark - GIF Delegate

-(void)viewMain{
    viewBackGround = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [viewBackGround setBackgroundColor:[UIColor whiteColor]];
    viewBackGround.alpha = 0.6f;
    [self.view addSubview:viewBackGround];
    
    UIImageView *imgLoading = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,100,100)];
    viewLoader= [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-50, 100 ,100)];
    [viewLoader setBackgroundColor:[UIColor clearColor]];
    NSURL *url1 = [[NSBundle mainBundle] URLForResource:@"60" withExtension:@"gif"];
    imgLoading.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url1]];
    [viewLoader addSubview:imgLoading];
    [self.view addSubview:viewLoader];
}

-(void)stopGIF{
    [viewLoader removeFromSuperview];
    [viewBackGround removeFromSuperview];
}

#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    return [arrayPrint count];
}

#pragma mark- Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    if([SELECTPICKER isEqualToString:@"Timezone"]){
    //    [txtTimeZone setText:[[arrayPrint objectAtIndex:row] strPropertyAddress]];
        strTimezoneId = [[arrayPrint objectAtIndex:row] strTimezoneId];
    }
    if([SELECTPICKER isEqualToString:@"Type"]){
     //   [txtType setText:[[arrayPrint objectAtIndex:row] strPropertyAddress]];
      //  strTypeId = [[arrayPrint objectAtIndex:row]strUserId];
    }
    if([SELECTPICKER isEqualToString:@"Department"]){
       // [txtDepartment setText:[[arrayPrint objectAtIndex:row] strPropertyAddress]];
        strDepartmentId = [[arrayPrint objectAtIndex:row]strDepartmentId];
        
    }
    if([SELECTPICKER isEqualToString:@"Compnay"]){
   //     [txtCompany setText:[[arrayPrint objectAtIndex:row] strPropertyAddress]];
       strCompanyId = [[arrayPrint objectAtIndex:row]strDepartmentId];
        txtDepartment.text = @"Departments";
        strDepartmentId=@"00";
    }
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    return [[arrayPrint objectAtIndex:row]strPropertyAddress];
}

#pragma -mark Button IBAction (click Events)

- (IBAction)SelectTimezone:(id)sender {
    if(arrayTimeZone.count != 0){
        SELECTPICKER = @"Timezone";
        viewPickerView.hidden = NO;
        //[self GetTimeZone];
        arrayPrint = [NSMutableArray arrayWithArray:arrayTimeZone];
        //  arrayPrint1 = [NSMutableArray arrayWithArray:arrayTimeZone];
        [picker reloadAllComponents];
        CGRect Frame = viewPickerView.frame;
        Frame.origin.y  = viewTimezone.frame.origin.y+txtTimeZone.frame.size.height+txtTimeZone.frame.origin.y+2;
        viewPickerView.frame = Frame;
    }
}

- (IBAction)SelectType:(id)sender {
    if(arrayType.count != 0){
        SELECTPICKER = @"Type";
        viewPickerView.hidden = NO;
        arrayPrint = [NSMutableArray arrayWithArray:arrayType];
        [picker reloadAllComponents];
        
        CGRect Frame = viewPickerView.frame;
        Frame.origin.y  = viewType.frame.origin.y+txtType.frame.size.height+txtType.frame.origin.y+2;
        viewPickerView.frame = Frame;
        //[self GetType];
    }
}

-(IBAction)Back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)SelectCompany:(id)sender {
    if(arrayCompanies.count != 0){
        SELECTPICKER = @"Compnay";
        viewPickerView.hidden = NO;
        
        arrayPrint = [NSMutableArray arrayWithArray:arrayCompanies];
        [picker reloadAllComponents];
        CGRect Frame = viewPickerView.frame;
        Frame.origin.y  = viewCompany.frame.origin.y+txtCompany.frame.size.height+txtCompany.frame.origin.y+2;
        viewPickerView.frame = Frame;
    }
}

- (IBAction)SelectDepartment:(id)sender {
    if(arrayDepartment.count != 0){
        SELECTPICKER = @"Department";
        viewPickerView.hidden = NO;
        
        arrayPrint = [NSMutableArray arrayWithArray:arrayDepartment];
        [picker reloadAllComponents];
        CGRect Frame = viewPickerView.frame;
        Frame.origin.y  = viewDepartment.frame.origin.y+txtDepartment.frame.size.height+txtDepartment.frame.origin.y+2;
        viewPickerView.frame = Frame;
    }
}

- (IBAction)Add:(id)sender{
    NSString *parameter;
    NSString *strPASSMATCH =@"NO";
    // NSString *strEmail =@"";
    
    BOOL b=[self NSStringIsValidEmail:txtEmail.text];
    // NSLog(@"Email %@",b);
    if (!b) {
        //NSLog(@"You got: YES");
    }
    if(![appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
        if([@"00" isEqualToString:strCompanyId] || [@"0" isEqualToString:strCompanyId] || [@"" isEqualToString:strCompanyId])
            [self showUiAlertWithMessage:@"Please Select Company" andtitle:@""];
        else
            if([@"00" isEqualToString:strDepartmentId] || [@"0" isEqualToString:strDepartmentId] || [@"" isEqualToString:strDepartmentId])
                [self showUiAlertWithMessage:@"Please Select Department" andtitle:@""];
    }
   
    if([txtFirstName.text isEqualToString:[Methods whitSpace:txtFirstName.text]])
        [self showUiAlertWithMessage:@"Please write first name" andtitle:@""];
    else
    if([@"Empty" isEqualToString:[Methods whitSpace:txtEmail.text]])
        [self showUiAlertWithMessage:@"Please write Email" andtitle:@""];
    else
     if (!b)
         [self showUiAlertWithMessage:@"Please write proper email" andtitle:@""];
    else{
        NSString *userTypeId;
        if([txtType.text isEqualToString:@"Super Admin"])
            userTypeId = @"1";
        else if([txtType.text isEqualToString:@"Admin"])
            userTypeId = @"2";
        else if([txtType.text isEqualToString:@"Staff"])
            userTypeId = @"3";
        
        if([txtType.text isEqualToString:@"Super Admin"] || [txtType.text isEqualToString:@"Admin"] || [txtType.text isEqualToString:@"Staff"]){
            parameter = [@"user_id="stringByAppendingString:
                         [[[arrayPrinting objectAtIndex:0]strUserId] stringByAppendingString:
                          [@"&timezone_id=" stringByAppendingString:
                           [strTimezoneId stringByAppendingString:
                            [@"&user_type_id=" stringByAppendingString:
                             [userTypeId stringByAppendingString:
                              [@"&firstname=" stringByAppendingString:
                               [txtFirstName.text stringByAppendingString:
                                [@"&email=" stringByAppendingString:
                                 txtEmail.text]]]]]]]]];
        }
        if( [txtType.text isEqualToString:@"Admin"] || [txtType.text isEqualToString:@"Staff"]){
            [@"&department_id="stringByAppendingString:
             [strDepartmentId stringByAppendingString:
              [@"&company_id=" stringByAppendingString:
               strCompanyId]]];
        }
        
//        parameter = [@"user_id="stringByAppendingString:
//                     [[[arrayPrinting objectAtIndex:0]strUserId] stringByAppendingString:
//                      [@"&timezone_id=" stringByAppendingString:
//                       [strTimezoneId stringByAppendingString:
//                        [@"&user_type_id=" stringByAppendingString:
//                         [userTypeId stringByAppendingString:
//                          [@"&firstname=" stringByAppendingString:
//                           [txtFirstName.text stringByAppendingString:
//                            [@"&email=" stringByAppendingString:
//                             [txtEmail.text stringByAppendingString:
//                              [@"&department_id="stringByAppendingString:
//                               [strDepartmentId stringByAppendingString:
//                                [@"&company_id=" stringByAppendingString:
//                                 strCompanyId]]]]]]]]]]]]];
        
        if([@"NotEmpty" isEqualToString:[Methods whitSpace:txtMobile.text]])
            parameter = [parameter stringByAppendingString:[@"&mobile=" stringByAppendingString:txtMobile.text]];
        if([@"NotEmpty" isEqualToString:[Methods whitSpace:txtLastName.text]])
            parameter = [parameter stringByAppendingString:[@"&lastname=" stringByAppendingString:txtLastName.text]];
     
        NSDictionary *DataDictionary = [Methods WebServerData:urlUserProfile andPostParameter:parameter];
        NSLog(@"DataDictionary %@",DataDictionary);
        // status
        bool dataAry = [DataDictionary objectForKey:@"status"];
        if(dataAry){
            [self showUiAlertWithMessage:[DataDictionary objectForKey:@"info"] andtitle:@""];
            [self Cancel:sender];
        }else
        {
            NSArray *dataAry = [DataDictionary objectForKey:@"info"];
            for (NSDictionary *dic in dataAry) {
                NSString *strMessge = [dic valueForKey:@"error_message"];
                NSString *strTitle = [dic valueForKey:@"error_title"];
                [self showUiAlertWithMessage:strMessge andtitle:strTitle];
            }
        }
    }
}

- (IBAction)Cancel:(id)sender{
//    Dashboard *second=[self.storyboard instantiateViewControllerWithIdentifier:@"dashboard"] ;
//    [self.navigationController pushViewController:second animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)HidePicker:(id)sender{
    viewPickerView.hidden = YES;
}

- (IBAction)Done:(id)sender{
    viewPickerView.hidden = YES;
    int idt =(int)[picker selectedRowInComponent:0] ;
    if([SELECTPICKER isEqualToString:@"Timezone"]){
        [txtTimeZone setText:[[arrayPrint objectAtIndex:idt] strPropertyAddress]];
        strTimezoneId = [[arrayPrint objectAtIndex:idt] strTimezoneId];
    }
    if([SELECTPICKER isEqualToString:@"Type"]){
        [txtType setText:[[arrayPrint objectAtIndex:idt] strPropertyAddress]];
        strTypeId = [[arrayPrint objectAtIndex:idt]strUserId];
        if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
            if([txtType.text isEqualToString:@"Super Admin"]){
                txtDepartment.text = @"Departments";
                strDepartmentId=@"00";
                txtCompany.text = @"Companies";
                strCompanyId=@"00";
            }
            [self manageSuperAdmin:[[arrayPrint objectAtIndex:idt] strPropertyAddress]];
        }
    }
    if([SELECTPICKER isEqualToString:@"Department"]){
        [txtDepartment setText:[[arrayPrint objectAtIndex:idt] strPropertyAddress]];
        strDepartmentId = [[arrayPrint objectAtIndex:idt]strDepartmentId];
    }
    if([SELECTPICKER isEqualToString:@"Compnay"]){
        [txtCompany setText:[[arrayPrint objectAtIndex:idt] strPropertyAddress]];
        strCompanyId = [[arrayPrint objectAtIndex:idt]strCompanyId];
        [self GetDepartment];
        
    }
}


#pragma -mark User define function

-(void)WebServices{
    AllWebServices *web = [[AllWebServices alloc]init];
    NSMutableArray *array = [web EditProfile];
    urlForApprovalCount = [[array objectAtIndex:0]webForApprvalCount];
    urlUserUpdate = [[array objectAtIndex:0]webUserUpdate];
    urlTimezoneList = [[array objectAtIndex:0]webTimezoneList];
    urlForApprovalCount = [[array objectAtIndex:0]webForApprvalCount];
    urlDepartmentList = [[array objectAtIndex:0]webDepartmentList];
    urlCompany = [[array objectAtIndex:0]webCompany];
    urlEditProfile = [[array objectAtIndex:0]webEditProfile];
    urlUserProfile = [[array objectAtIndex:0]webProfileUpdate];
    //NSLog(@"All webservice %@",array);
}

-(void)GetForApprovalCount{
    // urlForApprovalCount = [[array objectAtIndex:0]webForApprvalCount];
    //    strForApprovalCount = @"";
    NSDictionary *dataDictionary = [Methods  WebServerData:urlForApprovalCount];
    
    bool status = [dataDictionary objectForKey:@"status"];
    if(status){
        NSLog(@" ForApproval count: - %@",[dataDictionary objectForKey:@"info"]);
        if ([[dataDictionary objectForKey:@"info"] isEqualToString:@"0"]){
            lblCount1.hidden = YES;
            lblCount2.hidden = YES;
        }else{
            lblCount1.hidden = NO;
            lblCount2.hidden = NO;
            lblCount1.text = [dataDictionary objectForKey:@"info"];
            lblCount2.text = [dataDictionary objectForKey:@"info"];
            lblCount1.layer.masksToBounds = YES;
            lblCount1.layer.cornerRadius = 8.0;
            
            lblCount2.layer.masksToBounds = YES;
            lblCount2.layer.cornerRadius = 8.0;
        }
    }
}


-(void)GetTimeZone{
    NSString *parameter = [@"token=" stringByAppendingString:[appDelegate.STRTOKEN  stringByAppendingString:[@"&company_id=" stringByAppendingString:appDelegate.STRCOMPANYID]]];
    NSDictionary *dataDictionary = [Methods  WebServerData:urlTimezoneList andPostParameter:parameter];
    //NSLog(@"GetTimeZone dataDictionary %@",dataDictionary);
    NSArray *dataAry = [dataDictionary objectForKey:@"info"];
    
    NSString *strData = [dataDictionary objectForKey:@"status"];
    // if([appDelegate.ISAPPROVE isEqualToString:@"NO"])
    
    if([strData intValue])
    {
        arrayTimeZone = [[NSMutableArray alloc]init];
        arrayPrint = [[NSMutableArray alloc]init];
        // NSLog(@"All data of grid %@",dataAry);
        for (NSDictionary *dic in dataAry) {
            CustomData *cmd = [[CustomData alloc]init];
            cmd.strTimezoneId = [dic valueForKey:@"timezone_id"];
            cmd.strTimezoneName = [dic valueForKey:@"timezone_name"];
            cmd.strPropertyAddress = [dic valueForKey:@"timezone_name"];
            cmd.strTimezoneCode = [dic valueForKey:@"timezone_code"];
            [arrayTimeZone addObject:cmd];
            [arrayPrint addObject:cmd];
        }
        [picker reloadAllComponents];
    }
    
}


-(void)GetCompany{
    if(appDelegate.ARRAYCOMPANY.count ==0){
        NSDictionary *dataDictionary = [Methods  WebServerData:urlCompany];
        NSArray *keys;
        int i, count;
        id key1, value;
        arrayCompanies = [[NSMutableArray alloc]init];
        NSDictionary *dict = [dataDictionary objectForKey:@"info"];
        keys = [dict allKeys];
        count =(int)[keys count];
        CustomData *cmd = [[CustomData alloc]init];
        cmd.strKey =@"00";
        cmd.strCompanyId =@"00";
        cmd.strStatus =@"Companies";
        cmd.strPropertyAddress = @"Companies";
        [arrayCompanies addObject:cmd];
        
        for (i = 0; i < count; i++){
            CustomData *cmd = [[CustomData alloc]init];
            key1 = [keys objectAtIndex: i];
            value = [dict objectForKey: key1];
            cmd.strKey =[NSString stringWithFormat:@"%@",key1];
            cmd.strCompanyId =[NSString stringWithFormat:@"%@",key1];
            cmd.strStatus =[NSString stringWithFormat:@"%@",value];
            cmd.strPropertyAddress =[NSString stringWithFormat:@"%@",value];
            [arrayCompanies addObject:cmd];
        }
    }else{
        //NSLog(@"COMPANY SAVE");
        arrayCompanies = [[NSMutableArray alloc]initWithArray:appDelegate.ARRAYCOMPANY];
    }
}

-(void)GetDepartment{
    if([strCompanyId isEqualToString:@"00"]){
        arrayDepartment = [[NSMutableArray alloc]init];
        arrayPrint= [[NSMutableArray alloc]init];
        arrayPrint1= [[NSMutableArray alloc]init];
        
        CustomData *cmd = [[CustomData alloc]init];
        cmd.strDepartmentId = @"00";
        cmd.strCompanyId = @"00";
        cmd.strDepartmentName = @"Departments";
        cmd.strPropertyAddress = @"Departments";
        [arrayDepartment addObject:cmd];
       // [arrayDepartmentTest addObject:cmd];
    }else{
        NSString *parameter = [@"token=" stringByAppendingString:[appDelegate.STRTOKEN  stringByAppendingString:[@"&company_id=" stringByAppendingString:strCompanyId]]];
        NSDictionary *dataDictionary = [Methods  WebServerData:urlDepartmentList andPostParameter:parameter];
        //NSLog(@"DepartmentList dataDictionary %@",dataDictionary);
        NSArray *dataAry = [dataDictionary objectForKey:@"info"];
        NSString *strData = [dataDictionary objectForKey:@"status"];
        // if([appDelegate.ISAPPROVE isEqualToString:@"NO"])
        
        if([strData intValue]){
            arrayDepartment = [[NSMutableArray alloc]init];
            arrayPrint= [[NSMutableArray alloc]init];
            arrayPrint1= [[NSMutableArray alloc]init];
            
            CustomData *cmd = [[CustomData alloc]init];
            cmd.strDepartmentId = @"00";
            cmd.strCompanyId = @"00";
            cmd.strDepartmentName = @"Departments";
            cmd.strPropertyAddress = @"Departments";
            [arrayDepartment addObject:cmd];
        //    [arrayDepartmentTest addObject:cmd];
            // NSLog(@"All data of grid %@",dataAry);
            for (NSDictionary *dic in dataAry) {
                CustomData *cmd = [[CustomData alloc]init];
                cmd.strDepartmentId = [dic valueForKey:@"department_id"];
                cmd.strDepartmentName = [dic valueForKey:@"department_name"];
                cmd.strPropertyAddress = [dic valueForKey:@"department_name"];
                cmd.strDepartmentStatus = [dic valueForKey:@"department_status"];
                [arrayDepartment addObject:cmd];
          //      [arrayDepartmentTest addObject:cmd];
                [arrayPrint addObject:cmd];
            }
            [picker reloadAllComponents];
        }
    }
}

-(void)GetType{
    arrayType = [[NSMutableArray alloc]init];
    arrayPrint = [[NSMutableArray alloc]init];
    CustomData *cmd = [[CustomData alloc]init];
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
        CustomData *cmd = [[CustomData alloc]init];
        cmd.strPropertyAddress = @"Super Admin";
        cmd.strUserId = @"1";
        [arrayType addObject:cmd];
        [arrayPrint addObject:cmd];
        
    }
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]  || [appDelegate.STRUSERTYPE isEqualToString:@"Admin"] ){
        cmd = [[CustomData alloc]init];
        cmd.strPropertyAddress = @"Admin";
        cmd.strUserId = @"2";
        [arrayType addObject:cmd];
        [arrayPrint addObject:cmd];
        [picker reloadAllComponents];
    }
    
    
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"] || [appDelegate.STRUSERTYPE isEqualToString:@"Staff"] || [appDelegate.STRUSERTYPE isEqualToString:@"Admin"] ){
        cmd = [[CustomData alloc]init];
        cmd.strPropertyAddress = @"Staff";
        cmd.strUserId = @"3";
        [arrayType addObject:cmd];
        [arrayPrint addObject:cmd];
        [picker reloadAllComponents];
    }
    
   
}

-(void)manageSuperAdmin :(NSString *) param{
    if([param isEqualToString:@"Staff"] || [param isEqualToString:@"Admin"]){
        viewDepartment.hidden = NO;
        viewCompany.hidden = NO;
        CGRect Frame = viewCompany.frame;
        Frame.origin.y   = viewType.frame.origin.y+viewType.frame.size.height-4;
        viewCompany.frame = Frame;
        
        Frame = viewDepartment.frame;
        Frame.origin.y   = viewCompany.frame.origin.y+viewCompany.frame.size.height-4;
        viewDepartment.frame = Frame;
        
        Frame = viewAll.frame;
        Frame.origin.y   = viewDepartment.frame.origin.y+viewDepartment.frame.size.height-4;
        viewAll.frame = Frame;
        
        Frame = viewMain.frame;
        Frame.size.height   = viewAll.frame.origin.y+viewAll.frame.size.height;
        viewMain.frame = Frame;
        scroll.contentSize = CGSizeMake(0, viewMain.frame.size.height);
    }else{
        viewDepartment.hidden = YES;
        viewCompany.hidden = YES;
        //       CGRect Frame = viewDepartment.frame;
        //        Frame.origin.y   = viewType.frame.origin.y+viewType.frame.size.height-4;
        //        viewDepartment.frame = Frame;
        //
        //        Frame = viewCompany.frame;
        //        Frame.origin.y   = viewDepartment.frame.origin.y+viewDepartment.frame.size.height-4;
        //        viewCompany.frame = Frame;
        
        CGRect Frame = viewAll.frame;
        Frame.origin.y   = viewType.frame.origin.y+viewType.frame.size.height-4;
        viewAll.frame = Frame;
        
        Frame = viewMain.frame;
        Frame.size.height   = viewAll.frame.origin.y+viewAll.frame.size.height;
        viewMain.frame = Frame;
        scroll.contentSize = CGSizeMake(0, viewMain.frame.size.height);
    }
}

-(void)manageUser{
    if([appDelegate.STRUSERTYPE isEqualToString:@"SuperAdmin"]){
        viewTab.hidden = YES;
        viewAdminTab.hidden = YES;
        viewSuperAdminTab.hidden = NO;
    }else if([appDelegate.STRUSERTYPE isEqualToString:@"Admin"]){
        viewTab.hidden = YES;
        viewAdminTab.hidden = NO;
        viewSuperAdminTab.hidden = YES;
    }else if([appDelegate.STRUSERTYPE isEqualToString:@"User"]){
        viewTab.hidden = NO;
        viewAdminTab.hidden = YES;
        viewSuperAdminTab.hidden = YES;
    }
}

-(void)printGrid{
    Methods =[[AllMethods alloc]init];
    NSDictionary *dataDictionary = [Methods WebServerData:urlEditProfile];
    
    //NSDictionary *dataDictionary = [Methods  WebServerData:urlDepartmentList andPostParameter:parameter];
    //NSLog(@"DepartmentList dataDictionary %@",dataDictionary);
    NSArray *dataAry = [dataDictionary objectForKey:@"info"];
    NSString *strData = [dataDictionary objectForKey:@"status"];
    // if([appDelegate.ISAPPROVE isEqualToString:@"NO"])
    arrayPrinting = [[NSMutableArray alloc]init];
    NSLog(@"Data Array %@",dataAry);
    if([strData intValue]){
       
        for (NSDictionary *dic in dataAry) {
            CustomData *cmd = [[CustomData alloc]init];
            cmd.strCompanyId = [dic valueForKey:@"company_id"];
            if([[dic valueForKey:@"department_name"] isEqual:[NSNull null]])
                cmd.strDepartmentName = @"Departments";
            else
                cmd.strDepartmentName = [dic valueForKey:@"department_name"];
            
            if([[dic valueForKey:@"company_name"] isEqual:[NSNull null]])
                cmd.strCompanyName = @"Comapanies";
            else
                cmd.strCompanyName = [dic valueForKey:@"company_name"];
            cmd.strDepartmentId = [dic valueForKey:@"department_id"];
            cmd.strUserEmail = [dic valueForKey:@"user_email"];
            cmd.strFirstName = [dic valueForKey:@"firstname"];
            cmd.strLastName = [dic valueForKey:@"lastname"];
            cmd.strMobileNumber = [dic valueForKey:@"mobile"];
            cmd.strUserType = [dic valueForKey:@"role_id"];
            cmd.strTimezoneId = [dic valueForKey:@"timezone_id"];
            cmd.strUserType = [dic valueForKey:@"user_type"];
            cmd.strUserId = [dic valueForKey:@"user_id"];
            [arrayPrinting addObject:cmd];
        }
        [self PrintText];
    }
}

-(void)keyboardOnScreen:(NSNotification *)notification{
    NSDictionary *info  = notification.userInfo;
    NSValue      *value = info[UIKeyboardFrameEndUserInfoKey];
    CGRect rawFrame      = [value CGRectValue];
    CGRect keyboardFrame = [self.view convertRect:rawFrame fromView:nil];
    key = 0;
    key = keyboardFrame.size.height;
    scroll.contentSize = CGSizeMake(0, viewMain.frame.size.height+key);
}

-(void)keyboardWillHide:(NSNotification *)notification{
    scroll.contentSize = CGSizeMake(0, viewMain.frame.size.height);
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

-(void)showUiAlertWithMessage:(NSString *)message andtitle:(NSString *)title{
    UIAlertView *obj=[[UIAlertView alloc]initWithTitle:title
                                               message:message
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles: nil];
    [obj show];
}

#pragma -mark UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
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
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//}
//
//- (IBAction)SelectTimezone:(id)sender{
//    
//}
//
//- (IBAction)SelectType:(id)sender{
//    
//}
//
//- (IBAction)SelectDepartment:(id)sender{
//    
//}
//
//- (IBAction)SelectCompany:(id)sender{
//    
//}
//
//- (IBAction)Add:(id)sender{
//    
//}
//
//- (IBAction)Cancel:(id)sender{
//    
//}
//
//- (IBAction)Done:(id)sender{
//    
//}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

@end
