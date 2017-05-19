//
//  Companies.m
    //  ActionLog
//
//  Created by Hardik Davda on 9/14/16.
//  Copyright © 2016 SLP-World. All rights reserved.
//

#import "Companies.h"
#import "CustomDataform.h"
#import "CustomCellAdvanceSearch.h"

#import "PickerView.h"

@interface Companies ()<CZPickerViewDelegate>{
    UIView *nomatchesView;
    UIView *viewBackGround;
    UIView *viewLoader;
    NSTimer *timer;
    NSMutableArray *arraySubtask;
    NSMutableArray *arrayStutas;
    NSMutableArray *arrayDueDate;
    NSString *LoginData;
    NSString *managePicker;
    CustomDataform *web;// = [[CustomDataform alloc]init];
    
}
@property (nonatomic) PickerView *statusPickerView;

@end

@implementation Companies

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    web = [[CustomDataform alloc]init];
    arraySubtask = [[NSMutableArray alloc]init];
    
    LoginData = @"SuperAdmin";
//    if([LoginData isEqualToString:@"SuperAdmin"]){
//        arraySubtask = [web AdvanceSearchSuperAdminData];
//    }else if ([LoginData isEqualToString:@"Admin"]){
//        arraySubtask = [web AdvanceSearchAdmnData];
//    }else{
//        arraySubtask = [web AdvanceSearchStaffData];
//    }
    [self GetStatus];
    [self GetOverDue];
    
//    arraySubtask = [CustomDataform AdvanceSearchData];
    
     [table reloadData];
    [self manageView];
    
    // Do any additional setup after loading the view.
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    
    // [self setNeedsStatusBarAppearanceUpdate];
    return UIStatusBarStyleLightContent;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  // timer = [NSTimer scheduledTimerWithTimeInterval:.000001 target:self selector:@selector(initialize) userInfo:nil repeats:NO];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(stopGIF) userInfo:nil repeats:NO];
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{              // Default is 1 if not implemented
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arraySubtask.count;
}
- (void)setUpCellForSuperAdmin:(CustomCellAdvanceSearch *)cell atIndexPath:(NSIndexPath *)indexPath {
    
        if (indexPath.row == 0){
//            cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            //    cell.txtSubTask.text = [[arraySubtask objectAtIndex:indexPath.section]strSubtask];
            cell.txtFilter.placeholder = [[arraySubtask objectAtIndex:indexPath.row]strPlaceholder];
        
            cell.txtFilter.text = [[arraySubtask objectAtIndex:indexPath.row]strSelectedValue];
            
            NSLog(@"%@",[[arraySubtask objectAtIndex:indexPath.row]strPlaceholder]);
            cell.txtFilter.tag = indexPath.section;
            cell.btnOne.tag = [[arraySubtask objectAtIndex:indexPath.row]btnTag];
    
        }else
    {
//        cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        //    cell.txtSubTask.text = [[arraySubtask objectAtIndex:indexPath.section]strSubtask];
        cell.txtFilter.placeholder = [[arraySubtask objectAtIndex:indexPath.row]strPlaceholder];
        cell.txtFilter1.placeholder = [[arraySubtask objectAtIndex:indexPath.row]strPlaceholder1];
     
        
        cell.txtFilter.text = [[arraySubtask objectAtIndex:indexPath.row]strSelectedValue];
        cell.txtFilter1.text = [[arraySubtask objectAtIndex:indexPath.row]strSelectedValue1];
        
        cell.btnOne.tag = [[arraySubtask objectAtIndex:indexPath.row]btnTag];
        cell.btnTwo.tag = [[arraySubtask objectAtIndex:indexPath.row]btnTag1];
        NSLog(@"%@",[[arraySubtask objectAtIndex:indexPath.row]strPlaceholder]);
        cell.txtFilter.tag = indexPath.section;
    }
}

- (void)setUpCellForAdmin:(CustomCellAdvanceSearch *)cell atIndexPath:(NSIndexPath *)indexPath {
    //    cell.txtSubTask.text = [[arraySubtask objectAtIndex:indexPath.section]strSubtask];
    cell.txtFilter.placeholder = [[arraySubtask objectAtIndex:indexPath.row]strPlaceholder];
    cell.txtFilter1.placeholder = [[arraySubtask objectAtIndex:indexPath.row]strSelectedValue];
    
    cell.txtFilter.text = [[arraySubtask objectAtIndex:indexPath.row]strSelectedValue];
    cell.txtFilter1.text = [[arraySubtask objectAtIndex:indexPath.row]strSelectedValue1];
    
    
    cell.btnOne.tag = [[arraySubtask objectAtIndex:indexPath.row]btnTag];
    cell.btnTwo.tag = [[arraySubtask objectAtIndex:indexPath.row]btnTag1];

    NSLog(@"%@",[[arraySubtask objectAtIndex:indexPath.row]strPlaceholder]);
    cell.txtFilter.tag = indexPath.section;
}

- (void)setUpCellForStaff:(CustomCellAdvanceSearch *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.txtFilter.placeholder = [[arraySubtask objectAtIndex:indexPath.row]strPlaceholder];
    cell.txtFilter1.placeholder = [[arraySubtask objectAtIndex:indexPath.row]strPlaceholder1];
    
    cell.txtFilter.text = [[arraySubtask objectAtIndex:indexPath.row]strSelectedValue];
    cell.txtFilter1.text = [[arraySubtask objectAtIndex:indexPath.row]strSelectedValue1];
    
    cell.btnOne.tag = [[arraySubtask objectAtIndex:indexPath.row]btnTag];
    cell.btnTwo.tag = [[arraySubtask objectAtIndex:indexPath.row]btnTag1];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomCellAdvanceSearch *cell;
    if ([LoginData isEqualToString:@"SuperAdmin"]){
        if (indexPath.row == 0){
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        }
        [self setUpCellForSuperAdmin:cell atIndexPath:indexPath];
    }
    else if ([LoginData isEqualToString:@"Admin"]){
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        [self setUpCellForAdmin:cell atIndexPath:indexPath];
    }else if([LoginData isEqualToString:@"Staff"]){
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        [self setUpCellForStaff:cell atIndexPath:indexPath];
    }
//    [self setUpCellForSuperAdmin:cell atIndexPath:indexPath];
    
//    if (indexPath.row == 0){
//        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//        //    cell.txtSubTask.text = [[arraySubtask objectAtIndex:indexPath.section]strSubtask];
//        cell.txtFilter.placeholder = [[arraySubtask objectAtIndex:indexPath.row]strPlaceholder];
//        NSLog(@"%@",[[arraySubtask objectAtIndex:indexPath.row]strPlaceholder]);
//        cell.txtFilter.tag = indexPath.section;
//        
//    }else
//    {
//        cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
//    //    cell.txtSubTask.text = [[arraySubtask objectAtIndex:indexPath.section]strSubtask];
//        cell.txtFilter.placeholder = [[arraySubtask objectAtIndex:indexPath.row]strPlaceholder];
//        cell.txtFilter1.placeholder = [[arraySubtask objectAtIndex:indexPath.row]strPlaceholder1];
//        NSLog(@"%@",[[arraySubtask objectAtIndex:indexPath.row]strPlaceholder]);
//        cell.txtFilter.tag = indexPath.section;
//    }
    return  cell;
}

#pragma -mark UITableview Delegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return  indexPath;
}

#pragma -mark Button IBAction (click Events)

- (IBAction)AddCompany:(id)sender{
    
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

-(void)manageView{
    CGRect fram = table.frame;
    fram.size.height = table.contentSize.height+10;
    table.frame =  fram;
    
    fram = viewTab.frame;
    fram.origin.y = table.frame.origin.y+table.frame.size.height;
    viewTab.frame = fram;
    
}


#pragma mark- Picker View Delegate
/** delegate method for picking one item */
- (void)czpickerView:(PickerView *)pickerView didConfirmWithItemAtRow:(NSInteger)row {
    if ([managePicker isEqualToString:@"Date"])
    {
        NSLog(@"Selected rows: %@", [[arrayDueDate objectAtIndex:row]strPropertyAddress]);
        [self ReloadCell:11 andvalueOfString:[[arrayDueDate objectAtIndex:row]strPropertyAddress]];

    }else{
          NSLog(@"Selected rows: %@", [[arrayStutas objectAtIndex:row]strPropertyAddress]);
        [self ReloadCell:10 andvalueOfString:[[arrayStutas objectAtIndex:row]strPropertyAddress]];
    }

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
            [self ReloadCell:1 andvalueOfString:@"get It"];
            break;
        
        case 2:
            NSLog(@"Departments ");
             [self ReloadCell:2 andvalueOfString:@"get It"];
            break;
        
        case 3:
            NSLog(@"Created By ");
             [self ReloadCell:3 andvalueOfString:@"get It"];
            break;
        
        case 4:
            NSLog(@" Assign To");
             [self ReloadCell:4 andvalueOfString:@"get It"];
            break;
        
        case 5:
            NSLog(@" Status");
             [self ReloadCell:5 andvalueOfString:@"get It"];
            break;
        
        case 6:
            NSLog(@" All(Due)");
             [self ReloadCell:6 andvalueOfString:@"get It"];
            break;
        
        case 7:
            NSLog(@"All(Work) ");
             [self ReloadCell:7 andvalueOfString:@"get It"];
            break;
        
        case 8:
            NSLog(@" Work From Date");
             [self ReloadCell:8 andvalueOfString:@"get It"];
            break;
        
        case 9:
            NSLog(@" Work To Date");
             [self ReloadCell:9 andvalueOfString:@"get It"];
            break;
        
        case 10:
            NSLog(@" Due From Date");
            managePicker = @"Status";
            if (!self.statusPickerView) {
                self.statusPickerView = [[PickerView alloc] initWithHeaderTitle:@"Statuses" values:arrayStutas];
                self.statusPickerView.delegate = self;
            }
            self.statusPickerView.values = arrayStutas;
            [self.statusPickerView show];
//            [self ReloadCell:10 andvalueOfString:@"get It"];
            
            break;

        case 11:
            NSLog(@" Due To Date");
            managePicker = @"Date";
            if (!self.statusPickerView) {
                self.statusPickerView = [[PickerView alloc] initWithHeaderTitle:@"DueDate" values:arrayDueDate];
                self.statusPickerView.delegate = self;
            }
            self.statusPickerView.values = arrayDueDate;
            [self.statusPickerView show];
//             [self ReloadCell:11 andvalueOfString:@"get It"];
            break;
            
        default:
            NSLog(@" Not Identyfy");
             [self ReloadCell:1 andvalueOfString:@"get It"];
            break;
    }
    if(btn.tag == 0){
    
    }
}

-(void)ReloadCell:(int) rowNumber andvalueOfString:(NSString *)dataValue{
    int idt = 0;
    for (int i = 0;i<arraySubtask.count;i++){
        if([[arraySubtask objectAtIndex:i]btnTag] == rowNumber){
            CustomDataform *cmd = [[CustomDataform alloc]init];
            cmd = [arraySubtask objectAtIndex:i];
            cmd.strSelectedValue = dataValue;//@"Final it ";
            [arraySubtask removeObjectAtIndex:i];
            [arraySubtask insertObject:cmd atIndex:i];
            idt = i;
            break;
        }if ([[arraySubtask objectAtIndex:i]btnTag1] == rowNumber) {
            CustomDataform *cmd = [[CustomDataform alloc]init];
            cmd = [arraySubtask objectAtIndex:i];
            cmd.strSelectedValue1 = dataValue;//@"Final it ";
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
    [table reloadRowsAtIndexPaths:rowsToReload2 withRowAnimation:UITableViewRowAnimationNone];
}

- (IBAction)Add2:(id)sender{
    
}

- (IBAction)Add3:(id)sender{
    
}



- (IBAction)searchStatus:(id)sender{
    
}

- (IBAction)back:(id)sender{
    
}
- (IBAction)MinuesSubTask:(id)sender{
    UIButton *btn = sender;
    int i = (int)btn.tag;
    [arraySubtask removeObjectAtIndex:i];
    
     [table reloadData];
}

- (IBAction)AddSubTask:(id)sender{
    CustomData *cmd = [[CustomData alloc]init];
    cmd.strSubtask = @"";
    cmd.strPlaceHolder = @"Please Enter Sub Task";
    [arraySubtask addObject:cmd];
    [table reloadData];
}

- (IBAction)Dashboard:(id)sender{
    Dashboard *second=[self.storyboard instantiateViewControllerWithIdentifier:@"dashboard"] ;
    [self.navigationController pushViewController:second animated:YES];
    
}

- (IBAction)Archived:(id)sender{

    arraySubtask = [[NSMutableArray alloc]init];
    
//    if([LoginData isEqualToString:@"SuperAdmin"]){
//        arraySubtask = [web AdvanceSearchSuperAdminData];
//    }else if ([LoginData isEqualToString:@"Admin"]){
//        arraySubtask = [web AdvanceSearchAdmnData];
//    }else{
//        arraySubtask = [web AdvanceSearchStaffData];
//    }
    [table reloadData];
//    [self manageView];
    
//    Archived *second=[self.storyboard instantiateViewControllerWithIdentifier:@"archived"] ;
//    [self.navigationController pushViewController:second animated:YES];
}

- (IBAction)Companies:(id)sender{
    Companies *second=[self.storyboard instantiateViewControllerWithIdentifier:@"companies"] ;
    [self.navigationController pushViewController:second animated:YES];
    
}

- (IBAction)User:(id)sender{
    Users *second=[self.storyboard instantiateViewControllerWithIdentifier:@"users"] ;
    [self.navigationController pushViewController:second animated:YES];
    
}

-(void)GetOverDue{
    Methods = [[AllMethods alloc]init];
    NSDictionary *dataDictionary = [Methods  WebServerData:[appDelegate.WEBPATH stringByAppendingString:@"actionlog/getActionLogOverdueList"]];
    bool status = [[dataDictionary objectForKey:@"status"]boolValue];
    if(status){
        NSArray *dataAry = [dataDictionary objectForKey:@"info"];
        arrayDueDate = [[NSMutableArray alloc]init];
        for (int i =0 ; i<dataAry.count; i++) {
            CustomData *cmd = [[CustomData alloc] init];
            cmd.strId = [NSString stringWithFormat:@"%d",i];
            cmd.strStatus = dataAry[i];
            cmd.strPropertyAddress = dataAry[i];
            [arrayDueDate addObject:cmd];
        }
    }
}

#pragma -mark User define function

-(void)WebServices{
    AllWebServices *web = [[AllWebServices alloc]init];
    
    NSMutableArray *array = [web WebCompanies];
    NSLog(@"All webservice %@",array);
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
    }else if([appDelegate.STRUSERTYPE isEqualToString:@"User"]){
        viewTab.hidden = NO;
        viewAdminTab.hidden = YES;
        viewSuperAdminTab.hidden = YES;
    }
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
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma -mark UITextField Delegate


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * searchStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    CustomData *cmd = [[CustomData alloc]init];
    cmd = [arraySubtask objectAtIndex:textField.tag];
    cmd.strSubtask = searchStr;
    return YES;
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
