
//  AddAction.m
//  ActionLog

//  Created by Hardik Davda on 9/14/16.
//  Copyright © 2016 SLP-World. All rights reserved.

#import "AddAction.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "UploadRemoveImage.h"

#import "Dashboard.h"
@interface AddAction (){
    UIView *nomatchesView;
    UIView *viewBackGround;
    UIView *viewLoader;
     int key;
    NSTimer *timer;
    NSString *urlAdd;
    NSString *urlAssignTo;
    NSString *urlUpdateAction;
    NSString *urlForApprovalCount;

    NSString *urlTagList;
    NSMutableArray *arrayAssignTo;
    NSMutableArray *arrayPrint1;
    NSMutableArray *arrayTesting;
    NSMutableArray *arrayTag;
    NSMutableArray *arrayTagList;
    NSMutableArray *arrayPrint11;
    NSMutableArray *arraySubtask;
    NSDate *dDate;
    NSDate *wDate;

    NSString *strAssignTo_Id;
    CGRect TESTINGFRAME;
    NSString *clickhideDropDown;
    NSString *selectedDate;

    NSArray *array;
    int IMAGE_COUNTER;
}

@end

@implementation AddAction
@synthesize strISEDITE;

- (void)viewDidLoad {
    [super viewDidLoad];
     viewImage.hidden = true;
    Methods = [[AllMethods alloc]init];
    arrayTesting = [[NSMutableArray alloc]init];
    lblCount1.hidden = YES;
    lblCount2.hidden = YES;
    arraySubtask = [[NSMutableArray alloc]init];
    CustomData *cmd = [[CustomData alloc]init];
    cmd.strSubtask = @"";
    cmd.strPlaceHolder = @"Please Enter Sub Task";
    [arraySubtask addObject:cmd];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:1800];
    [comps setDay:1];
    [comps setMonth:1];
    [comps setHour:12];
    [comps setMinute:59];
    [comps setSecond:59];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    wDate = [cal dateFromComponents:comps];
    
    
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardOnScreen:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

    
    TESTINGFRAME = viewTag.frame;
    viewTag.hidden = YES;
    viewTagSearch.hidden = YES;
    [self setNeedsStatusBarAppearanceUpdate];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self manageUser];
   

    viewDate.hidden = YES;
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    txtTitle.inputAccessoryView = numberToolbar;
    //txtDescription.inputAccessoryView =numberToolbar;
    
    txtCreatedBy.text = appDelegate.STRUSERNAME;
    timer = [NSTimer scheduledTimerWithTimeInterval:.000001 target:self selector:@selector(initialize) userInfo:nil repeats:NO];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(stopGIF) userInfo:nil repeats:NO];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    // [self setNeedsStatusBarAppearanceUpdate];
    return UIStatusBarStyleLightContent;
}

- (void)initialize{
    [self WebServices];
    [self webData];
    [self GetForApprovalCount];
    [self manageAllView];

//    scroll.contentSize = CGSizeMake(0, viewButton.frame.size.height+viewButton.frame.origin.y+viewCollection.frame.origin.y);
    scroll.contentSize = CGSizeMake(0, viewButton.frame.size.height+viewButton.frame.origin.y);
    
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

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow: (NSInteger)row forComponent:(NSInteger)component{
    return [arrayPrint1 objectAtIndex:row];
}

#pragma -mark UITableview Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{              // Default is 1 if not implemented
    return arraySubtask.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomeCellSubtask *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.txtSubTask.text = [[arraySubtask objectAtIndex:indexPath.section]strSubtask];
    cell.txtSubTask.placeholder = [[arraySubtask objectAtIndex:indexPath.section]strPlaceHolder];
    cell.txtSubTask.tag = indexPath.section;
    cell.btnMinus.tag = indexPath.section;
    if (indexPath.section == 0){
        cell.btnMinus.hidden = YES;
        cell.imgMinus.hidden = YES;
    }
    return  cell;
}

#pragma -mark UITableview Delegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return  indexPath;
}


#pragma mark- Button IBAction

#pragma mark- Addor Remove subtask

- (IBAction)MinuesSubTask:(id)sender{
    UIButton *btn = sender;
    int i = (int)btn.tag;
    [arraySubtask removeObjectAtIndex:i];
    [table reloadData];
    [self manageAllView];
}

- (IBAction)AddSubTask:(id)sender{
    CustomData *cmd = [[CustomData alloc]init];
    cmd.strSubtask = @"";
    cmd.strPlaceHolder = @"Please Enter Sub Task";
    [arraySubtask addObject:cmd];
    [table reloadData];
    [self manageAllView];
}

- (IBAction)Cancel:(id)sender{
    [self.view endEditing:YES];

    Dashboard *second=[self.storyboard instantiateViewControllerWithIdentifier:@"dashboard"] ;
    [self.navigationController pushViewController:second animated:YES];
}

- (IBAction)AddAndUpdate:(id)sender{
    [self.view endEditing:YES];

    NSString *Parameter;// = [@"token=" stringByAppendingString:appDelegate.STRTOKEN];
    Parameter = [@"&created_by=" stringByAppendingString:txtCreatedBy.text];
    if ([@"Empty" isEqualToString:[Methods whitSpace:txtTitle.text]]) {
        [self showUiAlertWithMessage:@"Please write proper title" andtitle:@""];
    }else if([@"Empty" isEqualToString:[Methods whitSpace:txtWorkDate.text]]){
        [self showUiAlertWithMessage:@"Please select the workdate" andtitle:@""];
    }else if([@"Empty" isEqualToString:[Methods whitSpace:txtDueDate.text]]){
        [self showUiAlertWithMessage:@"Please select the duedate" andtitle:@""];
    }else if([@"Empty" isEqualToString:[Methods whitSpace:txtAssignTo.text]]){
        [self showUiAlertWithMessage:@"Please select assign to" andtitle:@""];
    }else{
         //2016-10-03 15:00:00
        NSString *datatt= @"yyyy-MM-dd HH:mm:ss";
        NSString *datat=@"dd-MMM-yyyy hh:mm a";
        NSString *strDate = [Methods DateWithFormate:txtDueDate.text andCurrentFormate:datat andNewFormateDate:datatt];
        
        Parameter = [Parameter stringByAppendingString:[@"&title=" stringByAppendingString:[txtTitle.text stringByAppendingString:[@"&duedate=" stringByAppendingString:[strDate stringByAppendingString:[@"&work_date=" stringByAppendingString:[txtWorkDate.text stringByAppendingString:[@"&assigned_to=" stringByAppendingString:strAssignTo_Id]]]]]]]];

        for (int i = 0 ; i<arrayTesting.count; i++) {
            Parameter=[Parameter stringByAppendingString:[@"&tags[]=" stringByAppendingString:[[arrayTesting objectAtIndex:i]strKey]]];
        }
        
   //Append Subtask
        int COUNT = 0;
        for (int i = 0 ; i<arraySubtask.count; i++) {
            if ([@"NotEmpty" isEqualToString:[Methods whitSpace:[[arraySubtask objectAtIndex:i]strSubtask]]]) {
                NSString *count = [NSString stringWithFormat:@"%d", COUNT];
                Parameter=[Parameter stringByAppendingString:[@"&sub_task[" stringByAppendingString:[count stringByAppendingString:[@"]="stringByAppendingString:[[arraySubtask objectAtIndex:i]strSubtask]]]]];
                COUNT++;
            }
        }
        
        NSDictionary *dataDictionary = [[NSDictionary alloc]init];
        NSLog(@"%@",Parameter);
            dataDictionary = [Methods WebServerData:urlAdd andPostParameter:Parameter];
        NSLog(@"Add Action %@",dataDictionary);
        Dashboard *second = [self.storyboard instantiateViewControllerWithIdentifier:@"dashboard"];
        [self.navigationController pushViewController:second animated:YES];
    }
}

- (IBAction)Browse:(id)sender{
    [self.view endEditing:YES];

    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    elcPicker.maximumImagesCount = 10; //Set the maximum number of images to select to 100
    elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
    elcPicker.onOrder = YES; //For multiple image selection, display and return order of selected images
    elcPicker.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie]; //Supports image and movie types
    elcPicker.imagePickerDelegate = self;
    [self presentViewController:elcPicker animated:YES completion:nil];
}

-(IBAction)DueDate:(id)sender{
    selectedDate = @"DueDate";
    [self.view endEditing:YES];
    [scroll setContentOffset:CGPointMake(0,0) animated:YES ];
//    myPicker = [[UIDatePicker alloc]init];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:2100];
    [comps setDay:1];
    [comps setMonth:1];
    [comps setYear:2100];
    [comps setHour:12];
    [comps setMinute:59];
    [comps setSecond:59];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *YourDate = [cal dateFromComponents:comps];
    
    NSDateComponents *comps1 = [[NSDateComponents alloc] init];
    [comps1 setDay:1];
    [comps1 setMonth:1];
    [comps1 setYear:1800];
    [comps1 setHour:12];
    [comps1 setMinute:59];
    [comps1 setSecond:59];
    
    NSCalendar *cal1 = [NSCalendar currentCalendar];
    NSDate *YourDate1 = [cal1 dateFromComponents:comps1];
    
    [myPicker setMinimumDate: YourDate1];
    [myPicker setMaximumDate:YourDate];
    
    viewDate.hidden = NO;
}

-(IBAction)WorkDate:(id)sender{
    selectedDate = @"WorkDate";
    [self.view endEditing:YES];
    [scroll setContentOffset:CGPointMake(0,0) animated:YES ];
    if([@"NotEmpty" isEqualToString:[Methods whitSpace:txtDueDate.text]]){
        viewDate.hidden = NO;
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setYear:1800];
        [comps setDay:1];
        [comps setMonth:1];
        [comps setHour:12];
        [comps setMinute:59];
        [comps setSecond:59];
        
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDate *YourDate = [cal dateFromComponents:comps];
        [myPicker setMaximumDate: dDate];
        [myPicker setMinimumDate: YourDate];
    }else{
        [self showUiAlertWithMessage:@"First Select DueDate " andtitle:@""];
    }
}

-(IBAction)selectDate:(id)sender{
    [self.view endEditing:YES];
    if([selectedDate isEqualToString:@"DueDate"]){
        NSDate *chosen = myPicker.date;
        dDate = myPicker.date;
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd-MMM-yyyy hh:mm a"];
        NSString *fromDay = [NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:chosen]];
        txtDueDate.text = fromDay;
        txtWorkDate.text = @"";
    }else{
        NSDate *chosen = myPicker.date;
        wDate = myPicker.date;
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd-MMM-yyyy hh:mm a"];
        NSString *fromDay = [NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:chosen]];
        txtWorkDate.text = fromDay;
    }
    [self CloseDate:sender];
}

-(IBAction)CloseDate:(id)sender{
    viewDate.hidden = YES;
    // NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    [myPicker setDate:[NSDate date]];
}

- (IBAction)AssignTo:(id)sender{
    [self.view endEditing:YES];
    if([@"YES" isEqualToString:clickhideDropDown ]){
        [scroll setContentOffset:CGPointMake(0,0) animated:YES ];

        if(arrayAssignTo.count){
            clickhideDropDown = @"NO";
            CGRect rt = txtAssignTo.frame;
            NSMutableArray *arrayTemp = [[NSMutableArray alloc]init] ;
            float height = MIN(264,(arrayAssignTo.count+1)*44);
            [self showPopUpWithTitle:@"Select Assign To" withOption:arrayAssignTo Option1:arrayTemp xy:CGPointMake(rt.origin.x, rt.origin.y-height+scroll.frame.origin.y+viewAssignTo.frame.origin.y) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
        }
    }else{
        clickhideDropDown = @"YES";
        [Dropobj fadeOut];
    }
}

- (IBAction)Tag:(id)sender{
    if(arrayTag.count != 0)
        viewTagSearch.hidden = NO;

}

-(IBAction)PostNote:(id)sender{
    [self.view endEditing:YES];
    NSLog(@"Image Count %lu",(unsigned long)array.count);
    
     NSMutableDictionary *Parameter = [[NSMutableDictionary alloc]init];
//    NSString *Parameter;// = [@"token=" stringByAppendingString:appDelegate.STRTOKEN];
//    Parameter = [@"&created_by=" stringByAppendingString:txtCreatedBy.text];
    [Parameter setObject:txtCreatedBy.text  forKey:@"created_by"];
    
    if ([@"Empty" isEqualToString:[Methods whitSpace:txtTitle.text]]) {
        [self showUiAlertWithMessage:@"Please write proper title" andtitle:@""];
    }else if([@"Empty" isEqualToString:[Methods whitSpace:txtWorkDate.text]]){
        [self showUiAlertWithMessage:@"Please select the workdate" andtitle:@""];
    }else if([@"Empty" isEqualToString:[Methods whitSpace:txtDueDate.text]]){
        [self showUiAlertWithMessage:@"Please select the duedate" andtitle:@""];
    }else if([@"Empty" isEqualToString:[Methods whitSpace:txtAssignTo.text]]){
        [self showUiAlertWithMessage:@"Please select assign to" andtitle:@""];
    }else{
        //2016-10-03 15:00:00
        NSString *datatt= @"yyyy-MM-dd HH:mm:ss";
        NSString *datat=@"dd-MMM-yyyy hh:mm a";
        NSString *strDate = [Methods DateWithFormate:txtDueDate.text andCurrentFormate:datat andNewFormateDate:datatt];
        
        [Parameter setObject:txtTitle.text  forKey:@"title"];
        [Parameter setObject:strDate forKey:@"duedate"];
        [Parameter setObject:txtWorkDate.text forKey:@"work_date"];
        [Parameter setObject:strAssignTo_Id forKey:@"assigned_to"];

        for (int i = 0 ; i<arrayTesting.count; i++) {
            NSString *par = @"tags[]";
            [Parameter setObject:[[arrayTesting objectAtIndex:i]strKey] forKey:par];
            
//            Parameter=[Parameter stringByAppendingString:[@"&tags[]=" stringByAppendingString:[[arrayTesting objectAtIndex:i]strKey]]];
        }
        
        //Append Subtask
        int COUNT = 0;
        for (int i = 0 ; i<arraySubtask.count; i++) {
            if ([@"NotEmpty" isEqualToString:[Methods whitSpace:[[arraySubtask objectAtIndex:i]strSubtask]]]) {
                NSString *count = [NSString stringWithFormat:@"%d", COUNT];
                
                NSString *par = [@"sub_task[" stringByAppendingString:[count stringByAppendingString:@"]"]];
                 [Parameter setObject:[[arraySubtask objectAtIndex:i]strSubtask] forKey:par];

                //                Parameter=[Parameter stringByAppendingString:[@"&sub_task[" stringByAppendingString:[count stringByAppendingString:[@"]="stringByAppendingString:[[arraySubtask objectAtIndex:i]strSubtask]]]]];
                COUNT++;
            }
        }
        NSLog(@"Parameter %@",Parameter);
//        NSDictionary *dataDictionary = [[NSDictionary alloc]init];
//        NSLog(@"%@",Parameter);
//        dataDictionary = [Methods WebServerData:urlAdd andPostParameter:Parameter];
//        NSLog(@"Add Action %@",dataDictionary);
//        Dashboard *second = [self.storyboard instantiateViewControllerWithIdentifier:@"dashboard"];
//        [self.navigationController pushViewController:second animated:YES];
    }
    
    
    NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc]init];
    [mutableDict setObject:@"Value1" forKey:@"Key1"];
    [mutableDict setObject:@"Value2" forKey:@"Key2"];
    [mutableDict setObject:@"Value3" forKey:@"Key3"];
    
    NSDictionary *firstDictionary = [NSMutableDictionary dictionaryWithDictionary:mutableDict];

    
    NSString *str1 = urlAdd;//[appDelegate.WEBPATH stringByAppendingString:@"pts_fallover_add.php"];
    NSString *tempNoteId = @"NO USE PARAMETER";
//    NSDictionary *params1 = @{@"make_property_available_again":@"",@"pro_id":@"",@"user_id":@"",};
    UploadRemoveImage *obj = [[UploadRemoveImage alloc]init];
    UIImage *Document = [[UIImage alloc]init];
    Document=imgSelect.image;
    [obj postImageToURL:str1 withMethod:@"sendfiles.php" andParams:firstDictionary andImage:array noteId:tempNoteId eventId:@"" fileType:@"files" completion:^(BOOL success, NSDictionary *responseObj){
        NSLog(@"Responce %@",responseObj);
        if(success)
            NSLog(@"Success");
        else
        {}
    }];
}

- (IBAction)Dashboard:(id)sender{
    [self.view endEditing:YES];

    appDelegate.ISAPPROVE=@"NO";
    Dashboard *second=[self.storyboard instantiateViewControllerWithIdentifier:@"dashboard"] ;
    [self.navigationController pushViewController:second animated:YES];
}

- (IBAction)Approved:(id)sender{
    [self.view endEditing:YES];

    appDelegate.ISAPPROVE=@"YES";
    Dashboard *second=[self.storyboard instantiateViewControllerWithIdentifier:@"dashboard"] ;
    [self.navigationController pushViewController:second animated:YES];
}

- (IBAction)Archived:(id)sender{
    [self.view endEditing:YES];

    Archived *second=[self.storyboard instantiateViewControllerWithIdentifier:@"archived"] ;
    [self.navigationController pushViewController:second animated:YES];
}

- (IBAction)Companies:(id)sender{
    [self.view endEditing:YES];

    Companies *second=[self.storyboard instantiateViewControllerWithIdentifier:@"companies"] ;
    [self.navigationController pushViewController:second animated:YES];
}

- (IBAction)User:(id)sender{
    [self.view endEditing:YES];

    Users *second=[self.storyboard instantiateViewControllerWithIdentifier:@"users"] ;
    [self.navigationController pushViewController:second animated:YES];
}

#pragma -mark Slect Image From Gallary Delegate

- (void)displayPickerForGroup:(ALAssetsGroup *)group{
    ELCAssetTablePicker *tablePicker = [[ELCAssetTablePicker alloc] initWithStyle:UITableViewStylePlain];
    tablePicker.singleSelection = YES;
    tablePicker.immediateReturn = YES;
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initWithRootViewController:tablePicker];
    elcPicker.maximumImagesCount = 1;
    elcPicker.imagePickerDelegate = self;
    elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
    elcPicker.onOrder = NO; //For single image selection, do not display and return order of selected images
    tablePicker.parent = elcPicker;
    // Move me
    tablePicker.assetGroup = group;
    [tablePicker.assetGroup setAssetsFilter:[ALAssetsFilter allAssets]];
    [self presentViewController:elcPicker animated:YES completion:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return YES;
    else
        return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}

#pragma mark- Save Tag

- (IBAction)SaveTag:(id)sender{
    [self.view endEditing:YES];

    //[self HideDropDownAtAllPlace];
    viewTag.hidden = NO;
    [self ManageTagView];
    
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
    int i = (int)arrayTesting.count;
    if(arrayTesting.count == 0){
       x= imgBoder.frame.origin.x;
        // x= imgBoder.frame.origin.y+5;
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
        x= imgBoder.frame.origin.x;
            //  x= imgBoder.frame.origin.y+5;
            if ((FRAME.size.height+FRAME.origin.y+30)>viewTag.frame.size.height) {
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
    cmd11.strKey = strDATA;
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
    [self PrintTag];
    [self ManageTagView];
}

-(IBAction)AddTag:(id)sender{
    
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
        if([@"Empty" isEqualToString:[Methods whitSpace:txtAssignTo.text]] || [@"Assign To" isEqualToString:txtAssignTo.text]){
            [self showUiAlertWithMessage:@"Please select assign to for selecting tag" andtitle:@""];
        }else{
            if(arrayTag.count != 0)
                viewTagSearch.hidden = NO;
        }
    }else{
        if(arrayTag.count != 0)
            viewTagSearch.hidden = NO;
        else
            [self showUiAlertWithMessage:@"No tag available for select" andtitle:@""];
    }
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
            x= imgBoder.frame.origin.x;
            //y = 12;
            y = imgBoder.frame.origin.y+5;
            if ((imgBoder.frame.origin.y+10+30+imgBoder.frame.origin.y)>viewTag.frame.size.height){
                CGRect fram = viewTag.frame;
                fram.size.height = imgBoder.frame.origin.y+30+imgBoder.frame.origin.y+10;
                viewTag.frame = fram;
            }
        }else{
            CGRect FRAME =  [[arrayTesting objectAtIndex:J-1]FINALFRAMELABLE];
            if((FRAME.size.width+FRAME.origin.x+size.width+22)<imgBoder.frame.size.width){
                y = FRAME.origin.y;
                x =(FRAME.size.width+FRAME.origin.x+20);
            }else{
                x= imgBoder.frame.origin.x;
                //x= 10;
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
    [self PrintTag];
    //[self manageView];
    [self ManageTagView];
}

-(void)PrintTag{
}

-(void)doneWithNumberPad{
    [self.view endEditing:YES];
}

-(IBAction)CloseTag:(id)sender{
    viewTag.hidden = YES;
    viewTagSearch.hidden = YES;
    arrayPrint1 = [[NSMutableArray alloc]initWithArray:arrayPrint11];
    [picker reloadAllComponents];
   // [self ForClose];
}

- (IBAction)CancelTag:(id)sender{
    viewTagSearch.hidden = YES;
    
}

#pragma -mark Delegate ImagePicker (Selection Image)

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:    (NSDictionary *)info {
    UIImage *imgdata;
    for (UIView *v in [_scrollView subviews])
        [v removeFromSuperview];
    CGRect workingFrame = _scrollView.frame;
    workingFrame.origin.x = 0;
    
    imgdata = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:[info count]];
    NSMutableArray *images1 = [NSMutableArray arrayWithCapacity:[info count]];
    
    imgSelect.image= imgdata;
    [images addObject:imgdata];
    [images1 addObject:imgdata];
    
    UIImageView *imageview1 = [[UIImageView alloc] initWithImage:imgdata];
    [imageview1 setContentMode:UIViewContentModeScaleAspectFit];
    
    UIImageView *imageview = [[UIImageView alloc] initWithImage:imgdata];
    [imageview setContentMode:UIViewContentModeScaleAspectFit];
    imageview.frame = workingFrame;
    
    [_scrollView addSubview:imageview];
    workingFrame.origin.x = workingFrame.origin.x + workingFrame.size.width;
    {
        array =[NSArray arrayWithArray:images];
        self.chosenImages = images;
        [_scrollView setPagingEnabled:YES];
        [_scrollView setContentSize:CGSizeMake(workingFrame.origin.x, workingFrame.size.height)];
        //UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        //[_scrollView addGestureRecognizer:singleTap];
        //UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap1:)];
    }
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark ELCImagePickerControllerDelegate Methods

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info{
    viewImage.hidden = false;
    IMAGE_COUNTER = 0;
    if(info.count>0){
        if(info.count>1)
            //imgRight.hidden = NO;
        imgSelect.hidden = YES;
        IMAGE_COUNTER = (int)info.count;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    for (UIView *v in [_scrollView subviews])
        [v removeFromSuperview];
    CGRect workingFrame = _scrollView.frame;
    workingFrame.origin.x = 0;
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:[info count]];
    NSMutableArray *images1 = [NSMutableArray arrayWithCapacity:[info count]];
    int DEMO=1;
    for (NSDictionary *dict in info) {
        [self ManageView];
        lblSelectedFile.hidden = YES;
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                UIImage* image1=[dict objectForKey:UIImagePickerControllerOriginalImage];
                imgSelect.image= image;
                [images addObject:image];
                [images1 addObject:image1];
                
                UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
                [imageview setContentMode:UIViewContentModeScaleAspectFit];
                imageview.frame = workingFrame;
                
                UIImageView *imageview1 = [[UIImageView alloc] initWithImage:image1];
                [imageview1 setContentMode:UIViewContentModeScaleAspectFit];
                
                UIImageView *imageview11 = [[UIImageView alloc] initWithFrame:CGRectMake(DEMO, 0, viewImage.frame.size.height, viewImage.frame.size.height)];
              //  [imageview1 setContentMode:UIViewContentModeScaleAspectFit];
                
                imageview11.image = image1;
                [_scrollView addSubview:imageview11];
               
                DEMO=DEMO+viewImage.frame.size.height+10;
                workingFrame.origin.x = workingFrame.origin.x + workingFrame.size.width;
            } else
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
        } else if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypeVideo){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                UIImage* image1=[dict objectForKey:UIImagePickerControllerOriginalImage];
                
                [images addObject:image];
                [images1 addObject:image1];
                
                UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
                [imageview setContentMode:UIViewContentModeScaleAspectFit];
                imageview.frame = workingFrame;
                
                UIImageView *imageview1 = [[UIImageView alloc] initWithImage:image];
                [imageview1 setContentMode:UIViewContentModeScaleAspectFit];
                imageview1.frame = workingFrame;
                
                [_scrollView addSubview:imageview];
                workingFrame.origin.x = workingFrame.origin.x + workingFrame.size.width;
            } else
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
        } else
            NSLog(@"Uknown asset type");
    }
    
    array =[NSArray arrayWithArray:images1];
    self.chosenImages = images;
    _scrollView.contentSize = CGSizeMake(DEMO, 0);

  //  [_scrollView setPagingEnabled:YES];
  //  [_scrollView setContentSize:CGSizeMake(workingFrame.origin.x, workingFrame.size.height)];
    
  //  UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
   // [_scrollView addGestureRecognizer:singleTap];
   // UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap1:)];
}

-(void)ManageView{
    CGRect frame = viewImage.frame;
    frame.origin.y  = viewBrowser.frame.origin.y+viewBrowser.frame.size.height;
    viewImage.frame = frame;
    
    [self manageAllView];
}

-(void)ManageTagView{
    viewTag.hidden = NO;
    NSLog(@"Array count %lu",(unsigned long)arrayTesting.count);
    if(arrayTesting.count == 0){
        viewTag.hidden = YES;
        CGRect frame = viewCollection.frame;
        frame.origin.y  = viewTagAdd.frame.origin.y+viewTagAdd.frame.size.height;
        viewCollection.frame = frame;
    }else{
        viewTag.hidden = NO;
        CGRect frame = viewTag.frame;
        frame.origin.y  = viewTagAdd.frame.origin.y+viewTagAdd.frame.size.height;
        viewTag.frame= frame;
        
        frame = viewCollection.frame;
        frame.origin.y  = viewTag.frame.origin.y+viewTag.frame.size.height;
        viewCollection.frame = frame;
    }
    [self manageAllView];
//    scroll.contentSize = CGSizeMake(0, viewButton.frame.size.height+viewButton.frame.origin.y+viewCollection.frame.origin.y);
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ELCImagePickerControllerDelegate Methods

#pragma -mark Dropdown Delegate

-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSMutableArray*)arrOptions Option1:(NSMutableArray*)arrOptions1 xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple{
    
    Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions options1:arrOptions1 xy:point size:size isMultiple:isMultiple];
    Dropobj.delegate = self;
    [Dropobj showInView:self.view animated:YES];
    
    /*----------------Set DropDown backGroundColor-----------------*/
    
    [Dropobj SetBackGroundDropDown_R:245.0 G:245.0 B:245.0 alpha:0.90];
}

- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex{
    /*----------------Get Selected Value[Single selection]-----------------*/
    //[scroll setContentOffset:CGPointMake(0,0) animated:YES ];
    clickhideDropDown = @"YES";
    if([appDelegate.STRUSERTYPE  isEqualToString:@"Super Admin"]){
        if(arrayTesting.count != 0){
                [self showUiAlertWithMessage:@"Available tags will be reset" andtitle:@""];
                [self removeTag];
        }
        txtAssignTo.text = [[arrayAssignTo objectAtIndex:anIndex]strPropertyAddress];
        strAssignTo_Id = [[arrayAssignTo objectAtIndex:anIndex]strKey];
        [self ManageTag:[[arrayAssignTo objectAtIndex:anIndex]strCompanyId] andUserId:[[arrayAssignTo objectAtIndex:anIndex]strKey]];
        
    }else{
        txtAssignTo.text = [[arrayAssignTo objectAtIndex:anIndex]strPropertyAddress];
        strAssignTo_Id = [[arrayAssignTo objectAtIndex:anIndex]strKey];    //    Companies
    }
}

#pragma mark- Remove Tag

-(void)removeTag{
    for(int i =0 ; i<arrayTesting.count;i++){
        [self removeTagFromPrint:[[arrayTesting objectAtIndex:i]strId]];
    }
    for(int i =0 ; i<arrayTesting.count;i++){
        [self removeTagFromPrint:[[arrayTesting objectAtIndex:i]strId]];
    }
}

-(void)removeTagFromPrint : (NSString *)tagId{
    UIButton *btnTEst = [[UIButton alloc]init];
    btnTEst.tag = [tagId integerValue];
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
            x= imgBoder.frame.origin.x;
            //y = 12;
            y = imgBoder.frame.origin.y+5;
            if ((imgBoder.frame.origin.y+10+30+imgBoder.frame.origin.y)>viewTag.frame.size.height){
                CGRect fram = viewTag.frame;
                fram.size.height = imgBoder.frame.origin.y+30+imgBoder.frame.origin.y+10;
                viewTag.frame = fram;
            }
        }else{
            CGRect FRAME =  [[arrayTesting objectAtIndex:J-1]FINALFRAMELABLE];
            if((FRAME.size.width+FRAME.origin.x+size.width+22)<imgBoder.frame.size.width){
                y = FRAME.origin.y;
                x =(FRAME.size.width+FRAME.origin.x+20);
            }else{
                x= imgBoder.frame.origin.x;
                //x= 10;
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
        UIButton *button = [[arrayTesting objectAtIndex:J]btnTESTING];
        //[UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(lblName.frame.origin.x+lblName.frame.size.width-4,lblName.frame.origin.y+5/*20+(25*i)*/, 15, 15.0);
        CGRect FRAME = button.frame;
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
    [self PrintTag];
    //[self manageView];
    [self ManageTagView];
}

-(void)ManageTag : (NSString *)CompanyId andUserId :(NSString *)UserID{
    
    if([CompanyId isEqualToString:@"0"]){
        for(int i = 0; i<arrayTagList.count; i++){
            if([[[arrayTagList objectAtIndex:i]strUserId] isEqualToString:UserID]){
                CustomData *cmd = [arrayTagList objectAtIndex:i];
                [arrayTag addObject:cmd];
                [arrayPrint1 addObject:[[arrayTagList objectAtIndex:i]strPropertyAddress]];
            }
        }
    }else{
        for(int i = 0; i<arrayTagList.count; i++){
            if([[[arrayTagList objectAtIndex:i]strCompanyId] isEqualToString:CompanyId]){
                CustomData *cmd = [arrayTagList objectAtIndex:i];
                [arrayTag addObject:cmd];
                [arrayPrint1 addObject:[[arrayTagList objectAtIndex:i]strPropertyAddress]];
            }
        }
    }
    [picker reloadAllComponents];
}

- (void)DropDownListView:(DropDownListView *)dropdownListView Datalist:(NSMutableArray*)ArryData{

}

#pragma mark- Manage Design

- (void)manageAllView{
    float Y;
    CGRect frame = viewButton.frame;
    frame.origin.y  = viewImage.frame.origin.y+viewImage.frame.size.height;
    viewButton.frame = frame;
//    scroll.contentSize = CGSizeMake(0, viewButton.frame.size.height+viewButton.frame.origin.y+viewCollection.frame.origin.y);
    
    frame = viewMain.frame;
    
    viewMain.frame = frame;
    
    frame = viewTagAdd.frame;
    frame.origin.y   = viewMain.frame.size.height;
    Y = viewMain.frame.size.height+viewTagAdd.frame.size.height;
    viewTagAdd.frame = frame;
    
    if (!viewTag.isHidden){
        frame = viewTag.frame;
        frame.origin.y = Y;
        Y = Y+viewTag.frame.size.height;
        viewTag.frame = frame;
    }
    frame = viewBrowser.frame;
    frame.origin.y = Y;
    Y = Y+viewBrowser.frame.size.height;
    viewBrowser.frame = frame;

    if(!viewImage.isHidden){
        frame = viewImage.frame;
        frame.origin.y = Y;
        Y = Y + viewImage.frame.size.height;
        viewImage.frame = frame;
    }
    
    CGFloat height = table.rowHeight;
    height = 44*arraySubtask.count;
    
    CGRect tableFrame = table.frame;
    tableFrame.size.height = height;
    table.frame = tableFrame;
    
    frame = viewSubTask.frame;
    frame.origin.y = Y;
    frame.size.height = table.frame.size.height+10;
    Y = Y + frame.size.height;//table.frame.size.height+10;
    viewSubTask.frame = frame;
    
    frame = viewButton.frame;
    frame.origin.y = Y;
    Y = Y + viewButton.frame.size.height;
    viewButton.frame = frame;
     scroll.contentSize = CGSizeMake(0, viewButton.frame.size.height+viewButton.frame.origin.y);
//    ViewTagAdd
//    viewTag
//    viewBrowser
//    ViewImage
//    ViewSubTask
//    viewButton
//    viewCollection
//    viewTagSearch
//    ViewDate
}

#pragma mark- User Define Function

-(void)WebServices{
    AllWebServices *web = [[AllWebServices alloc]init];
    NSMutableArray *array1 = [web WebAddAction];
    urlForApprovalCount = [[array1 objectAtIndex:0]webForApprvalCount];
    urlAdd = [[array1 objectAtIndex:0]webAddAction];
    urlAssignTo = [[array1 objectAtIndex:0]webAssignTo];
    urlUpdateAction = [[array1 objectAtIndex:0]webUpdateAction];
    urlTagList = [[array1 objectAtIndex:0]webTagList];
    [self GetTag];
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

-(void)GetTag{
//    if(appDelegate.ARRAYTAGVALUE.count == 0 || appDelegate.ARRAYTAG.count ==0){
   // NSString *parameter = [@"token=" stringByAppendingString:appDelegate.STRTOKEN];
        NSDictionary *dataDictionary = [Methods  WebServerData:urlTagList];
        arrayTag = [[NSMutableArray alloc]init];
        arrayPrint1 = [[NSMutableArray alloc]init];
        arrayPrint11 = [[NSMutableArray alloc]init];
        arrayTagList = [[NSMutableArray alloc]init];
        NSArray *dataAry = [dataDictionary objectForKey:@"info"];
        
        for (NSDictionary *dic in dataAry) {
            CustomData *cmd = [[CustomData alloc]init];
            cmd.strKey = [dic valueForKey:@"tag_id"];//[NSString stringWithFormat:@"%@",key];
            cmd.strStatus = [dic valueForKey:@"tag_name"];// [NSString stringWithFormat:@"%@",value];
            cmd.strPropertyAddress = [dic valueForKey:@"tag_name"];//[NSString stringWithFormat:@"%@",value];
            cmd.strCompanyId = [dic valueForKey:@"company_id"];
            cmd.strUserId = [dic valueForKey:@"user_id"];
            [arrayTag addObject:cmd];
            [arrayTagList addObject:cmd];
            [appDelegate.ARRAYTAG addObject:cmd];
            [appDelegate.ARRAYTAGVALUE addObject:cmd.strPropertyAddress];
            [arrayPrint1 addObject:cmd.strPropertyAddress];
            [arrayPrint11 addObject:cmd.strPropertyAddress];
        }
//    }else{
//        arrayTag = [[NSMutableArray alloc]initWithArray:appDelegate.ARRAYTAG];
//        arrayTagList = [[NSMutableArray alloc]initWithArray:appDelegate.ARRAYTAG];
//        arrayPrint1 = [[NSMutableArray alloc]initWithArray:appDelegate.ARRAYTAGVALUE];
//        arrayPrint11 = [[NSMutableArray alloc]initWithArray:appDelegate.ARRAYTAGVALUE];
//    }
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
        arrayTag = [[NSMutableArray alloc]init];//WithArray:appDelegate.ARRAYTAG];
        arrayPrint1 = [[NSMutableArray alloc]init];//WithArray:appDelegate.ARRAYTAGVALUE];
    }
    [picker reloadAllComponents];
}

-(void)manageUser{
    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
        viewTab.hidden = YES;
        viewAdminTab.hidden = NO;
        viewSuperAdminTab.hidden = YES;
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

#pragma mark- Get Assignto List

-(void)webData{
    if(appDelegate.ARRAYASSIGNTO.count ==0){
        NSDictionary *dataDictionary = [Methods  WebServerData:urlAssignTo];
        NSArray *dataAry = [dataDictionary objectForKey:@"info"];
        arrayAssignTo = [[NSMutableArray alloc]init];
        CustomData *cmd = [[CustomData alloc]init];
        cmd.strKey = @"00";//[dic valueForKey:@"user_id"];
        cmd.strStatus = @"Assign To";//[dic valueForKey:@"assignee_name"];
        cmd.strPropertyAddress = @"Assign To";//[dic valueForKey:@"assignee_name"];
        cmd.strCompanyId =@"00";// [dic valueForKey:@"company_id"];
         [arrayAssignTo addObject:cmd];
        for (NSDictionary *dic in dataAry) {
            CustomData *cmd = [[CustomData alloc]init];
            cmd.strKey = [dic valueForKey:@"user_id"];//[NSString stringWithFormat:@"%@",key];
            cmd.strStatus = [dic valueForKey:@"assignee_name"];// [NSString stringWithFormat:@"%@",value];
            cmd.strPropertyAddress = [dic valueForKey:@"assignee_name"];//[NSString stringWithFormat:@"%@",value];
            cmd.strCompanyId = [dic valueForKey:@"company_id"];
             [arrayAssignTo addObject:cmd];
        }
    }
    else
        arrayAssignTo = [[NSMutableArray alloc]initWithArray:appDelegate.ARRAYASSIGNTO];
}

-(void)editeInformation{
    
}

-(void)textViewDidChange:(UITextView *)textView{
     lblPalaceholder.hidden = NO;
    if ([@"Empty" isEqualToString:[Methods whitSpace:textView.text]]) {
        lblPalaceholder.hidden = NO;
    }
    else{
        lblPalaceholder.hidden = YES;
    }
}

-(NSString *)whitSpace:(NSString *)param{
    NSString *rawString = param;
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
    if ([trimmed length] == 0)
        return @"Empty";
    else
        return @"NotEmpty";
}

-(void)showUiAlertWithMessage:(NSString *)message andtitle:(NSString *)title{
    UIAlertView *obj=[[UIAlertView alloc]initWithTitle:@""
                                               message:message
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles: nil];
    [obj show];
}

#pragma mark- Keyboard Methods

-(void)keyboardOnScreen:(NSNotification *)notification{
    NSDictionary *info  = notification.userInfo;
    NSValue      *value = info[UIKeyboardFrameEndUserInfoKey];
    CGRect rawFrame      = [value CGRectValue];
    CGRect keyboardFrame = [self.view convertRect:rawFrame fromView:nil];
    key = 0;
    key = keyboardFrame.size.height;
    scroll.contentSize = CGSizeMake(0, viewButton.frame.size.height+viewButton.frame.origin.y+key);
}

-(void)keyboardWillHide:(NSNotification *)notification{
    scroll.contentSize = CGSizeMake(0, viewButton.frame.size.height+viewButton.frame.origin.y);
    
}

#pragma -mark UITextField Delegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.tag<99){
        NSString * searchStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
        CustomData *cmd = [[CustomData alloc]init];
        cmd = [arraySubtask objectAtIndex:textField.tag];
        cmd.strSubtask = searchStr;
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
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
