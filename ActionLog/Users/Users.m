//
//  Users.m
//  ActionLog
//
//  Created by Hardik Davda on 9/14/16.
//  Copyright © 2016 SLP-World. All rights reserved.
//

#import "Users.h"
#import "AddUsers.h"
#import "PickerView.h"

@interface Users ()<CZPickerViewDelegate>
{
    UIView *nomatchesView;
    UIView *viewBackGround;
    UIView *viewLoader;
    NSTimer *timer;
    NSString *urlUserList;
    NSString *urlForApprovalCount;

    NSString *urlChangeActionStatus;
    NSString *strDepartment_Id;
    NSString *strCompany_Id;
    NSString *strType_Id;
    NSMutableArray *arrayID;
    NSString *urlCompany;
    NSString *urlDepartmentList;
    NSString *strDepartmentParameter;
    
    NSMutableArray *arrayUserList;
    NSMutableArray *arrayUserName;
    NSMutableArray *arrayStutas;
    NSMutableArray *arrayPrint;
    NSMutableArray *arrayCompanies;
    NSMutableArray *arrayDepartment;
    NSMutableArray *arrayDepartmentTest;
    NSString *dropDownSelection;
    NSMutableArray *arrayType;
    NSMutableArray *arrayTemp;
    NSMutableArray *arrayApply;
    int alertDelete;
}

@property (nonatomic) PickerView *statusPickerView;

@end

@implementation Users

- (void)viewDidLoad {
    [super viewDidLoad];
    strDepartmentParameter = @"NO";
    lblCount1.hidden = YES;
    
     [self setNeedsStatusBarAppearanceUpdate];
    arrayApply = [[NSMutableArray alloc]init];
    ViewTitleSearch.hidden = YES;
    [self ManageView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    // [self setNeedsStatusBarAppearanceUpdate];
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    Methods = [[AllMethods alloc]init];
    [self viewMain];
    table.hidden = YES;
    timer = [NSTimer scheduledTimerWithTimeInterval:.000001 target:self selector:@selector(initialize) userInfo:nil repeats:NO];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(stopGIF) userInfo:nil repeats:NO];
}

- (void)initialize{
    [self WebServices];
    [self webUserListData];
    [self webDepartmentData];
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"])
        [self GetCompany];
    [self GetDepartment];
    [self GetType];
    [self GetForApprovalCount];
    [self GetStatus];
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
    table.hidden = NO;
    [viewLoader removeFromSuperview];
    [viewBackGround removeFromSuperview];
}

#pragma -mark UITableview Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    [nomatchesView removeFromSuperview];// Default is 1 if not implemented
    if(arrayPrint.count == 0)
        [self noDataFound];
    else
        [nomatchesView removeFromSuperview];
    return arrayPrint.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomCell *cell;// = [[CustomCell alloc]init];
   
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
       cell = [tableView dequeueReusableCellWithIdentifier:@"cellCompany"];
        cell.lblDescription.text = [[arrayPrint objectAtIndex:indexPath.section]strCompanyName];
        cell.lblTitle.text = [[arrayPrint objectAtIndex:indexPath.section]strUserName];
        cell.lblName.text = [[arrayPrint objectAtIndex:indexPath.section]strUserType];
        cell.lblStatus.text = [[arrayPrint objectAtIndex:indexPath.section]strUserStatus];
        cell.btnCheck.hidden = NO;
        if([ [[arrayPrint objectAtIndex:indexPath.section]strUserStatus] isEqualToString:@"Active"]){
            cell.viewInActive.hidden = YES;
            cell.viewActive.hidden = NO;
            cell.imgStatus.image = [UIImage imageNamed:@"Active.png"];
        }else{
            cell.viewInActive.hidden = NO;
            cell.viewActive.hidden = YES;
            cell.imgStatus.image = [UIImage imageNamed:@"Inactive.png"];
        }
        if([[[arrayPrint objectAtIndex:indexPath.section] strAllow] isEqualToString:@"No"]){
            cell.btnCheck.hidden = YES;
            cell.imgCheck.image = [UIImage imageNamed:@"Check-dis.png"];
        }
        cell.btnCheck.tag = indexPath.section;
        if ([[[arrayPrint objectAtIndex:indexPath.section]strIsCheck] isEqualToString:@"YES"]){
            cell.imgCheck.image = [UIImage imageNamed:@"chack-btn-1.png"];
        } else
            cell.imgCheck.image = [UIImage imageNamed:@"checkDisbale.png"];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.lblTitle.text = [[arrayPrint objectAtIndex:indexPath.section]strUserName];
        cell.lblName.text = [[arrayPrint objectAtIndex:indexPath.section]strUserType];
        cell.lblStatus.text = [[arrayPrint objectAtIndex:indexPath.section]strUserStatus];
        cell.btnCheck.hidden = NO;
        if([ [[arrayPrint objectAtIndex:indexPath.section]strUserStatus] isEqualToString:@"Active"]){
            
            cell.imgStatus.image = [UIImage imageNamed:@"Active.png"];
        }else{
            cell.imgStatus.image = [UIImage imageNamed:@"Inactive.png"];
        }
        if([[[arrayPrint objectAtIndex:indexPath.section] strAllow] isEqualToString:@"No"]){
            cell.btnCheck.hidden = YES;
            cell.imgCheck.image = [UIImage imageNamed:@"Check-dis.png"];
        }
        cell.btnCheck.tag = indexPath.section;
        if ([[[arrayPrint objectAtIndex:indexPath.section]strIsCheck] isEqualToString:@"YES"]){
            cell.imgCheck.image = [UIImage imageNamed:@"chack-btn-1.png"];
        } else
            cell.imgCheck.image = [UIImage imageNamed:@"checkDisbale.png"];
    }
    if([[[arrayPrint objectAtIndex:indexPath.section] strAllow] isEqualToString:@"No"]){
        cell.imgCheck.image = [UIImage imageNamed:@"Check-dis.png"];
    }
    cell.accessoryView = nil;
    cell.accessoryType = UITableViewCellAccessoryNone;
    return  cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"])
        return 74;
    else
        return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width,10)];
    [view1 setBackgroundColor: [Methods colorWithHexString:@"EFEFEF"]];
    return view1;
}

#pragma -mark UITableview Delegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomData *cmd = [[CustomData alloc]init];
    cmd =[arrayPrint objectAtIndex:indexPath.section];
    NSMutableArray *arrayDemo = [[NSMutableArray alloc]init];
    [arrayDemo addObject:cmd];
    AddUsers *second=[self.storyboard instantiateViewControllerWithIdentifier:@"addusers"] ;
    second.strGet = @"update";
    second.arrayGet = arrayDemo;
    [self.navigationController pushViewController:second animated:YES];
    return  indexPath;
}

#pragma -mark Button IBAction (click Events)

- (IBAction)AddUser:(id)sender{
    AddUsers *second=[self.storyboard instantiateViewControllerWithIdentifier:@"addusers"] ;
    second.strGet = @"add";
    [self.navigationController pushViewController:second animated:YES];
}

-(IBAction)AdvanceSearch:(id)sender{
    [self HideDropDownAtAllPlace];
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"])
        viewAdvanceSearchSuperAdmin.hidden = NO;
    else
        viewAdvanceSearch.hidden = NO;
    [self ManageView1];
}


- (IBAction)AllCheck:(id)sender{
    if(btnCheckAll.tag == 1){
        btnCheckAll.tag = 2;
        imgChekApply.image = [UIImage imageNamed:@"SelectBtn.png"];
        arrayApply = [[NSMutableArray alloc]init];
        for (int i=0 ; i<arrayPrint.count; i++) {
            CustomData *cmd = [[ CustomData alloc]init];
            cmd= [arrayPrint objectAtIndex:i];
            if([[[arrayPrint objectAtIndex:i] strAllow] isEqualToString:@"No"]){
                cmd.strIsCheck   = @"NO";
            }else{
                cmd.strIsCheck   = @"YES";
                [arrayApply addObject:cmd.strUserId];
            }
            [arrayPrint replaceObjectAtIndex:i withObject:cmd];
        }
    }else{
        arrayApply = [[NSMutableArray alloc]init];
        for (int i=0 ; i<arrayPrint.count; i++) {
            CustomData *cmd = [[ CustomData alloc]init];
            cmd = [arrayPrint objectAtIndex:i];
            cmd.strIsCheck   = @"NO";
            [arrayPrint replaceObjectAtIndex:i withObject:cmd];
        }
        btnCheckAll.tag = 1;
        imgChekApply.image = [UIImage imageNamed:@"checkDisbale.png"];
    }
    [table reloadData];
}

- (IBAction)AllDropDown:(id)sender{
    [self HideDropDownAtAllPlace];
    UIButton *btnDemo = sender;
    switch (btnDemo.tag) {
        case 1:
            if(arrayDepartment.count){
                dropDownSelection = @"Department";
                [self DropDownPicker:@"Departments" andSelectionArray:arrayDepartment];
            }
            break;
        case 2:
           if(arrayType.count){
                dropDownSelection = @"Type";
                [self DropDownPicker:@"User Type" andSelectionArray:arrayType];
            }
            break;
        case 3:
                if(arrayStutas.count){
                    dropDownSelection = @"Status";
                    [self DropDownPicker:@"Status" andSelectionArray:arrayStutas];
                }
            break;
        case 4:
                if(arrayID.count){
                    dropDownSelection = @"Apply";
                    [self DropDownPicker:@"Change Status" andSelectionArray:arrayID];
                }
            break;
        case 11:
                if(arrayCompanies.count){
                    dropDownSelection = @"Company";
                    [self DropDownPicker:@"Companies" andSelectionArray:arrayCompanies];
                    txtSADepartment.text = @"Departments";
                }
            break;
        case 12:
                if(arrayDepartment.count){
                    dropDownSelection = @"Department";
                    [self DropDownPicker:@"Departments" andSelectionArray:arrayDepartment];
                }
            
            break;
        case 13:
                if(arrayType.count){
                    dropDownSelection = @"Type";
                    [self DropDownPicker:@"User Type" andSelectionArray:arrayType];
                }
            break;
        case 14:
                if(arrayStutas.count){
                    dropDownSelection = @"Status";
                    [self DropDownPicker:@"Status" andSelectionArray:arrayStutas];
                }
            break;
        default:
            break;
    }
}
- (void)DropDownPicker : (NSString *)title andSelectionArray:(NSMutableArray *)arrayData{

    if (!self.statusPickerView) {
        self.statusPickerView = [[PickerView alloc] initWithHeaderTitle:title values:arrayData];
        self.statusPickerView.delegate = self;
    }
    self.statusPickerView.values = arrayData;
    [self.statusPickerView show];
}

-(IBAction)ApplyCheck:(id)sender{
    [self HideDropDownAtAllPlace];
    if(arrayApply.count != 0){
        alertDelete = 1;
        NSString *strMesage = [@"Are you sure! You want to " stringByAppendingString:[txtApply.text stringByAppendingString:@" this user"]] ;
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"" message:strMesage delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [av show];
    }else{
        [self showUiAlertWithMessage:@"You have not select any user" andtitle:@""];
    }
}

- (IBAction)Archived:(id)sender{
    Archived *second=[self.storyboard instantiateViewControllerWithIdentifier:@"archived"] ;
    [self.navigationController pushViewController:second animated:YES];
}


- (IBAction)CellCheck:(id)sender {
    [self HideDropDownAtAllPlace];
    UIButton *btnDemo = sender;
    if ([[[arrayPrint objectAtIndex:btnDemo.tag]strIsCheck] isEqualToString:@"NO"]) {
        CustomData *cmd = [[ CustomData alloc]init];
        cmd =[arrayPrint objectAtIndex:btnDemo.tag];
        cmd.strIsCheck   = @"YES";
        [arrayApply addObject:cmd.strUserId];
        [arrayPrint replaceObjectAtIndex:btnDemo.tag withObject:cmd];//
    }else{
        CustomData *cmd = [[ CustomData alloc]init];
        cmd = [arrayPrint objectAtIndex:btnDemo.tag];
        [arrayPrint replaceObjectAtIndex:btnDemo.tag withObject:cmd];
        for (int i =0 ; i<arrayApply.count; i++) {
            if([cmd.strUserId isEqualToString:[arrayApply objectAtIndex:i]]){
                [arrayApply removeObjectAtIndex:i];
            }
        }
    }
    [table reloadData];
}

- (IBAction)Companies:(id)sender{
    Companies *second=[self.storyboard instantiateViewControllerWithIdentifier:@"companies"] ;
    [self.navigationController pushViewController:second animated:YES];
    
}

- (IBAction)Close:(id)sender{
    [self HideDropDownAtAllPlace];
    [self ManageView];
    [self Reset:sender];
}

- (IBAction)CloseTitleSearch:(id)sender{
    [self HideDropDownAtAllPlace];
    ViewTitleSearch.hidden = YES;
    [self Reset:sender];
}

- (IBAction)Dashboard:(id)sender{
    UIButton *btn = sender;
    if(btn.tag == 2){
        appDelegate.ISAPPROVE = @"YES";
        Dashboard *second=[self.storyboard instantiateViewControllerWithIdentifier:@"dashboard"] ;
        [self.navigationController pushViewController:second animated:YES];
    }else{
    appDelegate.ISAPPROVE = @"NO";
        Dashboard *second=[self.storyboard instantiateViewControllerWithIdentifier:@"dashboard"] ;
        [self.navigationController pushViewController:second animated:YES];
    }
}

- (IBAction)SearchTitleChange:(id)sender {
    NSString *searchText;
    searchText =txtTitelSearch.text;
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@ ",
                                    searchText];
    self.filltereList = (NSMutableArray *)[arrayUserName filteredArrayUsingPredicate:resultPredicate];
    if ([@"Empty" isEqualToString:[Methods whitSpace:searchText]]) {
        arrayPrint = [NSMutableArray arrayWithArray:arrayUserList];
        [table reloadData];
    }else
        [self shortText];
    
}
-(void)shortText{
    arrayPrint = [[NSMutableArray alloc]init];
    NSString *test;
    for (int j = 0;j<self.filltereList.count;j++){
        NSString *tesFilter = [self.filltereList objectAtIndex:j];
        for (int i=0; i<arrayUserName.count; i++) {
            test = [arrayUserName objectAtIndex:i];
            if ([test isEqualToString:tesFilter]) {
                CustomData *cmd = [[ CustomData alloc]init];
                cmd = [arrayUserList objectAtIndex:i];
                [arrayPrint addObject:cmd];
            }
        }
    }
    [table reloadData];
}

- (IBAction)Search:(id)sender{
    [self HideDropDownAtAllPlace];
    NSString *param = [@"grid_type="stringByAppendingString:@"Dashboard"];
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
        if([txtSACompany.text isEqualToString:@"Companies"]){
        }else{
            param = [param stringByAppendingString:[@"&company id="stringByAppendingString:strCompany_Id]];
        }
    }
    if([txtDepartment.text isEqualToString:@"Departments"]){
    }else{
        param = [param stringByAppendingString:[@"&department_id="stringByAppendingString:strDepartment_Id]];
    }
    if([txtType.text isEqualToString:@"Type"]){
    }else{
        param = [param stringByAppendingString:[@"&user_type_id="stringByAppendingString:strType_Id]];
    }
    if([txtStatus.text isEqualToString:@"Status"]){
    }else{
        param = [param stringByAppendingString:[@"&status="stringByAppendingString:txtStatus.text]];
    }
    if([@"Empty" isEqualToString:[Methods whitSpace:txtTitelSearch.text]]){
    }else{
        param = [param stringByAppendingString:[@"&search="stringByAppendingString:txtTitelSearch.text]];
    }
    [self PrintGrid:param];
}

- (IBAction)Reset:(id)sender{
    [self HideDropDownAtAllPlace];
    txtTitelSearch.text = @"";
    txtSACompany.text = @"Companies";
    txtSADepartment.text =@"Departments";
    txtSAType.text = @"Type";
    txtSAStatus.text = @"Status";

    txtDepartment.text =@"Departments";
    txtType.text = @"Type";
    txtStatus.text = @"Status";
    arrayDepartment = [[NSMutableArray alloc]init];
    CustomData *cmd = [[CustomData alloc]init];
    cmd.strDepartmentId = @"00";
    cmd.strCompanyId = @"00";
    cmd.strDepartmentName = @"Departments";
    cmd.strPropertyAddress = @"Departments";
    [arrayDepartment addObject:cmd];
    
    NSString *parameter = [@"grid_type=" stringByAppendingString:@"Dashboard"] ;
    [self PrintGrid:parameter];
}

- (IBAction)TitleSearch:(id)sender{
    [self HideDropDownAtAllPlace];
    ViewTitleSearch.hidden = NO;
}

- (IBAction)User:(id)sender{
    Users *second=[self.storyboard instantiateViewControllerWithIdentifier:@"users"] ;
    [self.navigationController pushViewController:second animated:YES];
}

#pragma -mark UIAlertview Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertDelete == 1){
        if (buttonIndex == 1) {
            NSString *parameter;
            parameter = [@"&action_type=statusChange" stringByAppendingString:[@"&status=" stringByAppendingString:txtApply.text]];
            
            for(int i=0;i<arrayApply.count;i++){
                parameter = [parameter stringByAppendingString:[@"&user_ids[]=" stringByAppendingString:[arrayApply objectAtIndex:i]]];
            }
            NSDictionary *dataDictionary;
            dataDictionary = [Methods  WebServerData:urlChangeActionStatus andPostParameter:parameter];
            arrayApply = [[NSMutableArray alloc]init];
            imgChekApply.image = [UIImage imageNamed:@"checkDisbale.png"];
            [self Reset:self];
        }
        alertDelete = 0;
    }
    
    alertDelete = 0;
}

#pragma -mark Dropdown Delegate

//-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSMutableArray*)arrOptions Option1:(NSMutableArray*)arrOptions1 xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple{
//    
//    Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions options1:arrOptions1 xy:point size:size isMultiple:isMultiple];
//    Dropobj.delegate = self;
//    [Dropobj showInView:self.view animated:YES];
//    
//    /*----------------Set DropDown backGroundColor-----------------*/
//    [Dropobj SetBackGroundDropDown_R:245.0 G:245.0 B:245.0 alpha:0.90];
//}

//- (void)DropDownListView:(DropDownListView *)dropdownListView Datalist:(NSMutableArray*)ArryData{
//    
//}

-(void)czpickerView:(PickerView *)pickerView didConfirmWithItemAtRow:(NSInteger)row {
    if([@"Company" isEqualToString:dropDownSelection]){
        txtSACompany.text = [[arrayCompanies objectAtIndex:row]strPropertyAddress];
        strCompany_Id =[NSString stringWithFormat:@"%@",[[arrayCompanies objectAtIndex:row]strCompanyId]];
        [self DepartmentFilter:[[arrayCompanies objectAtIndex:row]strCompanyId]];
    }else if([@"Department" isEqualToString:dropDownSelection]){
        txtDepartment.text = [[arrayDepartment objectAtIndex:row]strPropertyAddress];
        txtSADepartment.text = [[arrayDepartment objectAtIndex:row]strPropertyAddress];
        strDepartment_Id =[NSString stringWithFormat:@"%@",[[arrayDepartment objectAtIndex:row]strDepartmentId]];
    }else if([@"Status" isEqualToString:dropDownSelection]){
        txtStatus.text = [[arrayStutas objectAtIndex:row]strPropertyAddress];
        txtSAStatus.text = [[arrayStutas objectAtIndex:row]strPropertyAddress];
    }else if([@"Type" isEqualToString:dropDownSelection]){
        txtType.text = [[arrayType objectAtIndex:row]strPropertyAddress];
        txtSAType.text = [[arrayType objectAtIndex:row]strPropertyAddress];
        strType_Id = [[arrayType objectAtIndex:row]strId];
    }else if([@"Apply" isEqualToString:dropDownSelection]){
        txtApply.text = [[arrayID objectAtIndex:row]strPropertyAddress];
    }
}

//- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex{
//    /*----------------Get Selected Value[Single selection]-----------------*/
//    if([@"Company" isEqualToString:dropDownSelection]){
//        txtSACompany.text = [[arrayCompanies objectAtIndex:anIndex]strPropertyAddress];
//       // txtSADepartment.text = [[arrayDepartment objectAtIndex:anIndex]strPropertyAddress];
//        strCompany_Id =[NSString stringWithFormat:@"%@",[[arrayCompanies objectAtIndex:anIndex]strCompanyId]];
//        [self DepartmentFilter:[[arrayCompanies objectAtIndex:anIndex]strCompanyId]];
//    }else if([@"Department" isEqualToString:dropDownSelection]){
//        txtDepartment.text = [[arrayDepartment objectAtIndex:anIndex]strPropertyAddress];
//          txtSADepartment.text = [[arrayDepartment objectAtIndex:anIndex]strPropertyAddress];
//                strDepartment_Id =[NSString stringWithFormat:@"%@",[[arrayDepartment objectAtIndex:anIndex]strDepartmentId]];
//    }else if([@"Status" isEqualToString:dropDownSelection]){
//       txtStatus.text = [[arrayStutas objectAtIndex:anIndex]strPropertyAddress];
//         txtSAStatus.text = [[arrayStutas objectAtIndex:anIndex]strPropertyAddress];
//    }else if([@"Type" isEqualToString:dropDownSelection]){
//        txtType.text = [[arrayType objectAtIndex:anIndex]strPropertyAddress];
//        txtSAType.text = [[arrayType objectAtIndex:anIndex]strPropertyAddress];
//        strType_Id = [[arrayType objectAtIndex:anIndex]strId];
//    }else if([@"Apply" isEqualToString:dropDownSelection]){
//        txtApply.text = [[arrayID objectAtIndex:anIndex]strPropertyAddress];
//    }
//}

#pragma -mark User define function
-(void)HideDropDownAtAllPlace{
    [self.view endEditing:YES];
}

#pragma -mark User define function

-(void)GetForApprovalCount{
   NSDictionary *dataDictionary = [Methods  WebServerData:urlForApprovalCount];
    
    bool status = [dataDictionary objectForKey:@"status"];
    if(status){
        NSLog(@" ForApproval count: - %@",[dataDictionary objectForKey:@"info"]);
        if ([[dataDictionary objectForKey:@"info"] isEqualToString:@"0"]){
            lblCount1.hidden = YES;
        }else{
            lblCount1.hidden = NO;
            lblCount1.text = [dataDictionary objectForKey:@"info"];
            lblCount1.layer.masksToBounds = YES;
            lblCount1.layer.cornerRadius = 8.0;
        }
    }
}

-(void)GetCompany{
    if(appDelegate.ARRAYCOMPANY.count ==0){
        NSDictionary *dataDictionary = [Methods  WebServerData:urlCompany];
        NSArray *keys;
        int i, count;
        id key, value;
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
            key = [keys objectAtIndex: i];
            value = [dict objectForKey: key];
            cmd.strKey =[NSString stringWithFormat:@"%@",key];
            cmd.strCompanyId =[NSString stringWithFormat:@"%@",key];
            cmd.strStatus =[NSString stringWithFormat:@"%@",value];
            cmd.strPropertyAddress =[NSString stringWithFormat:@"%@",value];
            [arrayCompanies addObject:cmd];
        }
    }else{
        arrayCompanies = [[NSMutableArray alloc]initWithArray:appDelegate.ARRAYCOMPANY];
    }
}

-(void)GetDepartment{
    
    if(appDelegate.ARRAYDEPARTMENT.count == 0){
        NSDictionary *dataDictionary = [Methods  WebServerData:urlDepartmentList];
        NSArray *dataAry = [dataDictionary objectForKey:@"info"];
        arrayDepartment = [[NSMutableArray alloc]init];
        arrayDepartmentTest = [[NSMutableArray alloc]init];
        CustomData *cmd = [[CustomData alloc]init];
        cmd.strDepartmentId = @"00";
        cmd.strCompanyId = @"00";
        cmd.strDepartmentName = @"Departments";
        cmd.strPropertyAddress = @"Departments";
        [arrayDepartment addObject:cmd];
        [arrayDepartmentTest addObject:cmd];
        for (NSDictionary *dic in dataAry) {
            CustomData *cmd = [[CustomData alloc]init];
            cmd.strDepartmentId = [dic valueForKey:@"department_id"];
            cmd.strCompanyId = [dic valueForKey:@"company_id"];
            cmd.strDepartmentName = [dic valueForKey:@"department_name"];
            cmd.strPropertyAddress = [dic valueForKey:@"department_name"];
            [arrayDepartment addObject:cmd];
            [arrayDepartmentTest addObject:cmd];
            [appDelegate.ARRAYDEPARTMENT addObject:cmd];
        }
    }else{
        arrayDepartment = [[NSMutableArray alloc]initWithArray:appDelegate.ARRAYDEPARTMENT];
        arrayDepartmentTest = [[NSMutableArray alloc]initWithArray:appDelegate.ARRAYDEPARTMENT];
    }
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"])
    {
        arrayDepartment = [[NSMutableArray alloc]init];
        CustomData *cmd = [[CustomData alloc]init];
        cmd.strDepartmentId = @"00";
        cmd.strCompanyId = @"00";
        cmd.strDepartmentName = @"Departments";
        cmd.strPropertyAddress = @"Departments";
        [arrayDepartment addObject:cmd];
    }
}

-(void)DepartmentFilter :(NSString *)strId{
    if([strId isEqualToString:@"00"]){
        arrayDepartment = [[NSMutableArray alloc]init];
        CustomData *cmd = [[CustomData alloc]init];
        cmd.strDepartmentId = @"00";
        cmd.strCompanyId = @"00";
        cmd.strDepartmentName = @"Departments";
        cmd.strPropertyAddress = @"Departments";
        [arrayDepartment addObject:cmd];
    }else{
        arrayDepartment = [[NSMutableArray alloc]init];
        CustomData *cmd = [[CustomData alloc]init];
        cmd.strDepartmentId = @"00";
        cmd.strCompanyId = @"00";
        cmd.strDepartmentName = @"Departments";
        cmd.strPropertyAddress = @"Departments";
        [arrayDepartment addObject:cmd];
        for(int i = 0 ; i<arrayDepartmentTest.count;i++){
            if([[[arrayDepartmentTest objectAtIndex:i]strCompanyId] isEqualToString:strId]){
                CustomData *cmd = [[CustomData alloc]init];
                cmd = [arrayDepartmentTest objectAtIndex:i];
                [arrayDepartment addObject:cmd];
            }
        }
    }
}

-(void)GetType{
    arrayType = [[NSMutableArray alloc]init];
        CustomData *cmd = [[CustomData alloc]init];
        cmd = [[CustomData alloc]init];
        cmd.strId = @"00";
        cmd.strDepartmentName = @"Type";
        cmd.strPropertyAddress = @"Type";
        [arrayType addObject:cmd];
        if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
            cmd = [[CustomData alloc]init];
            cmd.strId = @"1";
            cmd.strDepartmentName = @"Super Admin";
            cmd.strPropertyAddress = @"Super Admin";
            [arrayType addObject:cmd];
        }
        cmd = [[CustomData alloc]init];
        cmd.strId = @"2";
        cmd.strDepartmentName = @"Admin";
        cmd.strPropertyAddress = @"Admin";
        [arrayType addObject:cmd];
        
        cmd = [[CustomData alloc]init];
        cmd.strId = @"3";
        cmd.strDepartmentName = @"Staff";
        cmd.strPropertyAddress = @"Staff";
        [arrayType addObject:cmd];
}

-(void)GetStatus{
    arrayStutas = [[NSMutableArray alloc]init];
        CustomData *cmd = [[CustomData alloc]init];
        cmd.strDepartmentId = @"00";
        cmd.strDepartmentName = @"Status";
        cmd.strPropertyAddress = @"Status";
        [arrayStutas addObject:cmd];

        cmd = [[CustomData alloc]init];
        cmd.strDepartmentId = @"1";
        cmd.strDepartmentName = @"Active";
        cmd.strPropertyAddress = @"Active";
        [arrayStutas addObject:cmd];
        
        cmd = [[CustomData alloc]init];
        cmd.strDepartmentId = @"2";
        cmd.strDepartmentName = @"Inactive";
        cmd.strPropertyAddress = @"Inactive";
        [arrayStutas addObject:cmd];
}

-(void)PrintGrid :(NSString *)parameter{

    NSDictionary *dataDictionary = [Methods  WebServerData:urlUserList andPostParameter:parameter];
    NSArray *dataAry = [dataDictionary objectForKey:@"info"];
     NSString *strData = [dataDictionary objectForKey:@"status"];
    arrayUserList = [[NSMutableArray alloc]init];
    arrayUserName = [[NSMutableArray alloc]init];
    arrayPrint = [[NSMutableArray alloc]init];
    if([strData intValue])
    {
        for (NSDictionary *dic in dataAry) {
            CustomData *cmd = [[CustomData alloc]init];
            if([[dic valueForKey:@"company_name"] isEqual:[NSNull null]] || [[dic valueForKey:@"company_name"] isEqualToString:@"<null>"] ||[[dic valueForKey:@"company_name"] isEqualToString:@"null"]  ){
                cmd.strCompanyName = @"Super Admin";
            }else
                cmd.strCompanyName = [dic valueForKey:@"company_name"];
            cmd.strAllow = [dic valueForKey:@"action_allow"];
            cmd.strUserEmail = [dic valueForKey:@"user_email"];
            cmd.strUserId    = [dic valueForKey:@"user_id"];
            cmd.strUserStatus = [dic valueForKey:@"user_status"];
            cmd.strUserType = [dic valueForKey:@"user_type"];
            cmd.strUserName = [dic valueForKey:@"username"];
            cmd.strTimezoneId = [dic valueForKey:@"timezone_id"];
            cmd.strCompanyId = [dic valueForKey:@"company_id"];
            cmd.strDepartmentId = [dic valueForKey:@"department_id"];
            cmd.strFirstName = [dic valueForKey:@"firstname"];
            cmd.strLastName = [dic valueForKey:@"lastname"];
            cmd.strMobileNumber = [dic valueForKey:@"mobile_number"];
            cmd.strIsCheck   = @"NO";
            [arrayPrint addObject:cmd];
            [arrayUserName addObject:cmd.strUserName];
            [arrayUserList addObject:cmd];
        }
    }
    [table reloadData];
    [self test];
    
}

-(void)manageUser{
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
        viewTab.hidden = YES;
        viewAdminTab.hidden = YES;
        viewSuperAdminTab.hidden = NO;
    }else if([appDelegate.STRUSERTYPE isEqualToString:@"Admin"]){
        viewTab.hidden = YES;
        viewAdminTab.hidden = NO;
        viewSuperAdminTab.hidden = YES;
    }else if([appDelegate.STRUSERTYPE isEqualToString:@"Staff"]){
        viewTab.hidden = NO;
        viewAdminTab.hidden = YES;
        viewSuperAdminTab.hidden = YES;
    }
}

-(void)ManageView{
    viewAdvanceSearch.hidden = YES;
    viewAdvanceSearchSuperAdmin.hidden = YES;
    CGRect frame= viewListUser.frame;
    frame.origin.y  = 0;
    frame.size.height  = viewAction.frame.origin.y-5;
    viewListUser.frame = frame;
}

-(void)ManageView1{
    CGRect frame= viewListUser.frame;
    frame.origin.y  = viewAdvanceSearch.frame.size.height;
    frame.size.height  = viewAction.frame.origin.y-5-viewAdvanceSearch.frame.size.height;
    viewListUser.frame = frame;
}

-(void)noDataFound{
    nomatchesView = [[UIView alloc] initWithFrame:self.view.frame];
    nomatchesView.backgroundColor = [UIColor clearColor];
    UILabel *matchesLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,table.frame.size.width,table.frame.size.height)];
    matchesLabel.font = [UIFont boldSystemFontOfSize:18];
    [matchesLabel setFont: [matchesLabel.font fontWithSize: 16]];
    matchesLabel.lineBreakMode = NSLineBreakByWordWrapping;
    matchesLabel.textAlignment = NSTextAlignmentCenter;
    matchesLabel.numberOfLines = 1;
    matchesLabel.shadowColor = [UIColor lightTextColor];
    matchesLabel.textColor = [UIColor darkGrayColor];
    matchesLabel.shadowOffset = CGSizeMake(0, 1);
    matchesLabel.backgroundColor = [UIColor clearColor];
    matchesLabel.text = @"No Record Found";
    [nomatchesView addSubview:matchesLabel];
    [table insertSubview:nomatchesView belowSubview:table];
}

-(void)test{
    arrayID = [[NSMutableArray alloc]init];
    CustomData *cmd = [[CustomData alloc]init];
    cmd.strPropertyAddress = @"Active";
    cmd.strId = @"1";
    [arrayID addObject:cmd];
    cmd = [[CustomData alloc]init];
    cmd.strPropertyAddress = @"Inactive";
    cmd.strId = @"2";
    [arrayID addObject:cmd];
    
}

-(void)webDepartmentData{
    NSString *parameter = [@"&company_id=" stringByAppendingString:appDelegate.STRCOMPANYID];
    NSDictionary *dataDictionary = [Methods  WebServerData:urlDepartmentList andPostParameter:parameter];
    NSArray *dataAry = [dataDictionary objectForKey:@"info"];
    NSString *strData = [dataDictionary objectForKey:@"status"];
    if([strData intValue]){
        arrayDepartment = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in dataAry) {
            CustomData *cmd = [[CustomData alloc]init];
            cmd.strDepartmentId = [dic valueForKey:@"department_id"];
            cmd.strDepartmentName = [dic valueForKey:@"department_name"];
            cmd.strPropertyAddress = [dic valueForKey:@"department_name"];
            cmd.strDepartmentStatus = [dic valueForKey:@"department_status"];
        }
    }
}

-(void)WebServices{
    AllWebServices *web = [[AllWebServices alloc]init];
    
    NSMutableArray *array = [web WebUser];
    urlForApprovalCount = [[array objectAtIndex:0]webForApprvalCount];  
    urlUserList  =[[array objectAtIndex:0]webUserList];
    urlDepartmentList = [[array objectAtIndex:0]webDepartmentList];
    urlCompany = [[array objectAtIndex:0]webCompany];
    urlChangeActionStatus = [[array objectAtIndex:0]webChangeActionStatus];
}

-(void)webUserListData{
    NSString *parameter = [@"grid_type=" stringByAppendingString:@"Dashboard"];
    [self PrintGrid:parameter];
}

-(void)showUiAlertWithMessage:(NSString *)message andtitle:(NSString *)title{
    UIAlertView *obj=[[UIAlertView alloc]initWithTitle:@""
                                               message:message
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles: nil];
    [obj show];
}

#pragma mark- UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
