//
//  AddUsers.m
//  ActionLog
//
//  Created by Hardik Davda on 9/14/16.
//  Copyright © 2016 SLP-World. All rights reserved.
//

/*
 #import "PickerView.h"
 <CZPickerViewDelegate>
 
 @property (nonatomic) PickerView *statusPickerView;

 #pragma mark- Picker View Delegate
 -(void)czpickerView:(PickerView *)pickerView didConfirmWithItemAtRow:(NSInteger)row {
 if ([managePicker isEqualToString:@"Date"])
 {
 NSLog(@"Selected rows: %@", [[arrayDueDate objectAtIndex:row]strPropertyAddress]);
 [self ReloadCell:11 andvalueOfString:[[arrayDueDate objectAtIndex:row]strPropertyAddress]];
 
 }else{
 NSLog(@"Selected rows: %@", [[arrayStutas objectAtIndex:row]strPropertyAddress]);
 [self ReloadCell:10 andvalueOfString:[[arrayStutas objectAtIndex:row]strPropertyAddress]];
 }
 
 }
 
 if (!self.statusPickerView) {
 self.statusPickerView = [[PickerView alloc] initWithHeaderTitle:@"Statuses" values:arrayStutas];
 self.statusPickerView.delegate = self;
 }
 self.statusPickerView.values = arrayStutas;
 [self.statusPickerView show];
 
 */



#import "AddUsers.h"
#import "Users.h"
#import "PickerView.h"

@interface AddUsers ()<CZPickerViewDelegate>{
    UIView *viewBackGround;
    UIView *viewLoader;
    NSTimer *timer;
    int key;
    NSString *urlUserUpdate;
    NSString *urlDepartmentList;
    NSString *urlTimezoneList;
    NSString *urlCompany;
    NSString *urlForApprovalCount;

    NSMutableArray *arrayDepartment;
    NSMutableArray *arrayDepartmentTest;
    NSMutableArray *arrayCompanies;
    NSMutableArray *arrayTimeZone;
    NSMutableArray *arrayType;
    NSMutableArray *arrayPrint;
    NSMutableArray *arrayPrint1;
    NSMutableArray *arrayPrint2;
    NSString *SELECTPICKER;
    NSString *strDepartmentId;
    NSString *strCompanyId;
    NSString *strTypeId;
    NSString *strTimezoneId;
    CGRect FrameScroll;
}

@property (nonatomic) PickerView *statusPickerView;

@end

@implementation AddUsers

@synthesize arrayGet,strGet;
- (void)viewDidLoad {
    [super viewDidLoad];
    lblCount1.hidden = YES;
    viewPickerView.hidden = YES;
    FrameScroll = scroll.frame;
    if([strGet isEqualToString:@"update"]){
        lblTitelUser.text = @"EDIT USER";
        btnDepartment.userInteractionEnabled = false;
        btnType.userInteractionEnabled = false;
        btnComapny.userInteractionEnabled = false;
        
        
        imgDepartment.hidden = YES;
        imgType.hidden = YES;
        imgComapny.hidden = YES;
        
        imgDepartmentD.hidden = NO;
        imgTypeD.hidden = NO;
        imgComapnyD.hidden = NO;
    
        
        
        lblPassword.hidden = YES;
        lblConfermPassword.hidden = YES;
        //btnAdd.titleLabel.text = @"Update";
        [btnAdd setTitle:@"Update" forState:UIControlStateNormal];
        if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"])
            [self manageSuperAdmin:[[arrayGet objectAtIndex:0]strUserType]];
        else
            viewCompany.hidden = YES;
        
    }else{
        lblTitelUser.text = @"ADD USER";
        btnDepartment.userInteractionEnabled = true;
        btnType.userInteractionEnabled = true;
        btnComapny.userInteractionEnabled = true;
        
        imgDepartment.hidden = NO;
        imgType.hidden = NO;
        imgComapny.hidden = NO;
        
        imgDepartmentD.hidden = YES;
        imgTypeD.hidden = YES;
        imgComapnyD.hidden = YES;
        
        if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"])
            [self manageSuperAdmin:@"Super Admin"];
        else
            viewCompany.hidden = YES;
        
    }[self setNeedsStatusBarAppearanceUpdate];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardOnScreen:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    
    txtType.inputAccessoryView = numberToolbar;
    txtEmail.inputAccessoryView = numberToolbar;
    txtMobile.inputAccessoryView = numberToolbar;
    txtCompany.inputAccessoryView = numberToolbar;
    txtConfirmPassword.inputAccessoryView = numberToolbar;
    txtPassword.inputAccessoryView = numberToolbar;
    txtLastName.inputAccessoryView = numberToolbar;
    txtFirstName.inputAccessoryView = numberToolbar;
    
}
-(void)doneWithNumberPad{
    [self.view endEditing:YES];
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
    
    scroll.contentSize = CGSizeMake(0, viewMain.frame.size.height);
    [self WebServices];
    
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"])
        [self GetCompany];
    if([appDelegate.STRUSERTYPE isEqualToString:@"Admin"]){
        strCompanyId = appDelegate.STRCOMPANYID;
        [self GetDepartment];
    
    }
    [self GetType];
    [self GetTimeZone];
    [self GetForApprovalCount];
    if([strGet isEqualToString:@"update"]){
        [self PrintText];
    }
    else
        lblTitelUser.text = @"ADD USER";
    viewPickerView.hidden = YES;
   

}

-(void)PrintText{
    
    for(int i=0;i<arrayTimeZone.count;i++){
        if([[[arrayTimeZone objectAtIndex:i]strTimezoneId] isEqualToString:[[arrayGet objectAtIndex:0]strTimezoneId]])
        txtTimeZone.text=[[arrayTimeZone objectAtIndex:i]strTimezoneName];
        strTimezoneId =[[arrayGet objectAtIndex:0]strTimezoneId];
    }
    
    txtType.text = [[arrayGet objectAtIndex:0]strUserType];
    for(int i=0;i<arrayType.count;i++){
        if([[[arrayType objectAtIndex:i]strPropertyAddress] isEqualToString:[[arrayGet objectAtIndex:0]strUserType]]){
            strTypeId =[[arrayType objectAtIndex:i]strUserId];
        }
    }
    
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
        if([[[arrayGet objectAtIndex:0]strUserType] isEqualToString:@"Super Admin"]){
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
        if([[[arrayDepartment objectAtIndex:i]strDepartmentId] isEqualToString:[[arrayGet objectAtIndex:0]strDepartmentId]]){
            txtDepartment.text=[[arrayDepartment objectAtIndex:i]strDepartmentName];
            strDepartmentId = [[arrayGet objectAtIndex:0]strDepartmentId];
        }
    }
    txtFirstName.text = [[arrayGet objectAtIndex:0]strFirstName];
    txtLastName.text = [[arrayGet objectAtIndex:0]strLastName];
    txtEmail.text = [[arrayGet objectAtIndex:0]strUserEmail];
    
    txtMobile.text = [[arrayGet objectAtIndex:0]strMobileNumber];
    
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

//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 26)];
//   // label.backgroundColor = [UIColor grayColor];
//    label.textColor = [UIColor whiteColor];
//    label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
//    label.text = [[arrayPrint objectAtIndex:row] strPropertyAddress] ;
//    label.textAlignment = NSTextAlignmentCenter;
//    return label;    
//}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    if([SELECTPICKER isEqualToString:@"Timezone"]){
       // [txtTimeZone setText:[[arrayPrint objectAtIndex:row] strPropertyAddress]];
        strTimezoneId = [[arrayPrint objectAtIndex:row] strTimezoneId];
    }
    if([SELECTPICKER isEqualToString:@"Type"]){
      //  [txtType setText:[[arrayPrint objectAtIndex:row] strPropertyAddress]];
        strTypeId = [[arrayPrint objectAtIndex:row]strUserId];
//        if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
//            [self manageSuperAdmin:[[arrayPrint objectAtIndex:row] strPropertyAddress]];
//        }
    }
    if([SELECTPICKER isEqualToString:@"Department"]){
      //  [txtDepartment setText:[[arrayPrint objectAtIndex:row] strPropertyAddress]];
        strDepartmentId = [[arrayPrint objectAtIndex:row]strDepartmentId];

    }
    if([SELECTPICKER isEqualToString:@"Compnay"]){
      //  [txtCompany setText:[[arrayPrint objectAtIndex:row] strPropertyAddress]];
        strCompanyId = [[arrayPrint objectAtIndex:row]strDepartmentId];
        txtDepartment.text = @"Departments";
        strDepartmentId=@"00";
//        [self GetDepartment];
    }
   // viewPickerView.hidden = YES;
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
    Users *second=[self.storyboard instantiateViewControllerWithIdentifier:@"users"] ;
    [self.navigationController pushViewController:second animated:YES];
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
    else {
        //NSLog(@"You got: NO");
    }
    if([strGet isEqualToString:@"update"]){
        if([@"NotEmpty" isEqualToString:[Methods whitSpace:txtPassword.text]]){
            if([txtPassword.text isEqualToString:txtConfirmPassword.text]){
                strPASSMATCH = @"YES";
            }
        }else{
             strPASSMATCH = @"Update";
        }
    }else{
        if([txtPassword.text isEqualToString:txtConfirmPassword.text]){
            strPASSMATCH = @"YES";
        }
    }
    NSString *strCMP = @"NOPrint";
    NSString *strDPM = @"NOPrint";
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
        if(![txtType.text isEqualToString:@"Super Admin"]){
            if([txtCompany.text isEqualToString:@"Companies"]){
                strCMP = @"PrintMSG";
                //[self showUiAlertWithMessage:@"Please Select Company" andtitle:@""];
            } else if([txtDepartment.text isEqualToString:@"Departments"]){
                strDPM=@"PrintMSG";
                //  [self showUiAlertWithMessage:@"Please Select Departments" andtitle:@""];
            }
        }
    }
    
    
    if([txtTimeZone.text isEqualToString:@"Select Timezone"]){
        [self showUiAlertWithMessage:@"Please Select Timezone" andtitle:@""];
    }else
    if([txtType.text isEqualToString:@"Select Type"]){
        [self showUiAlertWithMessage:@"Please Select Type" andtitle:@""];
    }else if([strCMP isEqualToString:@"PrintMSG"]){
        [self showUiAlertWithMessage:@"Please Select Company" andtitle:@""];
    }else if([strDPM isEqualToString:@"PrintMSG"]){
        [self showUiAlertWithMessage:@"Please Select Departments" andtitle:@""];
    }else
    if([txtDepartment.text isEqualToString:@"Select Departments"]){
        [self showUiAlertWithMessage:@"Please Select Departments" andtitle:@""];
    }else
    if([@"Empty" isEqualToString:[Methods whitSpace:txtFirstName.text]]){
        [self showUiAlertWithMessage:@"Please write first name" andtitle:@""];
    }else
    if([@"Empty" isEqualToString:[Methods whitSpace:txtEmail.text]]){
        [self showUiAlertWithMessage:@"Please write email" andtitle:@""];
    }else if (!b) {
        [self showUiAlertWithMessage:@"Please write proper email" andtitle:@""];;
    }else if([@"Empty" isEqualToString:[Methods whitSpace:txtPassword.text]]&& [strGet isEqualToString:@"add"]){
        [self showUiAlertWithMessage:@"Please write password" andtitle:@""];
    }else
    if([@"Empty" isEqualToString:[Methods whitSpace:txtConfirmPassword.text]] && [strGet isEqualToString:@"add"]){
        [self showUiAlertWithMessage:@"Please write confirm password" andtitle:@""];
    }else if([@"NO" isEqualToString:strPASSMATCH] ){
        [self showUiAlertWithMessage:@"Please write both password same" andtitle:@""];
    }else
    {
        //NSLog(@"Department id := %@ \nTimezoneId := %@ \nType Id := %@ ",strDepartmentId,strTimezoneId,strTypeId);
        
        parameter = [@"token=" stringByAppendingString:
                     [appDelegate.STRTOKEN stringByAppendingString:
                       [@"&timezone_id=" stringByAppendingString:
                        [strTimezoneId stringByAppendingString:
                         [@"&action_type=" stringByAppendingString:
                          [strGet stringByAppendingString:
                           [@"&user_type_id=" stringByAppendingString:
                            [strTypeId stringByAppendingString:
                             [@"&firstname=" stringByAppendingString:
                              [txtFirstName.text stringByAppendingString:
                               [@"&email=" stringByAppendingString:
                                txtEmail.text]]]]]]]]]]];
        if([txtType.text isEqualToString:@"Admin"] || [txtType.text isEqualToString:@"Staff"] ){
            parameter = [parameter stringByAppendingString:
            [@"&department_id=" stringByAppendingString:
             [strDepartmentId stringByAppendingString:
              [@"&company_id=" stringByAppendingString:
               strCompanyId]]]];
        }
        if([strGet isEqualToString:@"update"]){
             parameter = [parameter stringByAppendingString:[@"&user_edit_id=" stringByAppendingString:[[arrayGet objectAtIndex:0]strUserId]]];
            
            if([@"NotEmpty" isEqualToString:[Methods whitSpace:txtPassword.text]]){
                if([txtPassword.text isEqualToString:txtConfirmPassword.text]){
                    parameter = [parameter stringByAppendingString:[@"&pasword=" stringByAppendingString:txtPassword.text]];
                }else{
                    [self showUiAlertWithMessage:@"Please write both password same" andtitle:@""];
                }
            }
        }
        else{
                parameter = [parameter stringByAppendingString:[@"&pasword=" stringByAppendingString:txtPassword.text]];
        }
        if([@"NotEmpty" isEqualToString:[Methods whitSpace:txtLastName.text]]){
            parameter = [parameter stringByAppendingString:[@"&lastname=" stringByAppendingString:txtLastName.text]];
        }
        if([@"NotEmpty" isEqualToString:[Methods whitSpace:txtMobile.text]]){
            parameter = [parameter stringByAppendingString:[@"&mobile=" stringByAppendingString:txtMobile.text]];
        }
        if([@"NotEmpty" isEqualToString:txtLastName.text]){
            parameter = [parameter stringByAppendingString:[@"&lastname=" stringByAppendingString:txtLastName.text]];
        }
        if([@"NotEmpty" isEqualToString:txtMobile.text]){
            parameter = [parameter stringByAppendingString:[@"&mobile=" stringByAppendingString:txtMobile.text]];
        }
        NSLog(@"Parameter %@",parameter);
        
        NSDictionary *DataDictionary = [Methods WebServerData:urlUserUpdate andPostParameter:parameter];
        NSLog(@"DataDictionary %@",DataDictionary);
       // status
        bool dataAry = [DataDictionary objectForKey:@"status"];
        if(dataAry){
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
        //NSLog(@"Array history AddSubtask %@",dataAry);
    }
}

- (IBAction)Cancel:(id)sender{
    Users *second=[self.storyboard instantiateViewControllerWithIdentifier:@"users"] ;
    [self.navigationController pushViewController:second animated:YES];
}

-(IBAction)HidePicker:(id)sender{
    viewPickerView.hidden = YES;
}
- (IBAction)searchTitleChaneg:(id)sender{
    NSString *searchText;
    //NSLog(@"Title Count %ld",arrayListUser.count);
    searchText =txtSearchDropdown.text;
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@ ",
                                    searchText];
    self.filltereList = (NSMutableArray *)[arrayPrint1 filteredArrayUsingPredicate:resultPredicate];
    if ([@"Empty" isEqualToString:[Methods whitSpace:searchText]]) {
        arrayPrint = [NSMutableArray arrayWithArray:arrayPrint1];
        [picker reloadAllComponents];
        //[self finalShort];
    }else
        [self shortText];
}

-(void)shortText{
    NSString *test;
    arrayPrint = [[NSMutableArray alloc]init];
    
    for (int j = 0;j<self.filltereList.count;j++){
        NSString *tesFilter = [self.filltereList objectAtIndex:j];
        for (int i=0; i<arrayPrint1.count; i++) {
            test = [arrayPrint1 objectAtIndex:i];
            if ([test isEqualToString:tesFilter]) {
                CustomData *cmd = [[CustomData alloc]init];
                cmd.strPropertyAddress = [[arrayPrint1 objectAtIndex:i]strPropertyAddress];
                [arrayPrint addObject:cmd];
            }
        }
        [picker reloadAllComponents];
    }
}

- (IBAction)Dashboard:(id)sender{
    Dashboard *second=[self.storyboard instantiateViewControllerWithIdentifier:@"dashboard"] ;
    [self.navigationController pushViewController:second animated:YES];
    
}

- (IBAction)Archived:(id)sender{
    Archived *second=[self.storyboard instantiateViewControllerWithIdentifier:@"archived"] ;
    [self.navigationController pushViewController:second animated:YES];
}

- (IBAction)Companies:(id)sender{
    Companies *second=[self.storyboard instantiateViewControllerWithIdentifier:@"companies"] ;
    [self.navigationController pushViewController:second animated:YES];
}

- (IBAction)User:(id)sender{
    Users *second=[self.storyboard instantiateViewControllerWithIdentifier:@"users"] ;
    [self.navigationController pushViewController:second animated:YES];
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
    NSMutableArray *array = [web WebAddUser];
    urlForApprovalCount = [[array objectAtIndex:0]webForApprvalCount];
    urlUserUpdate = [[array objectAtIndex:0]webUserUpdate];
    urlTimezoneList = [[array objectAtIndex:0]webTimezoneList];
    urlDepartmentList = [[array objectAtIndex:0]webDepartmentList];
    urlCompany = [[array objectAtIndex:0]webCompany];
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
//            lblCount2.hidden = YES;
        }else{
            lblCount1.hidden = NO;
//            lblCount2.hidden = NO;
            lblCount1.text = [dataDictionary objectForKey:@"info"];
//            lblCount2.text = [dataDictionary objectForKey:@"info"];
            lblCount1.layer.masksToBounds = YES;
            lblCount1.layer.cornerRadius = 8.0;
            
//            lblCount2.layer.masksToBounds = YES;
//            lblCount2.layer.cornerRadius = 8.0;
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
        // NSString *parameter = [@"token=" stringByAppendingString:appDelegate.STRTOKEN];
        NSDictionary *dataDictionary = [Methods  WebServerData:urlCompany];
        // NSArray *dataAry = [dataDictionary objectForKey:@"info"];
        //NSLog(@"Company %@",dataAry);
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
        [arrayDepartmentTest addObject:cmd];
    }else{
        NSString *parameter = [@"company_id=" stringByAppendingString:strCompanyId];
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
            [arrayDepartmentTest addObject:cmd];
            // NSLog(@"All data of grid %@",dataAry);
            for (NSDictionary *dic in dataAry) {
                CustomData *cmd = [[CustomData alloc]init];
                cmd.strDepartmentId = [dic valueForKey:@"department_id"];
                cmd.strDepartmentName = [dic valueForKey:@"department_name"];
                cmd.strPropertyAddress = [dic valueForKey:@"department_name"];
                cmd.strDepartmentStatus = [dic valueForKey:@"department_status"];
                [arrayDepartment addObject:cmd];
                [arrayDepartmentTest addObject:cmd];
                [arrayPrint addObject:cmd];
            }
            [picker reloadAllComponents];
        }
    }
}

-(void)GetType{
    arrayType = [[NSMutableArray alloc]init];
    arrayPrint = [[NSMutableArray alloc]init];
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
        CustomData *cmd = [[CustomData alloc]init];
        cmd.strPropertyAddress = @"Super Admin";
        cmd.strUserId = @"1";
        [arrayType addObject:cmd];
        [arrayPrint addObject:cmd];

    }
    
    CustomData *cmd = [[CustomData alloc]init];
    cmd.strPropertyAddress = @"Admin";
    cmd.strUserId = @"2";
    [arrayType addObject:cmd];
    [arrayPrint addObject:cmd];

    cmd = [[CustomData alloc]init];
    cmd.strPropertyAddress = @"Staff";
    cmd.strUserId = @"3";
    [arrayType addObject:cmd];
    [arrayPrint addObject:cmd];
    [picker reloadAllComponents];    
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

-(void)keyboardOnScreen:(NSNotification *)notification{
    NSDictionary *info  = notification.userInfo;
    NSValue      *value = info[UIKeyboardFrameEndUserInfoKey];
    CGRect rawFrame      = [value CGRectValue];
    CGRect keyboardFrame = [self.view convertRect:rawFrame fromView:nil];
    key = 0;
    key = keyboardFrame.size.height;
//    CGRect frame = FrameScroll;
//    frame.size.height = FrameScroll.size.height + key;
//    scroll.frame = frame;
    scroll.contentSize = CGSizeMake(0, viewMain.frame.size.height+key);
}

-(void)keyboardWillHide:(NSNotification *)notification{
//   scroll.frame = FrameScroll;
    scroll.contentSize = CGSizeMake(0, viewMain.frame.size.height);
}


-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
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

@end
