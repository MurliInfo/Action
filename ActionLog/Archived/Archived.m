//
//  Archived.m
//  ActionLog
//
//  Created by Hardik Davda on 9/14/16.
//  Copyright © 2016 SLP-World. All rights reserved.
//

#import "Archived.h"
#import "KNCirclePercentView.h"
#import "PickerView.h"
#import "CustomDataform.h"
#import "CustomCellAdvanceSearch.h"
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


@interface Archived ()<CZPickerViewDelegate>{
    UIView *nomatchesView;
    UIView *viewBackGround;
    UIView *viewLoader;
    NSTimer *timer;
    NSString *clickhideDropDown;
    NSMutableArray *arrayCompanies;
    NSString *dropDownSelection;
    NSMutableArray *arrayTemp;
    NSMutableArray *arrayDepartment;
    NSMutableArray *arrayDepartmentFull;
    NSMutableArray *arrayCreatedBy;
    NSMutableArray *arrayStutas;
    NSMutableArray *arrayAssignTo;
    NSMutableArray *arrayDueDate;
    NSMutableArray *arrayPrint;
    NSMutableArray *arrayListUser;
    NSMutableArray *arrayTag;
    NSMutableArray *arrayPrint1;
    NSMutableArray *arrayPrint11;
    NSMutableArray *arrayApply;
    NSMutableArray *arrayArchived;
    NSMutableArray *arrayTesting;
    NSMutableArray *arraAssignList;
    NSMutableArray *arrayUserList;
    NSMutableArray *arraySubtask;
    NSMutableArray *arrayWorkDate;
    NSString *urlCompany;
    NSString *urlDepartment;
    NSString *urlCreatedBy;
    NSString *urlAssignTo;
    NSString *urlStatus;
    NSString *urlDueDate;
    NSString *urlDueFrom;
    NSString *urlDueTo;
    NSString *urlDashboard;
    NSString *urlTagList;
    NSString *urlChangeActionStatus;
    NSString *urlForApprovalCount;

    int of;
    
    NSString *strCompany_Id;
    NSString *strDepartment_Id;
    NSString *strUserName_Id;
    NSString *strCreatedBy_Id;
    NSString *strAssignTo_Id;
    NSString *strDateSELECT;
    KNCirclePercentView *circleView;
    int temp;
    int alertDelete;
    NSString *FLAG;
    CGRect TESTINGFRAME;
    NSDateFormatter *dateFormat;
    int DATA;
    UIRefreshControl *refreshControl;
    UIView *viewDemoTable;
    UIView *viewLoaderTable;
    NSString *strLoard;
    NSString *strTEST;
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

@implementation Archived

- (void)viewDidLoad {
    [super viewDidLoad];
    viewUserSearch.hidden = YES;
    viewSearchButton.hidden = YES;
    
    FLAG = @"1";
    of=0;
        strLoard = @"YES";
    strLoard = @"YES";
    arrayPrint = [[NSMutableArray alloc]init];
    arraAssignList = [[NSMutableArray alloc]init];
    arrayListUser = [[NSMutableArray alloc]init];
    Methods = [[AllMethods alloc]init];
    lblCount1.hidden = YES;
    lblCount2.hidden = YES;
    
    arraySubtask = [[NSMutableArray alloc]init];
    web = [[CustomDataform alloc]init];
    
        if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
            arraySubtask = [web ADSASuperAdmin];
        }else if ([appDelegate.STRUSERTYPE isEqualToString:@"Admin"]){
            arraySubtask = [web ADSAAdmin];
        }else{
            arraySubtask = [web ADSAStaff];
        }
    [tableSearch reloadData];
    [self manageAdvanceSearchView];
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
    
    
    [self manageUser];
    viewTag.hidden = YES;
    viewTitleSearch.hidden = YES;
     [self setNeedsStatusBarAppearanceUpdate];
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Loading more items..."];
    [refreshControl addTarget:self action:@selector(loadMore) forControlEvents:UIControlEventValueChanged];
    
    NSString  *parameter = [@"grid_type=" stringByAppendingString:@"Archived"];
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"] ||[appDelegate.STRUSERTYPE isEqualToString:@"Admin"]){
        parameter = [parameter stringByAppendingString:[@"&assign_to="stringByAppendingString:appDelegate.STRUSERID]];
        strAssignTo_Id =appDelegate.STRUSERID;
        txtSAAssignTo.text = appDelegate.STRUSERNAME;
        
    }
   //NSString  *parameter = [@"grid_type=" stringByAppendingString:@"Archived"];
    strTEST = parameter;
    
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    strLoard = @"YES";
    viewTagSearch.hidden = YES;
    viewDate.hidden = YES;
    alertDelete = 0;
    arrayApply = [[NSMutableArray alloc]init];
    arrayTesting = [[NSMutableArray alloc]init];
    TESTINGFRAME = viewTag.frame;
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"] || [appDelegate.STRUSERTYPE isEqualToString:@"Admin"])
        TESTINGFRAME.origin.y = 50;
    [self AdvanceCollapseManage];
    
    [self viewMain];
    timer = [NSTimer scheduledTimerWithTimeInterval:.000001 target:self selector:@selector(initialize) userInfo:nil repeats:NO];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(stopGIF) userInfo:nil repeats:NO];
    timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(LoardServices) userInfo:nil repeats:NO];
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

-(void)LoardServices{
    NSLog(@"Loard services in archived");
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"] ||[appDelegate.STRUSERTYPE isEqualToString:@"Admin"]||[appDelegate.STRUSERTYPE isEqualToString:@"Staff"] ){
        [self GetStatus];
        //[self GetOverDue];
        [self GetAssign];
    }
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"] ||[appDelegate.STRUSERTYPE isEqualToString:@"Admin"]){
        [self GetDepartment];
    }
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
        [self GetCompany];
    }
    [self GetTag];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    // [self setNeedsStatusBarAppearanceUpdate];
    return UIStatusBarStyleLightContent;
}

- (void)initialize{
    
   of=0;
    strLoard = @"YES";
    temp = table.frame.size.width;
    viewTitleSearch.hidden = YES;
    viewTag.hidden = YES;
    [self WebServices];
    [self WebData];
    [self GetForApprovalCount];
    
    viewTagSearch.hidden = YES;
}
-(void)ResetArray{
    arraySubtask = [[NSMutableArray alloc]init];
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
        arraySubtask = [web ADSASuperAdmin];
    }else if ([appDelegate.STRUSERTYPE isEqualToString:@"Admin"]){
        arraySubtask = [web ADSAAdmin];
    }else{
        arraySubtask = [web ADSAStaff];
    }
    [tableSearch reloadData];
    [self manageAdvanceSearchView];
}

#pragma mark - GIF Delegate

-(void)viewMain{
    table.hidden = YES;
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


-(void)viewMainTable{
   
    viewDemoTable = [[UIView alloc]initWithFrame:CGRectMake(table.frame.origin.x, viewListAction.frame.size.height-60, table.frame.size.width, 50)];
    
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


#pragma -mark UITableview Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(tableView == table){
        [nomatchesView removeFromSuperview];
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
    if(tableView == table){
        return 1;
    }else{
        return arraySubtask.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == table){
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.lblTitle.text = [[arrayPrint objectAtIndex:indexPath.section]strActionLogTitle];
    cell.lblStatus.text = [[arrayPrint objectAtIndex:indexPath.section]strStatus];
    cell.lblDueDate.text =  [[arrayPrint objectAtIndex:indexPath.section]strDashboardDueDate];
    
    cell.lblAssignName.text = [[arrayPrint objectAtIndex:indexPath.section]strAssignTo];
    cell.lblPercentages.text = [[arrayPrint objectAtIndex:indexPath.section]strPercentageCompleted];
    cell.lblViewCount.text = [[arrayPrint objectAtIndex:indexPath.section]strNoteCount];
    cell.btnViewNote.tag = indexPath.section;
    cell.lblWorkDate.text =[[arrayPrint objectAtIndex:indexPath.section]strWorkDate];
        
    if([[[arrayPrint objectAtIndex:indexPath.section]strColor] isEqualToString:@"red"]){
        cell.lblDueDate.textColor = [Methods colorWithHexString:@"E35444"];
    }else{
        cell.lblDueDate.textColor = [Methods colorWithHexString:@"74AD46"];//74AD46
    }
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
    cell.btnCheck.tag = indexPath.section;
    
        
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

    
    NSInteger lastSectionIndex = [tableView numberOfSections] - 1;
    NSInteger lastRowIndex = [tableView numberOfRowsInSection:lastSectionIndex] - 1;
    
    if ((indexPath.section == lastSectionIndex) && (indexPath.row == lastRowIndex)) {
        if([strLoard isEqualToString:@"YES"]){
            [self  viewMainTable];
            timer = [NSTimer scheduledTimerWithTimeInterval:.0001 target:self selector:@selector(loadMore) userInfo:nil repeats:NO];
            
            // [self webReload];
        }
    }
    return  cell;
    }else{
        CustomCellAdvanceSearch *cell;
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
        return cell;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(tableView == table){
        return 10.0f;
    }else{
        return 0.0f;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width,10)];
    [view1 setBackgroundColor: [Methods colorWithHexString:@"EFEFEF"]];
    
    return view1;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *) indexPath{
    if(tableView == table){
    return YES;
    }else{
        return NO;
    }
}
//
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return UITableViewCellEditingStyleDelete;
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    NSLog(@"Try");
//    //     if (editingStyle == UITableViewCellEditingStyleDelete)
//    //           NSLog(@"Index path row %ld",indexPath.row);
//    
//}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Delete";
}

//-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewRowAction *button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:[[arrayPrint objectAtIndex:indexPath.section]strAssignTo] handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
//                                    {
//                                        NSLog(@"Action to perform with Button 1");
//                                        [table reloadData];
//                                    }];
//    button.backgroundColor = [Methods colorWithHexString:@"102D3F"]; //arbitrary color
//    return @[button];
//}

#pragma -mark UITableview Delegate



- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == table){
        NSString *strCreatedby;
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for (int i = 0; i<appDelegate.ARRAYASSIGNTO.count; i++) {
            NSLog(@"created by id %d",[ [[arrayPrint objectAtIndex:indexPath.section]strCreatedBy]intValue]);
            int idt = [ [[arrayPrint objectAtIndex:indexPath.section]strCreatedBy]intValue];
            int key = [[[appDelegate.ARRAYASSIGNTO objectAtIndex:i]strKey]intValue];
            if (idt== key) {
                strCreatedby = [[appDelegate.ARRAYASSIGNTO objectAtIndex:i]strStatus];
                break;
            }
        }
        CustomData *cmd= [[CustomData alloc]init];
        cmd = [arrayPrint objectAtIndex:indexPath.section];
//    cmd.strId =[[arrayPrint objectAtIndex:indexPath.section]strId];
//    cmd.strRevisedDate = [[arrayPrint objectAtIndex:indexPath.section]strRevisedDate];
//    cmd.strTagId = [[arrayPrint objectAtIndex:indexPath.section]strTagId];
//    cmd.strDueDate = [[arrayPrint objectAtIndex:indexPath.section]strDueDate];
//    // NSLog(@"DUE DATE %@",cmd.strDueDate);
//    cmd.strCreatedDate = [[arrayPrint objectAtIndex:indexPath.section]strCreatedDate];
//    cmd.strDashboardDueDate = [[arrayPrint objectAtIndex:indexPath.section]strDashboardDueDate];
//    cmd.strNotesReadStatus = [[arrayPrint objectAtIndex:indexPath.section]strNotesReadStatus];
//    cmd.strRevisedDate = [[arrayPrint objectAtIndex:indexPath.section]strRevisedDate];
//    cmd.strActionLogTitle = [[arrayPrint objectAtIndex:indexPath.section]strActionLogTitle];
//    cmd.strTagId = [[arrayPrint objectAtIndex:indexPath.section]strTagId];
//    cmd.strAssigneCompanyId = [[arrayPrint objectAtIndex:indexPath.section]strAssigneCompanyId];
//    cmd.strPercentageCompleted = [[arrayPrint objectAtIndex:indexPath.section]strPercentageCompleted];
//    cmd.strColor = [[arrayPrint objectAtIndex:indexPath.section]strColor];
//    cmd.strCreatedDate = [[arrayPrint objectAtIndex:indexPath.section]strCreatedDate];
//    cmd.strCreatedBy = [[arrayPrint objectAtIndex:indexPath.section]strCreatedBy];
//    cmd.strTagId = [[arrayPrint objectAtIndex:indexPath.section]strTagId];
        cmd.strUserName = strCreatedby;
        cmd.strAssignTo = [[arrayPrint objectAtIndex:indexPath.section]strAssignTo];
        cmd.strFrom = @"Archived";
        [array addObject:cmd];
        NSString *strActionLogId = [[arrayPrint objectAtIndex:indexPath.section]strId];
        AddSubtask *second=[self.storyboard instantiateViewControllerWithIdentifier:@"addsubtask"];
        second.getActionLogId = strActionLogId;
        second.getActionLogTitle =[[arrayPrint objectAtIndex:indexPath.section]strActionLogTitle];
        second.arrayGetDetail = array;
        second.getStatus = @"Archived";
        [self.navigationController pushViewController:second animated:YES];
    }
    return  indexPath;
}

#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
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

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    //    if([SELECTPICKER isEqualToString:@"Timezone"])
    {
        //[txtTagSearch setText:[arrayPrint1 objectAtIndex:row]];
        //strTimezoneId = [[arrayPrint objectAtIndex:row] strTimezoneId];
    }
    //    if([SELECTPICKER isEqualToString:@"Type"]){
    //        [txtType setText:[[arrayPrint objectAtIndex:row] strPropertyAddress]];
    //        strTypeId = [[arrayPrint objectAtIndex:row]strUserId];
    //    }
    //    if([SELECTPICKER isEqualToString:@"Department"]){
    //        [txtDepartment setText:[[arrayPrint objectAtIndex:row] strPropertyAddress]];
    //        strDepartmentId = [[arrayPrint objectAtIndex:row]strDepartmentId];
    //
    //    }
    // viewPickerView.hidden = YES;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    return [arrayPrint1 objectAtIndex:row];
}


#pragma mark- Picker View Delegate FOR POPUP
-(void)czpickerView:(PickerView *)pickerView didConfirmWithItemAtRow:(NSInteger)row {
 
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


#pragma -mark Button IBAction

- (IBAction)AdvanceSearch:(id)sender{
    [self HideDropDownAtAllPlace];
    UIButton *btn = sender;
    //NSLog(@"Button tab %ld",(long)btn.tag);
    switch (btn.tag) {
        case 1:
            //
            [self AdvanceSearchManage];
            btnAdvanceSearchCollapse.tag = 2;
            break;
            
        case 2:
            //
            [self AdvanceCollapseManage];
            btnAdvanceSearchCollapse.tag = 1;
            break;
            
        default:
            btnAdvanceSearchCollapse.tag = 2;
            break;
    }
    imgAdvanceSearchCollapse.image = [UIImage imageNamed:@"Cancel.png"];
    imgAdvanceSearchCollapse.image = [UIImage imageNamed:@"Search-icon.png"];
    //lblAdvanceSearchCollaps.text = @"Advanced Search";
    // lblAdvanceSearchCollaps.text = @"Collapse Search";
}

- (IBAction)AllCheck:(id)sender{
    //UIButton *btnDemo = sender;
    [self HideDropDownAtAllPlace];
    if(btnCheckAll.tag == 1){
        NSString *strCheck;
        strCheck = @"NO";
        btnCheckAll.tag = 2;
        imgChekApply.image = [UIImage imageNamed:@"SelectBtn.png"];
        arrayApply = [[NSMutableArray alloc]init];
        for (int i=0 ; i<arrayPrint.count; i++) {
            CustomData *cmd = [[ CustomData alloc]init];
            cmd.strId = [[arrayPrint objectAtIndex:i]strId];//
            cmd.strActionLogTitle = [[arrayPrint objectAtIndex:i]strActionLogTitle];
            cmd.strAssigneCompanyId = [[arrayPrint objectAtIndex:i]strAssigneCompanyId];
            cmd.strAssignTo = [[arrayPrint objectAtIndex:i]strAssignTo];
            cmd.strDueDate = [[arrayPrint objectAtIndex:i]strDueDate];
            cmd.strCreatedDate = [[arrayPrint objectAtIndex:i]strCreatedDate];
            cmd.strDashboardDueDate = [[arrayPrint objectAtIndex:i]strDashboardDueDate];
            cmd.strNotesReadStatus = [[arrayPrint objectAtIndex:i]strNotesReadStatus];
            cmd.strRevisedDate = [[arrayPrint objectAtIndex:i]strRevisedDate];
            cmd.strTagId = [[arrayPrint objectAtIndex:i]strTagId];
            cmd.strPercentageCompleted = [[arrayPrint objectAtIndex:i]strPercentageCompleted];
            cmd.strColor = [[arrayPrint objectAtIndex:i]strColor];
            cmd.strStatus = [[arrayPrint objectAtIndex:i]strStatus];
            cmd.strCreatedBy = [[arrayPrint objectAtIndex:i]strCreatedBy];
            cmd.strNoteCount =[[arrayPrint objectAtIndex:i]strNoteCount];
//            if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
//                cmd.strIsCheck   = @"YES";
//                strCheck = @"YES";
//                [arrayApply addObject:cmd];
//            }else
            {
                if([[[arrayPrint objectAtIndex:i]strCreatedBy]isEqualToString:appDelegate.STRUSERID]){
                    cmd.strIsCheck   = @"YES";
                    strCheck = @"YES";
                    [arrayApply addObject:cmd];
                }
                else
                    cmd.strIsCheck   = @"NO";
                }
            [arrayPrint replaceObjectAtIndex:i withObject:cmd];
        }
        if([strCheck isEqualToString:@"NO"]){
            btnCheckAll.tag = 1;
            imgChekApply.image = [UIImage imageNamed:@"checkDisbale.png"];
            [self showUiAlertWithMessage:@"You have not create any action" andtitle:@""];
        }
    }else{
        arrayApply = [[NSMutableArray alloc]init];
        for (int i=0 ; i<arrayPrint.count; i++) {
            CustomData *cmd = [[ CustomData alloc]init];
            cmd.strId = [[arrayPrint objectAtIndex:i]strId];//
            cmd.strActionLogTitle = [[arrayPrint objectAtIndex:i]strActionLogTitle];
            cmd.strAssigneCompanyId = [[arrayPrint objectAtIndex:i]strAssigneCompanyId];
            cmd.strAssignTo = [[arrayPrint objectAtIndex:i]strAssignTo];
            cmd.strDueDate = [[arrayPrint objectAtIndex:i]strDueDate];
            cmd.strCreatedDate = [[arrayPrint objectAtIndex:i]strCreatedDate];
            cmd.strDashboardDueDate =[[arrayPrint objectAtIndex:i]strDashboardDueDate];
            cmd.strNotesReadStatus = [[arrayPrint objectAtIndex:i]strNotesReadStatus];
            cmd.strRevisedDate = [[arrayPrint objectAtIndex:i]strRevisedDate];
            cmd.strTagId = [[arrayPrint objectAtIndex:i]strTagId];
            cmd.strPercentageCompleted = [[arrayPrint objectAtIndex:i]strPercentageCompleted];
            cmd.strColor = [[arrayPrint objectAtIndex:i]strColor];
            cmd.strStatus = [[arrayPrint objectAtIndex:i]strStatus];
            cmd.strCreatedBy = [[arrayPrint objectAtIndex:i]strCreatedBy];
            cmd.strNoteCount =[[arrayPrint objectAtIndex:i]strNoteCount];
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

- (IBAction)Approve:(id)sender{
    appDelegate.ISAPPROVE = @"YES";
    Dashboard *second=[self.storyboard instantiateViewControllerWithIdentifier:@"dashboard"] ;
    [self.navigationController pushViewController:second animated:YES];
}

- (IBAction)Archived:(id)sender{
    Archived *second=[self.storyboard instantiateViewControllerWithIdentifier:@"archived"] ;
    [self.navigationController pushViewController:second animated:YES];
}

- (IBAction)CancelTitleSearch:(id)sender{
    viewTitleSearch.hidden = YES;
    arrayPrint = [[NSMutableArray alloc]initWithArray:arraAssignList];
    [table reloadData];
    [self HideDropDownAtAllPlace];
}

-(void)CancelView{
    [self HideDropDownAtAllPlace];
    
    [self AdvanceCollapseManage];
  //  [self Reset:nil];
    [self stopGIF];
    
}

- (IBAction)Cancel:(id)sender{
   // [self viewMain];
    table.hidden = NO;
    [self CancelView];
    //timer = [NSTimer scheduledTimerWithTimeInterval:.0000001 target:self selector:@selector(CancelView) userInfo:nil repeats:NO];
}

- (IBAction)CellCheck:(id)sender{
    [self HideDropDownAtAllPlace];
    UIButton *btnDemo = sender;
    // NSLog(@"Indexpath %ld",(long)btnDemo.tag);
    
    if ([[[arrayPrint objectAtIndex:btnDemo.tag]strIsCheck] isEqualToString:@"NO"]) {
        CustomData *cmd = [[ CustomData alloc]init];
        //NSLog(@"Indexpath %ld",(long)btnDemo.tag);
        cmd.strId = [[arrayPrint objectAtIndex:btnDemo.tag]strId];//
        cmd.strActionLogTitle = [[arrayPrint objectAtIndex:btnDemo.tag]strActionLogTitle];
        cmd.strAssigneCompanyId = [[arrayPrint objectAtIndex:btnDemo.tag]strAssigneCompanyId];
        cmd.strAssignTo = [[arrayPrint objectAtIndex:btnDemo.tag]strAssignTo];
        cmd.strDueDate = [[arrayPrint objectAtIndex:btnDemo.tag]strDueDate];
        cmd.strCreatedDate = [[arrayPrint objectAtIndex:btnDemo.tag]strCreatedDate];
        cmd.strRevisedDate = [[arrayPrint objectAtIndex:btnDemo.tag]strRevisedDate];
        cmd.strTagId = [[arrayPrint objectAtIndex:btnDemo.tag]strTagId];
        cmd.strDashboardDueDate = [[arrayPrint objectAtIndex:btnDemo.tag]strDashboardDueDate];
        cmd.strNotesReadStatus = [[arrayPrint objectAtIndex:btnDemo.tag]strNotesReadStatus];
        cmd.strRevisedDate = [[arrayPrint objectAtIndex:btnDemo.tag]strRevisedDate];
        cmd.strDashboardDueDate = [[arrayPrint objectAtIndex:btnDemo.tag]strDashboardDueDate];
        cmd.strPercentageCompleted = [[arrayPrint objectAtIndex:btnDemo.tag]strPercentageCompleted];
        cmd.strColor = [[arrayPrint objectAtIndex:btnDemo.tag]strColor];
        cmd.strStatus = [[arrayPrint objectAtIndex:btnDemo.tag]strStatus];
        cmd.strCreatedBy = [[arrayPrint objectAtIndex:btnDemo.tag]strCreatedBy];
        cmd.strNoteCount =[[arrayPrint objectAtIndex:btnDemo.tag]strNoteCount];
        cmd.strColor = [[arrayPrint objectAtIndex:btnDemo.tag]strColor];
        cmd.strIsCheck   = @"YES";
        [arrayApply addObject:cmd];
        [arrayPrint replaceObjectAtIndex:btnDemo.tag withObject:cmd];//
        [arraAssignList replaceObjectAtIndex:btnDemo.tag withObject:cmd];
        //  [arrayDemo addObject:cmd.strPropertyAddress];
        
    }else{
        CustomData *cmd = [[ CustomData alloc]init];
        cmd.strId = [[arrayPrint objectAtIndex:btnDemo.tag]strId];//
        cmd.strActionLogTitle = [[arrayPrint objectAtIndex:btnDemo.tag]strActionLogTitle];
        cmd.strAssigneCompanyId = [[arrayPrint objectAtIndex:btnDemo.tag]strAssigneCompanyId];
        cmd.strAssignTo = [[arrayPrint objectAtIndex:btnDemo.tag]strAssignTo];
        cmd.strDueDate = [[arrayPrint objectAtIndex:btnDemo.tag]strDueDate];
        cmd.strCreatedDate = [[arrayPrint objectAtIndex:btnDemo.tag]strCreatedDate];
        cmd.strRevisedDate = [[arrayPrint objectAtIndex:btnDemo.tag]strRevisedDate];
        cmd.strTagId = [[arrayPrint objectAtIndex:btnDemo.tag]strTagId];
        cmd.strDashboardDueDate = [[arrayPrint objectAtIndex:btnDemo.tag]strDashboardDueDate];
        cmd.strNotesReadStatus = [[arrayPrint objectAtIndex:btnDemo.tag]strNotesReadStatus];
        cmd.strPercentageCompleted = [[arrayPrint objectAtIndex:btnDemo.tag]strPercentageCompleted];
        
        cmd.strStatus = [[arrayPrint objectAtIndex:btnDemo.tag]strStatus];
        cmd.strCreatedBy = [[arrayPrint objectAtIndex:btnDemo.tag]strCreatedBy];
        cmd.strNoteCount =[[arrayPrint objectAtIndex:btnDemo.tag]strNoteCount];
        cmd.strColor = [[arrayPrint objectAtIndex:btnDemo.tag]strColor];
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

-(IBAction)CloseDate:(id)sender{
    [self HideDropDownAtAllPlace];
    // [self HideDropDownAtAllPlace];
    viewDate.hidden = YES;
    // NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    [myPicker setDate:[NSDate date]];
}

- (IBAction)Dashboard:(id)sender{
    appDelegate.ISAPPROVE = @"NO";
    NSArray *array = [self.navigationController viewControllers];
    NSLog(@"View Array %@",array);
    
  //  [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
    
    Dashboard *second=[self.storyboard instantiateViewControllerWithIdentifier:@"dashboard"] ;
    [self.navigationController pushViewController:second animated:YES];
}

- (IBAction)DropDownSearch:(id)sender{
    [self HideDropDownAtAllPlace];
    UIButton *btn = sender;
    
    
    
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
            if(arrayArchived.count){
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


  
//    switch (btn.tag) {
//        case 50 :
//        {
//            if([@"YES" isEqualToString:clickhideDropDown ]){
//                if(arrayUserList.count){
//                    clickhideDropDown = @"NO";
//                    dropDownSelection = @"UserList";
//                    CGRect rt = txtSearchUser.frame;
//                    float height = MIN(220,(arrayCreatedBy.count+1)*44);
//                    [self showPopUpWithTitle:@"Select User Name" withOption:arrayUserList Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFullAll.frame.origin.y) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
//                }
//            }else{
//                clickhideDropDown = @"YES";
//                [Dropobj fadeOut];
//            }
//        }
//            
//            break;
//
//        case 1:
//        {
//            if([@"YES" isEqualToString:clickhideDropDown]){
//                if(arrayCompanies.count){
//                    txtSADepartment.text= @"Departments";
//                    clickhideDropDown = @"NO";
//                    dropDownSelection = @"Companies";
//                    CGRect rt = txtSACompany.frame;
//                    float height = MIN(264,(arrayCompanies.count+1)*44);
//                    [self showPopUpWithTitle:@"Select Company" withOption:arrayCompanies Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewFullAll.frame.origin.y+viewAdminSearch.frame.origin.y) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
//                }
//            }else{
//                clickhideDropDown = @"YES";
//                [Dropobj fadeOut];
//            }
//        }
//            break;
//        case 2:
//        {
//            if([@"YES" isEqualToString:clickhideDropDown ]){
//                if(arrayDepartment.count){
//                    clickhideDropDown = @"NO";
//                    dropDownSelection = @"Department";
//                    CGRect rt = txtSADepartment.frame;
//                    float height = MIN(264,(arrayDepartment.count+1)*44);
//                    [self showPopUpWithTitle:@"Select Department" withOption:arrayDepartment Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewFullAll.frame.origin.y+viewAdminSearch.frame.origin.y) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
//                }
//            }else{
//                clickhideDropDown = @"YES";
//                [Dropobj fadeOut];
//            }
//        }
//            break;
//        case 3:
//        {
//            if([@"YES" isEqualToString:clickhideDropDown ]){
//                if(arrayCreatedBy.count){
//                    clickhideDropDown = @"NO";
//                    dropDownSelection = @"CreatedBy";
//                    CGRect rt = txtSACreatedBy.frame;
//                    float height = MIN(264,(arrayCreatedBy.count+1)*44);
//                    [self showPopUpWithTitle:@"Select CreatedBy" withOption:arrayCreatedBy Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewFullAll.frame.origin.y+viewAdminSearch.frame.origin.y) size:CGSizeMake(rt.size.width+30, height) isMultiple:NO];
//                }
//            }else{
//                clickhideDropDown = @"YES";
//                [Dropobj fadeOut];
//            }
//        }
//            break;
//        case 4:
//        {
//            if([@"YES" isEqualToString:clickhideDropDown ]){
//                if(arrayAssignTo.count){
//                    clickhideDropDown = @"NO";
//                    dropDownSelection = @"AssignTo";
//                    CGRect rt = txtSAAssignTo.frame;
//                    float height = MIN(264,(arrayAssignTo.count+1)*44);
//                    [self showPopUpWithTitle:@"Select AssignTo" withOption:arrayAssignTo Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewFullAll.frame.origin.y+viewAdminSearch.frame.origin.y) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
//                }
//            }else{
//                clickhideDropDown = @"YES";
//                [Dropobj fadeOut];
//            }
//        }
//            break;
//        case 5:
//        {
//            if([@"YES" isEqualToString:clickhideDropDown ]){
//                if(arrayStutas.count){
//                    clickhideDropDown = @"NO";
//                    dropDownSelection = @"Stutas";
//                    CGRect rt = txtSAStatus.frame;
//                    float height = MIN(264,(arrayStutas.count+1)*44);
//                    [self showPopUpWithTitle:@"Select Stutas" withOption:arrayStutas Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewFullAll.frame.origin.y+viewAdminSearch.frame.origin.y) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
//                }
//            }else{
//                clickhideDropDown = @"YES";
//                [Dropobj fadeOut];
//            }
//        }
//            break;
//        case 6:
//        {
//            if([@"YES" isEqualToString:clickhideDropDown ]){
//                if(arrayDueDate.count){
//                    clickhideDropDown = @"NO";
//                    dropDownSelection = @"DueDate";
//                    CGRect rt = txtSADueDate.frame;
//                    float height = MIN(264,(arrayDueDate.count+1)*44);
//                    [self showPopUpWithTitle:@"Select Due Date" withOption:arrayDueDate Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewFullAll.frame.origin.y+viewAdminSearch.frame.origin.y) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
//                }
//            }else{
//                clickhideDropDown = @"YES";
//                [Dropobj fadeOut];
//            }
//        }
//            break;
//        case 7:
//            strDateSELECT= @"DateFrom";
//            viewDate.hidden = NO;
//            break;
//        case 8:
//            strDateSELECT= @"DateFrom";
//            viewDate.hidden = NO;
//            break;
//        case 11:
//        {
//            if([@"YES" isEqualToString:clickhideDropDown ]){
//                if(arrayDepartment.count){
//                    clickhideDropDown = @"NO";
//                    dropDownSelection = @"Department";
//                    CGRect rt = txtADepartment.frame;
//                    float height = MIN(264,(arrayDepartment.count+1)*44);
//                    [self showPopUpWithTitle:@"Select Department" withOption:arrayDepartment Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewFullAll.frame.origin.y+viewAdminSearch.frame.origin.y) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
//                }
//            }else{
//                clickhideDropDown = @"YES";
//                [Dropobj fadeOut];
//            }
//        }
//            break;
//        case 12:
//        {
//            if([@"YES" isEqualToString:clickhideDropDown ]){
//                if(arrayCreatedBy.count){
//                    clickhideDropDown = @"NO";
//                    dropDownSelection = @"CreatedBy";
//                    CGRect rt = txtACreatedBy.frame;
//                    float height = MIN(264,(arrayCreatedBy.count+1)*44);
//                    [self showPopUpWithTitle:@"Select CreatedBy" withOption:arrayCreatedBy Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewFullAll.frame.origin.y+viewAdminSearch.frame.origin.y) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
//                }
//            }else{
//                clickhideDropDown = @"YES";
//                [Dropobj fadeOut];
//            }
//        }
//            break;
//        case 13:
//        {
//            if([@"YES" isEqualToString:clickhideDropDown ]){
//                if(arrayAssignTo.count){
//                    clickhideDropDown = @"NO";
//                    dropDownSelection = @"AssignTo";
//                    CGRect rt = txtAAssignTo.frame;
//                    float height = MIN(264,(arrayAssignTo.count+1)*44);
//                    [self showPopUpWithTitle:@"Select AssignTo" withOption:arrayAssignTo Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewFullAll.frame.origin.y+viewAdminSearch.frame.origin.y) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
//                }
//            }else{
//                clickhideDropDown = @"YES";
//                [Dropobj fadeOut];
//            }
//        }
//            break;
//        case 14:
//        {
////            if([@"YES" isEqualToString:clickhideDropDown ]){
////                if(arrayStutas.count){
////                    clickhideDropDown = @"NO";
////                    dropDownSelection = @"Stutas";
////                    CGRect rt = txtADueDate.frame;
////                    float height = MIN(264,(arrayStutas.count+1)*44);
////                    [self showPopUpWithTitle:@"Select Stutas" withOption:arrayStutas Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewAdminSearch.frame.origin.y) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
////                }
////            }else{
////                clickhideDropDown = @"YES";
////                [Dropobj fadeOut];
////            }
//        }
//            break;
//        case 15:
//        {
//            if([@"YES" isEqualToString:clickhideDropDown ]){
//                if(arrayDueDate.count){
//                    clickhideDropDown = @"NO";
//                    dropDownSelection = @"Overdue";
//                    CGRect rt = txtSADueDate.frame;
//                    float height = MIN(264,(arrayDueDate.count+1)*44);
//                    [self showPopUpWithTitle:@"Select Due Date" withOption:arrayDueDate Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewFullAll.frame.origin.y+viewAdminSearch.frame.origin.y) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
//                }
//            }else{
//                clickhideDropDown = @"YES";
//                [Dropobj fadeOut];
//            }
//        }
//            break;
//        case 16:
//            strDateSELECT= @"DateFrom";
//            viewDate.hidden = NO;
//            break;
//        case 17:
//            strDateSELECT= @"DateTo";
//            viewDate.hidden = NO;
//            break;
//        case 21:
//        {
//            if([@"YES" isEqualToString:clickhideDropDown ]){
//                if(arrayCreatedBy.count){
//                    clickhideDropDown = @"NO";
//                    dropDownSelection = @"CreatedBy";
//                    CGRect rt = txtUCreatedBy.frame;
//                    float height = MIN(264,(arrayCreatedBy.count+1)*44);
//                    [self showPopUpWithTitle:@"Select CreatedBy" withOption:arrayCreatedBy Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewFullAll.frame.origin.y+viewSearch.frame.origin.y) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
//                }
//            }else{
//                clickhideDropDown = @"YES";
//                [Dropobj fadeOut];
//            }
//        }
//            break;
//        case 22:
//        {
//            if([@"YES" isEqualToString:clickhideDropDown ]){
//                if(arrayAssignTo.count){
//                    clickhideDropDown = @"NO";
//                    dropDownSelection = @"AssignTo";
//                    CGRect rt = txtUAssignTo.frame;
//                    float height = MIN(264,(arrayAssignTo.count+1)*44);
//                    [self showPopUpWithTitle:@"Select AssignTo" withOption:arrayAssignTo Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewFullAll.frame.origin.y+viewSearch.frame.origin.y) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
//                }
//            }else{
//                clickhideDropDown = @"YES";
//                [Dropobj fadeOut];
//            }
//        }
//            break;
//        case 23:
//        {
//            if([@"YES" isEqualToString:clickhideDropDown ]){
//                if(arrayStutas.count){
//                    clickhideDropDown = @"NO";
//                    dropDownSelection = @"Stutas";
//                    CGRect rt = txtUStatus.frame;
//                    float height = MIN(264,(arrayStutas.count+1)*44);
//                    [self showPopUpWithTitle:@"Select Stutas" withOption:arrayStutas Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewFullAll.frame.origin.y+viewSearch.frame.origin.y) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
//                }
//            }else{
//                clickhideDropDown = @"YES";
//                [Dropobj fadeOut];
//            }
//        }
//            break;
//        case 24:
//        {
//            if([@"YES" isEqualToString:clickhideDropDown ]){
//                if(arrayDueDate.count){
//                    clickhideDropDown = @"NO";
//                    dropDownSelection = @"DueDate";
//                    CGRect rt; //= txtDueDate.frame;
//                    float height = MIN(264,(arrayDueDate.count+1)*44);
//                    [self showPopUpWithTitle:@"Select Due Date" withOption:arrayDueDate Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y+rt.size.height+viewFull.frame.origin.y+viewFullAll.frame.origin.y+viewSearch.frame.origin.y) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
//                }
//            }else{
//                clickhideDropDown = @"YES";
//                [Dropobj fadeOut];
//            }
//        }
//            break;
//        case 25:
//            strDateSELECT= @"DateFrom";
//            viewDate.hidden = NO;
//            break;
//        case 26:
//            strDateSELECT= @"DateTo";
//            viewDate.hidden = NO;
//            break;
//        case 31:
//        {
//            //NSLog(@"InSaide switch");
//            if([@"YES" isEqualToString:clickhideDropDown ]){
//                if(arrayArchived.count){
//                    clickhideDropDown = @"NO";
//                    dropDownSelection = @"Archived";
//                    CGRect rt = txtArchived.frame;
//                    float height = MIN(220,(arrayArchived.count)*44);
//                    //NSLog(@"Height %f",height);
//                    [self showPopUpWithTitle:@"Select Due Date" withOption:arrayArchived Option1:arrayTemp xy:CGPointMake(rt.origin.x, viewAction.frame.origin.y-txtArchived.frame.size.height) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
//                }
//            }else{
//                clickhideDropDown = @"YES";
//                [Dropobj fadeOut];
//            }
//        }
//            break;
//        default:
//            break;
//    }
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



-(void)ResetView{
    [self HideDropDownAtAllPlace];
    txtSearchUser.text = @"User Name";
    txtSearchTitle.text = @"";
    
    
//    [self ResetField];

    
    [self ResetArray];
    NSString *parameter = [@"&grid_type=" stringByAppendingString:@"Archived"];
    FLAG =@"1";
    of = 0;
    strLoard = @"YES";
    strTEST = parameter;
    [self PrintGrid2:parameter];
    [self stopGIF];
}


-(void)ResetField{
    
    txtSACompany.text = @"Companies";
    txtSACreatedBy.text = @"Created By";
    txtSADepartment.text = @"Departments";
    txtSADueFromDate.text = @"Due From Date";
    txtSADueToDate.text = @"Due To Date";
    txtSAAssignTo.text = @"Assign To";
    
    txtADepartment.text = @"Departments";
    txtACreatedBy.text = @"Created By";
    txtADueFromDate.text = @"Due From Date";
    txtADueToDate.text = @"Due To Date";
    
    txtAAssignTo.text = @"Assign To";
    txtUAssignTo.text = @"Assign To";
    
    txtUCreatedBy.text = @"Created By";
    txtUDueFromDate.text = @"Due From Date";
    txtUDueToDate.text = @"Due To Date";
    txtUDueDate.text = @"Overdue";
}

- (IBAction)ResetUserSearch:(id)sender{
     [self ForClose];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.000001 target:self selector:@selector(ResetField) userInfo:nil repeats:NO];
}

- (IBAction)Reset:(id)sender{
    [self viewMain];
    table.hidden = NO;
    timer = [NSTimer scheduledTimerWithTimeInterval:.000001 target:self selector:@selector(ResetView) userInfo:nil repeats:NO];
}


- (IBAction)searchTitleChaneg:(id)sender{
    clickhideDropDown = @"YES";
    [Dropobj fadeOut];
    //[self HideDropDownAtAllPlace];
     {
        NSString *searchText;
        //NSLog(@"Title Count %ld",arrayListUser.count);
        searchText =txtSearchTitle.text;
        NSPredicate *resultPredicate = [NSPredicate
                                        predicateWithFormat:@"SELF contains[cd] %@ ",
                                        searchText];
        self.filltereList = (NSMutableArray *)[arrayListUser filteredArrayUsingPredicate:resultPredicate];
        if ([@"Empty" isEqualToString:[Methods whitSpace:searchText]]) {
            arrayPrint = [NSMutableArray arrayWithArray:arraAssignList];
            [table reloadData];
            //[self finalShort];
        }else
            [self shortText];
    }
    //arrayListUserApprove
    
}
-(void)SearchView{
    NSString *Parameter =[[NSString alloc]init];
    Parameter = [@"grid_type="stringByAppendingString:@"Archived"];
    
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
    FLAG =@"1";
    of = 0;
    strLoard = @"YES";
     [self PrintGrid2:Parameter];
//    [viewBackGround1 removeFromSuperview];
//    Parameter = [NSString stringWithFormat:@"%@",Parameter];
//    //NSLog(@"Parameter %@",strParammeter);
//    arraApprove = [[NSMutableArray alloc]init];
//    arrayListUserApprove = [[NSMutableArray alloc]init];
//    arrayPrint = [[NSMutableArray alloc]init];
//    arraAssignList = [[NSMutableArray alloc]init];
//    arrayListUser = [[NSMutableArray alloc]init];
//    strLoard =@"YES";
//    of=0;
//    strTEST = Parameter;
//    [self PrintGrid:Parameter];
//    [viewBackGround1 removeFromSuperview];
//    //[viewLoader removeFromSuperview];
//    [viewDemo removeFromSuperview];

    /*
    // [self HideDropDownAtAllPlace];
    txtSearchUser.text = @"User Name";
    txtSearchTitle.text = @"";
    [self ForClose];
    NSString *strParammeter =[[NSString alloc]init];
    strParammeter= [@"&grid_type=" stringByAppendingString:@"Archived"];
    
    if([@"NotEmpty" isEqualToString:[Methods whitSpace:txtSearchTitle.text]]){
        strParammeter =[strParammeter stringByAppendingString:[@"&search=" stringByAppendingString:txtSearchTitle.text]];
    }
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
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
        
        if([@"Due From Date" isEqualToString:txtSADueFromDate.text]&&[@"Due To Date" isEqualToString:txtSADueToDate.text])
        {
        }else{
            // NSLog(@"Due to date %@",txtSADueToDate.text);
            // NSLog(@"Due From date %@",txtSADueFromDate.text);
            if([@"Due From Date" isEqualToString:txtSADueFromDate.text])
            {
                strParammeter =[strParammeter stringByAppendingString:[@"&due_date=-" stringByAppendingString:txtSADueToDate.text]];// stringByAppendingString:[@"-" stringByAppendingString:txtSADueToDate.text]]]];
            }
            else if([@"Due To Date" isEqualToString:txtADueToDate.text]){
                strParammeter =[strParammeter stringByAppendingString:[@"&due_date=" stringByAppendingString:[txtSADueFromDate.text stringByAppendingString:@"-"]]];// stringByAppendingString:txtSADueToDate.text]]]];
            }
            else
                strParammeter =[strParammeter stringByAppendingString:[@"&due_date=" stringByAppendingString:[txtSADueFromDate.text stringByAppendingString:[@"-" stringByAppendingString:txtSADueToDate.text]]]];
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
        
        if([@"Due From Date" isEqualToString:txtADueFromDate.text]&&[@"Due To Date" isEqualToString:txtADueToDate.text])
        {
        }else{
            // NSLog(@"Due to date %@",txtSADueToDate.text);
            // NSLog(@"Due From date %@",txtSADueFromDate.text);
            if([@"Due From Date" isEqualToString:txtADueFromDate.text])
            {
                strParammeter =[strParammeter stringByAppendingString:[@"&due_date=-" stringByAppendingString:txtADueToDate.text]];// stringByAppendingString:[@"-" stringByAppendingString:txtSADueToDate.text]]]];
            }
            else if([@"Due To Date" isEqualToString:txtADueToDate.text]){
                strParammeter =[strParammeter stringByAppendingString:[@"&due_date=" stringByAppendingString:[txtADueFromDate.text stringByAppendingString:@"-"]]];// stringByAppendingString:txtSADueToDate.text]]]];
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
        if([@"Assign To" isEqualToString:txtUAssignTo.text]){
        }else{
            strParammeter =[strParammeter stringByAppendingString:[@"&assign_to=" stringByAppendingString:strAssignTo_Id]];
        }
        //        if([@"Status" isEqualToString:txtUStatus.text]){
        //        }else{
        //            strParammeter =[strParammeter stringByAppendingString:[@"&status=" stringByAppendingString:txtUStatus.text]];
        //        }
        if([@"Due From Date" isEqualToString:txtUDueFromDate.text]&&[@"Due To Date" isEqualToString:txtUDueToDate.text])
        {
        }else{
            //NSLog(@"Due to date %@",txtSADueToDate.text);
            //NSLog(@"Due From date %@",txtSADueFromDate.text);
            if([@"Due From Date" isEqualToString:txtUDueFromDate.text]){
                strParammeter =[strParammeter stringByAppendingString:[@"&due_date=-" stringByAppendingString:txtUDueToDate.text]];// stringByAppendingString:[@"-" stringByAppendingString:txtSADueToDate.text]]]];
            }
            else if([@"Due To Date" isEqualToString:txtUDueToDate.text]){
                strParammeter =[strParammeter stringByAppendingString:[@"&due_date=" stringByAppendingString:[txtUDueFromDate.text stringByAppendingString:@"-"]]];// stringByAppendingString:txtSADueToDate.text]]]];
            }
            else
                strParammeter =[strParammeter stringByAppendingString:[@"&due_date=" stringByAppendingString:[txtUDueFromDate.text stringByAppendingString:[@"-" stringByAppendingString:txtUDueToDate.text]]]];
        }
    }
    for(int i =0;i<arrayTesting.count;i++){
        if(i==0)
            strParammeter= [strParammeter stringByAppendingString:[@"&tags="stringByAppendingString:[[arrayTesting objectAtIndex:i]strId]]];
        else
            strParammeter= [strParammeter stringByAppendingString:[@","stringByAppendingString:[[arrayTesting objectAtIndex:i]strId]]];
    }
    //[self viewMain];
    strParammeter = [NSString stringWithFormat:@"%@",strParammeter];
    strTEST = strParammeter;
    NSLog(@"Parmeter for search %@",strParammeter);

    of = 0;
        strLoard = @"YES";
    NSString *strOfc = [NSString stringWithFormat:@"%d",of];
    
    //NSLog(@"paramter %@",parameter);
    // parameter = [parameter stringByAppendingString:@"&grid_type=Archived"];
    strParammeter = [strParammeter stringByAppendingString:[@"&page_offset=" stringByAppendingString:[strOfc stringByAppendingString:@"&page_length=10"]]];
    //NSLog(@"Parameter := %@\n offcet := %d",parameter ,of);
   
    {
        //NSLog(@"paramter %@",parameter);
        // parameter = [parameter stringByAppendingString:@"&grid_type=Archived"];
        NSDictionary *dataDictionary = [Methods  WebServerData:urlDashboard andPostParameter:strParammeter];
        NSLog(@"URln %@",urlDashboard);
        NSArray *dataAry = [dataDictionary objectForKey:@"info"];
        NSString *strData = [dataDictionary objectForKey:@"status"];
        // if([appDelegate.ISAPPROVE isEqualToString:@"NO"])
        if([strData intValue]){
            NSLog(@"All data of grid %@",dataAry);
            //  arraApprove = [[NSMutableArray alloc]init];
            // arrayListUserApprove = [[NSMutableArray alloc]init];
            arrayPrint = [[NSMutableArray alloc]init];
            arraAssignList = [[NSMutableArray alloc]init];
            arrayListUser = [[NSMutableArray alloc]init];
            for (NSDictionary *dic in dataAry) {
                if([@"No Record found" isEqualToString:[dic valueForKey:@"success_message"]]){
                    
                }else{
                    CustomData *cmd = [[CustomData alloc]init];
                    cmd.strId = [NSString stringWithFormat:@"%@",[dic valueForKey:@"actionlog_id"]];
                    cmd.strActionLogTitle = [NSString stringWithFormat:@"%@",[dic valueForKey:@"actionlog_title"]];
                    cmd.strAssignTo = [NSString stringWithFormat:@"%@",[dic valueForKey:@"assigned_to"] ];
                    // cmd.strDueDate = [NSString stringWithFormat:@"%@",[dic valueForKey:@"duedate"] ];
                    //cmd.strCreatedDate  = [NSString stringWithFormat:@"%@",[dic valueForKey:@"created_date"]];
                    cmd.strPercentageCompleted = [NSString stringWithFormat:@"%@",[dic valueForKey:@"percentage_compeleted"]];
                    cmd.strPercentageCompleted = [cmd.strPercentageCompleted stringByAppendingString:@" %"];
                    cmd.strStatus = [NSString stringWithFormat:@"%@",[dic valueForKey:@"actionlog_status"] ];
                    cmd.strCreatedBy = [NSString stringWithFormat:@"%@",[dic valueForKey:@"created_by_id"] ];
                    cmd.strNoteCount = [NSString stringWithFormat:@"%@",[dic valueForKey:@"notes_count"] ];
                    cmd.strIsCheck   = @"NO";
                    cmd.strRevisedDate = [NSString stringWithFormat:@"%@",[dic valueForKey:@"revised_date"]];
                    cmd.strDashboardDueDate = [NSString stringWithFormat:@"%@",[dic valueForKey:@"dashboard_duedate"]];
                    
                    cmd.strColor = [NSString stringWithFormat:@"%@",[dic valueForKey:@"duedate_color"]];
                    
                    
                    NSString *datatt= @"yyyy-MM-dd HH-mm-ss";
                    //NSLog(@"@All Data := %@",[Methods DateWithFormate:[dic valueForKey:@"created_date"] andCurrentFormate:appDelegate.STRWEBDATEFORMATE andNewFormateDate:appDelegate.STRDATEFORMATE]);
                    cmd.strCreatedDate =[dic valueForKey:@"created_date"] ;
                    cmd.strDueDate =[dic valueForKey:@"duedate"] ;
                    cmd.strRevisedDate =[dic valueForKey:@"revised_date"] ;
                    cmd.strDashboardDueDate =[dic valueForKey:@"dashboard_duedate"];
               
                    [arraAssignList addObject:cmd];
                    [arrayListUser addObject:cmd.strActionLogTitle];
                    [arrayPrint addObject:cmd];
                    [table  reloadData];
                }
            }
            of = of+10;
            if(arrayPrint.count<of){
                 strLoard = @"NO";
            }
            [table  reloadData];
        }else{
            arrayPrint = [[NSMutableArray alloc]init];
            [table  reloadData];
        }
    }
    [self stopGIF];
    
    */
//    viewSearchData.hidden = true;
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(stopGIF) userInfo:nil repeats:NO];
}

-(IBAction)Search:(id)sender{
    [self viewMain];
    table.hidden = NO;
    timer = [NSTimer scheduledTimerWithTimeInterval:.0000001 target:self selector:@selector(SearchView) userInfo:nil repeats:NO];
   // [self stopGIF];
}

#pragma mark - Title Search all methods
#pragma mark -

- (IBAction)SearchTitle:(id)sender{
    [self HideDropDownAtAllPlace];
    //[self AdvanceCollapseManage];
  //  [self Reset:sender];
    viewTitleSearch.hidden = NO;
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"] || [appDelegate.STRUSERTYPE isEqualToString:@"Admin"]){
        [self ManageTitleSearch];
    }
    
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
    [self ResetArray];
    UIButton *btn = sender;
    if(btn.tag == 1){
        [self.view endEditing:YES];
        [self HideDropDownAtAllPlace];
        NSString *strParammeter =[[NSString alloc]init];
        strParammeter = [@"grid_type="stringByAppendingString:@"Archived"];
        if([@"NotEmpty" isEqualToString:[Methods whitSpace:txtSearchTitle.text]]){
            strParammeter =[strParammeter stringByAppendingString:[@"&search=" stringByAppendingString:txtSearchTitle.text]];
        }
        
        if([@"User Name" isEqualToString:txtSearchUser.text]){
        }else{
            strParammeter =[strParammeter stringByAppendingString:[@"&action_user_id=" stringByAppendingString:strUserName_Id]];
        }
        arrayPrint = [[NSMutableArray alloc]init];
        arraAssignList = [[NSMutableArray alloc]init];
        arrayListUser = [[NSMutableArray alloc]init];
        strLoard =@"YES";
        of=0;
        strTEST = strParammeter;
        [self PrintGrid2:strParammeter];
    }else{
        
        NSString *param= [@"grid_type="stringByAppendingString:@"Archived"];
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
//        arraApprove = [[NSMutableArray alloc]init];
//        arrayListUserApprove = [[NSMutableArray alloc]init];
        arrayPrint = [[NSMutableArray alloc]init];
        arraAssignList = [[NSMutableArray alloc]init];
        arrayListUser = [[NSMutableArray alloc]init];
        strLoard =@"YES";

        of=0;
        strTEST = param;
        [self PrintGrid2:param];
        // [self ManageAtTagTime];
    }
}

-(IBAction)selectDate:(id)sender{
    [self HideDropDownAtAllPlace];
   // [self HideDropDownAtAllPlace];
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

//    if([strDateSELECT isEqualToString:@"DateFrom"]){
//        NSDate *chosen = myPicker.date;
//        dateFormat = [[NSDateFormatter alloc] init];
//        [dateFormat setDateFormat:@"MM/dd/yyyy"];
//        NSString *fromDay = [NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:chosen]];
//        //NSLog(@"Selected date from : = %@",fromDay);
//        txtADueFromDate.text = fromDay;
//        txtSADueFromDate.text = fromDay;
//        txtUDueFromDate.text = fromDay;
//    }else{
//        NSDate *chosen = myPicker.date;
//        dateFormat = [[NSDateFormatter alloc] init];
//        [dateFormat setDateFormat:@"MM/dd/yyyy"];//10/03/2016-15/03/2016
//        NSString *fromDay = [NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:chosen]];
//        // NSLog(@"Selected date To := %@",fromDay);
//        txtADueToDate.text = fromDay;
//        txtSADueToDate.text = fromDay;
//        txtUDueToDate.text = fromDay;
//    }
//    [self CloseDate:sender];
}

-(void)shortText{
    arrayPrint = [[NSMutableArray alloc]init];
    NSString *test;
    for (int j = 0;j<self.filltereList.count;j++){
        NSString *tesFilter = [self.filltereList objectAtIndex:j];
        for (int i=0; i<arraAssignList.count; i++) {
            test = [arrayListUser objectAtIndex:i];
            if ([test isEqualToString:tesFilter]) {
                CustomData *cmd = [[CustomData alloc]init];
                cmd.strId = [[arraAssignList objectAtIndex:i]strId];//
                cmd.strActionLogTitle = [[arraAssignList objectAtIndex:i]strActionLogTitle];
                cmd.strAssigneCompanyId = [[arraAssignList objectAtIndex:i]strAssigneCompanyId];
                cmd.strAssignTo = [[arraAssignList objectAtIndex:i]strAssignTo];
                cmd.strDueDate = [[arraAssignList objectAtIndex:i]strDueDate];
                cmd.strCreatedDate = [[arraAssignList objectAtIndex:i]strCreatedDate];
                cmd.strDashboardDueDate = [[arraAssignList objectAtIndex:i]strDashboardDueDate];
                cmd.strNotesReadStatus = [[arraAssignList objectAtIndex:i]strNotesReadStatus];
                cmd.strRevisedDate = [[arraAssignList objectAtIndex:i]strRevisedDate];
                cmd.strTagId = [[arraAssignList objectAtIndex:i]strTagId];
                cmd.strPercentageCompleted = [[arraAssignList objectAtIndex:i]strPercentageCompleted];
                cmd.strStatus = [[arraAssignList objectAtIndex:i]strStatus];
                cmd.strCreatedBy = [[arraAssignList objectAtIndex:i]strCreatedBy];
                cmd.strNoteCount =[[arraAssignList objectAtIndex:i]strNoteCount];
                cmd.strIsCheck   =[[arraAssignList objectAtIndex:i]strIsCheck];
                [arrayPrint addObject:cmd];
            }
        }
    }
    [table reloadData];
}

- (IBAction)viewNotes:(id)sender{
    UIButton *btnDemo = sender;
    //NSLog(@"Button tag %ld",(long)btnDemo.tag);
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
    cmd.strId =[[arrayPrint objectAtIndex:btnDemo.tag]strId];
    cmd.strColor = [[arrayPrint objectAtIndex:btnDemo.tag]strColor];
    cmd.strRevisedDate = [[arrayPrint objectAtIndex:btnDemo.tag]strRevisedDate];
    cmd.strTagId = [[arrayPrint objectAtIndex:btnDemo.tag]strTagId];
    cmd.strDueDate = [[arrayPrint objectAtIndex:btnDemo.tag]strDueDate];
    //NSLog(@"DUE DATE %@",cmd.strDueDate);
    cmd.strCreatedDate = [[arrayPrint objectAtIndex:btnDemo.tag]strCreatedDate];
    cmd.strDashboardDueDate = [[arrayPrint objectAtIndex:btnDemo.tag]strDashboardDueDate];
    cmd.strRevisedDate = [[arrayPrint objectAtIndex:btnDemo.tag]strRevisedDate];
    cmd.strActionLogTitle = [[arrayPrint objectAtIndex:btnDemo.tag]strActionLogTitle];
    cmd.strAssigneCompanyId = [[arrayPrint objectAtIndex:btnDemo.tag]strAssigneCompanyId];
    cmd.strPercentageCompleted = [[arrayPrint objectAtIndex:btnDemo.tag]strPercentageCompleted];
    cmd.strCreatedDate = [[arrayPrint objectAtIndex:btnDemo.tag]strCreatedDate];
    cmd.strCreatedBy = strCreatedby;//[[arrayPrint objectAtIndex:btnDemo.tag]strCreatedBy];
    cmd.strAssignTo = [[arrayPrint objectAtIndex:btnDemo.tag]strAssignTo];
    cmd.strFrom = @"Archived";
    [array addObject:cmd];
    NSString *strActionLogId = [[arrayPrint objectAtIndex:btnDemo.tag]strId];
    AddSubtask *second=[self.storyboard instantiateViewControllerWithIdentifier:@"addsubtask"];
    second.getActionLogId = strActionLogId;
    second.getActionLogTitle =[[arrayPrint objectAtIndex:btnDemo.tag]strActionLogTitle];
    second.arrayGetDetail = array;
    [self.navigationController pushViewController:second animated:YES];
}

- (IBAction)Back:(id)sender{
    
}

- (IBAction)Companies:(id)sender{
    Companies *second=[self.storyboard instantiateViewControllerWithIdentifier:@"companies"] ;
    [self.navigationController pushViewController:second animated:YES];
    
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
            parameter = [@"status=" stringByAppendingString:@"Deleted"];
            for(int i=0;i<arrayApply.count;i++){
                parameter = [parameter stringByAppendingString:[@"&actionlog_id[]=" stringByAppendingString:[[arrayApply objectAtIndex:i] strId]]];
            }
            
            NSDictionary *dataDictionary = [Methods  WebServerData:urlChangeActionStatus andPostParameter:parameter];
            NSArray *dataAry = [dataDictionary objectForKey:@"info"];
            NSLog(@"Data arry %@",dataAry);
            arrayApply = [[NSMutableArray alloc]init];
            imgChekApply.image = [UIImage imageNamed:@"checkDisbale.png"];
            [self  ResetView];
//            [self WebData];
        }
        alertDelete = 0;
        
    }
    alertDelete = 0;
}

#pragma mark- Add Tag and Search
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
    [self HideDropDownAtAllPlace];
    viewTagSearch.hidden = NO;
    viewTag.hidden = NO;
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"] || [appDelegate.STRUSERTYPE isEqualToString:@"Admin"]){
        viewTagSearch.hidden = YES;
        [self ManageUserTagSearch];
    }
    
}

- (IBAction)SaveTag:(id)sender{
    [self HideDropDownAtAllPlace];
    //[self HideDropDownAtAllPlace];
    [self.view endEditing:YES];
    CustomData *cmd11 = [[CustomData alloc]init];
    int idt = (int)[picker selectedRowInComponent:0] ;
    NSString *StrTag = [arrayPrint1 objectAtIndex:idt];
    int x = 0;
    int y = 0;
    UIFont *fontText = [UIFont systemFontOfSize:14];
    CGSize maximumLabelSize = CGSizeMake(imgBoder.frame.size.width , 20000.0f);
    CGRect textRect = [StrTag boundingRectWithSize:maximumLabelSize
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName:fontText}
                                           context:nil];
    CGSize  size = CGSizeMake(textRect.size.width, textRect.size.height);
    //NSLog(@"Font width %f",size.width);
    //NSLog(@"arrayTesting width %lu",(unsigned long)arrayTesting.count);
    txtTagSearch.text = @"";
    int i = (int)arrayTesting.count;
//  int ibm =(int)arrayTesting.count+1;
    //int TAG = ibm;
    //NSLog(@"arrayTesting width %d",TAG);
    if(arrayTesting.count == 0){
        x= imgBoder.frame.origin.y+5;
        y = imgBoder.frame.origin.y+5;
        if ((imgBoder.frame.size.height+imgBoder.frame.origin.y+30)>viewTag.frame.size.height){
            CGRect fram = viewTag.frame;
            //txtRelationShip.frame.size.height+txtRelationShip.frame.origin.y+10+30
            fram.size.height = imgBoder.frame.origin.y+30+imgBoder.frame.origin.y+10;//viewRelationship.frame.size.height+35;
            viewTag.frame = fram;
        }
    }else{
        CGRect FRAME =  [[arrayTesting objectAtIndex:i-1]FINALFRAMELABLE];
        
        if((FRAME.size.width+FRAME.origin.x+size.width+22)<imgBoder.frame.size.width){
            y = FRAME.origin.y;
            x =(FRAME.size.width+FRAME.origin.x+20);
        }else{
            x= imgBoder.frame.origin.y+5;
            if ((FRAME.size.height+FRAME.origin.y+15+size.width)>viewTag.frame.size.height) {
                CGRect fram = viewTag.frame;
                fram.size.height = viewTag.frame.size.height+38;
                viewTag.frame = fram;
            }
            y =(FRAME.size.height+FRAME.origin.y+12);//(txtRelationShip.frame.size.height+txtRelationShip.frame.origin.y+10));
        }
    }
    UIImageView *imgBoarder = [[UIImageView alloc]init];
    
    UILabel *lblName = [[UILabel alloc]init];
    imgBoarder.frame = CGRectMake(x, y/*20+(25*i)*/,size.width+25, 25.0);
    imgBoarder.image = [UIImage imageNamed:@"tag-bg.png"];
    lblName.frame = CGRectMake(x, y/*20+(25*i)*/,size.width+12, 25.0);
    CGRect FRAMELable = lblName.frame;
    lblName.text =StrTag ;
    //[lblName setBackgroundColor:[Methods colorWithHexString:@"f1f1f1"]];//[UIColor grayColor]];
    //lblName.layer.borderWidth = 1.0;
    
    // lblName.layer.borderColor = [[Methods colorWithHexString:@"b1b1b1"] CGColor];
    //[lblName setFont:[UIFont fontWithName:@"System" size:12]];
    [lblName setFont: [lblName.font fontWithSize: 13]];
    lblName.textAlignment = NSTextAlignmentCenter;
    [viewTag addSubview:imgBoarder];
    [viewTag addSubview:lblName];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(lblName.frame.origin.x+lblName.frame.size.width-4,lblName.frame.origin.y+5/*20+(25*i)*/, 15, 15.0);
    CGRect FRAME = button.frame;
    //  [button setTitle:cmd11.strCatName forState:UIControlStateNormal];
    // [button setTag:TAG];
    //[button setBackgroundColor:[UIColor blueColor]];
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
    //    [button setTag:TAG];
    
    [button setTag:[strDATA intValue]];
    
    cmd11.strCatName = StrTag;
    cmd11.strId = strDATA;//[NSString stringWithFormat:@"%d",TAG];
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
    // viewRelationshipPopup.hidden = YES;
    //[self manageView];
    
}

-(IBAction)AddTag:(id)sender{
    [self HideDropDownAtAllPlace];
    viewTagSearch.hidden = NO;
}

-(IBAction)CloseTag:(id)sender{
    [self HideDropDownAtAllPlace];
    viewTag.hidden = YES;
    viewTagSearch.hidden = YES;
    
    
    if([appDelegate.STRUSERTYPE isEqualToString:@"Staff"]){
        [self ForClose];
        [self Reset:sender];
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
       // [self ForClose];
        // [self Reset:sender];
        [self closeTagManage];
    }
}

- (IBAction)CancelTag:(id)sender{
    [self HideDropDownAtAllPlace];
    viewTagSearch.hidden = YES;
    
}
-(void)myAction:(id)sender{
    UIButton *btnTEst = sender;
    //NSLog(@"Buton tag %ld",(long)btnTEst.tag);
    // NSString *idO = [NSString stringWithFormat:@"%ld",(long)btnTEst.tag];
    int value;
    for (int i =0; i<arrayTesting.count; i++) {
        value = [[[arrayTesting objectAtIndex:i]strId] intValue];
        //NSLog(@"TAG VALUE %d",value);
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
    
    
    //NSLog(@"Array count %lu",(unsigned long)arrayTesting.count);
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
        //NSLog(@"Font width %f",size.width);
        CustomData *cmd = [[CustomData alloc]init];
        if(J == 0){
            x= imgBoder.frame.origin.x +5;
            //y = 12;
            y = imgBoder.frame.origin.y+5;
            if ((imgBoder.frame.origin.y+10+30+imgBoder.frame.origin.y)>viewTag.frame.size.height){
                CGRect fram = viewTag.frame;
                //txtRelationShip.frame.size.height+txtRelationShip.frame.origin.y+10+30
                // fram.size.height = imgBoder.frame.size.height+imgBoder.frame.origin.y+10+30;//viewRelationship.frame.size.height+35;
                fram.size.height = imgBoder.frame.origin.y+30+imgBoder.frame.origin.y+10;
                viewTag.frame = fram;
            }
        }else{
            CGRect FRAME =  [[arrayTesting objectAtIndex:J-1]FINALFRAMELABLE];
            if((FRAME.size.width+FRAME.origin.x+size.width+15+size.width)<imgBoder.frame.size.width){
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
        //[lblName setBackgroundColor:[Methods colorWithHexString:@"f1f1f1"]];//[UIColor grayColor]];
        //lblName.layer.borderWidth = 1.0;
        
        //lblName.layer.borderColor = [[Methods colorWithHexString:@"b1b1b1"] CGColor];
        //[lblName setFont:[UIFont fontWithName:@"System" size:12]];
        [lblName setFont: [lblName.font fontWithSize: 13]];
        lblName.textAlignment = NSTextAlignmentCenter;
        [viewTag addSubview:imgBoarder];
        [viewTag addSubview:lblName];
        
        //int it = [[[arryDemo objectAtIndex:J]strQ1] intValue];
        UIButton *button = [[arrayTesting objectAtIndex:J]btnTESTING];//[UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(lblName.frame.origin.x+lblName.frame.size.width-4,lblName.frame.origin.y+5/*20+(25*i)*/, 15, 15.0);
        CGRect FRAME = button.frame;
        //[button setTitle:[[arrayTesting objectAtIndex:J]strCatName] forState:UIControlStateNormal];
        [button setTag:[[[arrayTesting objectAtIndex:J]strId] intValue]];
        [button addTarget:self action:@selector(myAction:) forControlEvents:UIControlEventTouchUpInside];
        [viewTag addSubview:button];
        cmd.strCatName = [[arrayTesting objectAtIndex:J]strCatName];
        cmd.strId = [[arrayTesting objectAtIndex:J]strId];//[@"Testing " stringByAppendingString:[NSString stringWithFormat:@"%d",J]];
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
        //viewTagSearch.hidden = YES;
    }
    if([appDelegate.STRUSERTYPE isEqualToString:@"Staff"])
        [self PrintTag];
    //[self manageView];
}

-(void)PrintTag{
    // NSString *param= [@"token="stringByAppendingString:appDelegate.STRTOKEN];
    NSString *param= [@"&grid_type=" stringByAppendingString:@"Archived"];
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
    FLAG =@"1";
    of = 0;
    strLoard = @"YES";
//    arrayPrint = [[NSMutableArray alloc]init];
    //NSLog(@"Parameter of tag %@",param);
    [self ManageAtTagTime];
    strTEST = param;
    [self PrintGrid2:param];
    
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
    [self closeTagManage];
}


#pragma -mark Dropdown Delegate102d3f

-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSMutableArray*)arrOptions Option1:(NSMutableArray*)arrOptions1 xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple{
    
    Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions options1:arrOptions1 xy:point size:size isMultiple:isMultiple];
    Dropobj.delegate = self;
    [Dropobj showInView:self.view animated:YES];
    
    /*----------------Set DropDown backGroundColor-----------------*/
    [Dropobj SetBackGroundDropDown_R:245.0 G:245.0 B:245.0 alpha:0.90];
}

- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex{
    /*----------------Get Selected Value[Single selection]-----------------*/
    clickhideDropDown = @"YES";
    //[scroll setContentOffset:CGPointMake(0,0) animated:YES ];
    if([@"Companies" isEqualToString:dropDownSelection]){
        txtSACompany.text = [[arrayCompanies objectAtIndex:anIndex]strPropertyAddress];
        strCompany_Id = [NSString stringWithFormat:@"%@",[[arrayCompanies objectAtIndex:anIndex]strCompanyId]];
        [self ShortDepartment];
    }else if([@"Department" isEqualToString:dropDownSelection]){
        txtSADepartment.text = [[arrayDepartment objectAtIndex:anIndex]strPropertyAddress];
        txtADepartment.text = [NSString stringWithFormat:@"%@",[[arrayDepartment objectAtIndex:anIndex]strPropertyAddress]];
        strDepartment_Id =[NSString stringWithFormat:@"%@",[[arrayDepartment objectAtIndex:anIndex]strDepartmentId]];
    } else if([@"CreatedBy" isEqualToString:dropDownSelection]){
        txtSACreatedBy.text = [[arrayCreatedBy objectAtIndex:anIndex]strPropertyAddress];
        txtACreatedBy.text = [[arrayCreatedBy objectAtIndex:anIndex]strPropertyAddress];
        txtUCreatedBy.text = [[arrayCreatedBy objectAtIndex:anIndex]strPropertyAddress];
        strCreatedBy_Id = [[arrayCreatedBy objectAtIndex:anIndex]strKey];
        
    }else if([@"AssignTo" isEqualToString:dropDownSelection]){
        txtSAAssignTo.text = [[arrayAssignTo objectAtIndex:anIndex]strPropertyAddress];
        txtAAssignTo.text = [[arrayAssignTo objectAtIndex:anIndex]strPropertyAddress];
        txtUAssignTo.text = [[arrayAssignTo objectAtIndex:anIndex]strPropertyAddress];
        strAssignTo_Id = [[arrayAssignTo objectAtIndex:anIndex]strKey];
        //NSLog (@"Assign to %@",strAssignTo_Id);
        
    } else if([@"Stutas" isEqualToString:dropDownSelection]){
        txtSAStatus.text = [[arrayStutas objectAtIndex:anIndex]strPropertyAddress];
     //   txtAStatus.text = [[arrayStutas objectAtIndex:anIndex]strPropertyAddress];
        txtUStatus.text = [[arrayStutas objectAtIndex:anIndex]strPropertyAddress];
    }else if([@"DueDate" isEqualToString:dropDownSelection]){
        txtSADueDate.text = [[arrayDueDate objectAtIndex:anIndex]strPropertyAddress];
        txtSADueDate.text = [[arrayDueDate objectAtIndex:anIndex]strPropertyAddress];
//      txtUDueDate.text = [[arrayDueDate objectAtIndex:anIndex]strPropertyAddress];
    }else if([@"UserList" isEqualToString:dropDownSelection]){
        txtSearchUser.text = [[arrayUserList objectAtIndex:anIndex]strPropertyAddress];
        strUserName_Id = [[arrayUserList objectAtIndex:anIndex]strKey];
    }

    //    Companies
    //    Department
    //    CreatedBy
    //    AssignTo
    //    Stutas
    //    DueDate
    //    [self shortSuburb:txtState.text];
    //     txtReferralType.text = @"";

}

- (void)DropDownListView:(DropDownListView *)dropdownListView Datalist:(NSMutableArray*)ArryData{
    
}
#pragma -mark User define function
-(void)HideDropDownAtAllPlace{
    [self.view endEditing:YES];
    clickhideDropDown = @"YES";
    [Dropobj fadeOut];
}

#pragma mark- User define function
#pragma mark- dropdown selection
- (void)DropDownPicker : (NSString *)title andSelectionArray:(NSMutableArray *)arrayData{
    //[self DropDownPicker:@"Companies" andSelectionArray:arrayCompanies];
//    self.statusPickerView = [[PickerView alloc] init];
    NSLog(@"Title %@",title);
    if (!self.statusPickerView) {
        self.statusPickerView = [[PickerView alloc] initWithHeaderTitle:title values:arrayData];
        self.statusPickerView.delegate = self;
    }
    self.statusPickerView.values = arrayData;
    [self.statusPickerView show];
    
}


#pragma mark- User Define Function

-(void)WebServices{
    AllWebServices *web = [[AllWebServices alloc]init];
    
    NSMutableArray *array = [web WebDashboard];
    urlForApprovalCount = [[array objectAtIndex:0]webForApprvalCount];
    urlCompany = [[array objectAtIndex:0]webCompany];
    urlDepartment = [[array objectAtIndex:0]webDepartment];
    urlCreatedBy= [[array objectAtIndex:0]webCreatedBy];
    urlAssignTo= [[array objectAtIndex:0]webAssignTo];
    urlStatus= [[array objectAtIndex:0]webStatus];
    urlDueDate= [[array objectAtIndex:0]webDueDate];
    urlDueFrom= [[array objectAtIndex:0]webDueFrom];
    urlDueTo= [[array objectAtIndex:0]webDueTo];
    urlDashboard = [[array objectAtIndex:0]webDashboard];
    urlTagList = [[array objectAtIndex:0]webTagList];
    urlChangeActionStatus = [[array objectAtIndex:0]webChangeActionStatus];
}
-(void)loadMore{
   // [self viewMainTable];
    //NSString *parameter = [@"&grid_type=" stringByAppendingString:@"Archived"];
    
    [self PrintGrid2:strTEST];
    //NSLog(@"Loard Data ");
//    NSString *parameter = [@"&grid_type=" stringByAppendingString:[@"Archived" stringByAppendingString:[@"&page_length=10"stringByAppendingString:[@"&page_offset=" stringByAppendingString:FLAG]]]];
//    int idd=[FLAG intValue];
//    idd++;
//    FLAG =[NSString stringWithFormat:@"%d",idd];
//    [self PrintGrid2:parameter];
}

-(void)WebData{
    arrayArchived = [[NSMutableArray alloc]init];
    CustomData *cmd = [[CustomData alloc]init];
    cmd.strPropertyAddress = @"Delete";
    txtArchived.text = @"Delete";
    [arrayArchived addObject:cmd];
    NSString *parameter;
    if([appDelegate.STRUSERTYPE  isEqualToString:@"Admin"] ||[appDelegate.STRUSERTYPE  isEqualToString:@"Super Admin"]){
        parameter = [@"grid_type=" stringByAppendingString:[@"Archived" stringByAppendingString:[@"&assign_to="stringByAppendingString:appDelegate.STRUSERID]]];
        txtAAssignTo.text = appDelegate.STRUSERNAME;
        strAssignTo_Id =appDelegate.STRUSERID;
    }
    else
       parameter = [@"&grid_type=" stringByAppendingString:@"Archived"];
   // NSString *parameter = [@"&grid_type=" stringByAppendingString:[@"Archived" stringByAppendingString:[@"&page_length=10"stringByAppendingString:[@"&page_offset=" stringByAppendingString:FLAG]]]];
   // int idd=[FLAG intValue];
    //idd++;
    //FLAG =[NSString stringWithFormat:@"%d",idd];
     FLAG =@"1";
    of = 0;
    strTEST = parameter;
        [self PrintGrid2:parameter];
}

-(void)PrintGrid1 :(NSString *)parameter{
    NSDictionary *dataDictionary = [Methods  WebServerData:urlDashboard andPostParameter:parameter];
    NSArray *dataAry = [dataDictionary objectForKey:@"info"];
    NSString *strStatus = [dataDictionary objectForKey:@"status"];
    NSLog(@"All data of grid %@",dataAry);
    
    arrayPrint = [[NSMutableArray alloc]init];
    if([strStatus intValue]){
    for (NSDictionary *dic in dataAry) {
        CustomData *cmd = [[CustomData alloc]init];
        cmd.strId = [NSString stringWithFormat:@"%@",[dic valueForKey:@"actionlog_id"]];
        cmd.strActionLogTitle = [NSString stringWithFormat:@"%@",[dic valueForKey:@"actionlog_title"]];
        cmd.strAssignTo = [NSString stringWithFormat:@"%@",[dic valueForKey:@"assigned_to"] ];
        cmd.strDueDate = [NSString stringWithFormat:@"%@",[dic valueForKey:@"duedate"] ];
        
        cmd.strPercentageCompleted = [NSString stringWithFormat:@"%@",[dic valueForKey:@"percentage_compeleted"]];
        cmd.strPercentageCompleted = [cmd.strPercentageCompleted stringByAppendingString:@" %"];
        cmd.strStatus = [NSString stringWithFormat:@"%@",[dic valueForKey:@"actionlog_status"] ];
        cmd.strCreatedBy = [NSString stringWithFormat:@"%@",[dic valueForKey:@"created_by_id"] ];
        cmd.strNoteCount = [NSString stringWithFormat:@"%@",[dic valueForKey:@"notes_count"] ];
        [arrayPrint addObject:cmd];
    }
    }
    //NSLog(@"Array count %@",arrayPrint);
    [table  reloadData];
}
-(void)PrintGrid2 :(NSString *)parameter{
   // of = 0;
    NSString *strOfc = [NSString stringWithFormat:@"%d",of];
    
    //NSLog(@"paramter %@",parameter);
   // parameter = [parameter stringByAppendingString:@"&grid_type=Archived"];
    parameter = [parameter stringByAppendingString:[@"&page_offset=" stringByAppendingString:[strOfc stringByAppendingString:@"&page_length=10"]]];
    NSLog(@"Parameter := %@\n offcet := %d",parameter ,of);
    
    NSDictionary *dataDictionary = [Methods  WebServerData:urlDashboard andPostParameter:parameter];
    NSMutableArray *arrayD= [[NSMutableArray alloc]init];
    NSArray *dataAry = [dataDictionary objectForKey:@"info"];
    NSString *strData = [dataDictionary objectForKey:@"status"];
    // if([appDelegate.ISAPPROVE isEqualToString:@"NO"])
    if([strData intValue]){
        NSLog(@"All data of grid %@ flag %@",dataAry,dataDictionary);
      //  arraApprove = [[NSMutableArray alloc]init];
       // arrayListUserApprove = [[NSMutableArray alloc]init];
        if(of == 0){
            arrayPrint = [[NSMutableArray alloc]init];
            arraAssignList = [[NSMutableArray alloc]init];
            arrayListUser = [[NSMutableArray alloc]init];
        }
        
        for (NSDictionary *dic in dataAry) {
            NSLog(@"Success %@",[dic valueForKey:@"success_message"]);
            
            if([@"No Record found" isEqualToString:[dic valueForKey:@"success_message"]]){
                strLoard = @"NO";
               // [table  reloadData];
//                if(arrayPrint.count == 0){
//                    arrayPrint = [[NSMutableArray alloc]init];
//                    [table  reloadData];
//                }
            }else{
            CustomData *cmd = [[CustomData alloc]init];
            cmd.strId = [NSString stringWithFormat:@"%@",[dic valueForKey:@"actionlog_id"]];
            cmd.strActionLogTitle = [NSString stringWithFormat:@"%@",[dic valueForKey:@"actionlog_title"]];
            cmd.strAssignTo = [NSString stringWithFormat:@"%@",[dic valueForKey:@"assigned_to"] ];
            // cmd.strDueDate = [NSString stringWithFormat:@"%@",[dic valueForKey:@"duedate"] ];
            //cmd.strCreatedDate  = [NSString stringWithFormat:@"%@",[dic valueForKey:@"created_date"]];
            cmd.strPercentageCompleted = [NSString stringWithFormat:@"%@",[dic valueForKey:@"percentage_compeleted"]];
            cmd.strPercentageCompleted = [cmd.strPercentageCompleted stringByAppendingString:@" %"];
            cmd.strStatus = [NSString stringWithFormat:@"%@",[dic valueForKey:@"actionlog_status"] ];
            cmd.strCreatedBy = [NSString stringWithFormat:@"%@",[dic valueForKey:@"created_by_id"] ];
            cmd.strNoteCount = [NSString stringWithFormat:@"%@",[dic valueForKey:@"notes_count"] ];
//            if([appDelegate.STRUSERTYPE  isEqualToString:@"Super Admin"]){
//                if(btnCheckAll.tag == 1){
//                    cmd.strIsCheck   = @"YES";
//                }else
//                    cmd.strIsCheck   = @"NO";
//            }
                cmd.strIsCheck   = @"NO";
            cmd.strRevisedDate = [NSString stringWithFormat:@"%@",[dic valueForKey:@"revised_date"]];
            
            cmd.strColor = [NSString stringWithFormat:@"%@",[dic valueForKey:@"duedate_color"]];

            
            NSString *datatt= @"yyyy-MM-dd HH-mm-ss";
            //NSLog(@"@All Data := %@",[Methods DateWithFormate:[dic valueForKey:@"created_date"] andCurrentFormate:appDelegate.STRWEBDATEFORMATE andNewFormateDate:appDelegate.STRDATEFORMATE]);
            
                
                cmd.strAssigneCompanyId = [dic valueForKey:@"assignee_company_id"];
                cmd.strDueDate =[dic valueForKey:@"duedate"];
                cmd.strCreatedDate =[dic valueForKey:@"created_date"];
                cmd.strRevisedDate =[dic valueForKey:@"revised_date"] ;
                cmd.strDashboardDueDate = [dic valueForKey:@"dashboard_duedate"];
                cmd.strTagId = [dic valueForKey:@"tags_id"];
                
                cmd.strDueDate=[dic valueForKey:@"duedate"];
                cmd.strWorkDate = [dic valueForKey:@"work_date"];
                cmd.strWorkDateColor = [dic valueForKey:@"workdate_color"];
                cmd.strRevisedDate =[dic valueForKey:@"revised_date"] ;
                cmd.strReviceDateColor =[dic valueForKey:@"revicedate_color"] ;
                cmd.strDashboardDueDate = [dic valueForKey:@"dashboard_duedate"];
                cmd.strAssignyId = [dic valueForKey:@"assignee_id"];

                
//            cmd.strCreatedDate =[Methods DateWithFormate:[dic valueForKey:@"created_date"] andCurrentFormate:datatt andNewFormateDate:appDelegate.STRDATEFORMATE];
//            
//            if([@"Empty" isEqualToString:[dic valueForKey:@"duedate"]] || [[dic valueForKey:@"duedate"] isEqual:[NSNull null]] || [@"<null" isEqualToString:[dic valueForKey:@"duedate"]]){
//                cmd.strDueDate =@"No Revised Date";
//            }else{
//                datatt= @"yyyy-MM-dd HH-mm-ss";
//                cmd.strDueDate =[Methods DateWithFormate:[dic valueForKey:@"duedate"] andCurrentFormate:datatt andNewFormateDate:appDelegate.STRDATEFORMATE];
//            }
//            
//            
//            if([@"Empty" isEqualToString:[dic valueForKey:@"revised_date"]] || [[dic valueForKey:@"revised_date"] isEqual:[NSNull null]] || [@"<null" isEqualToString:[dic valueForKey:@"revised_date"]]){
//                cmd.strRevisedDate =@"No Revised Date";
//            }else{
//                datatt= @"yyyy-MM-dd HH-mm-ss";
//                cmd.strRevisedDate =[Methods DateWithFormate:[dic valueForKey:@"revised_date"] andCurrentFormate:datatt andNewFormateDate:appDelegate.STRDATEFORMATE];
//            }
//            if([@"Empty" isEqualToString:[dic valueForKey:@"dashboard_duedate"]] || [[dic valueForKey:@"dashboard_duedate"] isEqual:[NSNull null]] || [@"<null" isEqualToString:[dic valueForKey:@"dashboard_duedate"]]){
//                cmd.strDashboardDueDate =@"No Revised Date";
//            }else{
//                datatt= @"yyyy-MM-dd HH-mm-ss";
//                cmd.strDashboardDueDate =[Methods DateWithFormate:[dic valueForKey:@"dashboard_duedate"] andCurrentFormate:datatt andNewFormateDate:appDelegate.STRDATEFORMATE];
//            }
//            if([[NSString stringWithFormat:@"%@",[dic valueForKey:@"percentage_compeleted"]]isEqualToString:@"100"]){
//                if([[NSString stringWithFormat:@"%@",[dic valueForKey:@"percentage_compeleted"]]isEqualToString:@"100"] && [appDelegate.STRUSERID isEqualToString:[dic valueForKey:@"created_by_id"]] && [[dic valueForKey:@"actionlog_status"] isEqualToString:@"Completed"]){
//                    //  [arrayPrint addObject:cmd];
//                  //  [arraApprove addObject:cmd];
//                   // [arrayListUserApprove addObject:cmd.strActionLogTitle];
//                }
//            }else{
//                //  [arrayPrint addObject:cmd];
//              //  [arraAssignList addObject:cmd];
//                //[arrayListUser addObject:cmd.strActionLogTitle];
//            }
            [arrayD addObject:cmd];
            [arraAssignList addObject:cmd];
            [arrayListUser addObject:cmd.strActionLogTitle];
            //if([FLAG isEqualToString:@"1"])
                [arrayPrint addObject:cmd];
        }
        }
        of+=10;
        if(arrayPrint.count<of){
            strLoard = @"NO";
        }
        NSLog(@"OF %d",of);
        [table  reloadData];
        [self stopGIFTable];

    }else{
    arrayPrint = [[NSMutableArray alloc]init];
        [table  reloadData];
    }
//    if([FLAG isEqualToString:@"1"])
//        [table  reloadData];
//    else{
//        NSMutableArray *tempArray = [NSMutableArray new];
//        for (int i = 0; i < arrayD.count; i++) {
//            [arrayPrint insertObject:arrayD[i] atIndex:0];
//            
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:i];
//            [tempArray insertObject:indexPath atIndex:0];
//        }
//        
//    [UIView setAnimationsEnabled:NO];
//    [table beginUpdates];
//
//    [table insertRowsAtIndexPaths:tempArray withRowAnimation:UITableViewRowAnimationNone];
//    [table endUpdates];
//    [UIView setAnimationsEnabled:YES];
//    [refreshControl endRefreshing];
//    }
}


- (void)pickerChanged:(id)sender{
    if (DATA == 1) {
        [NSTimeZone resetSystemTimeZone];
        dateFormat.dateStyle=NSDateFormatterMediumStyle;
        [dateFormat setDateFormat:@"dd-MMM-yyyy"];
        //NSString *fromDay = [NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:[sender date]]];
        //txtRemainderDate.text = fromDay;
    }else{
        [NSTimeZone resetSystemTimeZone];
        dateFormat.dateStyle=NSDateFormatterMediumStyle;
        [dateFormat setDateFormat:@"h:mm:a"];
        //  NSString *fromDay = [NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:[sender date]]];
        // txtRemaiunderTime.text = fromDay;
    }
}

//-(void)manageUser{
//    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
//        viewTab.hidden = YES;
//        viewAdminTab.hidden = YES;
//        viewSuperAdminTab.hidden = NO;
//
//    }else if([appDelegate.STRUSERTYPE isEqualToString:@"Admin"]){
//        viewTab.hidden = YES;
//        viewAdminTab.hidden = NO;
//        viewSuperAdminTab.hidden = YES;
//    
//    }else if([appDelegate.STRUSERTYPE isEqualToString:@"User"]){
//        viewTab.hidden = NO;
//        viewAdminTab.hidden = YES;
//        viewSuperAdminTab.hidden = YES;
//    
//    }
//}

-(void)AdvanceSearchManage{
   // lblAdvanceSearchCollaps.text = @"Collapse Search";
    
    viewSearchData.hidden = NO;
    
    CGRect Frame = viewFull.frame;
    Frame.origin.y  = viewAdvanceSearch.frame.origin.y;
    Frame.size.height = viewFullAll.frame.size.height;
    viewFull.frame = Frame;
    
    Frame = viewListAction.frame;
    Frame.origin.y = (viewSearchData.frame.origin.y+viewSearchData.frame.size.height);
    Frame.size.height =(viewFull.frame.size.height)-(viewSearchData.frame.origin.y+viewSearchData.frame.size.height+5);//-viewAction.frame.size.height;
   
    viewListAction.frame = Frame;
    
    CGRect frameTable = table.frame;
    frameTable.origin.y =  10;
    frameTable.size.height = viewListAction.frame.size.height-20;
    table.frame = frameTable;
    
    /*
    CGRect Frame = viewFull.frame;
    Frame.origin.y = 0;
    Frame.size.height = viewAction.frame.origin.y-(viewFullAll.frame.origin.y);
    viewFull.frame = Frame;
    
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
        CGRect Frame = viewListAction.frame;
        Frame.origin.y = (viewSuperAdminSearch.frame.origin.y+viewSuperAdminSearch.frame.size.height);
        Frame.size.height =(viewFull.frame.size.height)-(viewSuperAdminSearch.frame.origin.y+viewSuperAdminSearch.frame.size.height);
        viewListAction.frame = Frame;
        
        CGRect frameTable = table.frame;
        frameTable.origin.y =  10;
        frameTable.size.height = viewListAction.frame.size.height-20;
        table.frame = frameTable;
        
    }else if([appDelegate.STRUSERTYPE isEqualToString:@"Admin"]){
        CGRect Frame = viewListAction.frame;
        Frame.origin.y = (viewAdminSearch.frame.origin.y+viewAdminSearch.frame.size.height);
        Frame.size.height =(viewFull.frame.size.height)-(viewAdminSearch.frame.origin.y+viewAdminSearch.frame.size.height);
        viewListAction.frame = Frame;
        
        CGRect frameTable = table.frame;
        frameTable.origin.y =  10;
        frameTable.size.height = viewListAction.frame.size.height-20;
        table.frame = frameTable;
        
    }else if([appDelegate.STRUSERTYPE isEqualToString:@"Staff"]){
        CGRect Frame = viewListAction.frame;
        Frame.origin.y = (viewSearch.frame.origin.y+viewSearch.frame.size.height);
        Frame.size.height =(viewFull.frame.size.height)-(viewSearch.frame.origin.y+viewSearch.frame.size.height);
        viewListAction.frame = Frame;
        
        CGRect frameTable = table.frame;
        frameTable.origin.y =  10;
        frameTable.size.height = viewListAction.frame.size.height-20;
        table.frame = frameTable;
    }
     */
}

-(void)ManageAtTagTime{
    {
        //        viewAction.hidden = NO;
        if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
            
            CGRect Frame = viewSearchButton.frame;
            Frame.origin.y = viewTag.frame.origin.y+viewTag.frame.size.height;//(viewAdvanceSearch.frame.origin.y+viewAdvanceSearch.frame.size.height);
            //Frame.size.height = viewTab.frame.origin.y- (viewTag.frame.origin.y+viewTag.frame.size.height+5+viewFullAll.frame.origin.y);
            viewSearchButton.frame = Frame;
            
            Frame = viewFull.frame;
            Frame.origin.y = viewSearchButton.frame.origin.y+viewSearchButton.frame.size.height;//(viewAdvanceSearch.frame.origin.y+viewAdvanceSearch.frame.size.height);
            Frame.size.height = viewSuperAdminTab.frame.origin.y- (viewSearchButton.frame.origin.y+viewSearchButton.frame.size.height+5+viewFullAll.frame.origin.y);
            viewFull.frame = Frame;
            //
            //            CGRect frameTable = table.frame;
            //            frameTable.origin.y =  10;
            //            frameTable.size.height = viewListAction.frame.size.height-10;
            //            table.frame = frameTable;
            
        }else if([appDelegate.STRUSERTYPE isEqualToString:@"Admin"]){
            CGRect Frame = viewSearchButton.frame;
            Frame.origin.y = viewTag.frame.origin.y+viewTag.frame.size.height;//(viewAdvanceSearch.frame.origin.y+viewAdvanceSearch.frame.size.height);
            //Frame.size.height = viewTab.frame.origin.y- (viewTag.frame.origin.y+viewTag.frame.size.height+5+viewFullAll.frame.origin.y);
            viewSearchButton.frame = Frame;
            
            Frame = viewFull.frame;
            Frame.origin.y = viewSearchButton.frame.origin.y+viewSearchButton.frame.size.height;//(viewAdvanceSearch.frame.origin.y+viewAdvanceSearch.frame.size.height);
            Frame.size.height = viewAdminTab.frame.origin.y- (viewSearchButton.frame.origin.y+viewSearchButton.frame.size.height+5+viewFullAll.frame.origin.y);
            viewFull.frame = Frame;
            
            //
            //            CGRect frameTable = table.frame;
            //            frameTable.origin.y =  10;
            //            frameTable.size.height = viewListAction.frame.size.height-10;
            //            table.frame = frameTable;
            
            
        }else if([appDelegate.STRUSERTYPE isEqualToString:@"Staff"]){
            CGRect Frame = viewFull.frame;
            Frame.origin.y = viewTag.frame.origin.y+viewTag.frame.size.height;//(viewAdvanceSearch.frame.origin.y+viewAdvanceSearch.frame.size.height);
            Frame.size.height = viewTab.frame.origin.y- (viewTag.frame.origin.y+viewTag.frame.size.height+5+viewFullAll.frame.origin.y);
            viewFull.frame = Frame;
            //
            //            CGRect frameTable = table.frame;
            //            frameTable.origin.y =  10;
            //            frameTable.size.height = viewListAction.frame.size.height-10;
            //            table.frame = frameTable;
            
        }//
    }
}
//
-(void)closeTagManage{
    CGRect Frame = viewFull.frame;
    Frame.origin.y = viewAdvanceSearch.frame.origin.y+viewAdvanceSearch.frame.size.height;//(viewAdvanceSearch.frame.origin.y+viewAdvanceSearch.frame.size.height);
    Frame.size.height = viewTab.frame.origin.y- (viewTag.frame.origin.y+viewTag.frame.size.height+5+viewFullAll.frame.origin.y);
    viewFull.frame = Frame;
}

-(void)AdvanceCollapseManage{
    //lblAdvanceSearchCollaps.text = @"Advance Search";
//    CGRect Frame = viewFull.frame;
//    Frame.origin.y = viewAdvanceSearch.frame.size.height+viewAdvanceSearch.frame.origin.y;
//    viewFull.frame = Frame;
//
    
    
    viewSearchData.hidden = YES;
    
    CGRect Frame = viewFull.frame;
    Frame.origin.y = viewAdvanceSearch.frame.size.height+viewAdvanceSearch.frame.origin.y;
    Frame.size.height = viewAction.frame.origin.y-(viewAdvanceSearch.frame.size.height+viewAdvanceSearch.frame.origin.y+viewFullAll.frame.origin.y);
    viewFull.frame = Frame;
    
    
//    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"])
    {
        CGRect Frame = viewListAction.frame;
        Frame.origin.y = 0;//(viewAdvanceSearch.frame.origin.y+viewAdvanceSearch.frame.size.height);
        Frame.size.height =(viewFull.frame.size.height);//-(viewAdvanceSearch.frame.origin.y+viewAdvanceSearch.frame.size.height);
        viewListAction.frame = Frame;
        
        CGRect frameTable = table.frame;
        frameTable.origin.y =  10;
        frameTable.size.height = viewListAction.frame.size.height-20;
        table.frame = frameTable;
        
    }
    
    /*
    viewAction.hidden = NO;
    
    ///// No use
    
    Frame = viewListAction.frame;
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
    CGRect Frame = viewFull.frame;
    Frame.origin.y = viewAdvanceSearch.frame.size.height+viewAdvanceSearch.frame.origin.y;
    Frame.size.height = viewAction.frame.origin.y-(viewAdvanceSearch.frame.size.height+viewAdvanceSearch.frame.origin.y+viewFullAll.frame.origin.y);
    viewFull.frame = Frame;

    
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
        CGRect Frame = viewListAction.frame;
        Frame.origin.y = 0;//(viewAdvanceSearch.frame.origin.y+viewAdvanceSearch.frame.size.height);
        Frame.size.height =(viewFull.frame.size.height);//-(viewAdvanceSearch.frame.origin.y+viewAdvanceSearch.frame.size.height);
        viewListAction.frame = Frame;
        
        CGRect frameTable = table.frame;
        frameTable.origin.y =  10;
        frameTable.size.height = viewListAction.frame.size.height-20;
        table.frame = frameTable;
        
    }else if([appDelegate.STRUSERTYPE isEqualToString:@"Admin"]){
        CGRect Frame = viewListAction.frame;
        Frame.origin.y = 0;//(viewAdvanceSearch.frame.origin.y+viewAdvanceSearch.frame.size.height);
        Frame.size.height =(viewFull.frame.size.height);
        viewListAction.frame = Frame;
        
        CGRect frameTable = table.frame;
        frameTable.origin.y =  10;
        frameTable.size.height = viewListAction.frame.size.height-20;
        table.frame = frameTable;
        
    }else if([appDelegate.STRUSERTYPE isEqualToString:@"Staff"]){
        CGRect Frame = viewListAction.frame;
        Frame.origin.y = 0;//(viewAdvanceSearch.frame.origin.y+viewAdvanceSearch.frame.size.height);
        Frame.size.height =(viewFull.frame.size.height);//-(viewAdvanceSearch.frame.origin.y+viewAdvanceSearch.frame.size.height);
        viewListAction.frame = Frame;
        
        CGRect frameTable = table.frame;
        frameTable.origin.y =  10;
        frameTable.size.height = viewListAction.frame.size.height-20;
        table.frame = frameTable;
    }
     */
}

-(void)manageUser{
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
        viewSuperAdminSearch.hidden = NO;
        viewAdminSearch.hidden = YES;
        viewSearch.hidden = YES;
        
        viewTab.hidden = YES;
        viewAdminTab.hidden = NO;
        viewSuperAdminTab.hidden = YES;
    }else if([appDelegate.STRUSERTYPE isEqualToString:@"Admin"]){
        viewSuperAdminSearch.hidden = YES;
        viewAdminSearch.hidden = NO;
        viewSearch.hidden = YES;
        
        viewTab.hidden = YES;
        viewAdminTab.hidden = NO;
        viewSuperAdminTab.hidden = YES;
    }else if([appDelegate.STRUSERTYPE isEqualToString:@"Staff"]){
        viewSuperAdminSearch.hidden = YES;
        viewAdminSearch.hidden = YES;
        viewSearch.hidden = NO;
        viewTab.hidden = NO;
        viewAdminTab.hidden = YES;
        viewSuperAdminTab.hidden = YES;
    }
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


-(void)GetCompany{
    if(appDelegate.ARRAYCOMPANY.count == 0){
        NSDictionary *dataDictionary = [Methods  WebServerData:urlCompany ];
        NSArray *keys;
        int i, count;
        id key, value;
        arrayCompanies = [[NSMutableArray alloc]init];
        NSDictionary *dict = [dataDictionary objectForKey:@"info"];
        keys = [dict allKeys];
        count =(int)[keys count];
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
    }else
        arrayCompanies = [[NSMutableArray alloc]initWithArray:appDelegate.ARRAYCOMPANY];
    
}

-(void)GetDepartment{
    
    if(appDelegate.ARRAYDEPARTMENT.count==0){
        if(appDelegate.ARRAYDEPARTMENT.count==0){
            //  NSString *parameter = [@"token=" stringByAppendingString:appDelegate.STRTOKEN];
            NSDictionary *dataDictionary = [Methods  WebServerData:urlDepartment];
            //NSLog(@"Department url  no parameter :- %@ ",urlDepartment);
            NSArray *dataAry = [dataDictionary objectForKey:@"info"];
            NSLog(@"Department url  no parameter :- %@ ",dataAry);
            arrayDepartment = [[NSMutableArray alloc]init];
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
        }
    } else{
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
    //
    if(appDelegate.ARRAYASSIGNTO.count ==0){
        NSDictionary *dataDictionary = [Methods  WebServerData:urlAssignTo];
        NSArray *keys;
        int i, count;
        id key, value;
        arrayAssignTo = [[NSMutableArray alloc]init];
        arrayCreatedBy = [[NSMutableArray alloc]init];
        arrayUserList = [[NSMutableArray alloc]init];
        NSDictionary *dict = [dataDictionary objectForKey:@"info"];
        keys = [dict allKeys];
        count =(int)[keys count];
        for (i = 0; i < count; i++){
            CustomData *cmd = [[CustomData alloc]init];
            key = [keys objectAtIndex: i];
            value = [dict objectForKey: key];
            cmd.strKey =[NSString stringWithFormat:@"%@",key];
            cmd.strStatus =[NSString stringWithFormat:@"%@",value];
            cmd.strPropertyAddress =[NSString stringWithFormat:@"%@",value];
            [arrayCreatedBy addObject:cmd];
            [arrayAssignTo addObject:cmd];
            [appDelegate.ARRAYASSIGNTO addObject:cmd];
        }
    }else{
        arrayCreatedBy = [NSMutableArray arrayWithArray:appDelegate.ARRAYCREATEDBY];
        arrayAssignTo = [[NSMutableArray alloc]initWithArray:appDelegate.ARRAYASSIGNTO];
        arrayUserList = [[NSMutableArray alloc]initWithArray:appDelegate.ARRAYUSERLIST];
    }
}

-(void)GetStatus{
    NSDictionary *dataDictionary = [Methods  WebServerData:urlStatus];
    
    NSArray *dataAry = [dataDictionary objectForKey:@"info"];
    // NSLog(@"Status %@",dataAry);
    arrayStutas = [[NSMutableArray alloc]init];
    for (int i =3 ; i<5; i++) {
        CustomData *cmd = [[CustomData alloc] init];
        cmd.strId = [NSString stringWithFormat:@"%d",i];
        cmd.strStatus = dataAry[i];
        cmd.strPropertyAddress = dataAry[i];
        [arrayStutas addObject:cmd];
        //NSLog(@"Status %@",dataAry[i]);
    }
}


-(void)GetTag{
    if (appDelegate.ARRAYTAG.count==0||appDelegate.ARRAYTAGVALUE.count==0) {
        
        NSDictionary *dataDictionary = [Methods  WebServerData:urlTagList];
        arrayTag = [[NSMutableArray alloc]init];
        arrayPrint1 = [[NSMutableArray alloc]init];
        arrayPrint11 = [[NSMutableArray alloc]init];
        NSArray *keys;
        int i, count;
        id key, value;
        NSDictionary *dict = [dataDictionary objectForKey:@"info"];
        keys = [dict allKeys];
        count =(int)[keys count];
        for (i = 0; i < count; i++){
            CustomData *cmd = [[CustomData alloc]init];
            key = [keys objectAtIndex: i];
            value = [dict objectForKey: key];
            cmd.strKey =[NSString stringWithFormat:@"%@",key];
            cmd.strStatus =[NSString stringWithFormat:@"%@",value];
            cmd.strPropertyAddress =[NSString stringWithFormat:@"%@",value];
            [arrayTag addObject:cmd];
            [appDelegate.ARRAYTAG addObject:cmd];
            [arrayPrint1 addObject:value];
            [appDelegate.ARRAYTAGVALUE addObject:value];
            [arrayPrint11 addObject:value];
        }
    }else{
        arrayTag = [[NSMutableArray alloc]initWithArray:appDelegate.ARRAYTAG];
        arrayPrint1 = [[NSMutableArray alloc]initWithArray:appDelegate.ARRAYTAGVALUE];
        arrayPrint11 = [[NSMutableArray alloc]initWithArray:appDelegate.ARRAYTAGVALUE];
    }
    [picker reloadAllComponents];
}


-(void)GetOverDue{
    if(appDelegate.ARRAYOVERDUE.count ==0){
        NSDictionary *dataDictionary = [Methods  WebServerData:urlDueDate];
    
        NSArray *dataAry = [dataDictionary objectForKey:@"info"];
        arrayDueDate = [[NSMutableArray alloc]init];
        for (int i =0 ; i<dataAry.count; i++) {
            CustomData *cmd = [[CustomData alloc] init];
            cmd.strId = [NSString stringWithFormat:@"%d",i];
            cmd.strStatus = dataAry[i];
            cmd.strPropertyAddress = dataAry[i];
            [arrayDueDate addObject:cmd];
            [appDelegate.ARRAYOVERDUE addObject:cmd];
        }
    }else
        arrayDueDate = [[NSMutableArray alloc]initWithArray:appDelegate.ARRAYOVERDUE];

    
}

-(void)showUiAlertWithMessage:(NSString *)message andtitle:(NSString *)title{
    UIAlertView *obj=[[UIAlertView alloc]initWithTitle:@""
                                               message:message
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles: nil];
    [obj show];
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

#pragma -mark UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if(textField.tag == 100){
        of=0;
        arrayPrint = [[NSMutableArray alloc]init];
        arraAssignList = [[NSMutableArray alloc]init];
        arrayListUser = [[NSMutableArray alloc]init];
        NSString *parameter = [@"grid_type=" stringByAppendingString:[@"Archived" stringByAppendingString:[@"&search=" stringByAppendingString:txtSearchTitle.text]]];
        strTEST = parameter;
        strLoard = @"YES";
        [self PrintGrid2:parameter];
    }
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
