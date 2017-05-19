
//
//  Dashboard.m
//  ActionLog
//
//  Created by Hardik Davda on 9/14/16.
//  Copyright © 2016 SLP-World. All rights reserved.
//

#import "Dashboard.h"
#import "KNCirclePercentView.h"
#import "AddSubtask.h"
#import "CustomDataform.h"
#import "CustomCellAdvanceSearch.h"
#import "PickerView.h"

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
 */

@interface Dashboard ()<CZPickerViewDelegate>{
    UIView *nomatchesView;
    // UIDatePicker *myPicker;
    NSDate *currentDate,*selectDate;
    int DATA;
    
    UIView *viewBackGround;
    UIView *viewLoader;
    NSTimer *timer;
    
    NSMutableArray *arrayTemp;
    NSMutableArray *arrayApply;
    
    NSMutableArray *arrayCompanies;
    NSMutableArray *arrayDepartment;
    NSMutableArray *arrayDepartmentFull;
    NSMutableArray *arrayCreatedBy;
    NSMutableArray *arrayAssignTo;
    NSMutableArray *arrayUserList;
    NSMutableArray *arrayStutas;
    NSMutableArray *arrayDueDate;
     NSMutableArray *arrayWorkDate;
    NSMutableArray *arrayPrint;
    NSMutableArray *arraAssignList;
    NSMutableArray *arraApprove;
    NSMutableArray *arrayListUser;
    NSMutableArray *arrayListUserApprove;
    NSMutableArray *arrayArchived;
    NSMutableArray *arrayTag;
    NSString *strForApprovalCount;
    NSMutableArray *arrayPrint1;
    NSMutableArray *arrayPrint11;
    
    NSMutableArray *arrayTesting;
    NSMutableArray *arraySubtask;
    NSString *dropDownSelection;
    NSString *clickhideDropDown;
    NSDateFormatter *dateFormat;
    
    NSString *urlCompany;
    NSString *urlDepartment;
    NSString *urlCreatedBy;
    NSString *urlAssignTo;
    NSString *urlStatus;
    NSString *urlDueDate;
    NSString *urlDueFrom;
    NSString *urlDueTo;
    NSString *urlSearch;
    NSString *urlDashboard;
    NSString *urlTagList;
    NSString *urlForApprovalCount;

    NSString *urlLogOut;
    
    NSString *urlChangeActionStatus;
    
    int alertDelete;
    NSString *strCompany_Id;
    NSString *strDepartment_Id;
    NSString *strCreatedBy_Id;
    NSString *strUserName_Id;
    NSString *strAssignTo_Id;
    NSString *strDateSELECT;
    
    KNCirclePercentView *circleView;
    int temp;
    UIView *view;
    CGRect TESTINGFRAME;
    NSString *strDataDemo;
    NSString *strGridType;
    int of;
    NSString *strLoard;
    NSString *strTEST;
    UIView *viewDemo;
    UIView *viewBackGround1;
    
    UIView *viewDemoTable;
    UIView *viewBackGroundTable;
    UIView *viewLoaderTable;
    CustomDataform *web;
}

@property (nonatomic) PickerView *companyPickerView;
@property (nonatomic) PickerView *departmentPickerView;
@property (nonatomic) PickerView *CreatedByPickerView;
@property (nonatomic) PickerView *assignToPickerView;
@property (nonatomic) PickerView *statusPickerView;
@property (nonatomic) PickerView *dueDatePickerView;
@property (nonatomic) PickerView *workDatePickerView;

@end

@implementation Dashboard

- (void)viewDidLoad {
    [super viewDidLoad];
//    viewAdminSearch.hidden = YES;
//    viewSuperAdminSearch.hidden = YES;
//    viewSuperAdminSearchForApproval.hidden = YES;
//    viewSearch.hidden = YES;
    viewUserSearch.hidden = YES;
    viewSearchButton.hidden = YES;
    
    lblCount1.hidden = YES;
    lblCount2.hidden = YES;
    
    aView.hidden = YES;
    [self manageUser];
    imgMenu.image = [imgMenu.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [imgMenu setTintColor:[UIColor whiteColor]];
    strGridType = @"Dashboard";
    viewTitleSearch.hidden =YES;
    viewTagSearch.hidden = YES;
    viewTag.hidden = YES;
    of = 0;
    arraySubtask = [[NSMutableArray alloc]init];
    web = [[CustomDataform alloc]init];
    if([appDelegate.ISAPPROVE isEqualToString:@"YES"] )
    {
        if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
            arraySubtask = [web ADSDFSuperAdmin];
        }else if ([appDelegate.STRUSERTYPE isEqualToString:@"Admin"]){
            arraySubtask = [web ADSDFSuperAdmin];
        }else{
            arraySubtask = [web ADSDFSuperAdmin];
        }
    }else{
        if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
            arraySubtask = [web ADSDSuperAdmin];
        }else if ([appDelegate.STRUSERTYPE isEqualToString:@"Admin"]){
            arraySubtask = [web ADSDAdmn];
        }else{
            arraySubtask = [web ADSDStaff];
        }
    }
    if(![appDelegate.STRUSERTYPE isEqualToString:@"Staff"]){
        int  rowNumber = 4;
        int idt = 0 ;
    
        for (int i = 0;i<arraySubtask.count;i++){
            if([[arraySubtask objectAtIndex:i]btnTag] == rowNumber){
                CustomDataform *cmd = [[CustomDataform alloc]init];
                cmd = [arraySubtask objectAtIndex:i];
                cmd.strSelectedValue = appDelegate.STRUSERNAME;  //@"Final it ";
                cmd.strValue = appDelegate.STRUSERID;
//            NSLog(@"Date Id %@",dataId);
                [arraySubtask removeObjectAtIndex:i];
                [arraySubtask insertObject:cmd atIndex:i];
                idt = i;
                break;
            }if ([[arraySubtask objectAtIndex:i]btnTag1] == rowNumber) {
                CustomDataform *cmd = [[CustomDataform alloc]init];
                cmd = [arraySubtask objectAtIndex:i];
                cmd.strSelectedValue1 = appDelegate.STRUSERNAME;//@"Final it ";
                cmd.strValue1 =  appDelegate.STRUSERID;
//            NSLog(@"Date Id %@",dataId);
            
                [arraySubtask removeObjectAtIndex:i];
                [arraySubtask insertObject:cmd atIndex:i];
                idt = i;
                break;
            }
        }
//        NSIndexPath* rowToReload2 = [NSIndexPath indexPathForRow:idt inSection:0];
//        NSArray* rowsToReload2 = [NSArray arrayWithObjects:rowToReload2, nil];
//        [tableSearch reloadRowsAtIndexPaths:rowsToReload2 withRowAnimation:UITableViewRowAnimationNone];
    }
    
   

    [tableSearch reloadData];
    [self manageAdvanceSearchView];
    viewSearchData.hidden = YES;
    strLoard =@"YES";
    [self setNeedsStatusBarAppearanceUpdate];
    
    viewFull.hidden = YES;
    if ([appDelegate.ISAPPROVE isEqualToString:@"NO"]){
        btnLogout.tag = 1;
        strDataDemo=@"NO";
        [Methods WebServerData:urlLogOut];
    }else{
        btnLogout.tag = 2;
        strDataDemo=@"YES";
    }
    
    [self viewMain];
    timer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(viewDidLoadCopy) userInfo:nil repeats:NO];
    timer = [NSTimer scheduledTimerWithTimeInterval:.05 target:self selector:@selector(stopGIF) userInfo:nil repeats:NO];
  }

-(void)manageAdvanceSearchView{
    
    float height = arraySubtask.count*44;
    NSLog(@"Height %f := Count %lu",height , (unsigned long)arraySubtask.count);
    CGRect fram = tableSearch.frame;
    fram.size.height = tableSearch.contentSize.height;
    tableSearch.frame =  fram;
    
    fram = viewSearchData.frame;
    fram.origin.y = 0;
    fram.size.height = tableSearch.frame.size.height;
    viewSearchData.frame = fram;
    
    fram = tableSearch.frame;
    fram.size.height = viewSearchData.frame.size.height;//tableSearch.contentSize.height+20;
    tableSearch.frame =  fram;
    
    

}

- (void)viewDidLoadCopy {
    //    [super viewDidLoad];
    imgMenu.image = [imgMenu.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [imgMenu setTintColor:[UIColor whiteColor]];
    
    Methods = [[AllMethods alloc]init];
//    txtAAssignTo.text = appDelegate.STRUSERNAME;
    alertDelete = 0;
    arraApprove = [[NSMutableArray alloc]init];
    arrayListUserApprove = [[NSMutableArray alloc]init];
    arrayPrint = [[NSMutableArray alloc]init];
    arraAssignList = [[NSMutableArray alloc]init];
    arrayListUser = [[NSMutableArray alloc]init];
    of=0;
    strLoard =@"YES";
    viewDate.hidden = YES;
    viewTagSearch.hidden = YES;
    arrayTesting = [[NSMutableArray alloc]init];
    TESTINGFRAME = viewTag.frame;
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"] || [appDelegate.STRUSERTYPE isEqualToString:@"Admin"])
        TESTINGFRAME.origin.y = 50;
    
    imgPlus.hidden = NO;
    btnPlus.hidden = NO;
    imgLogout.hidden = NO;
    btnLogout.hidden = NO;
    if ([appDelegate.ISAPPROVE isEqualToString:@"NO"]){
        lblTitle.text = @"DASHBOARD";
        viewAction.hidden = YES;
        //[self viewMain];
        [self initialize];
        //timer = [NSTimer scheduledTimerWithTimeInterval:.000000001 target:self selector:@selector(initialize) userInfo:nil repeats:NO];
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(stopGIF) userInfo:nil repeats:NO];
    }else{
        lblTitle.text = @"FOR APPROVAL";
        [self ForApproval:nil];
    }
    [self LoadServices];
    //    timer = [NSTimer scheduledTimerWithTimeInterval:7 target:self selector:@selector(LoadServices) userInfo:nil repeats:NO];
    clickhideDropDown = @"YES";
    NSString *parameter ;
    if([appDelegate.ISAPPROVE isEqualToString:@"YES"]){
        parameter = [@"grid_type=" stringByAppendingString:strGridType];
    }else{
        if([appDelegate.STRUSERTYPE isEqualToString:@"Admin"] || [appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
            parameter = [@"grid_type=" stringByAppendingString:[strGridType stringByAppendingString:[@"&assign_to="stringByAppendingString:appDelegate.STRUSERID]]];
            strAssignTo_Id =appDelegate.STRUSERID;
            // txtSAFAssignTo.text = appDelegate.STRUSERNAME;
//            txtSAAssignTo.text = appDelegate.STRUSERNAME;
        }else
            parameter = [@"grid_type=" stringByAppendingString:strGridType];
    }
    strTEST = parameter;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    aView.hidden = YES;
    //NSLog(@"Dasboard array count %lu",(unsigned long)arrayPrint.count);
    if ([appDelegate.ISAPPROVE isEqualToString:@"NO"]){
        btnLogout.tag = 1;
        strDataDemo=@"NO";
        [Methods WebServerData:urlLogOut];
    }else{
        btnLogout.tag = 2;
        strDataDemo=@"YES";
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    // [self setNeedsStatusBarAppearanceUpdate];
    return UIStatusBarStyleLightContent;
}

-(void)ResetArray{
    arraySubtask = [[NSMutableArray alloc]init];
    if([appDelegate.ISAPPROVE isEqualToString:@"YES"] )
    {
        if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
            arraySubtask = [web ADSDFSuperAdmin];
        }else if ([appDelegate.STRUSERTYPE isEqualToString:@"Admin"]){
            arraySubtask = [web ADSDFSuperAdmin];
        }else{
            arraySubtask = [web ADSDFSuperAdmin];
        }
    }else{
        if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
            arraySubtask = [web ADSDSuperAdmin];
        }else if ([appDelegate.STRUSERTYPE isEqualToString:@"Admin"]){
            arraySubtask = [web ADSDAdmn];
        }else{
            arraySubtask = [web ADSDStaff];
        }
    }
    [tableSearch reloadData];
    [self manageAdvanceSearchView];
}

- (void)initialize{
    //  viewAction.hidden = YES;
    //    viewUserSearch.hidden = YES;
    //    viewSearchButton.hidden = YES;
    
    
//    arraySubtask = [[NSMutableArray alloc]init];
//    [self ResetArray];
//
//    if([appDelegate.ISAPPROVE isEqualToString:@"YES"] )
//    {
//        if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
//            arraySubtask = [web ADSDFSuperAdmin];
//        }else if ([appDelegate.STRUSERTYPE isEqualToString:@"Admin"]){
//            arraySubtask = [web ADSDFSuperAdmin];
//        }else{
//            arraySubtask = [web ADSDFSuperAdmin];
//        }
//    }else{
//        if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
//            arraySubtask = [web ADSDSuperAdmin];
//        }else if ([appDelegate.STRUSERTYPE isEqualToString:@"Admin"]){
//            arraySubtask = [web ADSDAdmn];
//        }else{
//            arraySubtask = [web ADSDStaff];
//        }
//    }
//    [tableSearch reloadData];
//    [self manageAdvanceSearchView];
    viewAdvanceSearch.hidden = NO;
    
    viewUserSearch.hidden = YES;
    viewSearchButton.hidden = YES;
    viewTag.hidden = YES;
    viewTitleSearch.hidden = YES;
    
    [self HideDropDownAtAllPlace];
    [self AdvanceCollapseManage];
    [self closeTagManage];
    viewTagSearch.hidden = YES;
    arrayPrint1 = [[NSMutableArray alloc]initWithArray:arrayPrint11];
    
    [picker reloadAllComponents];
    [self ForClose];
    // [self Reset:sender];
    [self closeTagManage];
    
    
    if([appDelegate.ISAPPROVE isEqualToString:@"YES"]){
        btnMenu.hidden = YES;
        imgMenu.hidden = YES;
    }else{
        btnMenu.hidden = NO;
        imgMenu.hidden = NO;
    }
    [self ManageAllArrayforDropDown];
    [self manageUser];
    [self AdvanceCollapseManage];
    [self dateTime];
    [self WebServices];
    [self GetAssign];
    arraApprove = [[NSMutableArray alloc]init];
    arrayListUserApprove = [[NSMutableArray alloc]init];
    arrayPrint = [[NSMutableArray alloc]init];
    arraAssignList = [[NSMutableArray alloc]init];
    arrayListUser = [[NSMutableArray alloc]init];
    strLoard =@"YES";
    of=0;
    aView.hidden = YES;
    [self WebData];
    //    [self GetAssign];
    [self ManageForApprove];
    arrayApply= [[NSMutableArray alloc]init];
    temp = table.frame.size.width;
    Methods = [[AllMethods alloc]init];
}

-(void)LoadServices{
    //NSLog(@"Loard service");
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"] ||[appDelegate.STRUSERTYPE isEqualToString:@"Admin"]||[appDelegate.STRUSERTYPE isEqualToString:@"Staff"] ){
        [self GetStatus];
        [self GetOverDue];
        
    }
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"] ||[appDelegate.STRUSERTYPE isEqualToString:@"Admin"]){
        [self GetDepartment];
    }
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
        [self GetCompany];
    }
    [self GetTag];
    [self GetForApprovalCount];
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

-(void)viewMainTable{
    //    viewBackGroundTable = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    //    [viewBackGroundTable setBackgroundColor:[UIColor whiteColor]];
    //    viewBackGroundTable.alpha = 0.6f;
    //    [self.view addSubview:viewBackGround];
    //viewDemoTable = [[UIView alloc]initWithFrame:CGRectMake(0, viewFullAll.frame.origin.y+viewFull.frame.origin.y+viewListAction.frame.origin.y, viewListAction.frame.size.width, 400)];
    
    viewDemoTable = [[UIView alloc]initWithFrame:CGRectMake(table.frame.origin.x, viewListAction.frame.size.height-50, table.frame.size.width, 50)];
    
    //viewDemoTable.backgroundColor = [UIColor redColor];
    [viewDemoTable setBackgroundColor:[UIColor whiteColor]];
    UIImageView *imgLoading = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,44,44)];
    viewLoaderTable= [[UIView alloc] initWithFrame:CGRectMake(viewListAction.frame.size.width/2-50, 0, viewListAction.frame.size.width ,44)];
    [viewLoaderTable setBackgroundColor:[UIColor clearColor]];
    NSURL *url1 = [[NSBundle mainBundle] URLForResource:@"60" withExtension:@"gif"];
    imgLoading.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url1]];
    [viewLoaderTable addSubview:imgLoading];
    [viewDemoTable addSubview:viewLoaderTable];
    [viewListAction addSubview:viewDemoTable];
}

-(void)stopGIFTable{
    [viewDemoTable removeFromSuperview];
    //[viewDemoTable removeFromSuperview];
}

-(void)stopGIF{
    table.hidden = NO;
    [viewLoader removeFromSuperview];
    [viewBackGround removeFromSuperview];
    viewFull.hidden = NO;
}

#pragma -mark UITableview Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{              // Default is 1 if not implemented
    [nomatchesView removeFromSuperview];
     if (tableView.tag == 1){
         if(arrayPrint.count == 0)
            [self noDataFound];
        else
            [nomatchesView removeFromSuperview];
         return arrayPrint.count;
     }else{
         return 1;
     }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     if (tableView.tag == 1){
         return 1;
     }else{
         return arraySubtask.count;
     }
}

- (void)setUpCellForDashboard:(CustomCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Methods = [[AllMethods alloc]init];
    cell.lblTitle.text = [[arrayPrint objectAtIndex:indexPath.section]strActionLogTitle];
    cell.lblDueDate.text =  [[arrayPrint objectAtIndex:indexPath.section]strDashboardDueDate];
    cell.lblPercentages.text = [[arrayPrint objectAtIndex:indexPath.section]strPercentageCompleted];
    
    int it = (int)indexPath.section;
    
    it = [[[arrayPrint objectAtIndex:indexPath.section]strPercentageCompleted] intValue];
    circleView =[[KNCirclePercentView alloc]initWithFrame:CGRectMake(lbll.frame.origin.x, 23, 38, 38)] ;
    
    NSString *res = [NSString stringWithFormat:@"%@",[[arrayPrint objectAtIndex:indexPath.section]strPercentageCompleted]];
    cell.lblPercentages.text = res;
    cell.lblWorkDate.text = [[arrayPrint objectAtIndex:indexPath.section]strWorkDate];
    if([@"Empty" isEqualToString:[Methods whitSpace:[[arrayPrint objectAtIndex:indexPath.section]strReviceDateColor]]]){
        if([[[arrayPrint objectAtIndex:indexPath.section]strColor] isEqualToString:@"red"] ){
            cell.lblDueDate.textColor = [Methods colorWithHexString:@"E35444"];
        }else{
            cell.lblDueDate.textColor = [Methods colorWithHexString:@"74AD46"];//74AD46
        }
    }else{
        if([[[arrayPrint objectAtIndex:indexPath.section]strReviceDateColor] isEqualToString:@"red"] ){
            cell.lblDueDate.textColor = [Methods colorWithHexString:@"E35444"];
        }else{
            cell.lblDueDate.textColor = [Methods colorWithHexString:@"74AD46"];//74AD46
        }
    }
    if([[[arrayPrint objectAtIndex:indexPath.section]strWorkDateColor] isEqualToString:@"red"]){
        cell.lblWorkDate.textColor = [Methods colorWithHexString:@"E35444"];
    }else{
        cell.lblWorkDate.textColor = [Methods colorWithHexString:@"74AD46"];//74AD46
    }
    if([[[arrayPrint objectAtIndex:indexPath.section]strWorkDate] isEqualToString:@"No Work date"]){
        cell.lblWorkDate.textColor = [Methods colorWithHexString:@"757575"];//74AD46
        
    }
    [cell addSubview:circleView];
    [circleView drawCircleWithPercent:it];
    [circleView startAnimation];

}

- (void)setUpCellForApproval:(CustomCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.lblTitle.text = [[arrayPrint objectAtIndex:indexPath.section]strActionLogTitle];
    cell.lblDueDate.text =  [[arrayPrint objectAtIndex:indexPath.section]strDashboardDueDate];
    cell.btnCheck.tag = indexPath.section;
    if([[[arrayPrint objectAtIndex:indexPath.section]strCreatedBy]isEqualToString:appDelegate.STRUSERID]){
        cell.btnCheck.hidden = NO;
        if ([[[arrayPrint objectAtIndex:indexPath.section]strIsCheck] isEqualToString:@"YES"]){
            cell.imgCheck.image = [UIImage imageNamed:@"chack-btn-1.png"];
        } else
            cell.imgCheck.image = [UIImage imageNamed:@"checkDisbale.png"];
    }
    else{
        cell.btnCheck.hidden = YES;
        cell.imgCheck.image = [UIImage imageNamed:@"Check-dis.png"];
    }
    cell.lblWorkDate.text = [[arrayPrint objectAtIndex:indexPath.section]strWorkDate];
    if([@"Empty" isEqualToString:[Methods whitSpace:[[arrayPrint objectAtIndex:indexPath.section]strReviceDateColor]]]){
        if([[[arrayPrint objectAtIndex:indexPath.section]strColor] isEqualToString:@"red"] ){
            cell.lblDueDate.textColor = [Methods colorWithHexString:@"E35444"];
        }else{
            cell.lblDueDate.textColor = [Methods colorWithHexString:@"74AD46"];//74AD46
        }
    }else{
        if([[[arrayPrint objectAtIndex:indexPath.section]strReviceDateColor] isEqualToString:@"red"] ){
            cell.lblDueDate.textColor = [Methods colorWithHexString:@"E35444"];
        }else{
            cell.lblDueDate.textColor = [Methods colorWithHexString:@"74AD46"];//74AD46
        }
    }
    if([[[arrayPrint objectAtIndex:indexPath.section]strWorkDateColor] isEqualToString:@"red"]){
        cell.lblWorkDate.textColor = [Methods colorWithHexString:@"E35444"];
    }else{
        cell.lblWorkDate.textColor = [Methods colorWithHexString:@"74AD46"];//74AD46
    }
    if([[[arrayPrint objectAtIndex:indexPath.section]strWorkDate] isEqualToString:@"No Work date"]){
        cell.lblWorkDate.textColor = [Methods colorWithHexString:@"757575"];//74AD46
        
    }

//
//    if([[[arrayPrint objectAtIndex:indexPath.section]strColor] isEqualToString:@"red"]){
//        cell.lblDueDate.textColor = [Methods colorWithHexString:@"E35444"];
//    }else{
//        cell.lblDueDate.textColor = [Methods colorWithHexString:@"74AD46"];//74AD46
//    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == table){
        CustomCell *cell;// = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if ([appDelegate.ISAPPROVE isEqualToString:@"NO"]){
            cell= [tableView dequeueReusableCellWithIdentifier:@"cell"];
            [self setUpCellForDashboard:cell atIndexPath:indexPath];
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
            [self setUpCellForApproval:cell atIndexPath:indexPath];
        }
        NSInteger lastSectionIndex = [tableView numberOfSections] - 1;
        NSInteger lastRowIndex = [tableView numberOfRowsInSection:lastSectionIndex] - 1;
    
        if ((indexPath.section == lastSectionIndex) && (indexPath.row == lastRowIndex)) {
            if([strLoard isEqualToString:@"YES"]){
                [self  viewMainTable];
                timer = [NSTimer scheduledTimerWithTimeInterval:.0001 target:self selector:@selector(webReload) userInfo:nil repeats:NO];
            }
        }
        if([strLoard isEqualToString:@"YES"]){
        }
        cell.accessoryView = NULL;
        return  cell;
    }else{
         CustomCellAdvanceSearch *cell;
        NSLog(@"Advance Search");
        if ([[arraySubtask objectAtIndex:indexPath.row]Id] == 00){
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        }else
        if ([[arraySubtask objectAtIndex:indexPath.row]isSingal]) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            [self setUpCellForSuperAdmin:cell atIndexPath:indexPath];
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
                [self setUpCellForAdmin:cell atIndexPath:indexPath];
        }
//[appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"] || [appDelegate.STRUSERTYPE isEqualToString:@"Admin"])
//            if ([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
//                if (indexPath.row == 0){
//                    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//                }else{
//                    cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
//                }
//                [self setUpCellForSuperAdmin:cell atIndexPath:indexPath];
//            }
//            else if ([appDelegate.STRUSERTYPE isEqualToString:@"Admin"]){
//                cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
//                [self setUpCellForAdmin:cell atIndexPath:indexPath];
//            }else if([appDelegate.STRUSERTYPE isEqualToString:@"Staff"]){
//                cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
//                [self setUpCellForStaff:cell atIndexPath:indexPath];
//            }
        
        return  cell;
    }
}
- (void)setUpCellForSuperAdmin:(CustomCellAdvanceSearch *)cell atIndexPath:(NSIndexPath *)indexPath {
    
       cell.txtFilter.placeholder = [[arraySubtask objectAtIndex:indexPath.row]strPlaceholder];
        cell.txtFilter.text = [[arraySubtask objectAtIndex:indexPath.row]strSelectedValue];
        cell.txtFilter.tag = indexPath.section;
        cell.btnOne.tag = [[arraySubtask objectAtIndex:indexPath.row]btnTag];
        cell.imgAerro.image = [[arraySubtask objectAtIndex:indexPath.row]imgAerro];
   
}

- (void)setUpCellForAdmin:(CustomCellAdvanceSearch *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.txtFilter.placeholder = [[arraySubtask objectAtIndex:indexPath.row]strPlaceholder];
    cell.txtFilter1.placeholder = [[arraySubtask objectAtIndex:indexPath.row]strSelectedValue];
    cell.txtFilter.text = [[arraySubtask objectAtIndex:indexPath.row]strSelectedValue];
    cell.txtFilter1.text = [[arraySubtask objectAtIndex:indexPath.row]strSelectedValue1];
    cell.btnOne.tag = [[arraySubtask objectAtIndex:indexPath.row]btnTag];
    cell.btnTwo.tag = [[arraySubtask objectAtIndex:indexPath.row]btnTag1];
    cell.imgAerro.image = [[arraySubtask objectAtIndex:indexPath.row]imgAerro];
    cell.imgAerro1.image = [[arraySubtask objectAtIndex:indexPath.row]imgAerro1];
}

//- (void)setUpCellForStaff:(CustomCellAdvanceSearch *)cell atIndexPath:(NSIndexPath *)indexPath {
//    cell.txtFilter.placeholder = [[arraySubtask objectAtIndex:indexPath.row]strPlaceholder];
//    cell.txtFilter1.placeholder = [[arraySubtask objectAtIndex:indexPath.row]strPlaceholder1];
//    cell.txtFilter.text = [[arraySubtask objectAtIndex:indexPath.row]strSelectedValue];
//    cell.txtFilter1.text = [[arraySubtask objectAtIndex:indexPath.row]strSelectedValue1];
//    cell.btnOne.tag = [[arraySubtask objectAtIndex:indexPath.row]btnTag];
//    cell.btnTwo.tag = [[arraySubtask objectAtIndex:indexPath.row]btnTag1];
//    cell.imgAerro.image = [[arraySubtask objectAtIndex:indexPath.row]imgAerro];
//    cell.imgAerro1.image = [[arraySubtask objectAtIndex:indexPath.row]imgAerro1];
//}

#pragma -mark UITableview Delegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     if (tableView.tag == 1){
         NSString *strCreatedby;
         NSMutableArray *array = [[NSMutableArray alloc]init];
         for (int i = 0; i<appDelegate.ARRAYFULLASSIGNTO.count; i++) {
            int idt = [ [[arrayPrint objectAtIndex:indexPath.section]strCreatedBy]intValue];
            int key = [[[appDelegate.ARRAYFULLASSIGNTO objectAtIndex:i]strKey]intValue];
            if (idt== key) {
                strCreatedby = [[appDelegate.ARRAYFULLASSIGNTO objectAtIndex:i]strStatus];
                appDelegate.STRCREATEDBY = [[appDelegate.ARRAYFULLASSIGNTO objectAtIndex:i]strStatus];
                break;
            }
        }
         CustomData *cmd= [[CustomData alloc]init];
         cmd = [arrayPrint objectAtIndex:indexPath.section];
         cmd.strUserName = strCreatedby;
         cmd.strAssignTo = [[arrayPrint objectAtIndex:indexPath.section]strAssignTo];
         cmd.strFrom = @"Dashboard";
         [array addObject:cmd];
         NSString *strActionLogId = [[arrayPrint objectAtIndex:indexPath.section]strId];
         AddSubtask *second=[self.storyboard instantiateViewControllerWithIdentifier:@"addsubtask"];
         second.getActionLogId = strActionLogId;
         second.getActionLogTitle =[[arrayPrint objectAtIndex:indexPath.section]strActionLogTitle];
         second.arrayGetDetail = array;
         second.getStatus = @"Dashboard";
         [self.navigationController pushViewController:second animated:YES];
     }
    return  indexPath;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
     if (tableView.tag == 1){
         return 10.0f;
     }else
         return 0.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == table){
    return 76.0;
    }else{
        return 37.0;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width,10)];
    [view1 setBackgroundColor: [Methods colorWithHexString:@"EFEFEF"]];
    
    return view1;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *) indexPath{
    if (tableView.tag == 1){
    return YES;
    }else
        return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //  NSLog(@"Try");
    if (editingStyle == UITableViewCellEditingStyleDelete){
        //NSLog(@"Index path row %ld",indexPath.section);
        
        if([appDelegate.STRUSERID isEqualToString:[[arrayPrint objectAtIndex:indexPath.section]strCreatedBy]]){
            alertDelete = 2;
            UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"" message:@"Are you sure! You want to delete this action" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
            av.tag = indexPath.section;
            [av show];
        }else{
            alertDelete = 0;
            [self showUiAlertWithMessage:@"You have no rights to delete this action" andtitle:@""];
        }
    }
}


-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Delete";
}


- (IBAction)Add1:(id)sender{
    UIButton *btn = sender;
    //    if (!self.statusPickerView) {
    //        self.statusPickerView = [[PickerView alloc] initWithHeaderTitle:@"Statuses" values:arrayStutas];
    //        self.statusPickerView.delegate = self;
    //    }
    //    self.statusPickerView.values = arrayStutas;
    //    [self.statusPickerView show];
    
    switch (btn.tag) {
        case 1:
            NSLog(@" Companies");
            dropDownSelection = @"Companies";
            if (!self.companyPickerView) {
                self.companyPickerView = [[PickerView alloc] initWithHeaderTitle:@"Companies" values:arrayCompanies];
                self.companyPickerView.delegate = self;
            }
            self.companyPickerView.values = arrayCompanies;
            [self.companyPickerView show];
            
//            [self DropDownPicker:@"Companies" andSelectionArray:arrayCompanies];
            break;
            
        case 2:
            NSLog(@"Departments ");
            dropDownSelection = @"Department";
            if (!self.departmentPickerView) {
                self.departmentPickerView = [[PickerView alloc] initWithHeaderTitle:@"Departments" values:arrayDepartment];
                self.departmentPickerView.delegate = self;
            }
            self.departmentPickerView.values = arrayDepartment;
            [self.departmentPickerView show];

//            [self DropDownPicker:@"Departments" andSelectionArray:arrayDepartment];
            break;
            
        case 3:
            NSLog(@"Created By ");
            dropDownSelection = @"CreatedBy";
            if (!self.CreatedByPickerView) {
                self.CreatedByPickerView = [[PickerView alloc] initWithHeaderTitle:@"Created By" values:arrayCreatedBy];
                self.CreatedByPickerView.delegate = self;
            }
            self.CreatedByPickerView.values = arrayCreatedBy;
            [self.CreatedByPickerView show];

//            [self DropDownPicker:@"Created By" andSelectionArray:arrayCreatedBy];
            break;
            
        case 4:
            NSLog(@" Assign To");
            dropDownSelection = @"AssignTo";
            if (!self.assignToPickerView) {
                self.assignToPickerView = [[PickerView alloc] initWithHeaderTitle:@"Assign To" values:arrayAssignTo];
                self.assignToPickerView.delegate = self;
            }
            self.assignToPickerView.values = arrayAssignTo;
            [self.assignToPickerView show];

//            [self DropDownPicker:@"Assign To" andSelectionArray:arrayAssignTo];
            break;
            
        case 5:
            NSLog(@" Status");
            dropDownSelection = @"Stutas";
            if (!self.statusPickerView) {
                self.statusPickerView = [[PickerView alloc] initWithHeaderTitle:@"Stutas" values:arrayStutas];
                self.statusPickerView.delegate = self;
            }
            self.statusPickerView.values = arrayStutas;
            [self.statusPickerView show];

//            [self DropDownPicker:@"Stutas" andSelectionArray:arrayStutas];
            break;
            
        case 6:
            NSLog(@" All(Due)");
            dropDownSelection = @"DueDate";
            if (!self.dueDatePickerView) {
                self.dueDatePickerView = [[PickerView alloc] initWithHeaderTitle:@"DueDate" values:arrayDueDate];
                self.dueDatePickerView.delegate = self;
            }
            self.dueDatePickerView.values = arrayDueDate;
            [self.dueDatePickerView show];

//            [self DropDownPicker:@"DueDate" andSelectionArray:arrayDueDate];
           break;
            
        case 7:
            NSLog(@"All(Work) ");
            dropDownSelection = @"WorkDate";
            if (!self.workDatePickerView) {
                self.workDatePickerView = [[PickerView alloc] initWithHeaderTitle:@"WorkDate" values:arrayWorkDate];
                self.workDatePickerView.delegate = self;
            }
            self.workDatePickerView.values = arrayWorkDate;
            [self.workDatePickerView show];

//            [self DropDownPicker:@"WorkDate" andSelectionArray:arrayWorkDate];
            break;
            
        case 8:
            NSLog(@" Work From Date");
            strDateSELECT =@"WorkFrom";
            viewDate.hidden = NO;
            dropDownSelection = @"";
           // [self DropDownPicker:@"Created By" andSelectionArray:arrayCreatedBy];
            
            break;
            
        case 9:
            NSLog(@" Work To Date");
            strDateSELECT = @"WorkTo";
            viewDate.hidden = NO;
//            [self ReloadCell:9 andvalueOfString:@"get It" DatId :@""];
            break;
            
        case 10:
            NSLog(@"Due From Date");
            strDateSELECT = @"DueFrom";
//            dropDownSelection = @"Status";
            viewDate.hidden = NO;
//            if (!self.statusPickerView) {
//                self.statusPickerView = [[PickerView alloc] initWithHeaderTitle:@"Statuses" values:arrayStutas];
//                self.statusPickerView.delegate = self;
//            }
//            self.statusPickerView.values = arrayStutas;
//            [self.statusPickerView show];
//                        [self ReloadCell:10 andvalueOfString:@"get It" DatId :@""];
            
            break;
            
        case 11:
            NSLog(@"Due To Date");
            strDateSELECT = @"DueTo";
            viewDate.hidden = NO;
//            dropDownSelection = @"Date";
//            if (!self.statusPickerView) {
//                self.statusPickerView = [[PickerView alloc] initWithHeaderTitle:@"DueDate" values:arrayDueDate];
//                self.statusPickerView.delegate = self;
//            }
//            self.statusPickerView.values = arrayDueDate;
//            [self.statusPickerView show];
//                         [self ReloadCell:11 andvalueOfString:@"get It" DatId :@""];
            break;
        case 31:
            if(arrayDueDate.count){
                dropDownSelection = @"Archived";
                [self DropDownPicker:@"Change Status" andSelectionArray:arrayArchived];
                
//                clickhideDropDown = @"NO";
//                dropDownSelection = @"Archived";
//                CGRect rt = txtArchived.frame;
//                float height = MIN(220,(arrayArchived.count)*44);
//                [self showPopUpWithTitle:@"Select Due Date" withOption:arrayArchived Option1:arrayTemp xy:CGPointMake(rt.origin.x,viewFullAll.frame.size.height-(height-viewAction.frame.size.height-txtArchived.frame.origin.y)) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
            }
            break;
        
        case 50:
            dropDownSelection = @"UserList";
             [self DropDownPicker:@"Stutas" andSelectionArray:arrayUserList];
            break;
        default:
            NSLog(@" Not Identyfy");
            [self ReloadCell:1 andvalueOfString:@"get It" DatId :@""];
            break;
    }
    if(btn.tag == 0){
        
    }
}

-(void)ReloadCell:(int) rowNumber andvalueOfString:(NSString *)dataValue DatId : (NSString *)dataId{
    int idt = 0;
    for (int i = 0;i<arraySubtask.count;i++){
        if([[arraySubtask objectAtIndex:i]btnTag] == rowNumber){
            CustomDataform *cmd = [[CustomDataform alloc]init];
            cmd = [arraySubtask objectAtIndex:i];
            cmd.strSelectedValue = dataValue;//@"Final it ";
            cmd.strValue = dataId;
            NSLog(@"Date Id %@",dataId);
            [arraySubtask removeObjectAtIndex:i];
            [arraySubtask insertObject:cmd atIndex:i];
            idt = i;
            break;
        }if ([[arraySubtask objectAtIndex:i]btnTag1] == rowNumber) {
            CustomDataform *cmd = [[CustomDataform alloc]init];
            cmd = [arraySubtask objectAtIndex:i];
            cmd.strSelectedValue1 = dataValue;//@"Final it ";
            cmd.strValue1 =  dataId;
            NSLog(@"Date Id %@",dataId);

            [arraySubtask removeObjectAtIndex:i];
            [arraySubtask insertObject:cmd atIndex:i];
            idt = i;
            break;
        }
    }
//    for (int i = 0;i<arraySubtask.count;i++){
//        NSLog(@"Pelu := %@",[[arraySubtask objectAtIndex:i]strSelectedValue]);
//        NSLog(@"Biju := %@",[[arraySubtask objectAtIndex:i]strSelectedValue1]);
//    }
    
    NSIndexPath* rowToReload2 = [NSIndexPath indexPathForRow:idt inSection:0];
    NSArray* rowsToReload2 = [NSArray arrayWithObjects:rowToReload2, nil];
    [tableSearch reloadRowsAtIndexPaths:rowsToReload2 withRowAnimation:UITableViewRowAnimationNone];
}


#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [arrayPrint1 count];
}

#pragma mark- Picker View Delegate
//
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
//
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 26)];
//    // label.backgroundColor = [UIColor grayColor];
//    label.textColor = [UIColor whiteColor];
//    label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
//    label.text = [arrayPrint1 objectAtIndex:row] ;
//    label.textAlignment = NSTextAlignmentCenter;
//    return label;
//}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component{
    //[txtTagSearch setText:[arrayPrint1 objectAtIndex:row]];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow: (NSInteger)row forComponent:(NSInteger)component{
    return [arrayPrint1 objectAtIndex:row];
}

#pragma mark- Picker View Delegate of Dropdown

-(void)czpickerView:(PickerView *)pickerView didConfirmWithItemAtRow:(NSInteger)row {
    clickhideDropDown = @"YES";
    NSLog( @"%@",dropDownSelection);
    //[scroll setContentOffset:CGPointMake(0,0) animated:YES ];
    if([@"Companies" isEqualToString:dropDownSelection]){
         strCompany_Id = [NSString stringWithFormat:@"%@",[[arrayCompanies objectAtIndex:row]strCompanyId]];
        [self ReloadCell:1 andvalueOfString:[[arrayCompanies objectAtIndex:row]strPropertyAddress] DatId : [[arrayCompanies objectAtIndex:row]strCompanyId]];
       
        [self ShortDepartment];
    }
    else if([@"Department" isEqualToString:dropDownSelection]){
        [self ReloadCell:2 andvalueOfString:[[arrayDepartment objectAtIndex:row]strPropertyAddress] DatId :[[arrayDepartment objectAtIndex:row]strDepartmentId]];
        strDepartment_Id =[NSString stringWithFormat:@"%@",[[arrayDepartment objectAtIndex:row]strDepartmentId]];
    }
    else if([@"CreatedBy" isEqualToString:dropDownSelection]){
        [self ReloadCell:3 andvalueOfString:[[arrayCreatedBy objectAtIndex:row]strPropertyAddress] DatId :[[arrayCreatedBy objectAtIndex:row]strKey]];
        strCreatedBy_Id = [[arrayCreatedBy objectAtIndex:row]strKey];
        
    }// DatId :@""
    else if([@"AssignTo" isEqualToString:dropDownSelection]){
        [self ReloadCell:4 andvalueOfString:[[arrayAssignTo objectAtIndex:row]strPropertyAddress] DatId :[[arrayAssignTo objectAtIndex:row]strKey]];
        strAssignTo_Id = [[arrayAssignTo objectAtIndex:row]strKey];
    }
    else if([@"Stutas" isEqualToString:dropDownSelection]){
        [self ReloadCell:5 andvalueOfString:[[arrayStutas objectAtIndex:row]strPropertyAddress] DatId :[[arrayStutas objectAtIndex:row]strPropertyAddress]];
    }
    else if([@"DueDate" isEqualToString:dropDownSelection]){
        [self ReloadCell:6 andvalueOfString:[[arrayDueDate objectAtIndex:row]strPropertyAddress] DatId :[[arrayDueDate objectAtIndex:row]strPropertyAddress] ];
    }
    else if([@"WorkDate" isEqualToString:dropDownSelection]){
        [self ReloadCell:7 andvalueOfString:[[arrayWorkDate objectAtIndex:row]strPropertyAddress] DatId :[[arrayWorkDate objectAtIndex:row]strPropertyAddress] ];
    }
    else if([@"Archived" isEqualToString:dropDownSelection]){
        txtArchived.text = [[arrayArchived objectAtIndex:row]strPropertyAddress];

    }else if([@"UserList" isEqualToString:dropDownSelection]){
        txtSearchUser.text = [[arrayUserList objectAtIndex:row]strPropertyAddress];
        strUserName_Id = [[arrayUserList objectAtIndex:row]strKey];
    }
    
}

#pragma mark- Button IBAction (click Events)

- (IBAction)AdvanceSearch:(id)sender{
    //[self LoadServices];
    //if(arrayPrint.count != 0)
    {
        [self HideDropDownAtAllPlace];
        UIButton *btn = sender;
        switch (btn.tag) {
            case 1:
                btnAdvanceSearchCollapse.tag = 1;
                [self AdvanceSearchManage];
                break;
            case 2:
                [self AdvanceCollapseManage];
                break;
            default:
                btnAdvanceSearchCollapse.tag = 2;
                break;
        }
    }
    //    else
    //        [self showUiAlertWithMessage:@"You have no action available for search" andtitle:@""];
}

- (IBAction)AddAction:(id)sender{
    [self.view endEditing:YES];
    [self HideDropDownAtAllPlace];
    AddAction *second=[self.storyboard instantiateViewControllerWithIdentifier:@"addaction"] ;
    [self.navigationController pushViewController:second animated:YES];
}

-(IBAction)AddTag:(id)sender{
    viewTagSearch.hidden = NO;
}

- (IBAction)AllCheck:(id)sender{
    [self HideDropDownAtAllPlace];
    if(btnCheckAll.tag == 1){
        NSString *strCheck;
        strCheck = @"NO";
        btnCheckAll.tag = 2;
        imgChekApply.image = [UIImage imageNamed:@"SelectBtn.png"];
        arrayApply = [[NSMutableArray alloc]init];
        for (int i=0 ; i<arrayPrint.count; i++) {
            CustomData *cmd = [[ CustomData alloc]init];
            cmd = [arrayPrint objectAtIndex:i];
//            cmd.strId = [[arrayPrint objectAtIndex:i]strId];//
//            cmd.strActionLogTitle = [[arrayPrint objectAtIndex:i]strActionLogTitle];
//            cmd.strTagId =[[arrayPrint objectAtIndex:i]strTagId];
//            cmd.strAssignTo = [[arrayPrint objectAtIndex:i]strAssignTo];
//            cmd.strDueDate = [[arrayPrint objectAtIndex:i]strDueDate];
//            cmd.strCreatedDate = [[arrayPrint objectAtIndex:i]strCreatedDate];
//            cmd.strDashboardDueDate = [[arrayPrint objectAtIndex:i]strDashboardDueDate];
//            cmd.strNotesReadStatus = [[arrayPrint objectAtIndex:i]strNotesReadStatus];
//            cmd.strRevisedDate = [[arrayPrint objectAtIndex:i]strRevisedDate];
//            cmd.strPercentageCompleted = [[arrayPrint objectAtIndex:i]strPercentageCompleted];
//            cmd.strColor = [[arrayPrint objectAtIndex:i]strColor];
//            cmd.strStatus = [[arrayPrint objectAtIndex:i]strStatus];
//            cmd.strCreatedBy = [[arrayPrint objectAtIndex:i]strCreatedBy];
//            cmd.strNoteCount =[[arrayPrint objectAtIndex:i]strNoteCount];
            if([[[arrayPrint objectAtIndex:i]strCreatedBy]isEqualToString:appDelegate.STRUSERID]){
                cmd.strIsCheck   = @"YES";
                strCheck = @"YES";
                [arrayApply addObject:cmd];
            }else
                cmd.strIsCheck   = @"NO";
            [arrayPrint replaceObjectAtIndex:i withObject:cmd];
        }
        if([strCheck isEqualToString:@"NO"]){
            btnCheckAll.tag = 1;
            imgChekApply.image = [UIImage imageNamed:@"checkDisbale.png"];
            [self showUiAlertWithMessage:@"You have not create any action" andtitle:@""];
            //            [self showUiAlertWithMessage:@"You have not create any action" andtitle:@""];
        }
    }else{
        arrayApply = [[NSMutableArray alloc]init];
        for (int i=0 ; i<arrayPrint.count; i++) {
            CustomData *cmd = [[ CustomData alloc]init];
            cmd = [arrayPrint objectAtIndex:i];
//            cmd.strId = [[arrayPrint objectAtIndex:i]strId];//
//            cmd.strActionLogTitle = [[arrayPrint objectAtIndex:i]strActionLogTitle];
//            cmd.strTagId = [[arrayPrint objectAtIndex:i]strTagId];
//            cmd.strAssignTo = [[arrayPrint objectAtIndex:i]strAssignTo];
//            cmd.strDueDate = [[arrayPrint objectAtIndex:i]strDueDate];
//            cmd.strCreatedDate = [[arrayPrint objectAtIndex:i]strCreatedDate];
//            cmd.strDashboardDueDate =[[arrayPrint objectAtIndex:i]strDashboardDueDate];
//            cmd.strNotesReadStatus = [[arrayPrint objectAtIndex:i]strNotesReadStatus];
//            cmd.strRevisedDate = [[arrayPrint objectAtIndex:i]strRevisedDate];
//            cmd.strPercentageCompleted = [[arrayPrint objectAtIndex:i]strPercentageCompleted];
//            cmd.strColor = [[arrayPrint objectAtIndex:i]strColor];
//            cmd.strStatus = [[arrayPrint objectAtIndex:i]strStatus];
//            cmd.strCreatedBy = [[arrayPrint objectAtIndex:i]strCreatedBy];
//            cmd.strNoteCount =[[arrayPrint objectAtIndex:i]strNoteCount];
            cmd.strIsCheck   = @"NO";
            [arrayPrint replaceObjectAtIndex:i withObject:cmd];
        }
        btnCheckAll.tag = 1;
        imgChekApply.image = [UIImage imageNamed:@"checkDisbale.png"];
    }
    [table reloadData];
}

- (IBAction)ApplyCheck:(id)sender{
    [self HideDropDownAtAllPlace];
    if(arrayApply.count != 0){
        alertDelete = 1;
        NSString *strMesage = [@"Are you sure! You want to " stringByAppendingString:[txtArchived.text stringByAppendingString:@" this action"]] ;
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"" message:strMesage delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [av show];
    }else{
        [self showUiAlertWithMessage:@"You have not select any action" andtitle:@""];
    }
}


- (IBAction)Archived:(id)sender{
    Archived *second=[self.storyboard instantiateViewControllerWithIdentifier:@"archived"] ;
    [self.navigationController pushViewController:second animated:YES];
}

-(void)CallData{
    NSString *parameter = [@"grid_type=" stringByAppendingString:strGridType];
    arraApprove = [[NSMutableArray alloc]init];
    arrayListUserApprove = [[NSMutableArray alloc]init];
    arrayPrint = [[NSMutableArray alloc]init];
    arraAssignList = [[NSMutableArray alloc]init];
    arrayListUser = [[NSMutableArray alloc]init];
    strLoard =@"YES";
    of=0;
    strLoard =@"YES";
    [self PrintGrid:parameter];
}

- (IBAction)CancelTag:(id)sender{
    viewTagSearch.hidden = YES;
}

-(IBAction)ChangePassword:(id)sender{
    ChangePassword  *second=[self.storyboard instantiateViewControllerWithIdentifier:@"changepassword"] ;
    [self.navigationController pushViewController:second animated:YES];
}

-(IBAction)CloseTitleSearch:(id)sender{
    txtSearchTitle.text = @"";
    [self HideDropDownAtAllPlace];
    //   [self Reset:sender];
    NSString *parameter = [@"grid_type=" stringByAppendingString:strGridType];
    arraApprove = [[NSMutableArray alloc]init];
    arrayListUserApprove = [[NSMutableArray alloc]init];
    arrayPrint = [[NSMutableArray alloc]init];
    arraAssignList = [[NSMutableArray alloc]init];
    arrayListUser = [[NSMutableArray alloc]init];
    of=0;
    strLoard=@"YES";
    strTEST = parameter;
    [self PrintGrid:parameter];
    //arrayPrint =[NSMutableArray arrayWithArray:arraAssignList];
    [table reloadData];
    viewTitleSearch.hidden = YES;
    
}

-(IBAction)CloseDate:(id)sender{
    [self HideDropDownAtAllPlace];
    viewDate.hidden = YES;
    [myPicker setDate:[NSDate date]];
}

-(IBAction)CloseSearch:(id)sender{
    
    [self HideDropDownAtAllPlace];
    // txtSearchTitle.text = @"";
    //txtSearchUser.text = @"User Name";
    
    //    [self CloseTag:sender];
    if([appDelegate.STRUSERTYPE isEqualToString:@"Staff"])
    {
        viewTag.hidden = YES;
        viewTagSearch.hidden = YES;
        arrayPrint1 = [[NSMutableArray alloc]initWithArray:arrayPrint11];
        [picker reloadAllComponents];
        [self ForClose];
        //    [self closeTagManage];
    }
    [self AdvanceCollapseManage];
    [self closeTagManage];
    
    // [self Reset:sender];
    /*
     if([appDelegate.ISAPPROVE isEqualToString:@"NO"]){
     arrayPrint =[NSMutableArray arrayWithArray:arraAssignList];
     }else{
     arrayPrint =[NSMutableArray arrayWithArray:arraApprove];
     }
     */
    // [table reloadData];
    viewSearchData.hidden = YES;
    viewTitleSearch.hidden = YES;
    viewUserSearch.hidden = YES;
    viewSearchButton.hidden = YES;
    viewAdvanceSearch.hidden = NO;
}

-(IBAction)CloseTag:(id)sender{
    viewTag.hidden = YES;
    viewTagSearch.hidden = YES;
    if([appDelegate.STRUSERTYPE isEqualToString:@"Staff"]){
        [self ForClose];
        [self Reset:sender];
        [self closeTagManage];
    }
}

-(IBAction)CloseUserSearch:(id)sender{
    UIButton *btn = sender;
    if(btn.tag == 1){
        [self HideDropDownAtAllPlace];
        [self AdvanceCollapseManage];
        [self closeTagManage];
        viewTitleSearch.hidden = YES;
        viewUserSearch.hidden = YES;
        viewSearchButton.hidden = YES;
        viewAdvanceSearch.hidden = NO;
        
        
    }else{
        viewAdvanceSearch.hidden = NO;
        viewUserSearch.hidden = YES;
        viewSearchButton.hidden = YES;
        viewTag.hidden = YES;
        
        viewTagSearch.hidden = YES;
        arrayPrint1 = [[NSMutableArray alloc]initWithArray:arrayPrint11];
        
        [picker reloadAllComponents];
        [self ForClose];
        // [self Reset:sender];
        [self closeTagManage];
    }
}

- (IBAction)CellCheck:(id)sender{
    [self HideDropDownAtAllPlace];
    UIButton *btnDemo = sender;
    if ([[[arrayPrint objectAtIndex:btnDemo.tag]strIsCheck] isEqualToString:@"NO"]) {
        CustomData *cmd = [[ CustomData alloc]init];
        cmd = [arrayPrint objectAtIndex:btnDemo.tag];
//        cmd.strId = [[arrayPrint objectAtIndex:btnDemo.tag]strId];//
//        cmd.strActionLogTitle = [[arrayPrint objectAtIndex:btnDemo.tag]strActionLogTitle];
//        cmd.strTagId = [[arrayPrint objectAtIndex:btnDemo.tag]strTagId];
//        cmd.strAssignTo = [[arrayPrint objectAtIndex:btnDemo.tag]strAssignTo];
//        cmd.strDueDate = [[arrayPrint objectAtIndex:btnDemo.tag]strDueDate];
//        cmd.strCreatedDate = [[arrayPrint objectAtIndex:btnDemo.tag]strCreatedDate];
//        cmd.strRevisedDate = [[arrayPrint objectAtIndex:btnDemo.tag]strRevisedDate];
//        cmd.strDashboardDueDate = [[arrayPrint objectAtIndex:btnDemo.tag]strDashboardDueDate];
//        cmd.strNotesReadStatus = [[arrayPrint objectAtIndex:btnDemo.tag]strNotesReadStatus];
//        cmd.strRevisedDate = [[arrayPrint objectAtIndex:btnDemo.tag]strRevisedDate];
//        cmd.strDashboardDueDate = [[arrayPrint objectAtIndex:btnDemo.tag]strDashboardDueDate];
//        cmd.strPercentageCompleted = [[arrayPrint objectAtIndex:btnDemo.tag]strPercentageCompleted];
//        cmd.strColor = [[arrayPrint objectAtIndex:btnDemo.tag]strColor];
//        cmd.strStatus = [[arrayPrint objectAtIndex:btnDemo.tag]strStatus];
//        cmd.strCreatedBy = [[arrayPrint objectAtIndex:btnDemo.tag]strCreatedBy];
//        cmd.strNoteCount =[[arrayPrint objectAtIndex:btnDemo.tag]strNoteCount];
//        cmd.strColor = [[arrayPrint objectAtIndex:btnDemo.tag]strColor];
        
        cmd.strIsCheck = @"YES";
        
        [arrayApply addObject:cmd];
        [arrayPrint replaceObjectAtIndex:btnDemo.tag withObject:cmd];//
        [arraAssignList replaceObjectAtIndex:btnDemo.tag withObject:cmd];
        
    }else{
        CustomData *cmd = [[ CustomData alloc]init];
        cmd = [arrayPrint objectAtIndex:btnDemo.tag];
        
//        cmd.strId = [[arrayPrint objectAtIndex:btnDemo.tag]strId];//
//        cmd.strActionLogTitle = [[arrayPrint objectAtIndex:btnDemo.tag]strActionLogTitle];
//        cmd.strTagId = [[arrayPrint objectAtIndex:btnDemo.tag]strTagId];
//        cmd.strAssignTo = [[arrayPrint objectAtIndex:btnDemo.tag]strAssignTo];
//        cmd.strDueDate = [[arrayPrint objectAtIndex:btnDemo.tag]strDueDate];
//        cmd.strCreatedDate = [[arrayPrint objectAtIndex:btnDemo.tag]strCreatedDate];
//        cmd.strRevisedDate = [[arrayPrint objectAtIndex:btnDemo.tag]strRevisedDate];
//        cmd.strDashboardDueDate = [[arrayPrint objectAtIndex:btnDemo.tag]strDashboardDueDate];
//        cmd.strNotesReadStatus = [[arrayPrint objectAtIndex:btnDemo.tag]strNotesReadStatus];
//        cmd.strPercentageCompleted = [[arrayPrint objectAtIndex:btnDemo.tag]strPercentageCompleted];
//        
//        cmd.strStatus = [[arrayPrint objectAtIndex:btnDemo.tag]strStatus];
//        cmd.strCreatedBy = [[arrayPrint objectAtIndex:btnDemo.tag]strCreatedBy];
//        cmd.strNoteCount =[[arrayPrint objectAtIndex:btnDemo.tag]strNoteCount];
//        cmd.strColor = [[arrayPrint objectAtIndex:btnDemo.tag]strColor];
        
        cmd.strIsCheck   = @"NO";
        [arrayPrint replaceObjectAtIndex:btnDemo.tag withObject:cmd];
        [arraAssignList replaceObjectAtIndex:btnDemo.tag withObject:cmd];
        
        for (int i = 0 ; i<arrayApply.count; i++) {
            if([[[arrayApply objectAtIndex:i]strId] isEqualToString:cmd.strId]){
                [arrayApply removeObjectAtIndex:i];
            }
        }
    }
    [table reloadData];
}

- (IBAction)Dashboard:(id)sender{
    [self HideDropDownAtAllPlace];
    viewAction.hidden = YES;
    imgLogout.hidden = NO;
    btnLogout.hidden = NO;
    imgPlus.hidden = NO;
    btnPlus.hidden = NO;
    lbl1.hidden = NO;
    lbl2.hidden = NO;
    strGridType = @"Dashboard";
    btnCheckAll.tag = 1;
    imgChekApply.image = [UIImage imageNamed:@"checkDisbale.png"];
    
    viewFull.hidden = YES;
    imgApproval.image = [UIImage imageNamed:@"Icone_ForApproveD"];
    imgDashboard.image = [UIImage imageNamed:@"Icone_Dashboard"];
    
    imgApprovalStaff.image = [UIImage imageNamed:@"Icone_ForApproveD"];
    imgDashboardStaff.image = [UIImage imageNamed:@"Icone_Dashboard"];
    
    lblApproval.textColor = [Methods colorWithHexString:@"6C899B"];
    lblDashboard.textColor = [UIColor whiteColor];
    
    lblApprovalStaff.textColor = [Methods colorWithHexString:@"6C899B"];
    lblDashboardStaff.textColor = [UIColor whiteColor];
    
    imgLogout.image = [UIImage imageNamed:@"logout-btn.png"];
    btnLogout.tag = 1;
    viewDashoard.backgroundColor = [Methods colorWithHexString:@"74AD46"];
    viewApproval.backgroundColor = [UIColor clearColor];
    
    viewDashoardStaff.backgroundColor = [Methods colorWithHexString:@"74AD46"];
    viewApprovalStaff.backgroundColor = [UIColor clearColor];
    lblTitle.text = @"DASHBOARD";
    appDelegate.ISAPPROVE = @"NO";
    [self viewMain];
    clickhideDropDown = @"YES";{
        [self HideDropDownAtAllPlace];
        txtSearchTitle.text = @"";
//        txtSACompany.text = @"Companies";
//        txtSAFCompany.text = @"Companies";
//        
//        txtSADepartment.text = @"Departments";
//        txtADepartment.text = @"Departments";
//        txtSAFDepartment.text = @"Departments";
//        
//        txtSAFCreatedBy.text = @"Created By";
//        txtSACreatedBy.text = @"Created By";
//        txtACreatedBy.text = @"Created By";
//        txtUCreatedBy.text = @"Created By";
//        
//        
//        txtSAFAssignTo.text = @"Assign To";
//        txtSAAssignTo.text = @"Assign To";
//        txtAAssignTo.text = @"Assign To";
//        txtUAssignTo.text = @"Assign To";
//        
//        
//        txtSAStatus.text = @"Status";
//        txtAStatus.text = @"Status";
//        txtUStatus.text = @"Status";
//        
//        txtSAFDueDate.text = @"All";
//        txtSADueDate.text = @"All";
//        txtSAFDueFromDate.text = @"Due From Date";
//        txtSADueFromDate.text = @"Due From Date";
//        
//        txtUDueDate.text=@"All";
//        txtSADueDate.text = @"All";
//        txtSAFDueDate.text = @"All";
//        txtADueDate.text = @"All";
//        txtUStatus.text = @"Status";
//        
//        txtSAFDueFromDate.text = @"Due From Date";
//        txtSADueFromDate.text = @"Due From Date";
//        txtADueFromDate.text = @"Due From Date";
//        txtUDueFromDate.text = @"Due From Date";
//        
//        txtSAFDueToDate.text = @"Due To Date";
//        txtSADueToDate.text = @"Due To Date";
//        txtADueToDate.text = @"Due To Date";
//        txtUDueToDate.text = @"Due To Date";
//        
//        txtSADueDate.text = @"All";
//        txtUDueDate.text=@"All";
//        txtSADueFromDate.text = @"Due From Date";
    }
    [self ResetArray];
    timer = [NSTimer scheduledTimerWithTimeInterval:.000001 target:self selector:@selector(initialize) userInfo:nil repeats:NO];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(stopGIF) userInfo:nil repeats:NO];
}

- (IBAction)DropDownSearch:(id)sender{
    /*
    [self HideDropDownAtAllPlace];
    UIButton *btn = sender;
    switch (btn.tag) {
        case 41:
        {
            if([@"YES" isEqualToString:clickhideDropDown]){
                txtSADepartment.text = @"Departments";
                txtADepartment.text =  @"Departments";
                if(arrayCompanies.count){
                    clickhideDropDown = @"NO";
                    dropDownSelection = @"Companies";
                    CGRect rt = txtSAFCompany.frame;
                    float height = MIN(220,(arrayCompanies.count+1)*44);
                    [self showPopUpWithTitle:@"Select Company" withOption:arrayCompanies Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewSuperAdminSearchForApproval.frame.origin.y+viewTag.frame.size.height) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
                }
            }else{
                clickhideDropDown = @"YES";
                [Dropobj fadeOut];
            }
        }
            break;
        case 42:
        {
            if([@"YES" isEqualToString:clickhideDropDown ]){
                if(arrayDepartment.count){
                    clickhideDropDown = @"NO";
                    dropDownSelection = @"Department";
                    CGRect rt = txtSAFDepartment.frame;
                    float height = MIN(220,(arrayDepartment.count+1)*44);
                    [self showPopUpWithTitle:@"Select Department" withOption:arrayDepartment Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewSuperAdminSearchForApproval.frame.origin.y+viewTag.frame.size.height) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
                }
            }else{
                clickhideDropDown = @"YES";
                [Dropobj fadeOut];
            }
        }
            break;
        case 43:
        {
            if([@"YES" isEqualToString:clickhideDropDown ]){
                if(arrayCreatedBy.count){
                    clickhideDropDown = @"NO";
                    dropDownSelection = @"CreatedBy";
                    CGRect rt = txtSAFCreatedBy.frame;
                    float height = MIN(220,(arrayCreatedBy.count+1)*44);
                    [self showPopUpWithTitle:@"Select CreatedBy" withOption:arrayCreatedBy Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewSuperAdminSearchForApproval.frame.origin.y+viewTag.frame.size.height) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
                }
            }else{
                clickhideDropDown = @"YES";
                [Dropobj fadeOut];
            }
        }
            
            break;
        case 44:
        {
            if([@"YES" isEqualToString:clickhideDropDown ]){
                if(arrayAssignTo.count){
                    clickhideDropDown = @"NO";
                    dropDownSelection = @"AssignTo";
                    CGRect rt = txtSAFAssignTo.frame;
                    float height = MIN(220,(arrayAssignTo.count+1)*44);
                    [self showPopUpWithTitle:@"Select AssignTo" withOption:arrayAssignTo Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewSuperAdminSearchForApproval.frame.origin.y+viewTag.frame.size.height) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
                }
            }else{
                clickhideDropDown = @"YES";
                [Dropobj fadeOut];
            }
        }
            break;
        case 45:
        {
            if([@"YES" isEqualToString:clickhideDropDown ]){
                if(arrayStutas.count){
                    clickhideDropDown = @"NO";
                    dropDownSelection = @"Stutas";
                    CGRect rt = txtSAStatus.frame;
                    float height = MIN(220,(arrayStutas.count+1)*44);
                    [self showPopUpWithTitle:@"Select Stutas" withOption:arrayStutas Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewSuperAdminSearchForApproval.frame.origin.y+viewTag.frame.size.height) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
                }
            }else{
                clickhideDropDown = @"YES";
                [Dropobj fadeOut];
            }
        }
            break;
        case 46:
        {
            if([@"YES" isEqualToString:clickhideDropDown ]){
                if(arrayDueDate.count){
                    clickhideDropDown = @"NO";
                    dropDownSelection = @"DueDate";
                    CGRect rt = txtSAFDueDate.frame;
                    float height = MIN(220,(arrayDueDate.count)*44);
                    [self showPopUpWithTitle:@"Select Due Date" withOption:arrayDueDate Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewSuperAdminSearchForApproval.frame.origin.y+viewTag.frame.size.height) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
                }
            }else{
                clickhideDropDown = @"YES";
                [Dropobj fadeOut];
            }
        }
            break;
        case 47:
            strDateSELECT= @"DateFrom";
            viewDate.hidden = NO;
            break;
        case 48:
            strDateSELECT= @"DateTo";
            viewDate.hidden = NO;
            break;
        case 50 :
        {
            if([@"YES" isEqualToString:clickhideDropDown ]){
                if(arrayUserList.count){
                    clickhideDropDown = @"NO";
                    dropDownSelection = @"UserList";
                    CGRect rt = txtSearchUser.frame;
                    float height = MIN(220,(arrayCreatedBy.count+1)*44);
                    [self showPopUpWithTitle:@"Select User Name" withOption:arrayUserList Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFullAll.frame.origin.y) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
                }
            }else{
                clickhideDropDown = @"YES";
                [Dropobj fadeOut];
            }
        }
            
            break;
        case 1:
        {
            if([@"YES" isEqualToString:clickhideDropDown]){
                txtSADepartment.text = @"Departments";
                txtADepartment.text =  @"Departments";
                if(arrayCompanies.count){
                    clickhideDropDown = @"NO";
                    dropDownSelection = @"Companies";
                    CGRect rt = txtSACompany.frame;
                    float height = MIN(220,(arrayCompanies.count+1)*44);
                    [self showPopUpWithTitle:@"Select Company" withOption:arrayCompanies Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewSuperAdminSearch.frame.origin.y+viewTag.frame.size.height) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
                }
            }else{
                clickhideDropDown = @"YES";
                [Dropobj fadeOut];
            }
        }
            break;
        case 2:
        {
            if([@"YES" isEqualToString:clickhideDropDown ]){
                if(arrayDepartment.count){
                    clickhideDropDown = @"NO";
                    dropDownSelection = @"Department";
                    CGRect rt = txtSADepartment.frame;
                    float height = MIN(220,(arrayDepartment.count+1)*44);
                    [self showPopUpWithTitle:@"Select Department" withOption:arrayDepartment Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewSuperAdminSearch.frame.origin.y+viewTag.frame.size.height) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
                }
            }else{
                clickhideDropDown = @"YES";
                [Dropobj fadeOut];
            }
        }
            break;
        case 3:
        {
            if([@"YES" isEqualToString:clickhideDropDown ]){
                if(arrayCreatedBy.count){
                    clickhideDropDown = @"NO";
                    dropDownSelection = @"CreatedBy";
                    CGRect rt = txtSACreatedBy.frame;
                    float height = MIN(220,(arrayCreatedBy.count+1)*44);
                    [self showPopUpWithTitle:@"Select CreatedBy" withOption:arrayCreatedBy Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewSuperAdminSearch.frame.origin.y+viewTag.frame.size.height) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
                }
            }else{
                clickhideDropDown = @"YES";
                [Dropobj fadeOut];
            }
        }
            
            break;
        case 4:
        {
            if([@"YES" isEqualToString:clickhideDropDown ]){
                if(arrayAssignTo.count){
                    clickhideDropDown = @"NO";
                    dropDownSelection = @"AssignTo";
                    CGRect rt = txtSAAssignTo.frame;
                    float height = MIN(220,(arrayAssignTo.count+1)*44);
                    [self showPopUpWithTitle:@"Select AssignTo" withOption:arrayAssignTo Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewSuperAdminSearch.frame.origin.y+viewTag.frame.size.height) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
                }
            }else{
                clickhideDropDown = @"YES";
                [Dropobj fadeOut];
            }
        }
            break;
        case 5:
        {
            if([@"YES" isEqualToString:clickhideDropDown ]){
                if(arrayStutas.count){
                    clickhideDropDown = @"NO";
                    dropDownSelection = @"Stutas";
                    CGRect rt = txtSAStatus.frame;
                    float height = MIN(220,(arrayStutas.count+1)*44);
                    [self showPopUpWithTitle:@"Select Stutas" withOption:arrayStutas Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewSuperAdminSearch.frame.origin.y+viewTag.frame.size.height) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
                }
            }else{
                clickhideDropDown = @"YES";
                [Dropobj fadeOut];
            }
        }
            break;
        case 6:
        {
            if([@"YES" isEqualToString:clickhideDropDown ]){
                if(arrayDueDate.count){
                    clickhideDropDown = @"NO";
                    dropDownSelection = @"DueDate";
                    CGRect rt = txtSADueDate.frame;
                    float height = MIN(220,(arrayDueDate.count)*44);
                    [self showPopUpWithTitle:@"Select Due Date" withOption:arrayDueDate Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewSuperAdminSearch.frame.origin.y+viewTag.frame.size.height) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
                }
            }else{
                clickhideDropDown = @"YES";
                [Dropobj fadeOut];
            }
        }
            break;
        case 7:
            strDateSELECT= @"DateFrom";
            viewDate.hidden = NO;
            break;
        case 8:
            strDateSELECT= @"DateTo";
            viewDate.hidden = NO;
            
            break;
        case 11:
        {
            if([@"YES" isEqualToString:clickhideDropDown ]){
                if(arrayDepartment.count){
                    clickhideDropDown = @"NO";
                    dropDownSelection = @"Department";
                    CGRect rt = txtADepartment.frame;
                    float height = MIN(220,(arrayDepartment.count)*44);
                    [self showPopUpWithTitle:@"Select Department" withOption:arrayDepartment Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewAdminSearch.frame.origin.y+viewTag.frame.size.height) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
                }
            }else{
                clickhideDropDown = @"YES";
                [Dropobj fadeOut];
            }
        }
            break;
        case 12:
        {
            if([@"YES" isEqualToString:clickhideDropDown ]){
                if(arrayCreatedBy.count){
                    clickhideDropDown = @"NO";
                    dropDownSelection = @"CreatedBy";
                    CGRect rt = txtACreatedBy.frame;
                    float height = MIN(220,(arrayCreatedBy.count)*44);
                    [self showPopUpWithTitle:@"Select CreatedBy" withOption:arrayCreatedBy Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewAdminSearch.frame.origin.y+viewTag.frame.size.height) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
                }
            }else{
                clickhideDropDown = @"YES";
                [Dropobj fadeOut];
            }
        }
            break;
        case 13:
        {
            if([@"YES" isEqualToString:clickhideDropDown ]){
                if(arrayAssignTo.count){
                    clickhideDropDown = @"NO";
                    dropDownSelection = @"AssignTo";
                    CGRect rt = txtAAssignTo.frame;
                    float height = MIN(220,(arrayAssignTo.count)*44);
                    [self showPopUpWithTitle:@"Select AssignTo" withOption:arrayAssignTo Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewAdminSearch.frame.origin.y+viewTag.frame.size.height) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
                }
            }else{
                clickhideDropDown = @"YES";
                [Dropobj fadeOut];
            }
        }
            break;
        case 14:
        {
            if([@"YES" isEqualToString:clickhideDropDown ]){
                if(arrayStutas.count){
                    clickhideDropDown = @"NO";
                    dropDownSelection = @"Stutas";
                    CGRect rt = txtAStatus.frame;
                    float height = MIN(220,(arrayStutas.count)*44);
                    [self showPopUpWithTitle:@"Select Stutas" withOption:arrayStutas Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewAdminSearch.frame.origin.y+viewTag.frame.size.height) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
                }
            }else{
                clickhideDropDown = @"YES";
                [Dropobj fadeOut];
            }
        }
            break;
        case 15:
        {
            if([@"YES" isEqualToString:clickhideDropDown ]){
                if(arrayDueDate.count){
                    clickhideDropDown = @"NO";
                    dropDownSelection = @"DueDate";
                    CGRect rt = txtADueDate.frame;
                    float height = MIN(220,(arrayDueDate.count)*44);
                    [self showPopUpWithTitle:@"Select Due Date" withOption:arrayDueDate Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewAdminSearch.frame.origin.y+viewTag.frame.size.height) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
                }
            }else{
                clickhideDropDown = @"YES";
                [Dropobj fadeOut];
            }
        }
            break;
        case 16:
            strDateSELECT= @"DateFrom";
            viewDate.hidden = NO;
            break;
        case 17:
            strDateSELECT= @"DateTo";
            viewDate.hidden = NO;
            break;
        case 21:
        {
            if([@"YES" isEqualToString:clickhideDropDown ]){
                if(arrayCreatedBy.count){
                    clickhideDropDown = @"NO";
                    dropDownSelection = @"CreatedBy";
                    CGRect rt = txtUCreatedBy.frame;
                    float height = MIN(220,(arrayCreatedBy.count)*44);
                    [self showPopUpWithTitle:@"Select CreatedBy" withOption:arrayCreatedBy Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewSearch.frame.origin.y+viewTag.frame.size.height) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
                }
            }else{
                clickhideDropDown = @"YES";
                [Dropobj fadeOut];
            }
        }
            break;
        case 22:
        {
            if([@"YES" isEqualToString:clickhideDropDown ]){
                if(arrayAssignTo.count){
                    clickhideDropDown = @"NO";
                    dropDownSelection = @"AssignTo";
                    CGRect rt = txtUAssignTo.frame;
                    float height = MIN(220,(arrayAssignTo.count)*44);
                    [self showPopUpWithTitle:@"Select AssignTo" withOption:arrayAssignTo Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewSearch.frame.origin.y+viewTag.frame.size.height) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
                }
            }else{
                clickhideDropDown = @"YES";
                [Dropobj fadeOut];
            }
        }
            break;
        case 23:
        {
            if([@"YES" isEqualToString:clickhideDropDown ]){
                if(arrayStutas.count){
                    clickhideDropDown = @"NO";
                    dropDownSelection = @"Stutas";
                    CGRect rt = txtUStatus.frame;
                    float height = MIN(220,(arrayStutas.count)*44);
                    [self showPopUpWithTitle:@"Select Stutas" withOption:arrayStutas Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewSearch.frame.origin.y+viewTag.frame.size.height) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
                }
            }else{
                clickhideDropDown = @"YES";
                [Dropobj fadeOut];
            }
        }
            break;
        case 24:
        {
            if([@"YES" isEqualToString:clickhideDropDown ]){
                if(arrayDueDate.count){
                    clickhideDropDown = @"NO";
                    dropDownSelection = @"DueDate";
                    CGRect rt = txtUDueDate.frame;
                    float height = MIN(220,(arrayDueDate.count)*44);
                    [self showPopUpWithTitle:@"Select Due Date" withOption:arrayDueDate Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewSearch.frame.origin.y+viewTag.frame.size.height) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
                }
            }else{
                clickhideDropDown = @"YES";
                [Dropobj fadeOut];
            }
        }
            break;
        case 25:
            strDateSELECT= @"DateFrom";
            viewDate.hidden = NO;
            break;
        case 26:
            strDateSELECT= @"DateTo";
            viewDate.hidden = NO;
            break;
        case 31:
        {
            if([@"YES" isEqualToString:clickhideDropDown ]){
                if(arrayDueDate.count){
                    clickhideDropDown = @"NO";
                    dropDownSelection = @"Archived";
                    CGRect rt = txtArchived.frame;
                    float height = MIN(220,(arrayArchived.count)*44);
                    [self showPopUpWithTitle:@"Select Due Date" withOption:arrayArchived Option1:arrayTemp xy:CGPointMake(rt.origin.x,viewFullAll.frame.size.height-(height-viewAction.frame.size.height-txtArchived.frame.origin.y)) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
                }
            }else{
                clickhideDropDown = @"YES";
                [Dropobj fadeOut];
            }
        }
            break;
        default:
            break;
    }
*/
}

-(IBAction)EditProfile:(id)sender{
//    Companies *second=[self.storyboard instantiateViewControllerWithIdentifier:@"Companies"] ;
//    [self.navigationController pushViewController:second animated:YES];
    //
        EditProfile *second=[self.storyboard instantiateViewControllerWithIdentifier:@"editprofile"] ;
        [self.navigationController pushViewController:second animated:YES];
}

- (IBAction)ForApproval:(id)sender{
    [self HideDropDownAtAllPlace];
    imgPlus.hidden = YES;
    btnPlus.hidden = YES;
    lbl1.hidden = YES;
    lbl2.hidden = YES;
    viewAction.hidden = NO;
    strGridType = @"For Approval";
    btnCheckAll.tag = 1;
    imgChekApply.image = [UIImage imageNamed:@"checkDisbale.png"];
    viewFull.hidden = YES;
    imgApproval.image = [UIImage imageNamed:@"Icone_ForApprove"];
    imgDashboard.image = [UIImage imageNamed:@"Icone_DashboardD"];
    lblApproval.textColor = [UIColor whiteColor];
    lblDashboard.textColor = [Methods colorWithHexString:@"6C899B"];
    viewDashoard.backgroundColor = [UIColor clearColor];
    viewApproval.backgroundColor = [Methods colorWithHexString:@"74AD46"];
    
    imgApprovalStaff.image = [UIImage imageNamed:@"Icone_ForApprove"];
    imgDashboardStaff.image = [UIImage imageNamed:@"Icone_DashboardD"];
    lblApprovalStaff.textColor = [UIColor whiteColor];
    lblDashboardStaff.textColor = [Methods colorWithHexString:@"6C899B"];
    viewDashoardStaff.backgroundColor = [UIColor clearColor];
    viewApprovalStaff.backgroundColor = [Methods colorWithHexString:@"74AD46"];
    imgLogout.hidden = YES;
    btnLogout.hidden = YES;
    
    // imgLogout.image = [UIImage imageNamed:@"back-icon.png"];
    btnLogout.tag = 2;
    lblTitle.text = @"FOR APPROVAL";
    appDelegate.ISAPPROVE = @"YES";
    clickhideDropDown = @"YES";
    //[self viewMain];{
    {
        [self HideDropDownAtAllPlace];
        txtSearchTitle.text = @"";
//        txtSACompany.text = @"Companies";
//        txtSAFCompany.text = @"Companies";
//        
//        txtSADepartment.text = @"Departments";
//        txtADepartment.text = @"Departments";
//        txtSAFDepartment.text = @"Departments";
//        
//        txtSAFCreatedBy.text = @"Created By";
//        txtSACreatedBy.text = @"Created By";
//        txtACreatedBy.text = @"Created By";
//        txtUCreatedBy.text = @"Created By";
//        
//        
//        txtSAFAssignTo.text = @"Assign To";
//        txtSAAssignTo.text = @"Assign To";
//        txtAAssignTo.text = @"Assign To";
//        txtUAssignTo.text = @"Assign To";
//        
//        
//        txtSAStatus.text = @"Status";
//        txtAStatus.text = @"Status";
//        txtUStatus.text = @"Status";
//        
//        txtSAFDueDate.text = @"All";
//        txtSADueDate.text = @"All";
//        txtSAFDueFromDate.text = @"Due From Date";
//        txtSADueFromDate.text = @"Due From Date";
//        
//        txtUDueDate.text=@"All";
//        txtSADueDate.text = @"All";
//        txtSAFDueDate.text = @"All";
//        txtADueDate.text = @"All";
//        txtUStatus.text = @"Status";
//        
//        txtSAFDueFromDate.text = @"Due From Date";
//        txtSADueFromDate.text = @"Due From Date";
//        txtADueFromDate.text = @"Due From Date";
//        txtUDueFromDate.text = @"Due From Date";
//        
//        txtSAFDueToDate.text = @"Due To Date";
//        txtSADueToDate.text = @"Due To Date";
//        txtADueToDate.text = @"Due To Date";
//        txtUDueToDate.text = @"Due To Date";
//        
//        txtSADueDate.text = @"All";
//        txtUDueDate.text=@"All";
//        txtSADueFromDate.text = @"Due From Date";
    }
    [self ResetArray];
    timer = [NSTimer scheduledTimerWithTimeInterval:.000001 target:self selector:@selector(initialize) userInfo:nil repeats:NO];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(stopGIF) userInfo:nil repeats:NO];
}

-(IBAction)Menu:(id)sender{
//    Companies *second=[self.storyboard instantiateViewControllerWithIdentifier:@"Companies"] ;
//    [self.navigationController pushViewController:second animated:YES];
//    
    [self HideDropDownAtAllPlace];
    if(aView.isHidden){
        aView.hidden = NO;
        aView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
        // [self.view addSubview:popUp];
        [UIView animateWithDuration:0.3/1.5 animations:^{
            aView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                aView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3/2 animations:^{
                    aView.transform = CGAffineTransformIdentity;
                }];
            }];
        }];
    }else{
        aView.hidden = YES;
    }
}

-(void)ResetView{
    [self HideDropDownAtAllPlace];
    txtSearchUser.text = @"User Name";
    txtSearchTitle.text = @"";
    [self ResetField];
    //    txtSACompany.text = @"Companies";
    //    txtSAFCompany.text = @"Companies";
    //
    //    txtSADepartment.text = @"Departments";
    //    txtADepartment.text = @"Departments";
    //    txtSAFDepartment.text = @"Departments";
    //
    //    txtSAFCreatedBy.text = @"Created By";
    //    txtSACreatedBy.text = @"Created By";
    //    txtACreatedBy.text = @"Created By";
    //    txtUCreatedBy.text = @"Created By";
    //
    //    txtSAFAssignTo.text = @"Assign To";
    //    txtSAAssignTo.text = @"Assign To";
    //    txtAAssignTo.text = @"Assign To";
    //    txtUAssignTo.text = @"Assign To";
    //
    //
    //    txtSAStatus.text = @"Status";
    //    txtAStatus.text = @"Status";
    //    txtUStatus.text = @"Status";
    //
    //    txtSAFDueDate.text = @"All";
    //    txtSADueDate.text = @"All";
    //    txtSAFDueFromDate.text = @"Due From Date";
    //    txtSADueFromDate.text = @"Due From Date";
    //
    //    txtUDueDate.text=@"All";
    //    txtSADueDate.text = @"All";
    //    txtSAFDueDate.text = @"All";
    //    txtADueDate.text = @"All";
    //    txtUStatus.text = @"Status";
    //
    //    txtSAFDueFromDate.text = @"Due From Date";
    //    txtSADueFromDate.text = @"Due From Date";
    //    txtADueFromDate.text = @"Due From Date";
    //    txtUDueFromDate.text = @"Due From Date";
    //
    //    txtSAFDueToDate.text = @"Due To Date";
    //    txtSADueToDate.text = @"Due To Date";
    //    txtADueToDate.text = @"Due To Date";
    //    txtUDueToDate.text = @"Due To Date";
    //
    //    txtSADueDate.text = @"All";
    //    txtUDueDate.text=@"All";
    //    txtSADueFromDate.text = @"Due From Date";
    //[self viewMain];
    NSString *parameter = [@"grid_type=" stringByAppendingString:strGridType];
    strTEST = parameter;
    timer = [NSTimer scheduledTimerWithTimeInterval:.0001 target:self selector:@selector(CallData) userInfo:nil repeats:NO];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(stopGIF) userInfo:nil repeats:NO];
}

-(void)ResetField{
    
//    txtSACompany.text = @"Companies";
//    txtSAFCompany.text = @"Companies";
//    
//    txtSADepartment.text = @"Departments";
//    txtADepartment.text = @"Departments";
//    txtSAFDepartment.text = @"Departments";
//    
//    txtSAFCreatedBy.text = @"Created By";
//    txtSACreatedBy.text = @"Created By";
//    txtACreatedBy.text = @"Created By";
//    txtUCreatedBy.text = @"Created By";
//    
//    txtSAFAssignTo.text = @"Assign To";
//    txtSAAssignTo.text = @"Assign To";
//    txtAAssignTo.text = @"Assign To";
//    txtUAssignTo.text = @"Assign To";
//    
//    
//    txtSAStatus.text = @"Status";
//    txtAStatus.text = @"Status";
//    txtUStatus.text = @"Status";
//    
//    txtSAFDueDate.text = @"All";
//    txtSADueDate.text = @"All";
//    txtSAFDueFromDate.text = @"Due From Date";
//    txtSADueFromDate.text = @"Due From Date";
//    
//    txtUDueDate.text=@"All";
//    txtSADueDate.text = @"All";
//    txtSAFDueDate.text = @"All";
//    txtADueDate.text = @"All";
//    txtUStatus.text = @"Status";
//    
//    txtSAFDueFromDate.text = @"Due From Date";
//    txtSADueFromDate.text = @"Due From Date";
//    txtADueFromDate.text = @"Due From Date";
//    txtUDueFromDate.text = @"Due From Date";
//    
//    txtSAFDueToDate.text = @"Due To Date";
//    txtSADueToDate.text = @"Due To Date";
//    txtADueToDate.text = @"Due To Date";
//    txtUDueToDate.text = @"Due To Date";
//    
//    txtSADueDate.text = @"All";
//    txtUDueDate.text=@"All";
//    txtSADueFromDate.text = @"Due From Date";
}

- (IBAction)Reset:(id)sender{
    
    [self viewMain];
    timer = [NSTimer scheduledTimerWithTimeInterval:.0001 target:self selector:@selector(ResetView) userInfo:nil repeats:NO];
    [self ResetArray];
    //    [self HideDropDownAtAllPlace];
    //    txtSearchTitle.text = @"";
    //    txtSACompany.text = @"Companies";
    //
    //    txtSADepartment.text = @"Departments";
    //    txtADepartment.text = @"Departments";
    //
    //    txtSACreatedBy.text = @"Created By";
    //    txtACreatedBy.text = @"Created By";
    //    txtUCreatedBy.text = @"Created By";
    //
    //    txtSAAssignTo.text = @"Assign To";
    //    txtAAssignTo.text = @"Assign To";
    //    txtUAssignTo.text = @"Assign To";
    //
    //    txtSAStatus.text = @"Status";
    //    txtAStatus.text = @"Status";
    //    txtUStatus.text = @"Status";
    //    txtSADueDate.text = @"Due Date";
    //    txtSADueFromDate.text = @"Due From Date";
    //    txtUDueDate.text=@"All";
    //    txtSADueDate.text = @"All";
    //    txtADueDate.text = @"All";
    //    txtUStatus.text = @"Status";
    //
    //    txtSADueFromDate.text = @"Due From Date";
    //    txtADueFromDate.text = @"Due From Date";
    //    txtUDueFromDate.text = @"Due From Date";
    //
    //    txtSADueToDate.text = @"Due To Date";
    //    txtADueToDate.text = @"Due To Date";
    //    txtUDueToDate.text = @"Due To Date";
    //
    //    txtSADueDate.text = @"Due Date";
    //    txtUDueDate.text=@"All";
    //    txtSADueFromDate.text = @"Due From Date";
    //    //[self viewMain];
    //    NSString *parameter = [@"grid_type=" stringByAppendingString:strGridType];
    //    strTEST = parameter;
    //    timer = [NSTimer scheduledTimerWithTimeInterval:.0001 target:self selector:@selector(CallData) userInfo:nil repeats:NO];
    //    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(stopGIF) userInfo:nil repeats:NO];
    //
}
-(void)SearchView{
    NSString *Parameter =[[NSString alloc]init];
    Parameter = [@"grid_type="stringByAppendingString:strGridType];
    
    for(int i =0;i<arraySubtask.count-1;i++){
        
        if(![[[arraySubtask objectAtIndex:i]strPlaceholder] isEqualToString:[[arraySubtask objectAtIndex:i]strSelectedValue]]){
            NSLog(@"%@",[[arraySubtask objectAtIndex:i]strParameter]);
            Parameter = [Parameter stringByAppendingString:[[[arraySubtask objectAtIndex:i]strParameter] stringByAppendingString:[[arraySubtask objectAtIndex:i]strValue]]];
        }
        if(![[[arraySubtask objectAtIndex:i]strPlaceholder1] isEqualToString:[[arraySubtask objectAtIndex:i]strSelectedValue1]]){
            Parameter = [Parameter stringByAppendingString:[[[arraySubtask objectAtIndex:i]strParameter1] stringByAppendingString:[[arraySubtask objectAtIndex:i]strValue1]]];
        }
    }
    NSLog(@"Parameter = %@",Parameter);
    [viewBackGround1 removeFromSuperview];
    Parameter = [NSString stringWithFormat:@"%@",Parameter];
    //NSLog(@"Parameter %@",strParammeter);
    arraApprove = [[NSMutableArray alloc]init];
    arrayListUserApprove = [[NSMutableArray alloc]init];
    arrayPrint = [[NSMutableArray alloc]init];
    arraAssignList = [[NSMutableArray alloc]init];
    arrayListUser = [[NSMutableArray alloc]init];
    strLoard =@"YES";
    of=0;
    strTEST = Parameter;
    [self PrintGrid:Parameter];
    [viewBackGround1 removeFromSuperview];
    //[viewLoader removeFromSuperview];
    [viewDemo removeFromSuperview];
  
   
/*

    [self ForClose];
    txtSearchUser.text = @"User Name";
    txtSearchTitle.text = @"";
    [self.view endEditing:YES];
    [self HideDropDownAtAllPlace];
    NSString *strParammeter =[[NSString alloc]init];
    strParammeter = [@"grid_type="stringByAppendingString:strGridType];
    
    if([@"NotEmpty" isEqualToString:[Methods whitSpace:txtSearchTitle.text]]){
        strParammeter =[strParammeter stringByAppendingString:[@"&search=" stringByAppendingString:txtSearchTitle.text]];
    }
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
        if([appDelegate.ISAPPROVE isEqualToString:@"YES"]){
            if([@"Companies" isEqualToString:txtSAFCompany.text]){
            }else{
                strParammeter =[strParammeter stringByAppendingString:[@"&company_id=" stringByAppendingString:strCompany_Id]];
            }
            if([@"Departments" isEqualToString:txtSAFDepartment.text]){
            }else{
                strParammeter =[strParammeter stringByAppendingString:[@"&department_id=" stringByAppendingString:strDepartment_Id]];
            }
            if([@"Created By" isEqualToString:txtSAFCreatedBy.text]){
            }else{
                strParammeter =[strParammeter stringByAppendingString:[@"&created_by=" stringByAppendingString:strCreatedBy_Id]];
            }
            if([@"Assign To" isEqualToString:txtSAFAssignTo.text]){
            }else{
                strParammeter =[strParammeter stringByAppendingString:[@"&assign_to=" stringByAppendingString:strAssignTo_Id]];
            }
            //            if([@"Status" isEqualToString:txtSAFStatus.text]){
            //            }else{
            //                strParammeter =[strParammeter stringByAppendingString:[@"&status=" stringByAppendingString:txtSAStatus.text]];
            //            }
            if( [@"All" isEqualToString:txtSAFDueDate.text] ){
            }else{
                strParammeter =[strParammeter stringByAppendingString:[@"&overdue=" stringByAppendingString:txtSAFDueDate.text]];
            }
            if([@"Due From Date" isEqualToString:txtSAFDueFromDate.text]&&[@"Due To Date" isEqualToString:txtSAFDueToDate.text])
            {
            }else{
                if([@"Due From Date" isEqualToString:txtSAFDueFromDate.text])
                {
                    strParammeter =[strParammeter stringByAppendingString:[@"&due_date=-" stringByAppendingString:txtSAFDueToDate.text]];// stringByAppendingString:[@"-" stringByAppendingString:txtSADueToDate.text]]]];
                }
                else if([@"Due To Date" isEqualToString:txtSAFDueToDate.text]){
                    strParammeter =[strParammeter stringByAppendingString:[@"&due_date=" stringByAppendingString:[txtSAFDueFromDate.text stringByAppendingString:@"-"]]];
                }
                else
                    strParammeter =[strParammeter stringByAppendingString:[@"&due_date=" stringByAppendingString:[txtSAFDueFromDate.text stringByAppendingString:[@"-" stringByAppendingString:txtSAFDueToDate.text]]]];
            }
        }else{
            if([@"Companies" isEqualToString:txtSACompany.text]){
            }else{
                strParammeter =[strParammeter stringByAppendingString:[@"&company_id=" stringByAppendingString:strCompany_Id]];
            }
            if([@"Departments" isEqualToString:txtSADepartment.text]){
            }else{
                strParammeter =[strParammeter stringByAppendingString:[@"&department_id=" stringByAppendingString:strDepartment_Id]];
            }
            if([@"Created By" isEqualToString:txtSACreatedBy.text]){
            }else{
                strParammeter =[strParammeter stringByAppendingString:[@"&created_by=" stringByAppendingString:strCreatedBy_Id]];
            }
            if([@"Assign To" isEqualToString:txtSAAssignTo.text]){
            }else{
                strParammeter =[strParammeter stringByAppendingString:[@"&assign_to=" stringByAppendingString:strAssignTo_Id]];
            }
            if([@"Status" isEqualToString:txtSAStatus.text]){
            }else{
                strParammeter =[strParammeter stringByAppendingString:[@"&status=" stringByAppendingString:txtSAStatus.text]];
            }
            if( [@"All" isEqualToString:txtSAFDueDate.text] ){
            }else{
                strParammeter =[strParammeter stringByAppendingString:[@"&overdue=" stringByAppendingString:txtSADueDate.text]];
            }
            if([@"Due From Date" isEqualToString:txtSADueFromDate.text]&&[@"Due To Date" isEqualToString:txtSADueToDate.text])
            {
            }else{
                if([@"Due From Date" isEqualToString:txtSADueFromDate.text])
                {
                    strParammeter =[strParammeter stringByAppendingString:[@"&due_date=-" stringByAppendingString:txtSADueToDate.text]];// stringByAppendingString:[@"-" stringByAppendingString:txtSADueToDate.text]]]];
                }
                else if([@"Due To Date" isEqualToString:txtSADueToDate.text]){
                    strParammeter =[strParammeter stringByAppendingString:[@"&due_date=" stringByAppendingString:[txtSADueFromDate.text stringByAppendingString:@"-"]]];
                }
                else
                    strParammeter =[strParammeter stringByAppendingString:[@"&due_date=" stringByAppendingString:[txtSADueFromDate.text stringByAppendingString:[@"-" stringByAppendingString:txtSADueToDate.text]]]];
            }
        }
    }
    if([appDelegate.STRUSERTYPE isEqualToString:@"Admin"]){
        if([@"Departments" isEqualToString:txtADepartment.text]){
        }else{
            strParammeter =[strParammeter stringByAppendingString:[@"&department_id=" stringByAppendingString:strDepartment_Id]];
        }
        if([@"Created By" isEqualToString:txtACreatedBy.text]){
        }else{
            strParammeter =[strParammeter stringByAppendingString:[@"&created_by=" stringByAppendingString:strCreatedBy_Id]];
        }
        if([@"Assign To" isEqualToString:txtAAssignTo.text]){
        }else{
            strParammeter =[strParammeter stringByAppendingString:[@"&assign_to=" stringByAppendingString:strAssignTo_Id]];
        }
        //        if([@"Status" isEqualToString:txtAStatus.text]){
        //        }else{
        //            strParammeter =[strParammeter stringByAppendingString:[@"&status=" stringByAppendingString:txtAStatus.text]];
        //
        //        }
        if([@"All" isEqualToString:txtADueDate.text]){
        }else{
            strParammeter =[strParammeter stringByAppendingString:[@"&overdue=" stringByAppendingString:txtADueDate.text]];
        }
        if([@"Due From Date" isEqualToString:txtADueFromDate.text]&&[@"Due To Date" isEqualToString:txtADueToDate.text])
        {
        }else{
            if([@"Due From Date" isEqualToString:txtADueFromDate.text])
            {
                strParammeter =[strParammeter stringByAppendingString:[@"&due_date=-" stringByAppendingString:txtADueToDate.text]];// stringByAppendingString:[@"-" stringByAppendingString:txtSADueToDate.text]]]];
            }
            else if([@"Due To Date" isEqualToString:txtADueToDate.text]){
                strParammeter =[strParammeter stringByAppendingString:[@"&due_date=" stringByAppendingString:[txtADueFromDate.text stringByAppendingString:@"-"]]];
            }
            else
                strParammeter =[strParammeter stringByAppendingString:[@"&due_date=" stringByAppendingString:[txtADueFromDate.text stringByAppendingString:[@"-" stringByAppendingString:txtADueToDate.text]]]];
        }
    }
    if([appDelegate.STRUSERTYPE isEqualToString:@"Staff"]){
        if([@"Created By" isEqualToString:txtUCreatedBy.text]){
        }else{
            strParammeter =[strParammeter stringByAppendingString:[@"&created_by=" stringByAppendingString:strCreatedBy_Id]];
        }
        //        if([@"Assign To" isEqualToString:txtUAssignTo.text]){
        //        }else{
        //             strParammeter =[strParammeter stringByAppendingString:[@"&assign_to=" stringByAppendingString:strAssignTo_Id]];
        //        }
        if([@"Status" isEqualToString:txtUStatus.text]){
        }else{
            strParammeter =[strParammeter stringByAppendingString:[@"&status=" stringByAppendingString:txtUStatus.text]];
        }
        if([@"All" isEqualToString:txtUDueDate.text]){
        }else{
            strParammeter =[strParammeter stringByAppendingString:[@"&overdue=" stringByAppendingString:txtUDueDate.text]];
        }
        if([@"Due From Date" isEqualToString:txtUDueFromDate.text]&&[@"Due To Date" isEqualToString:txtUDueToDate.text])
        {
        }else{
            if([@"Due From Date" isEqualToString:txtUDueFromDate.text]){
                strParammeter =[strParammeter stringByAppendingString:[@"&due_date=-" stringByAppendingString:txtUDueToDate.text]];// stringByAppendingString:[@"-" stringByAppendingString:txtSADueToDate.text]]]];
            }else if([@"Due To Date" isEqualToString:txtUDueToDate.text]){
                strParammeter =[strParammeter stringByAppendingString:[@"&due_date=" stringByAppendingString:[txtUDueFromDate.text stringByAppendingString:@"-"]]];
            }else
                strParammeter =[strParammeter stringByAppendingString:[@"&due_date=" stringByAppendingString:[txtUDueFromDate.text stringByAppendingString:[@"-" stringByAppendingString:txtUDueToDate.text]]]];
        }
    }
    for(int i =0;i<arrayTesting.count;i++){
        if(i==0)
            strParammeter= [strParammeter stringByAppendingString:[@"&tags="stringByAppendingString:[[arrayTesting objectAtIndex:i]strId]]];
        else
            strParammeter= [strParammeter stringByAppendingString:[@","stringByAppendingString:[[arrayTesting objectAtIndex:i]strId]]];
    }
    [self viewMain];
    strParammeter = [NSString stringWithFormat:@"%@",strParammeter];
    //NSLog(@"Parameter %@",strParammeter);
    arraApprove = [[NSMutableArray alloc]init];
    arrayListUserApprove = [[NSMutableArray alloc]init];
    arrayPrint = [[NSMutableArray alloc]init];
    arraAssignList = [[NSMutableArray alloc]init];
    arrayListUser = [[NSMutableArray alloc]init];
    strLoard =@"YES";
    of=0;
    strTEST = strParammeter;
    [self PrintGrid:strParammeter];
    [viewBackGround1 removeFromSuperview];
    //[viewLoader removeFromSuperview];
    [viewDemo removeFromSuperview];
    
    */
    
    //  timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(stopGIF) userInfo:nil repeats:NO];
    //[self stopGIF];
}

-(IBAction)Search:(id)sender{
    //[self viewMain];
    {
        viewDemo = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        //        UIView *viewDemo = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        viewBackGround1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [viewBackGround1 setBackgroundColor:[UIColor whiteColor]];
        viewBackGround1.alpha = 0.6f;
        [self.view addSubview:viewBackGround1];
        
        UIImageView *imgLoading = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,100,100)];
        viewLoader= [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-50, 100 ,100)];
        [viewLoader setBackgroundColor:[UIColor clearColor]];
        NSURL *url1 = [[NSBundle mainBundle] URLForResource:@"60" withExtension:@"gif"];
        imgLoading.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url1]];
        [viewLoader addSubview:imgLoading];
        [viewDemo addSubview:viewLoader];
        [self.view addSubview:viewDemo];
    }
    txtSearchUser.text = @"User Name";
    txtSearchTitle.text = @"";
    timer = [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(SearchView) userInfo:nil repeats:NO];
    //     timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(stopGIF) userInfo:nil repeats:NO];
    //
    //     [self.view endEditing:YES];
    //     [self HideDropDownAtAllPlace];
    //    NSString *strParammeter =[[NSString alloc]init];
    //    strParammeter = [@"grid_type="stringByAppendingString:strGridType];
    //
    //    if([@"NotEmpty" isEqualToString:[Methods whitSpace:txtSearchTitle.text]]){
    //        strParammeter =[strParammeter stringByAppendingString:[@"&search=" stringByAppendingString:txtSearchTitle.text]];
    //    }
    //    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
    //        if([@"Companies" isEqualToString:txtSACompany.text]){
    //        }else{
    //            strParammeter =[strParammeter stringByAppendingString:[@"&company_id=" stringByAppendingString:strCompany_Id]];
    //        }
    //        if([@"Departments" isEqualToString:txtSADepartment.text]){
    //        }else{
    //            strParammeter =[strParammeter stringByAppendingString:[@"&department_id=" stringByAppendingString:strDepartment_Id]];
    //        }
    //        if([@"Created By" isEqualToString:txtSACreatedBy.text]){
    //        }else{
    //            strParammeter =[strParammeter stringByAppendingString:[@"&created_by=" stringByAppendingString:strCreatedBy_Id]];
    //        }
    //        if([@"Assign To" isEqualToString:txtSAAssignTo.text]){
    //        }else{
    //            strParammeter =[strParammeter stringByAppendingString:[@"&assign_to=" stringByAppendingString:strAssignTo_Id]];
    //        }
    ////        if([@"Status" isEqualToString:txtSAStatus.text]){
    ////        }else{
    ////            strParammeter =[strParammeter stringByAppendingString:[@"&status=" stringByAppendingString:txtSAStatus.text]];
    ////        }
    //        if([@"Due Date" isEqualToString:txtSADueDate.text]){
    //        }else{
    //            strParammeter =[strParammeter stringByAppendingString:[@"&overdue=" stringByAppendingString:txtSADueDate.text]];
    //        }
    //        if([@"Due From Date" isEqualToString:txtSADueFromDate.text]&&[@"Due To Date" isEqualToString:txtSADueToDate.text])
    //        {
    //        }else{
    //            if([@"Due From Date" isEqualToString:txtSADueFromDate.text])
    //            {
    //                strParammeter =[strParammeter stringByAppendingString:[@"&due_date=-" stringByAppendingString:txtSADueToDate.text]];// stringByAppendingString:[@"-" stringByAppendingString:txtSADueToDate.text]]]];
    //            }
    //            else if([@"Due To Date" isEqualToString:txtSADueToDate.text]){
    //                strParammeter =[strParammeter stringByAppendingString:[@"&due_date=" stringByAppendingString:[txtSADueFromDate.text stringByAppendingString:@"-"]]];
    //            }
    //            else
    //                strParammeter =[strParammeter stringByAppendingString:[@"&due_date=" stringByAppendingString:[txtSADueFromDate.text stringByAppendingString:[@"-" stringByAppendingString:txtSADueToDate.text]]]];
    //        }
    //    }
    //    if([appDelegate.STRUSERTYPE isEqualToString:@"Admin"]){
    //        if([@"Departments" isEqualToString:txtADepartment.text]){
    //        }else{
    //             strParammeter =[strParammeter stringByAppendingString:[@"&department_id=" stringByAppendingString:strDepartment_Id]];
    //        }
    //        if([@"Created By" isEqualToString:txtACreatedBy.text]){
    //        }else{
    //              strParammeter =[strParammeter stringByAppendingString:[@"&created_by=" stringByAppendingString:strCreatedBy_Id]];
    //        }
    //        if([@"Assign To" isEqualToString:txtAAssignTo.text]){
    //        }else{
    //            strParammeter =[strParammeter stringByAppendingString:[@"&assign_to=" stringByAppendingString:strAssignTo_Id]];
    //        }
    ////        if([@"Status" isEqualToString:txtAStatus.text]){
    ////        }else{
    ////            strParammeter =[strParammeter stringByAppendingString:[@"&status=" stringByAppendingString:txtAStatus.text]];
    ////
    ////        }
    //        if([@"All" isEqualToString:txtADueDate.text]){
    //        }else{
    //            strParammeter =[strParammeter stringByAppendingString:[@"&overdue=" stringByAppendingString:txtADueDate.text]];
    //        }
    //        if([@"Due From Date" isEqualToString:txtADueFromDate.text]&&[@"Due To Date" isEqualToString:txtADueToDate.text])
    //        {
    //        }else{
    //            if([@"Due From Date" isEqualToString:txtADueFromDate.text])
    //            {
    //                strParammeter =[strParammeter stringByAppendingString:[@"&due_date=-" stringByAppendingString:txtADueToDate.text]];// stringByAppendingString:[@"-" stringByAppendingString:txtSADueToDate.text]]]];
    //            }
    //            else if([@"Due To Date" isEqualToString:txtADueToDate.text]){
    //                strParammeter =[strParammeter stringByAppendingString:[@"&due_date=" stringByAppendingString:[txtADueFromDate.text stringByAppendingString:@"-"]]];
    //            }
    //            else
    //                strParammeter =[strParammeter stringByAppendingString:[@"&due_date=" stringByAppendingString:[txtADueFromDate.text stringByAppendingString:[@"-" stringByAppendingString:txtADueToDate.text]]]];
    //        }
    //    }
    //    if([appDelegate.STRUSERTYPE isEqualToString:@"Staff"]){
    //        if([@"Created By" isEqualToString:txtUCreatedBy.text]){
    //        }else{
    //             strParammeter =[strParammeter stringByAppendingString:[@"&created_by=" stringByAppendingString:strCreatedBy_Id]];
    //        }
    ////        if([@"Assign To" isEqualToString:txtUAssignTo.text]){
    ////        }else{
    ////             strParammeter =[strParammeter stringByAppendingString:[@"&assign_to=" stringByAppendingString:strAssignTo_Id]];
    ////        }
    //        if([@"Status" isEqualToString:txtUStatus.text]){
    //        }else{
    //            strParammeter =[strParammeter stringByAppendingString:[@"&status=" stringByAppendingString:txtUStatus.text]];
    //        }
    //        if([@"All" isEqualToString:txtUDueDate.text]){
    //        }else{
    //            strParammeter =[strParammeter stringByAppendingString:[@"&overdue=" stringByAppendingString:txtUDueDate.text]];
    //        }
    //        if([@"Due From Date" isEqualToString:txtUDueFromDate.text]&&[@"Due To Date" isEqualToString:txtUDueToDate.text])
    //        {
    //        }else{
    //            if([@"Due From Date" isEqualToString:txtUDueFromDate.text]){
    //                strParammeter =[strParammeter stringByAppendingString:[@"&due_date=-" stringByAppendingString:txtUDueToDate.text]];// stringByAppendingString:[@"-" stringByAppendingString:txtSADueToDate.text]]]];
    //            }else if([@"Due To Date" isEqualToString:txtUDueToDate.text]){
    //                strParammeter =[strParammeter stringByAppendingString:[@"&due_date=" stringByAppendingString:[txtUDueFromDate.text stringByAppendingString:@"-"]]];
    //            }else
    //                strParammeter =[strParammeter stringByAppendingString:[@"&due_date=" stringByAppendingString:[txtUDueFromDate.text stringByAppendingString:[@"-" stringByAppendingString:txtUDueToDate.text]]]];
    //        }
    //    }
    //    for(int i =0;i<arrayTesting.count;i++){
    //        if(i==0)
    //            strParammeter= [strParammeter stringByAppendingString:[@"&tags="stringByAppendingString:[[arrayTesting objectAtIndex:i]strId]]];
    //        else
    //            strParammeter= [strParammeter stringByAppendingString:[@","stringByAppendingString:[[arrayTesting objectAtIndex:i]strId]]];
    //    }
    //    [self viewMain];
    //    strParammeter = [NSString stringWithFormat:@"%@",strParammeter];
    //    //NSLog(@"Parameter %@",strParammeter);
    //    arraApprove = [[NSMutableArray alloc]init];
    //    arrayListUserApprove = [[NSMutableArray alloc]init];
    //    arrayPrint = [[NSMutableArray alloc]init];
    //    arraAssignList = [[NSMutableArray alloc]init];
    //    arrayListUser = [[NSMutableArray alloc]init];
    //    strLoard =@"YES";
    //    of=0;
    //    strTEST = strParammeter;
    //    [self PrintGrid:strParammeter];
    //    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(stopGIF) userInfo:nil repeats:NO];
}


- (void) setHighlighted:(BOOL)highlighted {
    
    //    [super setHighlighted:highlighted];
    //
    //    if (highlighted) {
    //        self.backgroundColor = UIColorFromRGB(0x387038);
    //    }
    //    else {
    //        self.backgroundColor = UIColorFromRGB(0x5bb75b);
    //    }
}

-(IBAction)selectDate:(id)sender{
    [self HideDropDownAtAllPlace];
    if([strDateSELECT isEqualToString:@"DueFrom"]){
        NSDate *chosen = myPicker.date;
        dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MM/dd/yyyy"];
        NSString *fromDay = [NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:chosen]];
        NSString *fromDay1 = fromDay;
        [self ReloadCell:10 andvalueOfString:fromDay DatId:fromDay];
        int rowNumber = 11;
//        [self ReloadCell:10 andvalueOfString:fromDay DatId:fromDay];

        for (int i = 0;i<arraySubtask.count;i++){
            NSLog(@"@%d",[[arraySubtask objectAtIndex:i]btnTag]);
            if([[arraySubtask objectAtIndex:i]btnTag1] == rowNumber){
                if([[[arraySubtask objectAtIndex:i]strSelectedValue1] isEqualToString:[[arraySubtask objectAtIndex:i]strPlaceholder1]]){
                    fromDay = [fromDay stringByAppendingString:@"-"];
                    [self ReloadCell:10 andvalueOfString:fromDay1 DatId:fromDay];
                    break;
                }else
                {
                    fromDay = [fromDay stringByAppendingString:[@"-" stringByAppendingString:[[arraySubtask objectAtIndex:i]strSelectedValue1]]];
                    [self ReloadCell:10 andvalueOfString:fromDay1 DatId:fromDay];
                    if([[arraySubtask objectAtIndex:i]btnTag1] == rowNumber){
                        CustomDataform *cmd = [[CustomDataform alloc]init];
                        cmd = [arraySubtask objectAtIndex:i];
                        cmd.strPlaceholder1 = [[arraySubtask objectAtIndex:i]strSelectedValue1];//@"Final it ";
                        //                        NSLog(@"Date Id %@",dataId);
                        [arraySubtask removeObjectAtIndex:i];
                        [arraySubtask insertObject:cmd atIndex:i];
                        //                        idt = i;
                        break;
                    }
                    break;
                }
                break;
            }
        }
    }else if ([strDateSELECT isEqualToString:@"DueTo"]){
        NSDate *chosen = myPicker.date;
        dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MM/dd/yyyy"];//10/03/2016-15/03/2016
        NSString *fromDay = [NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:chosen]];
        NSString *fromDay1 = fromDay;
        [self ReloadCell:11 andvalueOfString:fromDay1 DatId:fromDay];
          int rowNumber = 10;
        for (int i = 0;i<arraySubtask.count;i++){
            
            if([[arraySubtask objectAtIndex:i]btnTag] == rowNumber){
                if([[[arraySubtask objectAtIndex:i]strSelectedValue] isEqualToString:[[arraySubtask objectAtIndex:i]strPlaceholder]]){
                    fromDay = [@"-" stringByAppendingString:fromDay];
                    [self ReloadCell:10 andvalueOfString:[[arraySubtask objectAtIndex:i]strSelectedValue] DatId:fromDay];
                    [self ReloadCell:11 andvalueOfString:fromDay1 DatId:fromDay];
                    break;
                }else
                {
                    fromDay = [[[arraySubtask objectAtIndex:i]strSelectedValue] stringByAppendingString:[@"-" stringByAppendingString:fromDay]];
                    [self ReloadCell:10 andvalueOfString:[[arraySubtask objectAtIndex:i]strSelectedValue] DatId:fromDay];
                    if([[arraySubtask objectAtIndex:i]btnTag] == rowNumber){
                        CustomDataform *cmd = [[CustomDataform alloc]init];
                        cmd = [arraySubtask objectAtIndex:i];
                        cmd.strPlaceholder1 = fromDay1;//@"Final it ";
//                        NSLog(@"Date Id %@",dataId);
                        [arraySubtask removeObjectAtIndex:i];
                        [arraySubtask insertObject:cmd atIndex:i];
//                        idt = i;
                        break;
                    }
                    break;
                }
                break;
            }
        }
    }

    else if([strDateSELECT isEqualToString:@"WorkFrom"]){
        NSDate *chosen = myPicker.date;
        dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MM/dd/yyyy"];
        NSString *fromDay = [NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:chosen]];
        NSString *fromDay1 = fromDay;
        [self ReloadCell:8 andvalueOfString:fromDay DatId:fromDay];
        int rowNumber = 9;
        //        [self ReloadCell:10 andvalueOfString:fromDay DatId:fromDay];
        
        for (int i = 0;i<arraySubtask.count;i++){
            NSLog(@"@%d",[[arraySubtask objectAtIndex:i]btnTag]);
            if([[arraySubtask objectAtIndex:i]btnTag1] == rowNumber){
                if([[[arraySubtask objectAtIndex:i]strSelectedValue1] isEqualToString:[[arraySubtask objectAtIndex:i]strPlaceholder1]]){
                    fromDay = [fromDay stringByAppendingString:@"-"];
                    [self ReloadCell:8 andvalueOfString:fromDay1 DatId:fromDay];
                    break;
                }else
                {
                    fromDay = [fromDay stringByAppendingString:[@"-" stringByAppendingString:[[arraySubtask objectAtIndex:i]strSelectedValue1]]];
                    [self ReloadCell:8 andvalueOfString:fromDay1 DatId:fromDay];
                    if([[arraySubtask objectAtIndex:i]btnTag1] == rowNumber){
                        CustomDataform *cmd = [[CustomDataform alloc]init];
                        cmd = [arraySubtask objectAtIndex:i];
                        cmd.strPlaceholder1 = [[arraySubtask objectAtIndex:i]strSelectedValue1];//@"Final it ";
                        //                        NSLog(@"Date Id %@",dataId);
                        [arraySubtask removeObjectAtIndex:i];
                        [arraySubtask insertObject:cmd atIndex:i];
                        //                        idt = i;
                        break;
                    }
                    break;
                }
                break;
            }
        }

        
     
    }else{
        NSDate *chosen = myPicker.date;
        dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MM/dd/yyyy"];
        
        NSString *fromDay = [NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:chosen]];
        NSString *fromDay1 = fromDay;
        [self ReloadCell:9 andvalueOfString:fromDay DatId:fromDay];
        int rowNumber = 8;
        for (int i = 0;i<arraySubtask.count;i++){
            
            if([[arraySubtask objectAtIndex:i]btnTag] == rowNumber){
                if([[[arraySubtask objectAtIndex:i]strSelectedValue] isEqualToString:[[arraySubtask objectAtIndex:i]strPlaceholder]]){
                    fromDay = [@"-" stringByAppendingString:fromDay];
                    [self ReloadCell:8 andvalueOfString:[[arraySubtask objectAtIndex:i]strSelectedValue] DatId:fromDay];
                    [self ReloadCell:9 andvalueOfString:fromDay1 DatId:fromDay];
                    break;
                }else
                {
                    fromDay = [[[arraySubtask objectAtIndex:i]strSelectedValue] stringByAppendingString:[@"-" stringByAppendingString:fromDay]];
                    [self ReloadCell:8 andvalueOfString:[[arraySubtask objectAtIndex:i]strSelectedValue] DatId:fromDay];
                    if([[arraySubtask objectAtIndex:i]btnTag] == rowNumber){
                        CustomDataform *cmd = [[CustomDataform alloc]init];
                        cmd = [arraySubtask objectAtIndex:i];
                        cmd.strPlaceholder1 = fromDay1;//@"Final it ";
                        //                        NSLog(@"Date Id %@",dataId);
                        [arraySubtask removeObjectAtIndex:i];
                        [arraySubtask insertObject:cmd atIndex:i];
                        //                        idt = i;
                        break;
                    }
                    break;
                }
                break;
            }
        }
    }
    [self CloseDate:sender];
}

#pragma mark - Title Search all methods
#pragma mark -

-(IBAction)TitleSearch:(id)sender{
    //if(arrayPrint.count != 0)
    
    {
        [self HideDropDownAtAllPlace];
        viewTitleSearch.hidden = NO;
        if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"] || [appDelegate.STRUSERTYPE isEqualToString:@"Admin"]){
            [self ManageTitleSearch];
        }
        
    }
    //    else
    //        [self showUiAlertWithMessage:@"You have no action available for search" andtitle:@""];
}

- (void)ManageTitleSearch{
    btnSearchUser.tag = 1;
    btnCancelUser.tag = 1;
    btnResetUser.tag = 1;
    viewUserSearch.hidden = NO;
    viewSearchButton.hidden = NO;
    btnTitleCancel.hidden = YES;
    lblCancelTitle.hidden = YES;
    imgCancelTitle.hidden = YES;
    
    CGRect Frame = txtSearchTitle.frame;
    Frame.size.width = viewTitleSearch.frame.size.width - (txtSearchTitle.frame.origin.x*2)+15;
    txtSearchTitle.frame = Frame;
    
    Frame = imgTitleBoader.frame;
    Frame.size.width = viewTitleSearch.frame.size.width - (imgTitleBoader.frame.origin.x*2);
    imgTitleBoader.frame = Frame;
    
    
    Frame = viewUserSearch.frame;
    Frame.origin.y = 0;
    viewUserSearch.frame = Frame;
    
    Frame = viewTitleSearch.frame;
    Frame.origin.y = viewUserSearch.frame.origin.y+viewUserSearch.frame.size.height;
    viewTitleSearch.frame = Frame;
    
    Frame = viewSearchButton.frame;
    Frame.origin.y = viewTitleSearch.frame.origin.y+viewTitleSearch.frame.size.height;
    viewSearchButton.frame = Frame;
    
    [self ManageAtTitleTime];
}

-(void)ManageAtTitleTime{
    
    CGRect Frame = viewFull.frame;
    Frame.origin.y = viewSearchButton.frame.origin.y+viewSearchButton.frame.size.height;//(viewAdvanceSearch.frame.origin.y+viewAdvanceSearch.frame.size.height);
    Frame.size.height = viewAdminTab.frame.origin.y- (viewSearchButton.frame.origin.y+viewSearchButton.frame.size.height+5+viewFullAll.frame.origin.y);
    viewFull.frame = Frame;
}

- (IBAction)TitleUserSearch:(id)sender{
    //-(void)TitleSearch{
    UIButton *btn = sender;
    if(btn.tag == 1){
        [self.view endEditing:YES];
        [self ResetField];
        [self HideDropDownAtAllPlace];
        NSString *strParammeter =[[NSString alloc]init];
        strParammeter = [@"grid_type="stringByAppendingString:strGridType];
        if([@"NotEmpty" isEqualToString:[Methods whitSpace:txtSearchTitle.text]]){
            strParammeter =[strParammeter stringByAppendingString:[@"&search=" stringByAppendingString:txtSearchTitle.text]];
        }
        
        if([@"User Name" isEqualToString:txtSearchUser.text]){
        }else{
            strParammeter =[strParammeter stringByAppendingString:[@"&action_user_id=" stringByAppendingString:strUserName_Id]];
        }
        arraApprove = [[NSMutableArray alloc]init];
        arrayListUserApprove = [[NSMutableArray alloc]init];
        arrayPrint = [[NSMutableArray alloc]init];
        arraAssignList = [[NSMutableArray alloc]init];
        arrayListUser = [[NSMutableArray alloc]init];
        strLoard =@"YES";
        of=0;
        strTEST = strParammeter;
        [self PrintGrid:strParammeter];
    }else{
        [self ResetField];
        txtSearchTitle.text = @"";
        NSString *param= [@"grid_type="stringByAppendingString:strGridType];
        if([@"User Name" isEqualToString:txtSearchUser.text]){
        }else{
            param =[param stringByAppendingString:[@"&action_user_id=" stringByAppendingString:strUserName_Id]];
        }
        
        if(arrayTesting.count==0){
            //param= [@"token="stringByAppendingString:appDelegate.STRTOKEN];
        }else{
            for(int i =0;i<arrayTesting.count;i++){
                if(i==0)
                    param= [param stringByAppendingString:[@"&tags="stringByAppendingString:[[arrayTesting objectAtIndex:i]strId]]];
                else
                    param= [param stringByAppendingString:[@","stringByAppendingString:[[arrayTesting objectAtIndex:i]strId]]];
            }
        }
        arraApprove = [[NSMutableArray alloc]init];
        arrayListUserApprove = [[NSMutableArray alloc]init];
        arrayPrint = [[NSMutableArray alloc]init];
        arraAssignList = [[NSMutableArray alloc]init];
        arrayListUser = [[NSMutableArray alloc]init];
        strLoard =@"YES";
        
        of=0;
        strTEST = param;
        [self PrintGrid:param];
        // [self ManageAtTagTime];
    }
    
    
}

- (IBAction)viewNotes:(id)sender{
    UIButton *btnDemo = sender;
    NSString *strCreatedby;
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (int i = 0; i<arrayAssignTo.count; i++) {
        int idt = [ [[arrayPrint objectAtIndex:btnDemo.tag]strCreatedBy]intValue];
        int key = [[[arrayAssignTo objectAtIndex:i]strKey]intValue];
        if (idt== key) {
            strCreatedby = [[arrayAssignTo objectAtIndex:i]strStatus];
            break;
        }
    }
    CustomData *cmd= [[CustomData alloc]init];
    cmd = [arrayPrint objectAtIndex:btnDemo.tag];
    
//    cmd.strId =[[arrayPrint objectAtIndex:btnDemo.tag]strId];
//    cmd.strRevisedDate = [[arrayPrint objectAtIndex:btnDemo.tag]strRevisedDate];
//    cmd.strDueDate = [[arrayPrint objectAtIndex:btnDemo.tag]strDueDate];
//    cmd.strCreatedDate = [[arrayPrint objectAtIndex:btnDemo.tag]strCreatedDate];
//    cmd.strDashboardDueDate = [[arrayPrint objectAtIndex:btnDemo.tag]strDashboardDueDate];
//    cmd.strNotesReadStatus = [[arrayPrint objectAtIndex:btnDemo.tag]strNotesReadStatus];
//    cmd.strRevisedDate = [[arrayPrint objectAtIndex:btnDemo.tag]strRevisedDate];
//    cmd.strActionLogTitle = [[arrayPrint objectAtIndex:btnDemo.tag]strActionLogTitle];
//    cmd.strTagId = [[arrayPrint objectAtIndex:btnDemo.tag]strTagId];
//    cmd.strPercentageCompleted = [[arrayPrint objectAtIndex:btnDemo.tag]strPercentageCompleted];
//    cmd.strColor = [[arrayPrint objectAtIndex:btnDemo.tag]strColor];
//    cmd.strCreatedDate = [[arrayPrint objectAtIndex:btnDemo.tag]strCreatedDate];
    cmd.strCreatedBy = strCreatedby;//[[arrayPrint objectAtIndex:btnDemo.tag]strCreatedBy];
    cmd.strAssignTo = [[arrayPrint objectAtIndex:btnDemo.tag]strAssignTo];
    cmd.strFrom = @"Dashboard";
    [array addObject:cmd];
    NSString *strActionLogId = [[arrayPrint objectAtIndex:btnDemo.tag]strId];
    AddSubtask *second=[self.storyboard instantiateViewControllerWithIdentifier:@"addsubtask"];
    second.getActionLogId = strActionLogId;
    second.getActionLogTitle =[[arrayPrint objectAtIndex:btnDemo.tag]strActionLogTitle];
    second.arrayGetDetail = array;
    [self.navigationController pushViewController:second animated:YES];
}

- (IBAction)User:(id)sender{
    
}

-(IBAction)TextChangeTag:(id)sender{
    NSString *searchText;
    
    searchText =txtSearchTitle.text;
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@ ",
                                    searchText];
    self.filltereList = (NSMutableArray *)[arrayListUser filteredArrayUsingPredicate:resultPredicate];
    if ([@"Empty" isEqualToString:[Methods whitSpace:searchText]]) {
        arrayPrint = [NSMutableArray arrayWithArray:arraAssignList];
        [table reloadData];
    }else
        [self shortText];
}

- (IBAction)searchTitleChaneg:(id)sender{
    //[self HideDropDownAtAllPlace];
    clickhideDropDown = @"YES";
    [Dropobj fadeOut];
    NSString *parameter = [@"grid_type=" stringByAppendingString:[strGridType stringByAppendingString:[@"&search=" stringByAppendingString:txtSearchTitle.text]]];
    strTEST = parameter;
    [self PrintGrid:strTEST];
    //    if ([appDelegate.ISAPPROVE isEqualToString:@"NO"]) {
    //        NSString *searchText;
    //        searchText =txtSearchTitle.text;
    //        NSPredicate *resultPredicate = [NSPredicate
    //                                        predicateWithFormat:@"SELF contains[cd] %@ ",
    //                                        searchText];
    //        self.filltereList = (NSMutableArray *)[arrayListUser filteredArrayUsingPredicate:resultPredicate];
    //        if ([@"Empty" isEqualToString:[Methods whitSpace:searchText]]) {
    //            arrayPrint = [NSMutableArray arrayWithArray:arraAssignList];
    //            [table reloadData];
    //        }else
    //            [self shortText];
    //    }else{
    //        NSString *searchText;
    //        searchText =txtSearchTitle.text;
    //        NSPredicate *resultPredicate = [NSPredicate
    //                                        predicateWithFormat:@"SELF contains[cd] %@ ",
    //                                        searchText];
    //        self.filltereList = (NSMutableArray *)[arrayListUserApprove filteredArrayUsingPredicate:resultPredicate];
    //        if ([@"Empty" isEqualToString:[Methods whitSpace:searchText]]) {
    //            arrayPrint = [NSMutableArray arrayWithArray:arraApprove];
    //            [table reloadData];
    //        }else
    //            [self shortText];
    //    }
}

-(void)shortText{
    if ([appDelegate.ISAPPROVE isEqualToString:@"NO"]) {
        arrayPrint = [[NSMutableArray alloc]init];
        NSString *test;
        for (int j = 0;j<self.filltereList.count;j++){
            NSString *tesFilter = [self.filltereList objectAtIndex:j];
            for (int i=0; i<arraAssignList.count; i++) {
                test = [arrayListUser objectAtIndex:i];
                if ([test isEqualToString:tesFilter]) {
                    CustomData *cmd = [[CustomData alloc]init];
                    cmd = [arraAssignList objectAtIndex:i];
                    [arrayPrint addObject:cmd];
                }
            }
        }
        [table reloadData];
    }else{
        arrayPrint = [[NSMutableArray alloc]init];
        NSString *test;
        for (int j = 0;j<self.filltereList.count;j++){
            NSString *tesFilter = [self.filltereList objectAtIndex:j];
            for (int i=0; i<arraApprove.count; i++) {
                test = [arrayListUserApprove objectAtIndex:i];
                if ([test isEqualToString:tesFilter]) {
                    CustomData *cmd = [[CustomData alloc]init];
                    cmd = [arraApprove objectAtIndex:i];
                    [arrayPrint addObject:cmd];
                }
            }
        }
        [table reloadData];
    }
    NSString *parameter = [@"grid_type=" stringByAppendingString:[strGridType stringByAppendingString:[@"&search=" stringByAppendingString:txtSearchTitle.text]]];
    strTEST = parameter;
    [self PrintGrid:strTEST];
}


- (IBAction)Logout:(id)sender{
    [self HideDropDownAtAllPlace];
    //if(btnLogout.tag == 1){
    alertDelete = 5;
    UIAlertView *obj=[[UIAlertView alloc]initWithTitle:@""
                                               message:@"Are you sure you want to logout?"
                                              delegate:self
                                     cancelButtonTitle:@"Cancel"
                                     otherButtonTitles: @"Ok", nil];
    [obj show];
    
    
    
    // aView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    //[self.view addSubview:aView];
    
    //    [UIView animateWithDuration:0.3/1.5 animations:^{
    //        aView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    //    } completion:^(BOOL finished) {
    //        [UIView animateWithDuration:0.3/2 animations:^{
    //            aView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
    //        } completion:^(BOOL finished) {
    //            [UIView animateWithDuration:0.3/2 animations:^{
    //                aView.transform = CGAffineTransformIdentity;
    //            }];
    //        }];
    //    }];
    //
    //    if(aView.isHidden){
    //        aView.hidden = NO;
    //    aView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    //
    //   // [self.view addSubview:popUp];
    //
    //    [UIView animateWithDuration:0.3/1.5 animations:^{
    //        aView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    //    } completion:^(BOOL finished) {
    //        [UIView animateWithDuration:0.3/2 animations:^{
    //            aView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
    //        } completion:^(BOOL finished) {
    //            [UIView animateWithDuration:0.3/2 animations:^{
    //                aView.transform = CGAffineTransformIdentity;
    //            }];
    //        }];
    //    }];
    //    }else{
    //        aView.hidden = YES;
    //    }
    
    //    CGRect fram;
    //
    //    aView.frame = fram;
    //    //aView.frame = CGRectOffset(aView.frame, 0, 0);
    //    [UIView animateWithDuration:0.5f animations:^{
    //        aView.frame = CGRectOffset(aView.frame, 150, 150);
    //    }];
    //
    
    //}else{
    //  [self Dashboard:sender];
    // }
}

- (IBAction)Companies:(id)sender{
    Companies *second=[self.storyboard instantiateViewControllerWithIdentifier:@"companies"] ;
    [self.navigationController pushViewController:second animated:YES];
}

- (IBAction)Setting:(id)sender{
    Users *second=[self.storyboard instantiateViewControllerWithIdentifier:@"users"] ;
    [self.navigationController pushViewController:second animated:YES];
}


#pragma mark-   Tag Create Search

-(void)ManageUserTagSearch{
    
    btnSearchUser.tag = 2;
    btnCancelUser.tag = 2;
    btnResetUser.tag = 2;
    
    viewUserSearch.hidden = NO;
    viewSearchButton.hidden = NO;
    btnCloseTag.hidden = YES;
    
    CGRect Frame = btnAddTag.frame;
    Frame.origin.x = viewTag.frame.size.width-(btnAddTag.frame.size.width+imgBoder.frame.origin.x);
    btnAddTag.frame = Frame;
    
    Frame = imgBoder.frame;
    Frame.size.width = btnAddTag.frame.origin.x-imgBoder.frame.origin.x-5;
    imgBoder.frame = Frame;
    
    //   viewTag
    
    Frame = viewUserSearch.frame;
    Frame.origin.y = 0;
    viewUserSearch.frame = Frame;
    
    Frame = viewTag.frame;
    Frame.origin.y = viewUserSearch.frame.origin.y+viewUserSearch.frame.size.height;
    viewTag.frame = Frame;
    
    Frame = viewSearchButton.frame;
    Frame.origin.y = viewTag.frame.origin.y+viewTag.frame.size.height;
    viewSearchButton.frame = Frame;
    
    [self ManageAtTagTime];
    
    // [self ManageAtTitleTime];
    
}

-(IBAction)TagSearch:(id)sender{
    //if(arrayPrint.count != 0)
    {
        [self HideDropDownAtAllPlace];
        viewTagSearch.hidden = NO;
        viewTag.hidden = NO;
        
    }
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"] || [appDelegate.STRUSERTYPE isEqualToString:@"Admin"]){
        viewTagSearch.hidden = YES;
        [self ManageUserTagSearch];
    }
    
    //    else
    //        [self showUiAlertWithMessage:@"You have no action available for search" andtitle:@""];
}

- (IBAction)SaveTag:(id)sender{
    [self HideDropDownAtAllPlace];
    [self.view endEditing:YES];
    CustomData *cmd11 = [[CustomData alloc]init];
    int idt =(int)[picker selectedRowInComponent:0] ;
    NSString *StrTag = [arrayPrint1 objectAtIndex:idt];
    int x = 0 ;
    int y = 0;
    UIFont *fontText = [UIFont systemFontOfSize:14];
    CGSize maximumLabelSize = CGSizeMake(imgBoder.frame.size.width , 20000.0f);
    CGRect textRect = [StrTag boundingRectWithSize:maximumLabelSize
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName:fontText}
                                           context:nil];
    CGSize  size = CGSizeMake(textRect.size.width, textRect.size.height);
    txtTagSearch.text = @"";
    int i = (int)arrayTesting.count;
    if(arrayTesting.count == 0){
        x= imgBoder.frame.origin.y+5;
        y = imgBoder.frame.origin.y+5;
        if ((imgBoder.frame.size.height+imgBoder.frame.origin.y+30)>viewTag.frame.size.height){
            CGRect fram = viewTag.frame;
            fram.size.height = imgBoder.frame.origin.y+30+imgBoder.frame.origin.y+10;
            viewTag.frame = fram;
        }
    }else{
        CGRect FRAME =  [[arrayTesting objectAtIndex:i-1]FINALFRAMELABLE];
        
        if((FRAME.size.width+FRAME.origin.x+size.width+14+size.width)<imgBoder.frame.size.width){
            y = FRAME.origin.y;
            x =(FRAME.size.width+FRAME.origin.x+20);
        }else{
            x= imgBoder.frame.origin.y+5;
            if ((FRAME.size.height+FRAME.origin.y+30)>viewTag.frame.size.height) {
                CGRect fram = viewTag.frame;
                fram.size.height = viewTag.frame.size.height+38;
                viewTag.frame = fram;
            }
            y =(FRAME.size.height+FRAME.origin.y+12);
        }
    }
    UIImageView *imgBoarder = [[UIImageView alloc]init];
    
    UILabel *lblName = [[UILabel alloc]init];
    imgBoarder.frame = CGRectMake(x, y/*20+(25*i)*/,size.width+25, 25.0);
    imgBoarder.image = [UIImage imageNamed:@"tag-bg.png"];
    lblName.frame = CGRectMake(x, y/*20+(25*i)*/,size.width+12, 25.0);
    CGRect FRAMELable = lblName.frame;
    lblName.text =StrTag ;
    [lblName setFont: [lblName.font fontWithSize: 13]];
    lblName.textAlignment = NSTextAlignmentCenter;
    [viewTag addSubview:imgBoarder];
    [viewTag addSubview:lblName];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(lblName.frame.origin.x+lblName.frame.size.width-4,lblName.frame.origin.y+5/*20+(25*i)*/, 15, 15.0);
    CGRect FRAME = button.frame;
    [button setBackgroundImage:[UIImage imageNamed:@"CRMRelationshipcancel.png"]
                      forState:UIControlStateNormal];
    [button addTarget:self action:@selector(myAction:) forControlEvents:UIControlEventTouchUpInside];
    NSString *strDATA;
    {
        for(int i=0;i<arrayTag.count;i++){
            if([StrTag isEqualToString:[[arrayTag objectAtIndex:i]strStatus]]){
                strDATA= [[arrayTag objectAtIndex:i]strKey];
                break;
            }
        }
    }
    [button setTag:[strDATA intValue]];
    
    cmd11.strCatName = StrTag;
    cmd11.strId = strDATA;
    cmd11.btnTESTING = button;
    cmd11.lblTESTING = lblName;
    cmd11.imgTESTING = imgBoarder;
    cmd11.FINALFRAME = FRAME;
    
    cmd11.FINALFRAMELABLE = FRAMELable;
    [arrayTesting addObject:cmd11];
    [viewTag addSubview:button];
    cmd11 = [[CustomData alloc]init];
    
    {
        for (int i=0; i<arrayPrint1.count; i++) {
            if([StrTag isEqualToString:[arrayPrint1 objectAtIndex:i]]){
                [arrayPrint1 removeObjectAtIndex:i];
            }
        }
        [picker reloadAllComponents];
        viewTagSearch.hidden = YES;
    }
    if([appDelegate.STRUSERTYPE isEqualToString:@"Staff"])
        [self PrintTag];
}

-(void)myAction:(id)sender{
    UIButton *btnTEst = sender;
    int value;
    for (int i =0; i<arrayTesting.count; i++) {
        value = [[[arrayTesting objectAtIndex:i]strId] intValue];
        if(value == btnTEst.tag){
            UIButton *btn = [[arrayTesting objectAtIndex:i]btnTESTING];
            UILabel *lbl    = [[arrayTesting objectAtIndex:i]lblTESTING];
            UIImageView *img = [[arrayTesting objectAtIndex:i]imgTESTING];
            [img removeFromSuperview];
            [btn removeFromSuperview];
            [lbl removeFromSuperview];
            [arrayTesting removeObjectAtIndex:i];
            break;
        }
    }
    for (int i =0; i<arrayTesting.count; i++) {
        UIButton *btn = [[arrayTesting objectAtIndex:i]btnTESTING];
        UILabel *lbl    = [[arrayTesting objectAtIndex:i]lblTESTING];
        UIImageView *img = [[arrayTesting objectAtIndex:i]imgTESTING];
        [img removeFromSuperview];
        [lbl removeFromSuperview];
        [btn removeFromSuperview];
    }
    int x= 0;
    int y = 0;
    viewTag.frame = TESTINGFRAME;
    for (int J =0; J<arrayTesting.count; J++){
        UIFont *fontText = [UIFont systemFontOfSize:14];
        CGSize maximumLabelSize = CGSizeMake(viewTag.frame.size.width , 20000.0f);
        CGRect textRect = [[[arrayTesting objectAtIndex:J]strCatName] boundingRectWithSize:maximumLabelSize
                                                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                                                attributes:@{NSFontAttributeName:fontText}
                                                                                   context:nil];
        CGSize  size = CGSizeMake(textRect.size.width, textRect.size.height);
        CustomData *cmd = [[CustomData alloc]init];
        if(J == 0){
            x= imgBoder.frame.origin.x +5;
            y = imgBoder.frame.origin.y+5;
            if ((imgBoder.frame.origin.y+10+30+imgBoder.frame.origin.y)>viewTag.frame.size.height){
                CGRect fram = viewTag.frame;
                fram.size.height = imgBoder.frame.origin.y+30+imgBoder.frame.origin.y+10;
                viewTag.frame = fram;
            }
        }else{
            CGRect FRAME =  [[arrayTesting objectAtIndex:J-1]FINALFRAMELABLE];
            if((FRAME.size.width+FRAME.origin.x+size.width+14+size.width)<imgBoder.frame.size.width){
                y = FRAME.origin.y;
                x =(FRAME.size.width+FRAME.origin.x+20);
            }else{
                x= imgBoder.frame.origin.x +5;
                if ((FRAME.size.height+FRAME.origin.y+30)>viewTag.frame.size.height) {
                    CGRect fram = viewTag.frame;
                    fram.size.height = viewTag.frame.size.height+38;
                    viewTag.frame = fram;
                }
                y =(FRAME.size.height+FRAME.origin.y+12);
            }
        }
        UIImageView *imgBoarder = [[UIImageView alloc]init];
        UILabel *lblName = [[UILabel alloc]init];
        lblName.frame = CGRectMake(x, y/*20+(25*i)*/, size.width+12, 25.0);
        imgBoarder.frame = CGRectMake(x, y/*20+(25*i)*/, size.width+25, 25.0);
        imgBoarder.image = [UIImage imageNamed:@"tag-bg.png"];
        CGRect FRAMELable = lblName.frame;
        lblName.text =[[arrayTesting objectAtIndex:J]strCatName];//cmd11.strCatName ;
        [lblName setFont: [lblName.font fontWithSize: 13]];
        lblName.textAlignment = NSTextAlignmentCenter;
        [viewTag addSubview:imgBoarder];
        [viewTag addSubview:lblName];
        
        UIButton *button = [[arrayTesting objectAtIndex:J]btnTESTING];//[UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(lblName.frame.origin.x+lblName.frame.size.width-4,lblName.frame.origin.y+5/*20+(25*i)*/, 15, 15.0);
        CGRect FRAME = button.frame;
        
        [button setTag:[[[arrayTesting objectAtIndex:J]strId] intValue]];
        [button addTarget:self action:@selector(myAction:) forControlEvents:UIControlEventTouchUpInside];
        [viewTag addSubview:button];
        cmd.strCatName = [[arrayTesting objectAtIndex:J]strCatName];
        cmd.strId = [[arrayTesting objectAtIndex:J]strId];
        cmd.btnTESTING = button;
        cmd.FINALFRAME = FRAME;
        cmd.imgTESTING = imgBoarder;
        cmd.lblTESTING = lblName;
        cmd.imgTESTING = imgBoarder;
        cmd.FINALFRAMELABLE = FRAMELable;
        [viewTag addSubview:button];
        [arrayTesting replaceObjectAtIndex:J withObject:cmd];
    }
    {
        arrayPrint1 = [[NSMutableArray alloc]initWithArray:arrayPrint11];
        for (int j =0 ; j<arrayTesting.count; j++) {
            NSString  *StrTag = [[arrayTesting objectAtIndex:j]strCatName];
            for (int i=0; i<arrayPrint1.count; i++) {
                if([StrTag isEqualToString:[arrayPrint1 objectAtIndex:i]]){
                    [arrayPrint1 removeObjectAtIndex:i];
                }
            }
        }
        [picker reloadAllComponents];
    }
    if([appDelegate.STRUSERTYPE isEqualToString:@"Staff"])
        [self PrintTag];
}


-(void)PrintTag{
    NSString *param= [@"grid_type="stringByAppendingString:strGridType];
    if(arrayTesting.count==0){
        //param= [@"token="stringByAppendingString:appDelegate.STRTOKEN];
    }else{
        for(int i =0;i<arrayTesting.count;i++){
            if(i==0)
                param= [param stringByAppendingString:[@"&tags="stringByAppendingString:[[arrayTesting objectAtIndex:i]strId]]];
            else
                param= [param stringByAppendingString:[@","stringByAppendingString:[[arrayTesting objectAtIndex:i]strId]]];
        }
    }
    arraApprove = [[NSMutableArray alloc]init];
    arrayListUserApprove = [[NSMutableArray alloc]init];
    arrayPrint = [[NSMutableArray alloc]init];
    arraAssignList = [[NSMutableArray alloc]init];
    arrayListUser = [[NSMutableArray alloc]init];
    strLoard =@"YES";
    
    of=0;
    strTEST = param;
    [self PrintGrid:param];
    [self ManageAtTagTime];
}

-(void)ForClose{
    arrayPrint1 = [[NSMutableArray alloc]initWithArray:arrayPrint11];
    
    [picker reloadAllComponents];
    for (int i =0; i<arrayTesting.count; i++) {
        UIButton *btn = [[arrayTesting objectAtIndex:i]btnTESTING];
        UILabel *lbl    = [[arrayTesting objectAtIndex:i]lblTESTING];
        UIImageView *img = [[arrayTesting objectAtIndex:i]imgTESTING];
        [img removeFromSuperview];
        [lbl removeFromSuperview];
        [btn removeFromSuperview];
    }
    viewTag.frame = TESTINGFRAME;
    arrayTesting = [[NSMutableArray alloc]init];
}


#pragma -mark AlertView Delelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertDelete == 1){
        if (buttonIndex == 1) {
            NSString *parameter;
            NSString *strDemo =txtArchived.text;
            if([strDemo isEqualToString:@"Archive"]){
                parameter = [@"grid_type=" stringByAppendingString:[strGridType stringByAppendingString:[@"&status=" stringByAppendingString:@"Archived"]]];
            }else if([strDemo isEqualToString:@"Delete"]){
                parameter = [@"grid_type=" stringByAppendingString:[strGridType stringByAppendingString:[@"&status=" stringByAppendingString:@"Deleted"]]];
            }else{
                parameter = [@"grid_type=" stringByAppendingString:[strGridType stringByAppendingString:[@"&status=" stringByAppendingString:@"Deleted"]]];
            }
            
            for(int i=0;i<arrayApply.count;i++){
                parameter = [parameter stringByAppendingString:[@"&actionlog_id[]=" stringByAppendingString:[[arrayApply objectAtIndex:i] strId]]];
            }
            NSDictionary *dataDictionary = [[NSDictionary alloc]init];
            dataDictionary = [Methods  WebServerData:urlChangeActionStatus andPostParameter:parameter];
            // NSArray *dataAry = [dataDictionary objectForKey:@"info"];
            bool status = [dataDictionary objectForKey:@"status"];
            if (status) {
                arrayApply = [[NSMutableArray alloc]init];
                imgChekApply.image = [UIImage imageNamed:@"checkDisbale.png"];
                arraApprove = [[NSMutableArray alloc]init];
                arrayListUserApprove = [[NSMutableArray alloc]init];
                arrayPrint = [[NSMutableArray alloc]init];
                arraAssignList = [[NSMutableArray alloc]init];
                arrayListUser = [[NSMutableArray alloc]init];
                strLoard =@"YES";
                of=0;
                [self WebData];
            }else{
                NSArray *dataAry = [dataDictionary objectForKey:@"info"];
                for (NSDictionary *dic in dataAry){
                    [self showUiAlertWithMessage:[dic objectForKey:@"error_message"] andtitle:@""];
                }
            }
            //NSLog(@"Data arry %@",dataAry);
        }
        alertDelete = 0;
    }
    if (alertDelete == 2) {
        if (buttonIndex == 1) {
            NSString *parameter = [@"grid_type=" stringByAppendingString:[strGridType stringByAppendingString:[@"&actionlog_id[]=" stringByAppendingString:[[[arrayPrint objectAtIndex:alertView.tag]strId] stringByAppendingString:@"&status=Deleted"]]]];
            NSDictionary *dataDictionary = [[NSDictionary alloc]init];
            dataDictionary = [Methods WebServerData:urlChangeActionStatus andPostParameter:parameter];
            //NSLog(@"Delete Info %@",dataDictionary);
            [self Reset:nil];
        }
        NSString *parameter = [@"grid_type=" stringByAppendingString:strGridType];
        arraApprove = [[NSMutableArray alloc]init];
        arrayListUserApprove = [[NSMutableArray alloc]init];
        arrayPrint = [[NSMutableArray alloc]init];
        arraAssignList = [[NSMutableArray alloc]init];
        arrayListUser = [[NSMutableArray alloc]init];
        strLoard =@"YES";
        of=0;
        [self PrintGrid:parameter];
        [table reloadData];
        alertDelete = 0;
    }
    if(alertDelete == 5){
        if (buttonIndex == 1) {
            appDelegate.LOG = @"1";
            Login *second=[self.storyboard instantiateViewControllerWithIdentifier:@"login"] ;
            [self.navigationController pushViewController:second animated:YES];
        }
        
    }
    alertDelete = 0;
}

#pragma mark- Dropdown Delegate

- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex{
    /*----------------Get Selected Value[Single selection]-----------------*/
    clickhideDropDown = @"YES";
    /*
    NSLog( @"%@",dropDownSelection);
    //[scroll setContentOffset:CGPointMake(0,0) animated:YES ];
    if([@"Companies" isEqualToString:dropDownSelection]){
        txtSACompany.text = [[arrayCompanies objectAtIndex:anIndex]strPropertyAddress];
        txtSAFCompany.text = [[arrayCompanies objectAtIndex:anIndex]strPropertyAddress];
        strCompany_Id = [NSString stringWithFormat:@"%@",[[arrayCompanies objectAtIndex:anIndex]strCompanyId]];
        [self ShortDepartment];
    }else if([@"Department" isEqualToString:dropDownSelection]){
        txtSADepartment.text = [[arrayDepartment objectAtIndex:anIndex]strPropertyAddress];
        txtSAFDepartment.text = [[arrayDepartment objectAtIndex:anIndex]strPropertyAddress];
        txtADepartment.text = [NSString stringWithFormat:@"%@",[[arrayDepartment objectAtIndex:anIndex]strPropertyAddress]];
        strDepartment_Id =[NSString stringWithFormat:@"%@",[[arrayDepartment objectAtIndex:anIndex]strDepartmentId]];
    } else if([@"CreatedBy" isEqualToString:dropDownSelection]){
        txtSAFCreatedBy.text = [[arrayCreatedBy objectAtIndex:anIndex]strPropertyAddress];
        txtSACreatedBy.text = [[arrayCreatedBy objectAtIndex:anIndex]strPropertyAddress];
        txtACreatedBy.text = [[arrayCreatedBy objectAtIndex:anIndex]strPropertyAddress];
        txtUCreatedBy.text = [[arrayCreatedBy objectAtIndex:anIndex]strPropertyAddress];
        strCreatedBy_Id = [[arrayCreatedBy objectAtIndex:anIndex]strKey];
        
    }else if([@"AssignTo" isEqualToString:dropDownSelection]){
        txtSAFAssignTo.text = [[arrayAssignTo objectAtIndex:anIndex]strPropertyAddress];
        txtSAAssignTo.text = [[arrayAssignTo objectAtIndex:anIndex]strPropertyAddress];
        txtAAssignTo.text = [[arrayAssignTo objectAtIndex:anIndex]strPropertyAddress];
        txtUAssignTo.text = [[arrayAssignTo objectAtIndex:anIndex]strPropertyAddress];
        strAssignTo_Id = [[arrayAssignTo objectAtIndex:anIndex]strKey];
    } else if([@"Stutas" isEqualToString:dropDownSelection]){
        txtSAStatus.text = [[arrayStutas objectAtIndex:anIndex]strPropertyAddress];
        txtAStatus.text = [[arrayStutas objectAtIndex:anIndex]strPropertyAddress];
        txtUStatus.text = [[arrayStutas objectAtIndex:anIndex]strPropertyAddress];
    }else if([@"DueDate" isEqualToString:dropDownSelection]){
        txtSAFDueDate.text = [[arrayDueDate objectAtIndex:anIndex]strPropertyAddress];
        txtSADueDate.text = [[arrayDueDate objectAtIndex:anIndex]strPropertyAddress];
        txtADueDate.text = [[arrayDueDate objectAtIndex:anIndex]strPropertyAddress];
        txtUDueDate.text = [[arrayDueDate objectAtIndex:anIndex]strPropertyAddress];
        //NSLog(@"Due Date %@",[[arrayDueDate objectAtIndex:anIndex]strPropertyAddress]);
    }
    else if([@"Archived" isEqualToString:dropDownSelection]){
        txtArchived.text = [[arrayArchived objectAtIndex:anIndex]strPropertyAddress];
    }else if([@"UserList" isEqualToString:dropDownSelection]){
        txtSearchUser.text = [[arrayUserList objectAtIndex:anIndex]strPropertyAddress];
        strUserName_Id = [[arrayUserList objectAtIndex:anIndex]strKey];
    }
     */
}

- (void)DropDownListView:(DropDownListView *)dropdownListView Datalist:(NSMutableArray*)ArryData{
    
}

-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSMutableArray*)arrOptions Option1:(NSMutableArray*)arrOptions1 xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple{
    
    Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions options1:arrOptions1 xy:point size:size isMultiple:isMultiple];
    Dropobj.delegate = self;
    [Dropobj showInView:self.view animated:YES];
    
    /*----------------Set DropDown backGroundColor-----------------*/
    [Dropobj SetBackGroundDropDown_R:245.0 G:245.0 B:245.0 alpha:0.90];
}
#pragma mark- User define function
#pragma mark- dropdown selection
- (void)DropDownPicker : (NSString *)title andSelectionArray:(NSMutableArray *)arrayData{
    //[self DropDownPicker:@"Companies" andSelectionArray:arrayCompanies];
    if (!self.statusPickerView) {
        self.statusPickerView = [[PickerView alloc] initWithHeaderTitle:title values:arrayData];
        self.statusPickerView.delegate = self;
    }
    self.statusPickerView.values = arrayData;
    [self.statusPickerView show];
    
}

#pragma mark- User define function

-(void)AdvanceSearchManage{
    //viewAction.hidden = NO;
    NSLog(@"Advance Search ");
    viewSearchData.hidden = NO;
    
    CGRect Frame = viewFull.frame;
    Frame.origin.y  = viewAdvanceSearch.frame.origin.y;
    Frame.size.height = viewFullAll.frame.size.height;
    viewFull.frame = Frame;
    
    Frame = viewListAction.frame;
    Frame.origin.y = (viewSearchData.frame.origin.y+viewSearchData.frame.size.height);
    Frame.size.height =(viewFull.frame.size.height)-(viewSearchData.frame.origin.y+viewSearchData.frame.size.height+5);
    
    if ([appDelegate.ISAPPROVE isEqualToString:@"YES"])
        Frame.size.height = Frame.size.height -viewAction.frame.size.height;// (viewFull.frame.size.height-20)/*
    
    viewListAction.frame = Frame;
    
    CGRect frameTable = table.frame;
    frameTable.origin.y =  10;
    frameTable.size.height = viewListAction.frame.size.height-10;
    table.frame = frameTable;
    
    /*
     if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
        CGRect Frame = viewListAction.frame;
        Frame.origin.y = (viewSuperAdminSearch.frame.origin.y+viewSuperAdminSearch.frame.size.height);
        Frame.size.height =(viewFull.frame.size.height)-(viewSuperAdminSearch.frame.origin.y+viewSuperAdminSearch.frame.size.height+5);
        
        if ([appDelegate.ISAPPROVE isEqualToString:@"YES"])
            Frame.size.height = Frame.size.height -viewAction.frame.size.height;// (viewFull.frame.size.height-20)/*
        
        viewListAction.frame = Frame;
        
        CGRect frameTable = table.frame;
        frameTable.origin.y =  10;
        frameTable.size.height = viewListAction.frame.size.height-10;
        table.frame = frameTable;
        
    }else if([appDelegate.STRUSERTYPE isEqualToString:@"Admin"]){
        CGRect Frame = viewListAction.frame;
        Frame.origin.y = (viewAdminSearch.frame.origin.y+viewAdminSearch.frame.size.height);
        Frame.size.height =(viewFull.frame.size.height)-(viewAdminSearch.frame.origin.y+viewAdminSearch.frame.size.height+5);
        
        if ([appDelegate.ISAPPROVE isEqualToString:@"YES"])
            Frame.size.height = Frame.size.height -viewAction.frame.size.height;
        viewListAction.frame = Frame;
        
        CGRect frameTable = table.frame;
        frameTable.origin.y =  10;
        frameTable.size.height = viewListAction.frame.size.height-10;
        table.frame = frameTable;
        
    }else if([appDelegate.STRUSERTYPE isEqualToString:@"Staff"]){
        CGRect Frame = viewListAction.frame;
        Frame.origin.y = (viewSearch.frame.origin.y+viewSearch.frame.size.height)-5;
        Frame.size.height =(viewFull.frame.size.height)-(viewSearch.frame.origin.y+viewSearch.frame.size.height+5);
        
        if ([appDelegate.ISAPPROVE isEqualToString:@"YES"])
            Frame.size.height = Frame.size.height -viewAction.frame.size.height;
        
        viewListAction.frame = Frame;
        
        CGRect frameTable = table.frame;
        frameTable.origin.y =  10;
        frameTable.size.height = viewListAction.frame.size.height-5;
        table.frame = frameTable;
    }
     */
}

/*
-(void)AdvanceSearchManage1{
    //viewAction.hidden = NO;
    NSLog(@"Advance Search ");
    CGRect Frame = viewFull.frame;
    Frame.origin.y  = viewAdvanceSearch.frame.origin.y;
    Frame.size.height = viewFullAll.frame.size.height;
    viewFull.frame = Frame;
    
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
        CGRect Frame = viewListAction.frame;
        Frame.origin.y = (viewSuperAdminSearch.frame.origin.y+viewSuperAdminSearch.frame.size.height);
        Frame.size.height =(viewFull.frame.size.height)-(viewSuperAdminSearch.frame.origin.y+viewSuperAdminSearch.frame.size.height+5);
        
        if ([appDelegate.ISAPPROVE isEqualToString:@"YES"])
            Frame.size.height = Frame.size.height -viewAction.frame.size.height;// (viewFull.frame.size.height-20)/*
        
        viewListAction.frame = Frame;
        
        CGRect frameTable = table.frame;
        frameTable.origin.y =  10;
        frameTable.size.height = viewListAction.frame.size.height-10;
        table.frame = frameTable;
        
    }else if([appDelegate.STRUSERTYPE isEqualToString:@"Admin"]){
        CGRect Frame = viewListAction.frame;
        Frame.origin.y = (viewAdminSearch.frame.origin.y+viewAdminSearch.frame.size.height);
        Frame.size.height =(viewFull.frame.size.height)-(viewAdminSearch.frame.origin.y+viewAdminSearch.frame.size.height+5);
        
        if ([appDelegate.ISAPPROVE isEqualToString:@"YES"])
            Frame.size.height = Frame.size.height -viewAction.frame.size.height;
        viewListAction.frame = Frame;
        
        CGRect frameTable = table.frame;
        frameTable.origin.y =  10;
        frameTable.size.height = viewListAction.frame.size.height-10;
        table.frame = frameTable;
        
    }else if([appDelegate.STRUSERTYPE isEqualToString:@"Staff"]){
        CGRect Frame = viewListAction.frame;
        Frame.origin.y = (viewSearch.frame.origin.y+viewSearch.frame.size.height)-5;
        Frame.size.height =(viewFull.frame.size.height)-(viewSearch.frame.origin.y+viewSearch.frame.size.height+5);
        
        if ([appDelegate.ISAPPROVE isEqualToString:@"YES"])
            Frame.size.height = Frame.size.height -viewAction.frame.size.height;
        
        viewListAction.frame = Frame;
        
        CGRect frameTable = table.frame;
        frameTable.origin.y =  10;
        frameTable.size.height = viewListAction.frame.size.height-5;
        table.frame = frameTable;
    }
}
 */

-(void)AdvanceCollapseManage{
    viewAction.hidden = NO;
    
    
    CGRect Frame = viewListAction.frame;
    Frame.origin.y = 0;
    if ([appDelegate.ISAPPROVE isEqualToString:@"YES"]){
        Frame.size.height =(viewFull.frame.size.height-20)-viewAction.frame.size.height;
        viewAction.hidden = NO;
    }
    else{
        Frame.size.height =(viewFull.frame.size.height-20);
        viewAction.hidden = YES;
    }
    
    viewListAction.frame = Frame;
    
    CGRect frameTable = table.frame;
    frameTable.origin.y =  10;
    frameTable.size.height = viewListAction.frame.size.height-10;
    table.frame = frameTable;

    /*
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
        CGRect Frame = viewListAction.frame;
        Frame.origin.y = 0;(viewAdvanceSearch.frame.origin.y+viewAdvanceSearch.frame.size.height);
        if ([appDelegate.ISAPPROVE isEqualToString:@"YES"]){
            Frame.size.height =(viewFull.frame.size.height-20)-(viewAdvanceSearch.frame.origin.y+viewAdvanceSearch.frame.size.height)-viewAction.frame.size.height;
            viewAction.hidden = NO;
        }
        else{
            Frame.size.height =(viewFull.frame.size.height-20)-(viewAdvanceSearch.frame.origin.y+viewAdvanceSearch.frame.size.height)-viewAction.frame.size.height;
            viewAction.hidden = YES;
        }
        
           Frame.size.height =(viewFull.frame.size.height)-(viewAdvanceSearch.frame.origin.y+viewAdvanceSearch.frame.size.height+viewAction.frame.size.height);
        viewListAction.frame = Frame;
        
        CGRect frameTable = table.frame;
        frameTable.origin.y =  10;
        frameTable.size.height = viewListAction.frame.size.height-10;
        table.frame = frameTable;
        
    }else if([appDelegate.STRUSERTYPE isEqualToString:@"Admin"]){
        CGRect Frame = viewListAction.frame;
        Frame.origin.y =0; (viewAdvanceSearch.frame.origin.y+viewAdvanceSearch.frame.size.height);
        if ([appDelegate.ISAPPROVE isEqualToString:@"YES"]){
            Frame.size.height =(viewFull.frame.size.height-20)-(viewAdvanceSearch.frame.origin.y+viewAdvanceSearch.frame.size.height)-viewAction.frame.size.height;
            viewAction.hidden = NO;
        }
        else{
            Frame.size.height =(viewFull.frame.size.height-20)-(viewAdvanceSearch.frame.origin.y+viewAdvanceSearch.frame.size.height)-viewAction.frame.size.height;
            viewAction.hidden = YES;
        }
        viewListAction.frame = Frame;
        
        CGRect frameTable = table.frame;
        frameTable.origin.y =  10;
        frameTable.size.height = viewListAction.frame.size.height-10;
        table.frame = frameTable;
        
    }else if([appDelegate.STRUSERTYPE isEqualToString:@"Staff"]){
        CGRect Frame = viewListAction.frame;
        Frame.origin.y = 0;(viewAdvanceSearch.frame.origin.y+viewAdvanceSearch.frame.size.height)-5;
        if ([appDelegate.ISAPPROVE isEqualToString:@"YES"]){
            Frame.size.height =(viewFull.frame.size.height-20)-(viewAdvanceSearch.frame.origin.y+viewAdvanceSearch.frame.size.height)-viewAction.frame.size.height;
            viewAction.hidden = NO;
        }
        else{
            Frame.size.height =(viewFull.frame.size.height-20);
            viewAction.hidden = YES;
        }
        Frame.size.height =(viewFull.frame.size.height)-(viewAdvanceSearch.frame.origin.y+viewAdvanceSearch.frame.size.height);
        viewListAction.frame = Frame;
        
        CGRect frameTable = table.frame;
        frameTable.origin.y =  10;
        frameTable.size.height = viewListAction.frame.size.height-5;
        table.frame = frameTable;
    }
    */
}

-(void)Archived{
    if([appDelegate.ISAPPROVE isEqualToString:@"NO"]){
        arrayArchived = [[NSMutableArray alloc]init];
        CustomData *cmd = [[CustomData alloc]init];
        cmd.strPropertyAddress = @"Delete";
        txtArchived.text = @"Delete";
        [arrayArchived addObject:cmd];
    }else{
        arrayArchived = [[NSMutableArray alloc]init];
        CustomData *cmd = [[CustomData alloc]init];
        cmd.strPropertyAddress = @"Archive";
        [arrayArchived addObject:cmd];
        cmd = [[CustomData alloc]init];
        cmd.strPropertyAddress = @"Delete";
        [arrayArchived addObject:cmd];
    }
}

-(void)closeTagManage{
    CGRect Frame = viewFull.frame;
    Frame.origin.y = viewAdvanceSearch.frame.origin.y+viewAdvanceSearch.frame.size.height;
    //(viewAdvanceSearch.frame.origin.y+viewAdvanceSearch.frame.size.height);
    Frame.size.height = viewTab.frame.origin.y- (viewAdvanceSearch.frame.origin.y+viewAdvanceSearch.frame.size.height+5+viewFullAll.frame.origin.y);
    viewFull.frame = Frame;
}


-(void)dateTime{}

-(void)GetCompany{
    if(appDelegate.ARRAYCOMPANY.count ==0){
        // NSString *parameter = [@"token=" stringByAppendingString:appDelegate.STRTOKEN];
        NSDictionary *dataDictionary = [Methods  WebServerData:urlCompany];
        
        NSArray *dataAry = [dataDictionary objectForKey:@"info"];
        bool status = [dataDictionary objectForKey:@"status"];
        if(status){
            NSLog(@"Company %@",dataAry);
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
                [appDelegate.ARRAYCOMPANY addObject:cmd];
            }
        }else{
            NSArray *dataAry = [dataDictionary objectForKey:@"info"];
            for (NSDictionary *dic in dataAry){
                [self showUiAlertWithMessage:[dic objectForKey:@"error_message"] andtitle:@""];
            }
        }
    }else{
        //NSLog(@"COMPANY SAVE");
        arrayCompanies = [[NSMutableArray alloc]initWithArray:appDelegate.ARRAYCOMPANY];
    }
}

-(void)GetDepartment{
    
    if(appDelegate.ARRAYDEPARTMENT.count==0){
        //  NSString *parameter = [@"token=" stringByAppendingString:appDelegate.STRTOKEN];
        NSDictionary *dataDictionary = [Methods  WebServerData:urlDepartment];
        //NSLog(@"Department url  no parameter :- %@ ",urlDepartment);
        
        bool status = [[dataDictionary objectForKey:@"status"] boolValue];
        if(status){
            NSArray *dataAry = [dataDictionary objectForKey:@"info"];
            NSLog(@"Department url  no parameter :- %@ ",dataAry);
            arrayDepartment = [[NSMutableArray alloc]init];
            arrayDepartmentFull = [[NSMutableArray alloc]init];
            CustomData *cmd = [[CustomData alloc]init];
            cmd.strDepartmentId = @"00";
            cmd.strCompanyId = @"00";
            cmd.strDepartmentName = @"Departments";
            cmd.strPropertyAddress = @"Departments";
            [arrayDepartment addObject:cmd];
            [appDelegate.ARRAYDEPARTMENT addObject:cmd];
            for (NSDictionary *dic in dataAry) {
                CustomData *cmd = [[CustomData alloc]init];
                cmd.strDepartmentId = [dic valueForKey:@"department_id"];
                cmd.strCompanyId = [dic valueForKey:@"company_id"];
                cmd.strDepartmentName = [dic valueForKey:@"department_name"];
                cmd.strPropertyAddress = [dic valueForKey:@"department_name"];
                [appDelegate.ARRAYDEPARTMENT addObject:cmd];
                [arrayDepartment addObject:cmd];
                [arrayDepartmentFull addObject:cmd];
            }
        }else{
            NSArray *dataAry = [dataDictionary objectForKey:@"info"];
            for (NSDictionary *dic in dataAry){
                [self showUiAlertWithMessage:[dic objectForKey:@"error_message"] andtitle:@""];
            }
        }
    }else{
        arrayDepartment = [NSMutableArray arrayWithArray:appDelegate.ARRAYDEPARTMENT];
        arrayDepartmentFull = [NSMutableArray arrayWithArray:appDelegate.ARRAYDEPARTMENT];
    }
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
        arrayDepartment = [[NSMutableArray alloc]init];
        CustomData *cmd = [[CustomData alloc]init];
        cmd.strDepartmentId = @"00";
        cmd.strCompanyId = @"00";
        cmd.strDepartmentName = @"Departments";
        cmd.strPropertyAddress = @"Departments";
        [arrayDepartment addObject:cmd];
        
    }
}

-(void)ShortDepartment{
    arrayDepartment = [[NSMutableArray alloc]init];
    
    for (int i =0;i<arrayDepartmentFull.count;i++) {
        if([[[arrayDepartmentFull objectAtIndex:i]strCompanyId] isEqualToString:strCompany_Id]){
            CustomData *cmd = [[CustomData alloc]init];
            cmd = [arrayDepartmentFull objectAtIndex:i];//[dic valueForKey:@"department_id"];
            //        cmd.strCompanyId = [dic valueForKey:@"company_id"];
            //        cmd.strDepartmentName = [dic valueForKey:@"department_name"];
            //        cmd.strPropertyAddress = [dic valueForKey:@"department_name"];
            [appDelegate.ARRAYDEPARTMENT addObject:cmd];
            [arrayDepartment addObject:cmd];
            
        }
    }
}

-(void)GetAssign{
    if(appDelegate.ARRAYASSIGNTO.count == 0){
        NSDictionary *dataDictionary = [Methods  WebServerData:urlAssignTo];
        // NSLog(@"Assign to  list %@",dataDictionary);
        bool status = [[dataDictionary objectForKey:@"status"] boolValue ];
        if(status){
            NSArray *dataAry = [dataDictionary objectForKey:@"info"];
            arrayAssignTo = [[NSMutableArray alloc]init];
            arrayCreatedBy = [[NSMutableArray alloc]init];
            arrayUserList = [[NSMutableArray alloc]init];
            
            CustomData *cmd = [[CustomData alloc]init];
            cmd.strKey = @"00";//[dic valueForKey:@"user_id"];
            cmd.strStatus = @"Assign To";//[dic valueForKey:@"assignee_name"];
            cmd.strPropertyAddress = @"Assign To";//[dic valueForKey:@"assignee_name"];
            cmd.strCompanyId =@"00";// [dic valueForKey:@"company_id"];
            //  [arrayCreatedBy addObject:cmd];
            [arrayAssignTo addObject:cmd];
            [appDelegate.ARRAYASSIGNTO addObject:cmd];
            
            
            arrayCreatedBy = [[NSMutableArray alloc]init];
            cmd = [[CustomData alloc]init];
            cmd.strKey = @"00";//[dic valueForKey:@"user_id"];
            cmd.strStatus = @"Created By";//[dic valueForKey:@"assignee_name"];
            cmd.strPropertyAddress = @"Created By";//[dic valueForKey:@"assignee_name"];
            cmd.strCompanyId =@"00";// [dic valueForKey:@"company_id"];
            [arrayCreatedBy addObject:cmd];
            // [arrayAssignTo addObject:cmd];
            [appDelegate.ARRAYCREATEDBY addObject:cmd];
            
            
            arrayUserList = [[NSMutableArray alloc]init];
            cmd = [[CustomData alloc]init];
            cmd.strKey = @"00";//[dic valueForKey:@"user_id"];
            cmd.strStatus = @"User Name";//[dic valueForKey:@"assignee_name"];
            cmd.strPropertyAddress = @"User Name";//[dic valueForKey:@"assignee_name"];
            cmd.strCompanyId =@"00";// [dic valueForKey:@"company_id"];
            //  [arrayCreatedBy addObject:cmd];
            [arrayUserList addObject:cmd];
            [appDelegate.ARRAYUSERLIST addObject:cmd];
            //[appDelegate.ARRAYASSIGNTO addObject:cmd];
            
            
            for (NSDictionary *dic in dataAry) {
                CustomData *cmd = [[CustomData alloc]init];
                
                cmd.strKey = [dic valueForKey:@"user_id"];//[NSString stringWithFormat:@"%@",key];
                cmd.strStatus = [dic valueForKey:@"assignee_name"];// [NSString stringWithFormat:@"%@",value];
                cmd.strPropertyAddress = [dic valueForKey:@"assignee_name"];//[NSString stringWithFormat:@"%@",value];
                cmd.strCompanyId = [dic valueForKey:@"company_id"];
                [appDelegate.ARRAYFULLASSIGNTO addObject:cmd];
                if([[dic valueForKey:@"company_id"] isEqualToString:appDelegate.STRCOMPANYID] || [appDelegate.STRCOMPANYID isEqualToString:@"0"]){
                    [arrayCreatedBy addObject:cmd];
                    [arrayAssignTo addObject:cmd];
                    [arrayUserList addObject:cmd];
                    [appDelegate.ARRAYUSERLIST addObject:cmd];
                    [appDelegate.ARRAYASSIGNTO addObject:cmd];
                    [appDelegate.ARRAYCREATEDBY addObject:cmd];
                }
            }
            //        NSArray *keys;
            //        int i, count;
            //        id key, value;
            //        arrayAssignTo = [[NSMutableArray alloc]init];
            //        arrayCreatedBy = [[NSMutableArray alloc]init];
            //        NSDictionary *dict = [dataDictionary objectForKey:@"info"];
            //        keys = [dict allKeys];
            //        count =(int)[keys count];
            //        for (i = 0; i < count; i++){
            //            CustomData *cmd = [[CustomData alloc]init];
            //            key = [keys objectAtIndex: i];
            //            value = [dict objectForKey: key];
            //            cmd.strKey =[NSString stringWithFormat:@"%@",key];
            //            cmd.strStatus =[NSString stringWithFormat:@"%@",value];
            //            cmd.strPropertyAddress =[NSString stringWithFormat:@"%@",value];
            //            [arrayCreatedBy addObject:cmd];
            //            [arrayAssignTo addObject:cmd];
            //            [appDelegate.ARRAYASSIGNTO addObject:cmd];
            //        }
        }
        else{
            NSArray *dataAry = [dataDictionary objectForKey:@"info"];
            for (NSDictionary *dic in dataAry){
                [self showUiAlertWithMessage:[dic objectForKey:@"error_message"] andtitle:@""];
            }
        }
    }else{
        arrayCreatedBy = [NSMutableArray arrayWithArray:appDelegate.ARRAYCREATEDBY];
        arrayAssignTo = [NSMutableArray arrayWithArray:appDelegate.ARRAYASSIGNTO];
        arrayUserList = [[NSMutableArray alloc]initWithArray:appDelegate.ARRAYUSERLIST];
        
    }
}

-(void)GetStatus{
    arrayStutas = [[NSMutableArray alloc]init];
    CustomData *cmd = [[CustomData alloc] init];
    cmd.strId = [NSString stringWithFormat:@"%d",1];
    cmd.strStatus = @"Not Started";
    cmd.strPropertyAddress = @"Not Started";
    [arrayStutas addObject:cmd];
    cmd = [[CustomData alloc] init];
    cmd.strId = [NSString stringWithFormat:@"%d",2];
    cmd.strStatus = @"In Progress";
    cmd.strPropertyAddress = @"In Progress";
    [arrayStutas addObject:cmd];
}

-(void)GetOverDue{
    if(appDelegate.ARRAYOVERDUE.count ==0){
        NSDictionary *dataDictionary = [Methods  WebServerData:urlDueDate];
        bool status = [[dataDictionary objectForKey:@"status"]boolValue];
        if(status){
            NSDictionary *dataAry = [dataDictionary objectForKey:@"info"];
            NSArray *dataAryOverDue = [dataAry valueForKey:@"overDateOptions"];
             NSArray *dataAryWorkDue = [dataAry valueForKey:@"WorkDateOptions"];
            
            //for (NSArray *dic in dataAry) {
               // NSLog(@"%@",dic);
            // NSArray *dataAryOverDue = [dic valueForKey:@"overDateOptions"];
                NSLog(@"Over Due %@",dataAryOverDue);
                arrayDueDate = [[NSMutableArray alloc]init];
                for (int i =0 ; i<dataAryOverDue.count; i++) {
                    CustomData *cmd = [[CustomData alloc] init];
                    cmd.strId = [NSString stringWithFormat:@"%d",i];
                    cmd.strStatus = dataAryOverDue[i];
                    cmd.strPropertyAddress = dataAryOverDue[i];
                    [arrayDueDate addObject:cmd];
                    [appDelegate.ARRAYOVERDUE addObject:cmd];
                }
            arrayWorkDate= [[NSMutableArray alloc]init];
            for (int i =0 ; i<dataAryOverDue.count; i++) {
                CustomData *cmd = [[CustomData alloc] init];
                cmd.strId = [NSString stringWithFormat:@"%d",i];
                cmd.strStatus = dataAryWorkDue[i];
                cmd.strPropertyAddress = dataAryWorkDue[i];
                [arrayWorkDate addObject:cmd];
                [appDelegate.ARRAYWORKDATE addObject:cmd];
            }
            
        }else{
            NSArray *dataAry = [dataDictionary objectForKey:@"info"];
            for (NSDictionary *dic in dataAry){
                [self showUiAlertWithMessage:[dic objectForKey:@"error_message"] andtitle:@""];
            }
        }
    }else{
        arrayDueDate = [[NSMutableArray alloc]initWithArray:appDelegate.ARRAYOVERDUE];
        arrayWorkDate = [[NSMutableArray alloc]initWithArray:appDelegate.ARRAYWORKDATE];
    }
}
-(void)GetForApprovalCount{
    // urlForApprovalCount = [[array objectAtIndex:0]webForApprvalCount];
    [self WebServices];
    strForApprovalCount = @"";
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

-(void)GetTag{
    if(appDelegate.ARRAYTAG.count==0 || appDelegate.ARRAYTAGVALUE.count ==0){
        NSDictionary *dataDictionary = [Methods  WebServerData:urlTagList];
        //NSLog(@"Tag list %@",dataDictionary);
        arrayTag = [[NSMutableArray alloc]init];
        arrayPrint1 = [[NSMutableArray alloc]init];
        arrayPrint11 = [[NSMutableArray alloc]init];
        bool status = [dataDictionary objectForKey:@"status"];
        if(status){
            NSArray *dataAry = [dataDictionary objectForKey:@"info"];
            for (NSDictionary *dic in dataAry) {
                CustomData *cmd = [[CustomData alloc]init];
                cmd.strKey = [dic valueForKey:@"tag_id"];//[NSString stringWithFormat:@"%@",key];
                cmd.strStatus = [dic valueForKey:@"tag_name"];// [NSString stringWithFormat:@"%@",value];
                cmd.strPropertyAddress = [dic valueForKey:@"tag_name"];//[NSString stringWithFormat:@"%@",value];
                cmd.strCompanyId = [dic valueForKey:@"company_id"];
                [arrayTag addObject:cmd];
                [appDelegate.ARRAYTAG addObject:cmd];
                [appDelegate.ARRAYTAGVALUE addObject:cmd.strPropertyAddress];
                [arrayPrint1 addObject:cmd.strPropertyAddress];
                [arrayPrint11 addObject:cmd.strPropertyAddress];
            }
        }else{
            NSArray *dataAry = [dataDictionary objectForKey:@"info"];
            for (NSDictionary *dic in dataAry){
                [self showUiAlertWithMessage:[dic objectForKey:@"error_message"] andtitle:@""];
            }
        }
    }else{
        arrayTag = [[NSMutableArray alloc]initWithArray:appDelegate.ARRAYTAG];
        arrayPrint1 = [[NSMutableArray alloc]initWithArray:appDelegate.ARRAYTAGVALUE];
        arrayPrint11 = [[NSMutableArray alloc]initWithArray:appDelegate.ARRAYTAGVALUE];
    }
    [picker reloadAllComponents];
}

-(void)HideDropDownAtAllPlace{
    [self.view endEditing:YES];
    clickhideDropDown = @"YES";
    [Dropobj fadeOut];
}

-(void)ManageAtTagTime{
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
        CGRect Frame = viewSearchButton.frame;
        Frame.origin.y = viewTag.frame.origin.y+viewTag.frame.size.height;//(viewAdvanceSearch.frame.origin.y+viewAdvanceSearch.frame.size.height);
        //Frame.size.height = viewTab.frame.origin.y- (viewTag.frame.origin.y+viewTag.frame.size.height+5+viewFullAll.frame.origin.y);
        viewSearchButton.frame = Frame;
        
        Frame = viewFull.frame;
        Frame.origin.y = viewSearchButton.frame.origin.y+viewSearchButton.frame.size.height;//(viewAdvanceSearch.frame.origin.y+viewAdvanceSearch.frame.size.height);
        Frame.size.height = viewSuperAdminTab.frame.origin.y- (viewSearchButton.frame.origin.y+viewSearchButton.frame.size.height+5+viewFullAll.frame.origin.y);
        viewFull.frame = Frame;
    }else if([appDelegate.STRUSERTYPE isEqualToString:@"Admin"]){
        CGRect Frame = viewSearchButton.frame;
        Frame.origin.y = viewTag.frame.origin.y+viewTag.frame.size.height;//(viewAdvanceSearch.frame.origin.y+viewAdvanceSearch.frame.size.height);
        //Frame.size.height = viewTab.frame.origin.y- (viewTag.frame.origin.y+viewTag.frame.size.height+5+viewFullAll.frame.origin.y);
        viewSearchButton.frame = Frame;
        
        
        Frame = viewFull.frame;
        Frame.origin.y = viewSearchButton.frame.origin.y+viewSearchButton.frame.size.height;//(viewAdvanceSearch.frame.origin.y+viewAdvanceSearch.frame.size.height);
        Frame.size.height = viewAdminTab.frame.origin.y- (viewSearchButton.frame.origin.y+viewSearchButton.frame.size.height+5+viewFullAll.frame.origin.y);
        viewFull.frame = Frame;
    }else if([appDelegate.STRUSERTYPE isEqualToString:@"Staff"]){
        CGRect Frame = viewFull.frame;
        Frame.origin.y = viewTag.frame.origin.y+viewTag.frame.size.height;//(viewAdvanceSearch.frame.origin.y+viewAdvanceSearch.frame.size.height);
        Frame.size.height = viewTab.frame.origin.y- (viewTag.frame.origin.y+viewTag.frame.size.height+5+viewFullAll.frame.origin.y);
        viewFull.frame = Frame;
    }
}

-(void)ManageForApprove{
    viewAction.hidden = NO;
    if([appDelegate.ISAPPROVE isEqualToString:@"YES"]){
        viewAction.hidden = NO;
        CGRect Fram = viewAction.frame;
        Fram.origin.y = viewFull.frame.size.height-viewAction.frame.size.height;
        viewAction.frame = Fram;
    }
    if([appDelegate.ISAPPROVE isEqualToString:@"NO"]){
        viewAction.hidden = NO;
        CGRect Fram = viewAction.frame;
        Fram.origin.y = viewFull.frame.size.height;
        viewAction.frame = Fram;
    }
}

-(void)manageUser{
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
        /*
        if ([appDelegate.ISAPPROVE isEqualToString:@"YES"]) {
            viewSuperAdminSearchForApproval.hidden = NO;
            viewSuperAdminSearchForApproval.hidden = YES;
          
            viewSuperAdminSearch.hidden = YES;
            viewAdminSearch.hidden = YES;
            viewSearch.hidden = YES;
        }else{
            viewSuperAdminSearchForApproval.hidden = YES;
            viewSuperAdminSearch.hidden = NO;
            viewSuperAdminSearch.hidden = YES;
            viewAdminSearch.hidden = YES;
            viewSearch.hidden = YES;
        }
        */
        viewTab.hidden = YES;
        viewAdminTab.hidden = NO;
        viewSuperAdminTab.hidden = YES;
    }else if([appDelegate.STRUSERTYPE isEqualToString:@"Admin"]){
        /*
        viewSuperAdminSearchForApproval.hidden = YES;
        
        viewSuperAdminSearch.hidden = YES;
        //viewAdminSearch.hidden = NO;
        viewAdminSearch.hidden = YES;
        viewSearch.hidden = YES;
        */
        viewTab.hidden = YES;
        viewAdminTab.hidden = NO;
        viewSuperAdminTab.hidden = YES;
    }else if([appDelegate.STRUSERTYPE isEqualToString:@"Staff"]){
        /*
        viewSuperAdminSearchForApproval.hidden = YES;
        viewSuperAdminSearch.hidden = YES;
        viewAdminSearch.hidden = YES;
        viewSearch.hidden = NO;
        viewSearch.hidden = YES;
        */
        viewTab.hidden = NO;
        viewAdminTab.hidden = YES;
        viewSuperAdminTab.hidden = YES;
    }
}

-(void)ManageAllArrayforDropDown{
    
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

-(void)PrintGrid :(NSString *)parameter{
    NSString *strOfc = [NSString stringWithFormat:@"%d",of];
    
    parameter = [parameter stringByAppendingString:[@"&page_offset=" stringByAppendingString:[strOfc stringByAppendingString:@"&page_length=20"]]];
    //NSLog(@"web service %@ \nparameter %@",parameter,urlDashboard);
    Methods = [[AllMethods alloc]init];
    
    //parameter=@"";
    
    NSDictionary *dataDictionary = [Methods  WebServerData:urlDashboard andPostParameter:parameter];
    NSLog(@"web service %@ ",dataDictionary);
    
    bool strData = [[dataDictionary objectForKey:@"status"] boolValue];
    NSLog(@" Dashboard %@",dataDictionary);
    
    if(strData){
        NSArray *dataAry = [dataDictionary objectForKey:@"info"];
        for (NSDictionary *dic in dataAry) {
            CustomData *cmd = [[CustomData alloc]init];
            if([@"No Record found" isEqualToString:[dic valueForKey:@"success_message"]]){
                strLoard =@"NO";
            }else{
                cmd.strId = [NSString stringWithFormat:@"%@",[dic valueForKey:@"actionlog_id"]];
                cmd.strActionLogTitle = [NSString stringWithFormat:@"%@",[dic valueForKey:@"actionlog_title"]];
                cmd.strAssignTo = [NSString stringWithFormat:@"%@",[dic valueForKey:@"assigned_to"] ];
                cmd.strPercentageCompleted = [NSString stringWithFormat:@"%@",[dic valueForKey:@"percentage_compeleted"]];
                cmd.strPercentageCompleted = [cmd.strPercentageCompleted stringByAppendingString:@"%"];
                cmd.strStatus = [NSString stringWithFormat:@"%@",[dic valueForKey:@"actionlog_status"]];
                cmd.strCreatedBy = [NSString stringWithFormat:@"%@",[dic valueForKey:@"created_by_id"]];
                cmd.strNoteCount = [NSString stringWithFormat:@"%@",[dic valueForKey:@"notes_count"]];
                cmd.strIsCheck   = @"NO";
                cmd.strRevisedDate = [NSString stringWithFormat:@"%@",[dic valueForKey:@"revised_date"]];
                cmd.strDashboardDueDate = [NSString stringWithFormat:@"%@",[dic valueForKey:@"dashboard_duedate"]];
                cmd.strNotesReadStatus = [NSString stringWithFormat:@"%@",[dic valueForKey:@"notes_read_status"]];
                cmd.strColor = [NSString stringWithFormat:@"%@",[dic valueForKey:@"duedate_color"]];
                NSString *datatt= @"yyyy-MM-dd HH-mm-ss";
                cmd.strCreatedDate =[dic valueForKey:@"created_date"] ;
                cmd.strAssigneCompanyId = [dic valueForKey:@"assignee_company_id"];
                NSString *tgaId = [NSString stringWithFormat:@"%@",[dic valueForKey:@"tags_id"]];
                
                
                cmd.strTagId =[NSString stringWithFormat:@"%@",[dic valueForKey:@"tags_id"]];
                cmd.strDueDate=[dic valueForKey:@"duedate"];
                cmd.strWorkDate = [dic valueForKey:@"work_date"];
                cmd.strWorkDateColor = [dic valueForKey:@"workdate_color"];
                cmd.strRevisedDate =[dic valueForKey:@"revised_date"] ;
                 cmd.strReviceDateColor =[dic valueForKey:@"revicedate_color"] ;
                cmd.strDashboardDueDate = [dic valueForKey:@"dashboard_duedate"];
                cmd.strAssignyId = [dic valueForKey:@"assignee_id"];
           
                
                [arraApprove addObject:cmd];
                [arrayListUserApprove addObject:cmd.strActionLogTitle];
                [arraAssignList addObject:cmd];
                [arrayListUser addObject:cmd.strActionLogTitle];
            }
            if([appDelegate.ISAPPROVE isEqualToString:@"NO"])
                arrayPrint =[NSMutableArray arrayWithArray:arraAssignList];
            else
                arrayPrint =[NSMutableArray arrayWithArray:arraApprove];
        }
        of+=20;
        if(of > arrayPrint.count){
            strLoard =@"NO";
        }
        [self stopGIF];
        [self stopGIFTable];
        [table reloadData];
    }else{
        NSArray *dataAry = [dataDictionary objectForKey:@"info"];
        for (NSDictionary *dic in dataAry){
            [self showUiAlertWithMessage:[dic objectForKey:@"error_message"] andtitle:@""];
        }
        arrayPrint = [[NSMutableArray alloc]init];
        [self stopGIF];
        [self stopGIFTable];
        [table  reloadData];
    }
    
    //NSLog(@"arrayPrint count %lu",(unsigned long)arrayPrint.count);
}


-(void)PrintGridApprove:(NSString *)parameter{
    NSDictionary *dataDictionary = [Methods  WebServerData:urlDashboard andPostParameter:parameter];
    NSArray *dataAry = [dataDictionary objectForKey:@"info"];
    arrayPrint = [[NSMutableArray alloc]init];
    arraApprove = [[NSMutableArray alloc]init];
    bool *strStatus = [[dataDictionary objectForKey:@"status"] boolValue];
    
    for (NSDictionary *dic in dataAry) {
        CustomData *cmd = [[CustomData alloc]init];
        cmd.strId = [NSString stringWithFormat:@"%@",[dic valueForKey:@"actionlog_id"]];
        cmd.strActionLogTitle = [NSString stringWithFormat:@"%@",[dic valueForKey:@"actionlog_title"]];
        cmd.strAssignTo = [NSString stringWithFormat:@"%@",[dic valueForKey:@"assigned_to"] ];
        NSString *datatt= @"yyyy-MM-dd HH-mm-ss";
        cmd.strCreatedDate =[Methods DateWithFormate:[dic valueForKey:@"created_date"] andCurrentFormate:datatt andNewFormateDate:appDelegate.STRDATEFORMATE];
        datatt= @"yyyy-MM-dd HH-mm-ss";
        
        cmd.strRevisedDate =[Methods DateWithFormate:[dic valueForKey:@"revised_date"] andCurrentFormate:datatt andNewFormateDate:appDelegate.STRDATEFORMATE];
        
        datatt= @"yyyy-MM-dd HH-mm-ss";
        cmd.strDashboardDueDate =[Methods DateWithFormate:[dic valueForKey:@"dashboard_duedate"] andCurrentFormate:datatt andNewFormateDate:appDelegate.STRDATEFORMATE];
        cmd.strDueDate = [NSString stringWithFormat:@"%@",[dic valueForKey:@"duedate"]];
        cmd.strPercentageCompleted = [NSString stringWithFormat:@"%@",[dic valueForKey:@"percentage_compeleted"]];
        cmd.strPercentageCompleted = [cmd.strPercentageCompleted stringByAppendingString:@" %"];
        cmd.strStatus = [NSString stringWithFormat:@"%@",[dic valueForKey:@"actionlog_status"] ];
        cmd.strCreatedBy = [NSString stringWithFormat:@"%@",[dic valueForKey:@"created_by_id"] ];
        cmd.strNoteCount = [NSString stringWithFormat:@"%@",[dic valueForKey:@"notes_count"] ];
        cmd.strIsCheck   = @"NO";
        [arrayPrint addObject:cmd];
        [arraApprove addObject:cmd];
    }
    [table  reloadData];
}

- (void)pickerChanged:(id)sender{
    if (DATA == 1) {
        [NSTimeZone resetSystemTimeZone];
        dateFormat.dateStyle=NSDateFormatterMediumStyle;
        [dateFormat setDateFormat:@"dd-MMM-yyyy"];
    }else{
        [NSTimeZone resetSystemTimeZone];
        dateFormat.dateStyle=NSDateFormatterMediumStyle;
        [dateFormat setDateFormat:@"h:mm:a"];
    }
}

-(void)updateTextFieldDate:(id)sender{
    NSDate *chosen = [myPicker date];
    if (DATA == 1) {
        [NSTimeZone resetSystemTimeZone];
        dateFormat.dateStyle=NSDateFormatterMediumStyle;
        [dateFormat setDateFormat:@"dd-MMM-yyyy"];
        selectDate = chosen;
    }else{
        dateFormat.dateStyle=NSDateFormatterMediumStyle;
        [dateFormat setDateFormat:@"h:mm:a"];
        [NSTimeZone resetSystemTimeZone];
    }
    [viewDate removeFromSuperview];
    [viewDate removeFromSuperview];
}

-(void)WebData{
    [self Archived];
    NSString *parameter;
    if([appDelegate.STRUSERTYPE isEqualToString:@"Admin"] || [appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"] ){
        if ([appDelegate.ISAPPROVE isEqualToString:@"NO"]){
            // if([appDelegate.STRUSERTYPE isEqualToString:@"Admin"]){
            parameter = [@"grid_type=" stringByAppendingString:[strGridType stringByAppendingString:[@"&assign_to="stringByAppendingString:appDelegate.STRUSERID]]];
//            txtAAssignTo.text = appDelegate.STRUSERNAME;
            strAssignTo_Id =appDelegate.STRUSERID;
            //}
        }else{
            parameter = [@"grid_type=" stringByAppendingString:strGridType];
 //           txtAAssignTo.text = @"Assign To";
        }
    }
    else
        parameter = [@"grid_type=" stringByAppendingString:strGridType];
    strTEST = parameter;

    [self PrintGrid:parameter];
}
-(void)webReload{
    [self PrintGrid:strTEST];
}

-(void)WebServices{
    AllWebServices *web = [[AllWebServices alloc]init];
    NSMutableArray *array = [web WebDashboard];
    urlCompany = [[array objectAtIndex:0]webCompany];
    urlDepartment = [[array objectAtIndex:0]webDepartment];
    urlCreatedBy= [[array objectAtIndex:0]webCreatedBy];
    urlAssignTo= [[array objectAtIndex:0]webAssignTo];
    urlStatus= [[array objectAtIndex:0]webStatus];
    urlDueDate= [[array objectAtIndex:0]webDueDate];
    urlDueFrom= [[array objectAtIndex:0]webDueFrom];
    urlDueTo= [[array objectAtIndex:0]webDueTo];
    urlDashboard = [[array objectAtIndex:0]webDashboard];
    urlSearch= [[array objectAtIndex:0]webSearchFilter];
    urlTagList = [[array objectAtIndex:0]webTagList];
    urlForApprovalCount = [[array objectAtIndex:0]webForApprvalCount];
    urlChangeActionStatus = [[array objectAtIndex:0]webChangeActionStatus];
    urlLogOut = [[array objectAtIndex:0]webLogOut];
}
#pragma -mark UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    if(textField.tag == 200){
        of=0;
        arraApprove = [[NSMutableArray alloc]init];
        arrayListUserApprove = [[NSMutableArray alloc]init];
        arrayPrint = [[NSMutableArray alloc]init];
        arraAssignList = [[NSMutableArray alloc]init];
        arrayListUser = [[NSMutableArray alloc]init];
        NSString *parameter = [@"grid_type=" stringByAppendingString:[strGridType stringByAppendingString:[@"&search=" stringByAppendingString:txtSearchTitle.text]]];
        strTEST = parameter;
        [self PrintGrid:parameter];
    }
    return YES;
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
