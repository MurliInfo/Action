//
//  AddSubtask.m
//  ActionLog
//
//  Created by Hardik Davda on 9/14/16.
//  Copyright © 2016 SLP-World. All rights reserved.


#import "AddSubtask.h"
#import <AssetsLibrary/AssetsLibrary.h>
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

@interface AddSubtask ()<CZPickerViewDelegate>{
    UIView *nomatchesView;
    UIView *viewBackGround;
    UIView *viewLoader;
    NSTimer *timer;
    NSString *urlActionHistory;
    NSString *selctEmageName;
    NSString *urlSubTaskList;
    NSString *urlAddUpdateSubTask;
    NSString *urlAssignTo;
    NSString *urlUpdatAction;
    NSString *urlPostNote;
    NSString *urlChangeActionStatus;
    NSString *urlTagList;
    NSString *urlReorderTask;
    NSMutableArray *arrayPrint;
    NSMutableArray *arrayPrint1;
   // NSMutableArray *arrayTag1;
    NSMutableArray *arrayActionHistory;
    NSMutableArray *arraySubTask;
    NSMutableArray *arrayStatus;
    NSMutableArray *arrayAssignTo;
    NSMutableArray *arrayTesting;
    NSMutableArray *arrayTag;
    NSMutableArray *arrayPrint11;
    NSMutableArray *arrayTag2;
    NSMutableArray *arrayTag1;
    NSMutableArray *arrayTagFiletr;
    NSString *fromDate;
    NSString *strDateSelection;
    NSString *strManageTableView;
    float cellWidth;
    float cellWidth1;
    NSDate *dateBountry;
    NSDate *dateBountryMin;
    int alertDelete;
    NSString *dropDownSelection;
    NSString *clickhideDropDown;
    NSString *imgName;
    NSString *isNewTag;
    CGRect TESTINGFRAME;
    int AnIndex;
    //UIDatePicker *myPicker;
}
 @property (nonatomic) PickerView *statusPickerView;
@end

typedef void(^myCompletion)(BOOL);

@implementation AddSubtask


@synthesize getActionLogId,getActionLogTitle,arrayGetDetail,getStatus;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self ManageDicebal];
    lblCompleted.text = [[arrayGetDetail objectAtIndex:0]strPercentageCompleted];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
    if([getStatus isEqualToString:@"Dashboard"])
        [table addGestureRecognizer:longPress];
    
    viewTag.hidden = YES;
    [self WebServices];
    TESTINGFRAME = viewTag.frame;
    arrayTesting = [[NSMutableArray alloc]init];
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
   // txtTitle.inputAccessoryView = numberToolbar;
    viewTagSearch.hidden = YES;
    timer = [NSTimer scheduledTimerWithTimeInterval:.000001 target:self selector:@selector(updatWeb) userInfo:nil repeats:NO];
        // Do any additional setup after loading the view.//
     [self setNeedsStatusBarAppearanceUpdate];
    
    alertDelete = 0;
    isNewTag= @"NO";
    viewTag.hidden = YES;
    Methods = [[AllMethods alloc]init];
    
//    UILongPressGestureRecognizer *longPress1 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
//    [table1 addGestureRecognizer:longPress1];

    UIToolbar* numberToolbar1 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    numberToolbar1.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar1.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad1)],
                           nil];
    [numberToolbar1 sizeToFit];
    txtPercenatages.inputAccessoryView = numberToolbar1;
    txtComments.inputAccessoryView = numberToolbar1;
    cellWidth = lblTEST.frame.size.width;
    cellWidth1= lblTEST1.frame.size.width;
    NSMutableAttributedString *attributeString11 = [[NSMutableAttributedString alloc] initWithString:getActionLogTitle];
    [attributeString11 addAttribute:NSUnderlineStyleAttributeName
                              value:@2
                              range:NSMakeRange(0, [attributeString11 length])];
    //txtTitle.attributedText = attributeString11;
    txtTitle.text =getActionLogTitle;
    viewRevisedDate.hidden = YES;
    viewPercenatages.hidden = YES;
    NSMutableAttributedString *attributeString1 = [[NSMutableAttributedString alloc] initWithString:[[arrayGetDetail objectAtIndex:0]strRevisedDate]];
    [attributeString1 addAttribute:NSUnderlineStyleAttributeName
                             value:@2
                             range:NSMakeRange(0, [attributeString1 length])];
    lblReviceDate.attributedText = attributeString1;
    fromDate =[[arrayGetDetail objectAtIndex:0]strDueDate];
   
//    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
//    [dateFormat setDateFormat:@"dd-MMM-yyyy hh:mm a"];
//    NSString *concatDate;
//    concatDate = [dateFormat stringFromDate:[NSDate date]];
    
   // NSLog(@"Date %@ \n Current Date %@",fromDate,concatDate) ;
    lblDueDate.text = [[arrayGetDetail objectAtIndex:0]strDueDate];
    lblDueDate.textColor = [Methods colorWithHexString:[[arrayGetDetail objectAtIndex:0]strColor]];
    
    if ([@"No Revised date" isEqualToString:[[arrayGetDetail objectAtIndex:0]strRevisedDate]]) {
        lblReviceDate.textColor = [Methods colorWithHexString:@"000000"];
        if([[[arrayGetDetail objectAtIndex:0]strColor] isEqualToString:@"red"]){
            lblDueDate.textColor = [Methods colorWithHexString:@"E35444"];
        }else{
            lblDueDate.textColor = [Methods colorWithHexString:@"74AD46"];//74AD46
        }
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd-MMM-yyyy hh:mm a"];
        NSDate *date = [dateFormat dateFromString:[[arrayGetDetail objectAtIndex:0]strDueDate]];
        dateBountry = date;
         NSLog(@"Date %@",date);
    }else{
//        {
        NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
        [dateFormat1 setDateFormat:@"dd-MMM-yyyy hh:mm a"];
        NSDate *date = [dateFormat1 dateFromString:[[arrayGetDetail objectAtIndex:0]strRevisedDate]];
        NSLog(@"Date %@",date);
         dateBountry = date;
        
        NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
        [dateFormat setDateFormat:@"dd-MMM-yyyy hh:mm a"];
        NSString *concatDate;
        concatDate = [dateFormat stringFromDate:[NSDate date]];
        NSLog(@"Date %@ \n Current Date %@",fromDate,concatDate) ;

            NSString *secondString = fromDate;
            NSDate *firstDate,*secondDate;
//            concatDate = [dateFormat stringFromDate:[NSDate date]];
//
            secondDate = [dateFormat dateFromString:concatDate];
            firstDate =[[NSDate alloc]init];
            firstDate = [dateFormat dateFromString:fromDate];
            NSComparisonResult result;
            result = [secondDate compare:firstDate];
        if([[[arrayGetDetail objectAtIndex:0]strColor] isEqualToString:@"red"]){
            lblDueDate.textColor = [Methods colorWithHexString:@"E35444"];
        }else{
            lblDueDate.textColor = [Methods colorWithHexString:@"74AD46"];//74AD46
        }
        if([[[arrayGetDetail objectAtIndex:0]strReviceDateColor] isEqualToString:@"red"]){
            lblReviceDate.textColor = [Methods colorWithHexString:@"E35444"];
        }else{
            lblReviceDate.textColor = [Methods colorWithHexString:@"74AD46"];//74AD46
        }

//         if (result == NSOrderedAscending){
//             lblDueDate.textColor = [Methods colorWithHexString:@"74AD46"];//74AD46
//             
//         }else{
//             lblDueDate.textColor = [Methods colorWithHexString:@"E35444"];
//         }
//            NSComparisonResult result;
//            result = [secondDate compare:firstDate];
//            if (result == NSOrderedSame){
//                strReminderStatus = @"NoExpired";
//            }else if(result ==  NSOrderedAscending){
//                strReminderStatus = @"NoExpired";
//            }else if(result ==  NSOrderedDescending){
//                strReminderStatus = @"Expired";
//                lblDateOfRemainder.textColor = [UIColor redColor];
//                lblCReminder.textColor = [UIColor redColor];
//            }
//        }
        //lblDueDate.textColor = [Methods colorWithHexString:@"000000"];
//        if([[[arrayGetDetail objectAtIndex:0]strColor] isEqualToString:@"red"]){
//            lblReviceDate.textColor = [Methods colorWithHexString:@"E35444"];
//            //lblDueDate.textColor = [Methods colorWithHexString:@"E35444"];
//            
//        }else{
//            lblReviceDate.textColor = [Methods colorWithHexString:@"74AD46"];//74AD46
//            // lblDueDate.textColor = [Methods colorWithHexString:@"E35444"];//74AD46
//        }
//        //lblReviceDate.textColor = [Methods colorWithHexString:[[arrayGetDetail objectAtIndex:0]strColor]];
    }
    //lblDueDate.textColor = [Methods colorWithHexString:@"E35444"];
    //lblReviceDate.text = [[arrayGetDetail objectAtIndex:0]strRevisedDate];
    
    lblCreatedDate.text = [[arrayGetDetail objectAtIndex:0]strCreatedDate];
    NSLog(@"User name %@",[[arrayGetDetail objectAtIndex:0]strUserName]);
    lblCreatedBy.text = [[arrayGetDetail objectAtIndex:0]strUserName];
    
    NSMutableAttributedString *attributeString10 = [[NSMutableAttributedString alloc] initWithString:[[arrayGetDetail objectAtIndex:0]strAssignTo]];
    [attributeString10 addAttribute:NSUnderlineStyleAttributeName
                              value:@2
                              range:NSMakeRange(0, [attributeString10 length])];
    lblAssignTo.attributedText = attributeString10;
    //  lblReviceDate.text = [[arrayGetDetail objectAtIndex:0]strRevisedDate];
    
   // [self viewMain];
 //   timer = [NSTimer scheduledTimerWithTimeInterval:.000001 target:self selector:@selector(ForTag) userInfo:nil repeats:NO];
    lblWorkDate.text = [[arrayGetDetail objectAtIndex:0]strWorkDate];
    if([@"No Work date" isEqualToString:[[arrayGetDetail objectAtIndex:0]strWorkDate]]){
        lblWorkDate.textColor = [Methods colorWithHexString:@"757575"];
    }else{
        if([[[arrayGetDetail objectAtIndex:0]strWorkDateColor] isEqualToString:@"red"]){
            lblWorkDate.textColor = [Methods colorWithHexString:@"E35444"];
        }else{
            lblWorkDate.textColor = [Methods colorWithHexString:@"74AD46"];
        }
    }

    timer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(initialize) userInfo:nil repeats:NO];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(stopGIF) userInfo:nil repeats:NO];
    
    [self ForTag];
}

-(void)ManageDicebal{

    NSLog(@"User id login %@",appDelegate.STRUSERID);
    NSLog(@"UserId Data %@",[[arrayGetDetail objectAtIndex:0]strCreatedBy]);
    
    if([getStatus isEqualToString:@"Dashboard"]){
        if([[[arrayGetDetail objectAtIndex:0]strCreatedBy]isEqualToString:appDelegate.STRUSERID]){
            btnDelete.hidden = NO;
        }else
            btnDelete.hidden = YES;
        btnDelete.hidden = YES;
        txtTitle.userInteractionEnabled= NO;
        lblAdd.hidden = NO;
        lblPlus.hidden = NO;
        lblChange.hidden = NO;
       // btnDelete.hidden = NO;
        btnTag.hidden = NO;
        btnAddSubtask.hidden = NO;
        btnPostNotes.hidden = NO;
        btnUploadFile.hidden = NO;
        btnSelectSatus.hidden = NO;
        btnAssighnTo.hidden = NO;
        btnRevisedDate.hidden = NO;
        btnParcentages.hidden = NO;
        txtSubTask.userInteractionEnabled = YES;
        
        //  txtSubTask in side cell
        //    btncancelTask in sidse cell
        txtComments.userInteractionEnabled = YES;
        
    }else{
//        viewSubtaskNotes;
        txtTitle.userInteractionEnabled= NO;
        lblAdd.hidden = YES;
        lblPlus.hidden = YES;
        lblChange.hidden = YES;
        btnDelete.hidden = YES;
        btnTag.hidden = YES;
        btnAddSubtask.hidden = YES;
        btnPostNotes.hidden = YES;
        btnUploadFile.hidden = YES;
       // btnSelectSatus.hidden = YES;
        btnAssighnTo.hidden = YES;
        btnRevisedDate.hidden = YES;
        btnParcentages.hidden = YES;
        txtSubTask.userInteractionEnabled = NO;
        [self ManageSubtaskView];
      //  txtSubTask in side cell
    //    btncancelTask in sidse cell
        txtComments.userInteractionEnabled = NO;
    }
}

-(void)updatWeb{
        NSString *parameter = [@"&actionlog_id=" stringByAppendingString:[[[arrayGetDetail objectAtIndex:0]strId] stringByAppendingString:[@"&edit_type=single" stringByAppendingString:[@"&page_view=" stringByAppendingString:@"Opened"]]]];
    NSDictionary *dataDictionary= [[NSMutableDictionary alloc]init];
    dataDictionary = [Methods WebServerData:urlUpdatAction andPostParameter:parameter];
    
    //NSLog(@"Open View %@",dataDictionary);
}
-(void)ForTag{
    [self GetTag];
    
    clickhideDropDown = @"YES";
    if([[[arrayGetDetail objectAtIndex:0]strTagId] isEqualToString:@"No Tag"] ){
    }else{
        [self ManageTagView1];
        [self PreeTag];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    // [self setNeedsStatusBarAppearanceUpdate];
    return UIStatusBarStyleLightContent;
}
-(IBAction)linkDownload:(id)sender{
    UIButton *btnDownload= sender;
    //NSLog(@"Downlod image name of person %@",[[evntNote objectAtIndex:btnDownload.tag] strAuthor]);
    
    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[arrayPrint objectAtIndex:btnDownload.tag] strWebImagePath]]]];
    UIImageWriteToSavedPhotosAlbum(image,nil,nil,nil);
    // Let's save the file into Document folder.**
    NSString *Dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *pngPath = [NSString stringWithFormat:@"%@/test.png",Dir];// this path if you want save reference path in sqlite
    NSData *data1 = [NSData dataWithData:UIImagePNGRepresentation(image)];
    [data1 writeToFile:pngPath atomically:YES];
    //  NSString *dateStr=[NSString stringWithFormat:@"%@",[NSDate date]];
    //NSString *imageName = [dateStr stringByAppendingString:@".jpg"];
    //NSLog(@"saving jpeg");
    NSString *jpegPath = [NSString stringWithFormat:@"%@/%@",Dir,selctEmageName];// this path if you want save reference path in sqlite
    NSData *data2 = [NSData dataWithData:UIImageJPEGRepresentation(image, 1.0f)];//1.0f = 100% quality
    [data2 writeToFile:jpegPath atomically:YES];
    [self showUiAlertWithMessage:@"Attachment Downloaded successfully, Please check your gallery" andtitle:@"Done"];
}


- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    alertDelete = 0;
//    isNewTag= @"NO";
//    viewTag.hidden = YES;
//    Methods = [[AllMethods alloc]init];
//    
//    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
//    [table1 addGestureRecognizer:longPress];
//    
//    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
//    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
//    numberToolbar.items = [NSArray arrayWithObjects:
//                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
//                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad1)],
//                           nil];
//    [numberToolbar sizeToFit];
//    txtPercenatages.inputAccessoryView = numberToolbar;
//    txtComments.inputAccessoryView = numberToolbar;
//    cellWidth = lblTEST.frame.size.width;
//    cellWidth1= lblTEST1.frame.size.width;
//    NSMutableAttributedString *attributeString11 = [[NSMutableAttributedString alloc] initWithString:getActionLogTitle];
//    [attributeString11 addAttribute:NSUnderlineStyleAttributeName
//                             value:@2
//                             range:NSMakeRange(0, [attributeString11 length])];
//    //txtTitle.attributedText = attributeString11;
//    txtTitle.text =getActionLogTitle;
//    viewRevisedDate.hidden = YES;
//    viewPercenatages.hidden = YES;
//    NSMutableAttributedString *attributeString1 = [[NSMutableAttributedString alloc] initWithString:[[arrayGetDetail objectAtIndex:0]strRevisedDate]];
//    [attributeString1 addAttribute:NSUnderlineStyleAttributeName
//                            value:@2
//                            range:NSMakeRange(0, [attributeString1 length])];
//    lblReviceDate.attributedText = attributeString1;
//    lblDueDate.text = [[arrayGetDetail objectAtIndex:0]strDueDate];
//    lblDueDate.textColor = [Methods colorWithHexString:[[arrayGetDetail objectAtIndex:0]strColor]];
//
//    if ([@"No Revised Date" isEqualToString:[[arrayGetDetail objectAtIndex:0]strRevisedDate]]) {
//        lblReviceDate.textColor = [Methods colorWithHexString:@"000000"];
//        if([[[arrayGetDetail objectAtIndex:0]strColor] isEqualToString:@"red"]){
//            lblDueDate.textColor = [Methods colorWithHexString:@"E35444"];
//        }else{
//            lblDueDate.textColor = [Methods colorWithHexString:@"74AD46"];//74AD46
//        }
//    }else{
//        lblDueDate.textColor = [Methods colorWithHexString:@"000000"];
//        if([[[arrayGetDetail objectAtIndex:0]strColor] isEqualToString:@"red"]){
//            lblReviceDate.textColor = [Methods colorWithHexString:@"E35444"];
//            //lblDueDate.textColor = [Methods colorWithHexString:@"E35444"];
//
//        }else{
//            lblReviceDate.textColor = [Methods colorWithHexString:@"74AD46"];//74AD46
//           // lblDueDate.textColor = [Methods colorWithHexString:@"E35444"];//74AD46
//        }
//        //lblReviceDate.textColor = [Methods colorWithHexString:[[arrayGetDetail objectAtIndex:0]strColor]];
//    }
////lblDueDate.textColor = [Methods colorWithHexString:@"E35444"];
//    //lblReviceDate.text = [[arrayGetDetail objectAtIndex:0]strRevisedDate];
//    
//    lblCreatedDate.text = [[arrayGetDetail objectAtIndex:0]strCreatedDate];
//    lblCreatedBy.text = [[arrayGetDetail objectAtIndex:0]strCreatedBy];
//    
//    NSMutableAttributedString *attributeString10 = [[NSMutableAttributedString alloc] initWithString:[[arrayGetDetail objectAtIndex:0]strAssignTo]];
//    [attributeString10 addAttribute:NSUnderlineStyleAttributeName
//                              value:@2
//                              range:NSMakeRange(0, [attributeString10 length])];
//    lblAssignTo.attributedText = attributeString10;
//  //  lblReviceDate.text = [[arrayGetDetail objectAtIndex:0]strRevisedDate];
//    
//    [self viewMain];
//    timer = [NSTimer scheduledTimerWithTimeInterval:.000001 target:self selector:@selector(initialize) userInfo:nil repeats:NO];
//    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(stopGIF) userInfo:nil repeats:NO];
}
-(void)doneWithNumberPad{
    [txtTitle resignFirstResponder];
    NSDictionary *dataDictionary = [[NSMutableDictionary alloc]init];
    NSString *parameter = [@"&actionlog_id=" stringByAppendingString:[[[arrayGetDetail objectAtIndex:0]strId] stringByAppendingString:[@"&edit_type=single" stringByAppendingString:[@"&title=" stringByAppendingString:txtTitle.text]]]];
   dataDictionary = [Methods WebServerData:urlUpdatAction andPostParameter:parameter];
    
    //NSLog(@"Title Chaneg %@",dataDictionary);
}
- (void)initialize{
    Methods = [[AllMethods alloc]init];
    [self WebServices];
    [self webAssignToData];
    
    [self GetSubtaskList:^(BOOL finished) {
        if(finished){
//            strManageTableView = @"SubTask";
//            [table1 reloadData];
            [self ManageSubtaskView];
            NSLog(@"success StatusArray");
        }
    }];
//
    [self webData:^(BOOL finished) {
        if(finished){
            
            [table1  reloadData];
            [self ManageSubtaskView];
            NSLog(@"Web data success");
        }
    }];
    
    [self StatusArray:^(BOOL finished) {
        if(finished){
//            [table1  reloadData];
//            [self ManageSubtaskView];
            NSLog(@"success StatusArray");
        }
    }];
    
//    [self webData];
//    [self StatusArray];
  //[self GetTag];
    
    clickhideDropDown = @"YES";
//    if([[[arrayGetDetail objectAtIndex:0]strTagId] isEqualToString:@"No Tag"] ){
//    }else{
//        [self ManageTagView1];
//        [self PreeTag];
//    }
//    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(GetSubtaskList) userInfo:nil repeats:NO];
    [self manageFullView];
   // [self GetSubtaskList];
}


- (IBAction)longPressGestureRecognized:(id)sender {
    strManageTableView = @"SubTask";
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    UIGestureRecognizerState state = longPress.state;
    
    CGPoint location = [longPress locationInView:table];
    NSIndexPath *indexPath = [table indexPathForRowAtPoint:location];
    
    static UIView       *snapshot = nil;        ///< A snapshot of the row user is moving.
    static NSIndexPath  *sourceIndexPath = nil; ///< Initial index path, where gesture begins.
   // NSInteger postion;
    static NSIndexPath  *postion = nil;
    switch (state) {
        case UIGestureRecognizerStateBegan: {
            if (indexPath) {
                sourceIndexPath = indexPath;
                UITableViewCell *cell = [table cellForRowAtIndexPath:indexPath];
                cell.backgroundColor = [UIColor grayColor];
               //NSLog(@"Indexpath . row %ld",(long)indexPath.row);
                postion = indexPath;
                // Take a snapshot of the selected row using helper method.
                snapshot = [self customSnapshoFromView:cell];
                // Add the snapshot as subview, centered at cell's center...
                __block CGPoint center = cell.center;
                snapshot.center = center;
                snapshot.alpha = 0.0;
                [table addSubview:snapshot];
                [UIView animateWithDuration:0.25 animations:^{
                    
                    // Offset for gesture location.
                    center.y = location.y;
                    snapshot.center = center;
                    snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
                    snapshot.alpha = 0.98;
                    cell.alpha = 0.0;
                    
                } completion:^(BOOL finished) {
                    cell.hidden = YES;
                }];
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            CGPoint center = snapshot.center;
            center.y = location.y;
            snapshot.center = center;
            // Is destination valid and is it different from source?
            if (indexPath && ![indexPath isEqual:sourceIndexPath]) {
               //NSLog(@"Indexpath . row Second %ld",(long)indexPath.row);
                // ... update data source.
                // ... move the rows.
                [table moveRowAtIndexPath:sourceIndexPath toIndexPath:indexPath];
                // ... and update source so it is in sync with UI changes.
                sourceIndexPath = indexPath;
            }
            break;
        }
        case UIGestureRecognizerStateEnded:{
            //NSLog(@"Indexpath %ld. row Second %ld",(long)postion.row,(long)indexPath.row);
            [self viewMain];
//            CustomData *cmd= [[CustomData alloc]init];
//            cmd= [arraySubTask objectAtIndex:postion.row];
//            CustomData *cmd1 = [[CustomData alloc]init];
//            cmd1=[arraySubTask objectAtIndex:indexPath.row];
//            
//            [arraySubTask replaceObjectAtIndex:postion.row withObject:cmd1];
//            [arraySubTask replaceObjectAtIndex:indexPath.row withObject:cmd];
//            NSString *strPara=[@"actionlog_id=" stringByAppendingString:getActionLogId];
//            for(int i =0;i<arraySubTask.count;i++){
//                strPara = [strPara stringByAppendingString:[@"&positions["stringByAppendingString:[[NSString stringWithFormat:@"%d",i]stringByAppendingString:[@"]="stringByAppendingString:[[arraySubTask objectAtIndex:i]strSubTaskId]]]]];
//            }
            //timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(ReorderTask:postion: AndSecondPAth:indexPath:) userInfo:nil repeats:NO];
            [self ReorderTask:postion AndSecondPAth:indexPath];
//            [self stopGIF];
//            arraySubTask
//            break;
        }
        default: {
            // Clean up.
            UITableViewCell *cell = [table cellForRowAtIndexPath:sourceIndexPath];
            cell.hidden = NO;
            cell.alpha = 0.0;
            [UIView animateWithDuration:0.25 animations:^{
                snapshot.center = cell.center;
                snapshot.transform = CGAffineTransformIdentity;
                snapshot.alpha = 0.0;
                cell.alpha = 1.0;
            } completion:^(BOOL finished) {
                sourceIndexPath = nil;
                [snapshot removeFromSuperview];
                snapshot = nil;
            }];
            break;
        }
    }
}

#pragma mark - Helper methods

/** @brief Returns a customized snapshot of a given view. */
- (UIView *)customSnapshoFromView:(UIView *)inputView {
    
    // Make an image from the input view.
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Create an image view.
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    
    return snapshot;
}


#pragma -mark UITableview Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Default is 1 if not implemented
    if (tableView == table1){
//    if([strManageTableView isEqualToString:@"History"]){
        return 1;
    }else{
        return 1;
        //return arraySubTask.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if([strManageTableView isEqualToString:@"History"]){
    if (tableView == table1){
        return arrayPrint.count;
    }else{
        return arraySubTask.count;
        //return 1;
    }
    //return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomCell *cell;
    NSLog(@"arraySubTask.count %lu",(unsigned long)arraySubTask.count);
    NSLog(@"Status := %@ Array count %lu Number of Rows :=  %ld ",strManageTableView,(unsigned long)arrayPrint.count,(long)indexPath.row);
     //cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if([strManageTableView isEqualToString:@"History"]){
       if (tableView == table1){
        //NSLog(@"strManageTableView  === %@",[[arrayPrint objectAtIndex:indexPath.row]strStatus]);
        if ([@"Commented" isEqualToString:[[arrayPrint objectAtIndex:indexPath.row]strStatus]]) {
             cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            cell.viewComments.hidden = false;
            cell.viewAction.hidden = true;
            cell.lblName.text =[[arrayPrint objectAtIndex:indexPath.row]strActionUserName];
            cell.lblDate.text = [[arrayPrint objectAtIndex:indexPath.row]strCreatedDate];
            cell.lblDescription.text =[[arrayPrint objectAtIndex:indexPath.row]strDescription];
            
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
            cell.lblDate1.text = [[arrayPrint objectAtIndex:indexPath.row]strCreatedDate];
            NSString *STR = [[[arrayPrint objectAtIndex:indexPath.row]strActionUserName] stringByAppendingString:[@" " stringByAppendingString:[[arrayPrint objectAtIndex:indexPath.row]strStatus]]];
           
            CGFloat boldTextFontSize = 11.0f;
            
            cell.lblActionStatus.text = STR;
            
            cell.lblActionStatus.text = [NSString stringWithFormat:@"%@ %@",[[arrayActionHistory objectAtIndex:indexPath.row]strActionUserName],[[arrayPrint objectAtIndex:indexPath.row]strStatus]];
            NSLog(@"Statys %@",[[arrayPrint objectAtIndex:indexPath.row]strStatus]);
            NSRange range1 = [cell.lblActionStatus.text rangeOfString:[[arrayPrint objectAtIndex:indexPath.row]strActionUserName]];
            
            NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:cell.lblActionStatus.text];
            
            [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSize]}
                                    range:range1];
            cell.lblActionStatus.attributedText = attributedText;
            
            if ([@"Opened" isEqualToString:[[arrayPrint objectAtIndex:indexPath.row]strKey]]) {
                cell.imgIcone1.image = [UIImage imageNamed:@"icon2.png"];
            }
            if ([@"Closed" isEqualToString:[[arrayPrint objectAtIndex:indexPath.row]strKey]]) {
                cell.imgIcone1.image = [UIImage imageNamed:@"icon1.png"];
            }
            if ([@"Revised" isEqualToString:[[arrayPrint objectAtIndex:indexPath.row]strKey]]) {
                cell.imgIcone1.image = [UIImage imageNamed:@"clock.png"];
            }
            if ([@"Percentage" isEqualToString:[[arrayPrint objectAtIndex:indexPath.row]strKey]]) {
                cell.imgIcone1.image = [UIImage imageNamed:@"icon3.png"];
            }
            if ([@"Assigned" isEqualToString:[[arrayPrint objectAtIndex:indexPath.row]strKey]]) {
                cell.imgIcone1.image = [UIImage imageNamed:@"ic_AssignTo.png"];
            }
            if ([@"Worked" isEqualToString:[[arrayPrint objectAtIndex:indexPath.row]strKey]]) {
                cell.imgIcone1.image = [UIImage imageNamed:@"clock.png"];
            }
            cell.viewAction.hidden = false;
            cell.viewComments.hidden = true;
        }
        
//        cell.imgIcone.image = [UIImage imageNamed:@""];
//        cell.imgProfile.image =[UIImage imageNamed:@""];
//        cell.imgChat.image = [UIImage imageNamed:@""];
//        cell.lblDate.text =@"";
//        cell.lblName.text = @"";
//        cell.lblDescription.text = @"";
            //NSLog(@"INSAID ");
        //cell.viewAction.hidden = YES;
        
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        //        cell.accessoryView = accessory;
        if([getStatus isEqualToString:@"Dashboard"]){
            cell.txtSubTask.userInteractionEnabled = YES;
            cell.btnCancelTask.hidden = NO;
            cell.btnCheck.hidden = NO;
            cell.btnCompleteTask.hidden = NO;
            UIButton *accessory = [[UIButton alloc]initWithFrame:CGRectMake(lblTest.frame.origin.x,10, 22, 26)];
            [accessory addTarget:self action:@selector(EditSubtask:) forControlEvents:UIControlEventTouchUpInside];
            // [accessory setBackgroundColor:[UIColor lightGrayColor]];
            [cell addSubview:accessory];
        }else{
            cell.imgIcone.hidden = YES;
            cell.txtSubTask.userInteractionEnabled = NO;
            cell.btnCancelTask.hidden = YES;
            cell.btnCheck.hidden = YES;
            cell.btnCompleteTask.hidden = YES;
        }
        NSLog(@"indexPath.row]%ld ",(long)indexPath.row);
        cell.btnCancelTask.tag = indexPath.row;
        cell.btnCompleteTask.tag = indexPath.row;
        cell.txtSubTask.tag =[[[arraySubTask objectAtIndex:indexPath.row]strSubTaskId] intValue];
        cell.txtSubTask.userInteractionEnabled = NO;
        if ([[[arraySubTask objectAtIndex:indexPath.row]strStatus] isEqualToString:@"Completed"]) {
            NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:[[arraySubTask objectAtIndex:indexPath.row]strSubTaskName]];
            [attributeString addAttribute:NSStrikethroughStyleAttributeName
                                value:@1
                                range:NSMakeRange(0, [attributeString length])];
            cell.txtSubTask.attributedText = attributeString;
            cell.imgCompleteTask.image = [UIImage imageNamed:@"taskCheck.png"];
            cell.imgCancelTask.hidden = NO;
            //cell.btnCompleteTask.hidden = YES;
           // cell.btnCompleteTask.tag=1;
            cell.btnCancelTask.hidden = NO;
        }else{
            NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:[[arraySubTask objectAtIndex:indexPath.row]strSubTaskName]];
            [attributeString addAttribute:NSStrikethroughStyleAttributeName
                                    value:@0
                                    range:NSMakeRange(0, 0)];
            cell.txtSubTask.attributedText = attributeString;
           // cell.txtSubTask.text = [[arraySubTask objectAtIndex:indexPath.row]strSubTaskName];
            cell.imgCompleteTask.image = [UIImage imageNamed:@"taskUnCheck.png"];
           // cell.imgCancelTask.hidden = YES;
            //cell.btnCompleteTask.tag=2;
        }
        if([@"Archived" isEqualToString:[[arrayGetDetail objectAtIndex:0]strFrom]]){
            cell.btnCompleteTask.hidden = YES;
            cell.imgCancelTask.hidden = YES;
            cell.btnCancelTask.hidden = YES;
            cell.txtSubTask.userInteractionEnabled = NO;
        }
    }
    [cell.txtSubTask setContentOffset:CGPointZero animated:NO];
    [cell.txtSubTask scrollRangeToVisible:NSMakeRange(0, -1)];
    if(indexPath.row%2==0){
        cell.backgroundColor = [Methods colorWithHexString:@"F6F6F6"];
    }else{
        cell.backgroundColor = [Methods colorWithHexString:@"FFFFFF"];
    }
    return  cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width,10)];
    [view setBackgroundColor: [UIColor clearColor]];
    return view;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == table1){
        return 0;
    }else{
        return 10;
    }
    //return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   if (tableView == table1){
        if ([@"Commented" isEqualToString:[[arrayPrint objectAtIndex:indexPath.row]strKey]]) {
        //    return 80
            
            NSString *strL = [[arrayPrint objectAtIndex:indexPath.row]strDescription];
            
            UIFont *fontText = [UIFont systemFontOfSize:13];
            CGSize maximumLabelSize = CGSizeMake(cellWidth, 200000.0f);
            CGRect textRect = [strL boundingRectWithSize:maximumLabelSize
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName:fontText}
                                                 context:NSLineBreakByWordWrapping];
            CGSize  size = CGSizeMake(textRect.size.width, textRect.size.height);
            
            //        CGSize  textSize = {200.f, 200000.0f};
            //      CGSize  size = [strL  sizeWithFont: [UIFont systemFontOfSize:14.0f] constrainedToSize: textSize lineBreakMode: NSLineBreakByWordWrapping];
            size.height += 60.0f;
            //NSlog(@"hieght of row FIRST  %@",strL );
            float result = MAX(size.height, 80.0f);
            return result;

        }else{
            CGFloat boldTextFontSize = 11.0f;
            // cell.lblActionStatus.text = STR;
            NSString *strL = [NSString stringWithFormat:@"%@ %@",[[arrayActionHistory objectAtIndex:indexPath.row]strActionUserName],[[arrayPrint objectAtIndex:indexPath.row]strStatus]];
            
            NSRange range1 = [strL rangeOfString:[[arrayPrint objectAtIndex:indexPath.row]strActionUserName]];
            
            NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:strL];
            
            [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSize]}
                                    range:range1];
            //cell.lblActionStatus.attributedText = attributedText;
            //NSString *strL = [NSString stringWithFormat:@"%@ %@",[[arrayActionHistory objectAtIndex:indexPath.row]strActionUserName],[[arrayPrint objectAtIndex:indexPath.row]strStatus]];
            //[[arrayPrint objectAtIndex:indexPath.row]strDescription];
            //NSLog(@" row FIRST  st%@ \n Cell size %f",strL,cellWidth1);
            UIFont *fontText = [UIFont systemFontOfSize:12];
            CGSize maximumLabelSize = CGSizeMake(cellWidth1-55, 200000.0f);
            CGRect textRect = [strL boundingRectWithSize:maximumLabelSize
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName:fontText}
                                                 context:NSLineBreakByWordWrapping];
            CGSize  size = CGSizeMake(textRect.size.width, textRect.size.height);
           //  NSLog(@"hieght of row FIRST  %f  Widht %f",size.height,size.width);
            //        CGSize  textSize = {200.f, 200000.0f};
            //      CGSize  size = [strL  sizeWithFont: [UIFont systemFontOfSize:14.0f] constrainedToSize: textSize lineBreakMode: NSLineBreakByWordWrapping];
//            size.height;// += 10.0f;
            NSLog(@"Height %f",size.height);
            float result = MAX(size.height, 47.0f);
            return result;
            //return 47;
        }
    }else{
       // NSString *strL = [[arrayActionHistory objectAtIndex:indexPath.row]strDescription];
        NSString *strL = [[arraySubTask objectAtIndex:indexPath.row]strSubTaskName];
        
        UIFont *fontText = [UIFont systemFontOfSize:14];
        CGSize maximumLabelSize = CGSizeMake(lblSubtaskSize.frame.size.width, 200000.0f);
        CGRect textRect = [strL boundingRectWithSize:maximumLabelSize
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName:fontText}
                                             context:NSLineBreakByWordWrapping];
        CGSize  size = CGSizeMake(textRect.size.width, textRect.size.height);
        
        //        CGSize  textSize = {200.f, 200000.0f};
        //      CGSize  size = [strL  sizeWithFont: [UIFont systemFontOfSize:14.0f] constrainedToSize: textSize lineBreakMode: NSLineBreakByWordWrapping];
        size.height += 36.0f;
        //NSlog(@"hieght of row FIRST  %@",strL );
        float result = MAX(size.height, 64.0f);
        return result;

        
       // return 64;
    }
}

//
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}
//
//- (BOOL)tableView:(UITableView *)tableview canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}
//
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
//{
//    //NSLog(@"MOVE");
////    NSString *item = [arraySubTask objectAtIndex:sourceIndexPath.row];
////    [arraySubTask removeObject:item];
////    [arraySubTask insertObject:item atIndex:destinationIndexPath.row];
//    
//    [arrayActionHistory exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
//}

#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    return [arrayPrint1 count];
}

#pragma mark- Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    //    if([SELECTPICKER isEqualToString:@"Timezone"])
    {
       // [txtTagSearch setText:[arrayPrint1 objectAtIndex:row]];
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


#pragma mark- Picker View Delegate
-(void)czpickerView:(PickerView *)pickerView didConfirmWithItemAtRow:(NSInteger)row {
    int anIndex = (int)row;
    AnIndex = anIndex;
    if([@"Select Status" isEqualToString:dropDownSelection]){
        txtAllSatus.text = [[arrayStatus objectAtIndex:anIndex]strPropertyAddress];
        if([@"All" isEqualToString:txtAllSatus.text]){
            arrayPrint = [[NSMutableArray alloc]initWithArray:arrayActionHistory];
            strManageTableView = @"History";
            //NSLog(@"History ");
            [table1  reloadData];
            [self ManageSubtaskView];
        }else{
            arrayPrint = [[NSMutableArray alloc]init];
            for(int i =0; i<arrayActionHistory.count ;i++){
                if([txtAllSatus.text isEqualToString:[[arrayActionHistory objectAtIndex:i]strPropertyAddress] ]){
                    CustomData *cmd = [[CustomData alloc]init];
                    cmd = [arrayActionHistory objectAtIndex:i];
                    [arrayPrint addObject:cmd];
                }
            }
            timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(test) userInfo:nil repeats:NO];
        }
        strManageTableView=@"History";
        [table1 reloadData];
    }
    else{
        
        if([[[arrayAssignTo objectAtIndex:anIndex]strPropertyAddress] isEqualToString:@"Assign To"]){
            [self showUiAlertWithMessage:@"Please select proper Assign to " andtitle:@""];
            
        }else{
            if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
                alertDelete = 5;
                UIAlertView *obj=[[UIAlertView alloc]initWithTitle:@""
                                                           message:@"If you will change assignee. The available tags of this action will be reset"
                                                          delegate:self
                                                 cancelButtonTitle:@"Cancel"
                                                 otherButtonTitles: @"Ok", nil];
                [obj show];
                
                //[self showUiAlertWithMessage:@"If you will change assignee. The available tags of this action will be reset" andtitle:@""];
            }else{
                NSString *stringWithoutSpaces = [[arrayAssignTo objectAtIndex:anIndex]strKey];
                NSString *parameter = [@"&actionlog_id=" stringByAppendingString:[[[arrayGetDetail objectAtIndex:0]strId] stringByAppendingString:[@"&edit_type=single" stringByAppendingString:[@"&assigned_to=" stringByAppendingString:stringWithoutSpaces]]]];
                NSDictionary *dataDictionary = [[NSMutableDictionary alloc]init];
                
                dataDictionary = [Methods WebServerData:urlUpdatAction andPostParameter:parameter];
                NSLog(@"Assign to  %@",dataDictionary);
                
                NSMutableAttributedString *attributeString1 = [[NSMutableAttributedString alloc] initWithString:[[arrayAssignTo objectAtIndex:anIndex]strPropertyAddress]];
                [attributeString1 addAttribute:NSUnderlineStyleAttributeName
                                         value:@2
                                         range:NSMakeRange(0, [attributeString1 length])];
                
                lblAssignTo.attributedText = attributeString1;
                if ([@"Staff" isEqualToString:appDelegate.STRUSERTYPE]) {
                    //                  Dashboard *second=[self.storyboard instantiateViewControllerWithIdentifier:@"dashboard"] ;
                    //                  [self.navigationController pushViewController:second animated:YES];
                }
                [self webData:^(BOOL finished) {
                    if(finished){
                        [table1  reloadData];
                        [self ManageSubtaskView];
                        NSLog(@"success");
                    }
                }];
            }
        }
    }
}

#pragma mark- dropdown selection
- (void)DropDownPicker : (NSString *)title andSelectionArray:(NSMutableArray *)arrayData{
    if (!self.statusPickerView) {
        self.statusPickerView = [[PickerView alloc] initWithHeaderTitle:title values:arrayData];
        self.statusPickerView.delegate = self;
    }
    self.statusPickerView.values = arrayData;
    [self.statusPickerView show];
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

#pragma -mark UIButton IBAction

- (IBAction)AddSubtask:(id)sender{//
    [self.view endEditing:YES];
    if([@"NotEmpty" isEqualToString:[Methods whitSpace:txtSubTask.text]]){
        NSString *parameter=[@"&actionlog_id=" stringByAppendingString:[getActionLogId stringByAppendingString:[@"&action_type=" stringByAppendingString:[@"add" stringByAppendingString:[@"&task_name=" stringByAppendingString:txtSubTask.text]]]]];
        NSDictionary *dataDictionary = [[NSMutableDictionary alloc]init];
        dataDictionary = [Methods  WebServerData:urlAddUpdateSubTask andPostParameter:parameter];
        txtSubTask.text = @"";
        [self GetSubtaskList:^(BOOL finished) {
            if(finished){
                [self ManageSubtaskView];
                NSLog(@"success StatusArray");
            }
        }];
    }
}

- (IBAction)Back:(id)sender{
    [self.view endEditing:YES];
    txtAllSatus.text = @"All";
    [self updatWeb1];
    if([getStatus isEqualToString:@"Dashboard"]){
        Dashboard *second=[self.storyboard instantiateViewControllerWithIdentifier:@"dashboard"] ;
        [self.navigationController pushViewController:second animated:YES];
    }else{
        Archived *second=[self.storyboard instantiateViewControllerWithIdentifier:@"archived"] ;
        [self.navigationController pushViewController:second animated:YES];
    }
}

- (IBAction)CancelTask:(id)sender{
    [self.view endEditing:YES];
    txtAllSatus.text = @"All";
    UIButton *btn = sender;
    // if([@"NotEmpty" isEqualToString:[Methods whitSpace:txtSubTask.text]])
    {
        
        NSString *strTaskId = [[arraySubTask objectAtIndex:btn.tag]strSubTaskId];
        NSString *parameter=[@"&actionlog_id=" stringByAppendingString:[getActionLogId stringByAppendingString:[@"&action_type=" stringByAppendingString:[@"status" stringByAppendingString:[@"&subtask_id=" stringByAppendingString:[strTaskId stringByAppendingString:[@"&status=" stringByAppendingString:@"Removed"]]]]]]];
        
        //NSLog(@"Parameter %@",parameter);
        NSDictionary *dataDictionary = [[NSMutableDictionary alloc]init];
        dataDictionary = [Methods  WebServerData:urlAddUpdateSubTask andPostParameter:parameter];
        //NSArray *dataAry = [dataDictionary objectForKey:@"info"];
        //NSLog(@"CancelTask Subtask %@",dataAry);
        [arraySubTask removeObjectAtIndex:btn.tag];
        txtSubTask.text = @"";
        [self GetSubtaskList:^(BOOL finished) {
            if(finished){
//                strManageTableView = @"SubTask";
//                [table1 reloadData];
                [self ManageSubtaskView];
                NSLog(@"success StatusArray");
            }
        }];
//        [self GetSubtaskList];
    }
}

- (IBAction)Completed:(id)sender{
    [self.view endEditing:YES];
    txtAllSatus.text = @"All";
    UIButton *btn = sender;
    
    NSString *strTaskId=[[arraySubTask objectAtIndex:btn.tag]strSubTaskId];
    NSString *strStatus =[[arraySubTask objectAtIndex:btn.tag]strStatus];
    NSString *parameter=[@"&actionlog_id=" stringByAppendingString:[getActionLogId stringByAppendingString:[@"&action_type=" stringByAppendingString:[@"status" stringByAppendingString:[@"&subtask_id=" stringByAppendingString:strTaskId]]]]];
    if([strStatus isEqualToString:@"Completed" ]){
        parameter = [parameter stringByAppendingString:[@"&status=" stringByAppendingString:@"In Progress"]];
    }else{
        parameter = [parameter stringByAppendingString:[@"&status=" stringByAppendingString:@"Completed"]];
    }
    // NSLog(@"Parameter %@",parameter);
    NSDictionary *dataDictionary = [[NSMutableDictionary alloc]init];
    dataDictionary = [Methods  WebServerData:urlAddUpdateSubTask andPostParameter:parameter];
    //NSArray *dataAry = [dataDictionary objectForKey:@"info"];
    //NSLog(@" Completed Subtask %@",dataAry);
    
    [self GetSubtaskList:^(BOOL finished) {
        if(finished){
//            strManageTableView = @"SubTask";
//            [table1 reloadData];
            [self ManageSubtaskView];
            NSLog(@"success StatusArray");
        }
    }];
//    [self GetSubtaskList];
}

-(IBAction)CloseDate:(id)sender{
    [self.view endEditing:YES];
    txtAllSatus.text = @"All";
    viewRevisedDate.hidden = YES;
    [myPicker setDate:[NSDate date]];
}


- (IBAction)EditInfo:(id)sender{
    txtAllSatus.text = @"All";
    [self.view endEditing:YES];
    if([getStatus isEqualToString:@"Archived"]){
    }else{
        alertDelete = 1;
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Delete" message:@"Are you sure! You want to delete this action" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [av show];
    }
}

-(IBAction)EditSubtask:(UIButton *)sender{
      UITableViewCell *cell = (UITableViewCell *)sender.superview;
    NSIndexPath *indexPath = [table indexPathForCell:cell];
    //NSLog(@"Click of cell Data %ld",(long)indexPath.row);
    
    CustomCell *celll = [table cellForRowAtIndexPath:indexPath];
    celll.txtSubTask.userInteractionEnabled = YES;
    [celll.txtSubTask becomeFirstResponder];
}


-(IBAction)Percentage:(id)sender{
    viewRevisedDate.hidden = YES;
    
    [self.view endEditing:YES];
    CGRect Frame = viewPercenatages.frame;
    Frame.origin.y   = viewInformation.frame.origin.y+viewInfo.frame.origin.y+lblCompleted.frame.origin.y+lblCompleted.frame.size.height;
    viewPercenatages.frame = Frame;
    txtAllSatus.text = @"All";
    if(viewPercenatages.isHidden)
        viewPercenatages.hidden = NO;
    else
        viewPercenatages.hidden = YES;
    viewRevisedDate.hidden = YES;
    NSString *stringWithoutSpaces = [lblCompleted.text
                                     stringByReplacingOccurrencesOfString:@"%" withString:@""];
    txtPercenatages.text = stringWithoutSpaces;
}

-(IBAction)PercentageUp:(id)sender{
    
    NSString *stringWithoutSpaces = [txtPercenatages.text
                                     stringByReplacingOccurrencesOfString:@"%" withString:@""];
    int it= [stringWithoutSpaces intValue];
    if(it <100||[@"Empty" isEqualToString:[Methods whitSpace:txtPercenatages.text]]){
        it++;
        txtPercenatages.text = [NSString stringWithFormat:@"%d",it] ;
    }
}

-(IBAction)PercentageDown:(id)sender{
    NSString *stringWithoutSpaces = [txtPercenatages.text
                                     stringByReplacingOccurrencesOfString:@"%" withString:@""];
    int it= [stringWithoutSpaces intValue];
    if(it >0){
        it--;
        txtPercenatages.text = [NSString stringWithFormat:@"%d",it];
    }
}

-(IBAction)PercentageSave:(id)sender{
    NSString *strDemo = [txtPercenatages.text stringByAppendingString:@"%"];
    lblCompleted.text = strDemo;//txtPercenatages.text;
    
    NSString *stringWithoutSpaces = [txtPercenatages.text
                                     stringByReplacingOccurrencesOfString:@"%" withString:@""];
    if(stringWithoutSpaces.length ==0){
        stringWithoutSpaces= @"00";
        lblCompleted.text = @"00%";
    }
    NSDictionary *dataDictionary = [[NSMutableDictionary alloc]init];
    NSString *parameter = [@"&actionlog_id=" stringByAppendingString:[[[arrayGetDetail objectAtIndex:0]strId] stringByAppendingString:[@"&edit_type=single" stringByAppendingString:[@"&completed_percentage=" stringByAppendingString:stringWithoutSpaces]]]];
    dataDictionary = [Methods WebServerData:urlUpdatAction andPostParameter:parameter];
    //NSLog(@"Persantages save    %@",dataDictionary);
    [self PercentageCancel:sender];
    [self.view endEditing:YES];
    [self webData:^(BOOL finished) {
        if(finished){
            [table1  reloadData];
            [self ManageSubtaskView];
            NSLog(@"success");
        }
    }];
    
//    [self webData];
}

-(IBAction)PercentageCancel:(id)sender{
    [self.view endEditing:YES];
    viewPercenatages.hidden = YES;
}


-(IBAction)PostNote:(id)sender{
    txtAllSatus.text = @"All";
    [self.view endEditing:YES];

    if([@"NotEmpty" isEqualToString:[Methods whitSpace:txtComments.text]]){
        [txtComments resignFirstResponder];
        NSString *parameter=[@"&actionlog_id=" stringByAppendingString:[getActionLogId stringByAppendingString:[@"&notes=" stringByAppendingString:txtComments.text]]];
        
        //NSLog(@"Parameter %@",parameter);
        NSDictionary *dataDictionary = [[NSMutableDictionary alloc]init];
        dataDictionary = [Methods  WebServerData:urlPostNote andPostParameter:parameter];
       // NSArray *dataAry = [dataDictionary objectForKey:@"info"];
        //NSLog(@"PostNote AddSubtask %@",dataAry);
        txtComments.text = @"";
        lblUpload.text= @"";
        imgSelect.image = [UIImage imageNamed:@""];
        lblPalaceholder.hidden = NO;
        [self webData:^(BOOL finished) {
            if(finished){
                [table1  reloadData];
                [self ManageSubtaskView];
                NSLog(@"success");
            }
        }];
        
//        [self webData];
    }else{
        [self showUiAlertWithMessage:@"Please write note for post" andtitle:@""];
    }
}

- (IBAction)ReviceDate:(id)sender{
    txtAllSatus.text = @"All";
    [self.view endEditing:YES];
    CGRect Frame = viewRevisedDate.frame;
    Frame.origin.y   = viewInformation.frame.origin.y+viewInfo.frame.origin.y+lblReviceDate.frame.origin.y+lblReviceDate.frame.size.height;
    viewRevisedDate.frame = Frame;

    viewPercenatages.hidden= YES;
    strDateSelection = @"ReviceDate";
    if(viewRevisedDate.isHidden){
         lblDatePickerLable.text =@"Revised Due Date";
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setYear:2100];
        [comps setDay:1];
        [comps setMonth:1];
        [comps setHour:12];
        [comps setMinute:59];
        [comps setSecond:59];

        NSDateComponents *comps1 = [[NSDateComponents alloc] init];
        [comps1 setYear:1800];
        [comps1 setDay:1];
        [comps1 setMonth:1];
        [comps1 setHour:12];
        [comps1 setMinute:59];
        [comps1 setSecond:59];
        NSCalendar *cal1 = [NSCalendar currentCalendar];
        NSDate *YourDate1 = [cal1 dateFromComponents:comps1];
        
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDate *YourDate = [cal dateFromComponents:comps];
        [myPicker setMaximumDate: YourDate];
        [myPicker setMinimumDate: YourDate1];

        viewRevisedDate.hidden = NO;
    }else{
       
        viewRevisedDate.hidden = YES;
    }
}

-(IBAction)SaveRevisedDate:(id)sender{
    txtAllSatus.text = @"All";
    if([strDateSelection isEqualToString: @"ReviceDate"]){
        NSDate *chosen = myPicker.date;
        NSDateFormatter  *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd-MMM-yyyy hh:mm a"];
    NSString *fromDay = [NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:chosen]];
    //NSLog(@"Selected date To := %@",fromDay);
//    NSDate *date = [dateFormat dateFromString:[[arrayGetDetail objectAtIndex:0]strDueDate]];
    dateBountry = chosen;
    [self CloseDate:sender];
    dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"dd-MMM-yyyy hh:mm a"];
    NSString *concatDate;
    concatDate = [dateFormat stringFromDate:[NSDate date]];
    NSLog(@"Date %@ \n Current Date %@",fromDate,concatDate) ;
    
    NSDate *firstDate,*secondDate;
    concatDate = [dateFormat stringFromDate:[NSDate date]];
   
    //
    secondDate = [dateFormat dateFromString:concatDate];
    
    //            concatDate = [dateFormat stringFromDate:[NSDate date]];
    //
    //secondDate = [dateFormat dateFromString:concatDate];
    firstDate =[[NSDate alloc]init];
    firstDate = [dateFormat dateFromString:fromDay];
    NSComparisonResult result;
    result = [secondDate compare:firstDate];
    
    
    if (result == NSOrderedAscending){
        lblReviceDate.textColor = [Methods colorWithHexString:@"74AD46"];//74AD46
    }else{
        lblReviceDate.textColor = [Methods colorWithHexString:@"E35444"];
    }
    
    //
    NSMutableAttributedString *attributeString1 = [[NSMutableAttributedString alloc] initWithString:fromDay];
    [attributeString1 addAttribute:NSUnderlineStyleAttributeName
                             value:@2
                             range:NSMakeRange(0, [attributeString1 length])];
    
    lblReviceDate.attributedText = attributeString1;
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *fromDay1 = [NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:chosen]];
    //NSLog(@"Revised Date Update %@",fromDay1);
    lblReviceDate.attributedText = attributeString1;
    
    NSString *parameter = [@"&actionlog_id=" stringByAppendingString:[[[arrayGetDetail objectAtIndex:0]strId] stringByAppendingString:[@"&edit_type=single" stringByAppendingString:[@"&revised_date=" stringByAppendingString:fromDay1]]]];
    NSDictionary *dataDictionary = [[NSMutableDictionary alloc]init];
    dataDictionary = [Methods WebServerData:urlUpdatAction andPostParameter:parameter];
        NSArray *dataAry = [dataDictionary objectForKey:@"info"];
    for (NSDictionary *dic in dataAry) {
        NSLog(@"%@",[dic valueForKey:@"color"]);
        if([[dic valueForKey:@"color"] isEqualToString:@"red"]){
                //                lblWorkDate.textColor = [Methods colorWithHexString:@""]
            lblReviceDate.textColor = [Methods colorWithHexString:@"E35444"];
        }else{
            lblReviceDate.textColor = [Methods colorWithHexString:@"74AD46"];
        }
    }
    [self webData:^(BOOL finished) {
        if(finished){
            [table1  reloadData];
            [self ManageSubtaskView];
            NSLog(@"success");
        }
    }];
    }else{
        
        NSDate *chosen = myPicker.date;
        NSDateFormatter  *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd-MMM-yyyy hh:mm a"];
        NSString *fromDay = [NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:chosen]];
        //NSLog(@"Selected date To := %@",fromDay);
        
        [self CloseDate:sender];
        dateFormat=[[NSDateFormatter alloc]init];
        [dateFormat setDateFormat:@"dd-MMM-yyyy hh:mm a"];
        NSString *concatDate;
        concatDate = [dateFormat stringFromDate:[NSDate date]];
        NSLog(@"Date %@ \n Current Date %@",fromDate,concatDate) ;

        NSMutableAttributedString *attributeString1 = [[NSMutableAttributedString alloc] initWithString:fromDay];
        [attributeString1 addAttribute:NSUnderlineStyleAttributeName
                                 value:@2
                                 range:NSMakeRange(0, [attributeString1 length])];
        
//        lblReviceDate.attributedText = attributeString1;
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *fromDay1 = [NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:chosen]];
        //NSLog(@"Revised Date Update %@",fromDay1);
        lblWorkDate.attributedText = attributeString1;
        
        
        
        NSString *parameter = [@"&actionlog_id=" stringByAppendingString:[[[arrayGetDetail objectAtIndex:0]strId] stringByAppendingString:[@"&edit_type=single" stringByAppendingString:[@"&work_date=" stringByAppendingString:fromDay1]]]];
            NSDictionary *dataDictionary = [[NSMutableDictionary alloc]init];
            dataDictionary = [Methods WebServerData:urlUpdatAction andPostParameter:parameter];
        NSArray *dataAry = [dataDictionary objectForKey:@"info"];
        for (NSDictionary *dic in dataAry) {
            NSLog(@"%@",[dic valueForKey:@"color"]);
            if([[dic valueForKey:@"color"] isEqualToString:@"red"]){
//                lblWorkDate.textColor = [Methods colorWithHexString:@""]
                lblWorkDate.textColor = [Methods colorWithHexString:@"E35444"];
            }else{
                lblWorkDate.textColor = [Methods colorWithHexString:@"74AD46"];
            }
        }
        NSLog(@"Color Code %@",dataDictionary);
            [self webData:^(BOOL finished) {
                if(finished){
                    [table1  reloadData];
                    [self ManageSubtaskView];
                    NSLog(@"success");
                }
            }];
        
        
        
     
    }
//    [self webData];
    //NSLog(@"Revised Date Update %@",dataDictionary);
}

-(IBAction)SelectStatus:(id)sender{
    
    [self.view endEditing:YES];
    if(arrayStatus.count){
        clickhideDropDown = @"NO";
        dropDownSelection = @"Select Status";
        dropDownSelection = @"Select Status";
        txtAllSatus.text = @"All";
        [self DropDownPicker:@"Select Status" andSelectionArray:arrayStatus];
            
//            NSMutableArray *arrayTemp = [[NSMutableArray alloc]init];
//            CGRect rt = txtAllSatus.frame;
//            int height1;
//            height1 =self.view.frame.size.height-240;
//            //NSLog(@"HEIGHT %d",height1);
//            float height = MIN(220,(arrayStatus.count)*44);
//            
//            [self showPopUpWithTitle:@"Select Company" withOption:arrayStatus Option1:arrayTemp xy:CGPointMake(rt.origin.x+5, height1) size:CGSizeMake(rt.size.width+10, height) isMultiple:NO];
     
    }
}
-(IBAction)SelectWorkDate:(id)sender{
    strDateSelection = @"WorkDate";
    txtAllSatus.text = @"All";
    [self.view endEditing:YES];
    CGRect Frame = viewRevisedDate.frame;
    Frame.origin.y   = viewInformation.frame.origin.y+viewInfo.frame.origin.y+lblReviceDate.frame.origin.y+lblReviceDate.frame.size.height;
    viewRevisedDate.frame = Frame;
    
    viewPercenatages.hidden= YES;
    if(viewRevisedDate.isHidden){
        viewRevisedDate.hidden = NO;
        lblDatePickerLable.text =@"Work Date";
        [myPicker setMaximumDate: dateBountry];
    }else{
        viewRevisedDate.hidden = YES;
    }
    
    
}
-(IBAction)SelectAssignTo:(id)sender{
    
    alertDelete = 3;
    if([appDelegate.STRUSERTYPE isEqualToString:@"Staff"])
        [self showUiAlertWithMessage:@"If you will change assignee. The action will be moved on selected assignee" andtitle:@"Alert"];
    else{
    txtAllSatus.text = @"All";
    [self.view endEditing:YES];
    if([@"YES" isEqualToString:clickhideDropDown]){
        
        if(arrayAssignTo.count){
            viewPercenatages.hidden = YES;
            viewRevisedDate.hidden = YES;
            dropDownSelection = @"Select AssignTo";
            [self DropDownPicker:@"Select AssignTo" andSelectionArray:arrayAssignTo];
            
//            clickhideDropDown = @"NO";
//            dropDownSelection = @"Select AssignTo";
//            NSMutableArray *arrayTemp = [[NSMutableArray alloc]init];
//            CGRect rt = lblAssignTo.frame;
//            int height1;
//            height1 =scroll.frame.origin.y+viewInfo.frame.origin.y+
//            lblAssignTo.frame.origin.y+lblAssignTo.frame.size.height+viewInformation.frame.origin.y;
//            //NSLog(@"HEIGHT %d",height1);
//            float height = MIN(220,(arrayAssignTo.count)*44);
//            [self showPopUpWithTitle:@"Select Company" withOption:arrayAssignTo Option1:arrayTemp xy:CGPointMake(rt.origin.x-15, height1) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
//            
        }
    }else{
        clickhideDropDown = @"YES";
        [Dropobj fadeOut];
    }
    }
}

- (IBAction)UploadFIle:(id)sender{
    txtAllSatus.text = @"All";
    UIImagePickerController *pickr =[[UIImagePickerController alloc]init];
    pickr.delegate=(id)self;
    pickr.allowsEditing=YES;
    pickr.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:pickr animated:YES completion:NULL  ];
}

-(void)updateTextFieldDate:(id)sender{
    txtAllSatus.text = @"All";
    NSDate *chosen = [myPicker date];
    [NSTimeZone resetSystemTimeZone];
    NSDateFormatter *dateFormat;
    dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"dd-MMM-yyyy hh:mm a"];
    NSString *fromDay = [NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:chosen]];
    
    NSMutableAttributedString *attributeString1 = [[NSMutableAttributedString alloc] initWithString:fromDay];
    [attributeString1 addAttribute:NSUnderlineStyleAttributeName
                             value:@2
                             range:NSMakeRange(0, [attributeString1 length])];
    [myPicker removeFromSuperview];
    viewRevisedDate.hidden = YES;
}


-(IBAction)SelectImage:(id)sender{
    
}
//
- (IBAction)Dashboard:(id)sender{
    Dashboard *second=[self.storyboard instantiateViewControllerWithIdentifier:@"dashboard"] ;
    [self.navigationController pushViewController:second animated:YES];
}

- (IBAction)Archived:(id)sender{
     [self updatWeb1];
    
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


-(void)doneWithNumberPad1{
    [self.view endEditing:YES];
    //[txtComments resignFirstResponder];
}

#pragma -mark Tag Add Search

- (IBAction)SaveTag:(id)sender{
    
    txtAllSatus.text = @"All";
    [self.view endEditing:YES];
    CustomData *cmd11 = [[CustomData alloc]init];
    int idt =(int)[picker selectedRowInComponent:0] ;
    NSString *StrTag = [arrayPrint1 objectAtIndex:idt];
    //NSLog(@"TAg String %@",StrTag);
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
    // txtTagSearch.text = @"";
    int i = (int)arrayTesting.count;
    // int ibm =(int)arrayTesting.count+1;
    //int TAG = ibm;
    //NSLog(@"arrayTesting width %d",TAG);
    if(arrayTesting.count == 0){
        x= imgBoder.frame.origin.x;
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
    //[lblName setBackgroundColor:[Methods colorWithHexString:@"f1f1f1"]];//[UIColor grayColor]];
    //lblName.layer.borderWidth = 1.0;

    //lblName.layer.borderColor = [[Methods colorWithHexString:@"b1b1b1"] CGColor];
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
    [button addTarget:self action:@selector(SureDelete:) forControlEvents:UIControlEventTouchUpInside];
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
               // [arrayTag1 removeObjectAtIndex:i];
            }
        }
        [picker reloadAllComponents];
        viewTagSearch.hidden = YES;
    }
    [self PrintTag];
    [self ManageTagView1];
    if([isNewTag isEqualToString:@"YES"]){
        NSString *parameter = [@"&actionlog_id=" stringByAppendingString:[[[arrayGetDetail objectAtIndex:0]strId] stringByAppendingString:[@"&edit_type=single" stringByAppendingString:[@"&tags[]=" stringByAppendingString:strDATA]]]];
        NSDictionary *dataDictionary = [[NSMutableDictionary alloc]init];
        dataDictionary = [Methods WebServerData:urlUpdatAction andPostParameter:parameter];
    }
}

- (IBAction)CancelTag:(id)sender{
    viewTagSearch.hidden = YES;
    
}

-(void)SureDelete:(id)sender{
    if([getStatus isEqualToString:@"Archived"]){
        
    }else{
        alertDelete = 2;
        UIButton *Btn = sender;
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Delete" message:@"Are you sure! You want to remove this Tag" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        av.tag = Btn.tag;
        [av show];
    }
}

-(void)myAction:(int)sender{
    if([getStatus isEqualToString:@"Archived"]){
        
    }else{
    int btnTEst = sender;
    //NSLog(@"Buton tag %ld",(long)btnTEst.tag);
    // NSString *idO = [NSString stringWithFormat:@"%ld",(long)btnTEst.tag];
    int value;
    for (int i =0; i<arrayTesting.count; i++) {
        value = [[[arrayTesting objectAtIndex:i]strId] intValue];
        //NSLog(@"TAG VALUE %d",value);
        if(value == btnTEst){
            NSString *strDATA = [NSString stringWithFormat:@"%d",value];
            NSString *parameter = [@"&actionlog_id=" stringByAppendingString:[[[arrayGetDetail objectAtIndex:0]strId] stringByAppendingString:[@"&edit_type=single" stringByAppendingString:[@"&remove_tags[]=" stringByAppendingString:strDATA]]]];
            NSDictionary *dataDictionary = [[NSMutableDictionary alloc]init];
            dataDictionary = [Methods WebServerData:urlUpdatAction andPostParameter:parameter];
            
            //NSLog(@"Remove tag New Tag :== %@",dataDictionary);
            
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
            x= imgBoder.frame.origin.x;
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
            if((FRAME.size.width+FRAME.origin.x+size.width+22)<imgBoder.frame.size.width){
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
        [button addTarget:self action:@selector(SureDelete:) forControlEvents:UIControlEventTouchUpInside];
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
    [self ManageTagView1];
    }
    //[self manageView];
}

-(void)PrintTag{
    //    NSString *param= [@"token="stringByAppendingString:appDelegate.STRTOKEN];
    //    if(arrayTesting.count==0){
    //        param= [@"token="stringByAppendingString:appDelegate.STRTOKEN];
    //    }else{
    //        for(int i =0;i<arrayTesting.count;i++){
    //            if(i==0)
    //                param= [param stringByAppendingString:[@"&tags="stringByAppendingString:[[arrayTesting objectAtIndex:i]strId]]];
    //            else
    //                param= [param stringByAppendingString:[@","stringByAppendingString:[[arrayTesting objectAtIndex:i]strId]]];
    //        }
    //    }
    //NSLog(@"Parameter of tag %@",param);
    //[self PrintGrid:param];
    //[self ManageAtTagTime];
    
}

-(IBAction)AddTag:(id)sender{
    isNewTag= @"YES";
    viewTagSearch.hidden = NO;
}

-(IBAction)RemoveTag:(id)sender{
    [self.view endEditing:YES];
}

#pragma -mark UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  
    if(alertDelete == 1){
        if (buttonIndex == 1) {
            NSString *parameter = [@"actionlog_id[]=" stringByAppendingString:[[[arrayGetDetail objectAtIndex:0]strId] stringByAppendingString:@"&status=Deleted" ]];
            NSDictionary *dataDictionary = [[NSMutableDictionary alloc]init];
            dataDictionary = [Methods WebServerData:urlChangeActionStatus andPostParameter:parameter];
            
            NSLog(@"Delete Info %@",dataDictionary);
            timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(MoveDashboard) userInfo:nil repeats:NO];
        }
        alertDelete = 0;
    }else
    if(alertDelete == 2){
        if (buttonIndex == 1) {
            //NSLog(@"Delete Info %@",dataDictionary);
            [self myAction:alertView.tag];
//            timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(myAction:) userInfo:nil repeats:NO];
        }
        alertDelete = 0;
    }else if(alertDelete == 3){
        txtAllSatus.text = @"All";
        [self.view endEditing:YES];
        if([@"YES" isEqualToString:clickhideDropDown]){
            
            if(arrayAssignTo.count){
                viewPercenatages.hidden = YES;
                viewRevisedDate.hidden = YES;
                dropDownSelection = @"Select AssignTo";
                [self DropDownPicker:@"Select AssignTo" andSelectionArray:arrayAssignTo];
//                
//                clickhideDropDown = @"NO";
//                dropDownSelection = @"Select AssignTo";
//                NSMutableArray *arrayTemp = [[NSMutableArray alloc]init];
//                CGRect rt = lblAssignTo.frame;
//                int height1;
//                height1 =scroll.frame.origin.y+viewInfo.frame.origin.y+
//                lblAssignTo.frame.origin.y+lblAssignTo.frame.size.height+viewInformation.frame.origin.y;
//                //NSLog(@"HEIGHT %d",height1);
//                float height = MIN(220,(arrayAssignTo.count)*44);
//                [self showPopUpWithTitle:@"Select Company" withOption:arrayAssignTo Option1:arrayTemp xy:CGPointMake(rt.origin.x-15, height1) size:CGSizeMake(rt.size.width, height) isMultiple:NO];
            }
        }else{
            clickhideDropDown = @"YES";
            [Dropobj fadeOut];
        }
    }
    if(alertDelete == 5){
        if (buttonIndex == 1){
            [self ChangeAssignTo];
        }else{
            NSLog(@"Else");
        }
    }
    alertDelete = 0;
}

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
    clickhideDropDown = @"YES";
    AnIndex = (int)anIndex;
    
    if([@"Select Status" isEqualToString:dropDownSelection]){
        txtAllSatus.text = [[arrayStatus objectAtIndex:anIndex]strPropertyAddress];
        if([@"All" isEqualToString:txtAllSatus.text]){
            arrayPrint = [[NSMutableArray alloc]initWithArray:arrayActionHistory];
            strManageTableView = @"History";
            //NSLog(@"History ");
            [table1  reloadData];
            [self ManageSubtaskView];
        }else{
            arrayPrint = [[NSMutableArray alloc]init];
            for(int i =0; i<arrayActionHistory.count ;i++){
                if([txtAllSatus.text isEqualToString:[[arrayActionHistory objectAtIndex:i]strPropertyAddress] ]){
                    CustomData *cmd = [[CustomData alloc]init];
                    cmd = [arrayActionHistory objectAtIndex:i];
                    [arrayPrint addObject:cmd];
                }
            }
            timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(test) userInfo:nil repeats:NO];
        }
        strManageTableView=@"History";
        [table1 reloadData];
    }
    else{
        
        if([[[arrayAssignTo objectAtIndex:anIndex]strPropertyAddress] isEqualToString:@"Assign To"]){
            [self showUiAlertWithMessage:@"Please select proper Assign to " andtitle:@""];
            
        }else{
            if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
                alertDelete = 5;
                UIAlertView *obj=[[UIAlertView alloc]initWithTitle:@""
                                                           message:@"If you will change assignee. The available tags of this action will be reset"
                                                          delegate:self
                                                 cancelButtonTitle:@"Cancel"
                                                 otherButtonTitles: @"Ok", nil];
                [obj show];
                
                //[self showUiAlertWithMessage:@"If you will change assignee. The available tags of this action will be reset" andtitle:@""];
            }else{
                NSString *stringWithoutSpaces = [[arrayAssignTo objectAtIndex:anIndex]strKey];
                NSString *parameter = [@"&actionlog_id=" stringByAppendingString:[[[arrayGetDetail objectAtIndex:0]strId] stringByAppendingString:[@"&edit_type=single" stringByAppendingString:[@"&assigned_to=" stringByAppendingString:stringWithoutSpaces]]]];
                NSDictionary *dataDictionary = [[NSMutableDictionary alloc]init];
        
                dataDictionary = [Methods WebServerData:urlUpdatAction andPostParameter:parameter];
        //NSLog(@"Assign to  %@",dataDictionary);
        
                NSMutableAttributedString *attributeString1 = [[NSMutableAttributedString alloc] initWithString:[[arrayAssignTo objectAtIndex:anIndex]strPropertyAddress]];
                [attributeString1 addAttribute:NSUnderlineStyleAttributeName
                                 value:@2
                                 range:NSMakeRange(0, [attributeString1 length])];
        
                lblAssignTo.attributedText = attributeString1;
                if ([@"Staff" isEqualToString:appDelegate.STRUSERTYPE]) {
//                  Dashboard *second=[self.storyboard instantiateViewControllerWithIdentifier:@"dashboard"] ;
//                  [self.navigationController pushViewController:second animated:YES];
                }
                [self webData:^(BOOL finished) {
                    if(finished){
                        [table1  reloadData];
                        [self ManageSubtaskView];
                        NSLog(@"success");
                    }
                }];
            }
        }
    }
 }

-(void)ChangeAssignTo{
    NSString *stringWithoutSpaces = [[arrayAssignTo objectAtIndex:AnIndex]strKey];
    NSString *parameter = [@"&actionlog_id=" stringByAppendingString:[[[arrayGetDetail objectAtIndex:0]strId] stringByAppendingString:[@"&edit_type=single" stringByAppendingString:[@"&assigned_to=" stringByAppendingString:stringWithoutSpaces]]]];
    NSDictionary *dataDictionary = [[NSMutableDictionary alloc]init];
    
    dataDictionary = [Methods WebServerData:urlUpdatAction andPostParameter:parameter];
    NSLog(@"Assign to  %@",dataDictionary);
    
    NSMutableAttributedString *attributeString1 = [[NSMutableAttributedString alloc] initWithString:[[arrayAssignTo objectAtIndex:AnIndex]strPropertyAddress]];
    [attributeString1 addAttribute:NSUnderlineStyleAttributeName
                             value:@2
                             range:NSMakeRange(0, [attributeString1 length])];
    
    lblAssignTo.attributedText = attributeString1;
    if ([@"Staff" isEqualToString:appDelegate.STRUSERTYPE] || [@"Super Admin" isEqualToString:appDelegate.STRUSERTYPE] ) {
            Dashboard *second=[self.storyboard instantiateViewControllerWithIdentifier:@"dashboard"] ;
            [self.navigationController pushViewController:second animated:YES];
    }
    [self webData:^(BOOL finished) {
        if(finished){
            [table1  reloadData];
            [self ManageSubtaskView];
            NSLog(@"success");
        }
    }];
}

-(void)test{
    strManageTableView = @"History";
    [table1  reloadData];
  CGRect  frame5 = table1.frame;
    frame5.size.height = table1.contentSize.height;
    table1.frame = frame5;
   int YY =  viewSubtaskNotes.frame.origin.y+viewSubtaskNotes.frame.size.height+20;
    frame5  = viewList.frame;
    frame5.origin.y =   YY;// viewSubtaskNotes.frame.origin.y+viewSubtaskNotes.frame.size.height+20;
    frame5.size.height = viewSubtaskNotes.frame.size.height+viewSubtaskNotes.frame.origin.y+table1.frame.size.height+viewFilter.frame.size.height+30;
    viewList.frame = frame5;
    
    frame5  = viewFull.frame;
    frame5.size.height = viewList.frame.size.height+30;
    viewFull.frame = frame5;
    
    scroll.contentSize=CGSizeMake(0,viewFull.frame.size.height);
    [self ManageSubtaskView];
}

- (void)DropDownListView:(DropDownListView *)dropdownListView Datalist:(NSMutableArray*)ArryData{
    
}



#pragma mark - ImagePickerController delegat methods

-(void)imagePickerController:(UIImagePickerController *)picker11 didFinishPickingMediaWithInfo:(NSDictionary *)info{
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *representation = [myasset defaultRepresentation];
        NSString *fileName = [representation filename];
        lblUpload.text = fileName;
        imgName = fileName;
    };
    imgSelect.image= [Methods compressImage:info[UIImagePickerControllerEditedImage]];
    NSURL *imageURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:imageURL
                   resultBlock:resultblock
                  failureBlock:nil];
    NSString *dateStr=[NSString stringWithFormat:@"%@",[NSDate date]];
    NSString *imageName = [dateStr stringByAppendingString:@".jpg"];
    lblUpload.text = imageName;
    //
    //
    [picker11 dismissViewControllerAnimated:YES completion:NULL];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker11{
    [picker11 dismissViewControllerAnimated:YES completion:NULL];
}

#pragma -mark User Define Function
-(void)GetTag{
  //  if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"])
//    for(int i = 0; i<appDelegate.ARRAYTAG.count;i++){
//        NSLog(@"jkdfghss %@",[[appDelegate.ARRAYTAG objectAtIndex:i]strPropertyAddress]);
//        NSLog(@"jkdfghss %@",[[appDelegate.ARRAYTAG objectAtIndex:i]strKey]);
//    }
   
//    if(appDelegate.ARRAYTAG.count == 0 || appDelegate.ARRAYTAGVALUE.count == 0)
    {
        NSDictionary *dataDictionary = [Methods  WebServerData:urlTagList];
        arrayTag = [[NSMutableArray alloc]init];
        arrayPrint1 = [[NSMutableArray alloc]init];
        arrayPrint11 = [[NSMutableArray alloc]init];
        arrayTag1 = [[NSMutableArray alloc]init];
        
        NSLog(@"Tag list %@",dataDictionary);
        arrayTag = [[NSMutableArray alloc]init];
        arrayPrint1 = [[NSMutableArray alloc]init];
        arrayPrint11 = [[NSMutableArray alloc]init];
        NSArray *dataAry = [dataDictionary objectForKey:@"info"];
            
        for (NSDictionary *dic in dataAry) {
            CustomData *cmd = [[CustomData alloc]init];
            cmd.strKey = [dic valueForKey:@"tag_id"];//[NSString stringWithFormat:@"%@",key];
            cmd.strStatus = [dic valueForKey:@"tag_name"];// [NSString stringWithFormat:@"%@",value];
            cmd.strPropertyAddress = [dic valueForKey:@"tag_name"];//[NSString stringWithFormat:@"%@",value];
            cmd.strCompanyId = [dic valueForKey:@"company_id"];
            cmd.strUserId = [dic valueForKey:@"user_id"];
        
            if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"]){
                if([cmd.strCompanyId = [dic valueForKey:@"company_id"] isEqualToString:@"0"])
                {
                    if([cmd.strUserId isEqualToString:[[arrayGetDetail objectAtIndex:0]strAssignyId]]){
                        [arrayTag addObject:cmd];
                        [arrayTag1 addObject:cmd];
                        [appDelegate.ARRAYTAG addObject:cmd];
                        [arrayPrint1 addObject:cmd.strStatus];
                        [appDelegate.ARRAYTAGVALUE addObject:cmd.strStatus];
                        [arrayPrint11 addObject:cmd.strStatus];
                    }
                }else{
                    if([cmd.strCompanyId = [dic valueForKey:@"company_id"] isEqualToString:[[arrayGetDetail objectAtIndex:0]strAssigneCompanyId]]){
                        [arrayTag addObject:cmd];
                        [arrayTag1 addObject:cmd];
                        [appDelegate.ARRAYTAG addObject:cmd];
                        [arrayPrint1 addObject:cmd.strStatus];
                        [appDelegate.ARRAYTAGVALUE addObject:cmd.strStatus];
                        [arrayPrint11 addObject:cmd.strStatus];
                    }
                }
            }else{
                [arrayTag addObject:cmd];
                [arrayTag1 addObject:cmd];
                [appDelegate.ARRAYTAG addObject:cmd];
                [arrayPrint1 addObject:cmd.strStatus];
                [appDelegate.ARRAYTAGVALUE addObject:cmd.strStatus];
                [arrayPrint11 addObject:cmd.strStatus];
            }
        }
    }
//    else{
//    if([appDelegate.STRUSERTYPE isEqualToString:@"Super Admin"] && ![[[arrayGetDetail objectAtIndex:0]strAssigneCompanyId] isEqualToString:@"0"]){
//        arrayTag = [[NSMutableArray alloc]init];
//        arrayPrint1 = [[NSMutableArray alloc]init];
//        arrayPrint11 = [[NSMutableArray alloc]init];
//        arrayTag1 = [[NSMutableArray alloc]init];
//        for(int i= 0 ;i<appDelegate.ARRAYTAG.count;i++){
////            if([[[arrayGetDetail objectAtIndex:0]strAssigneCompanyId] isEqualToString:@"0"]){
////                
////            }
//            if([[[appDelegate.ARRAYTAG objectAtIndex:i] strCompanyId]  isEqualToString:[[arrayGetDetail objectAtIndex:0]strAssigneCompanyId]]){
//                CustomData *cmd = [[CustomData alloc]init];
//                cmd = [appDelegate.ARRAYTAG objectAtIndex:i];
//                [arrayTagFiletr addObject:cmd];//= [[NSMutableArray alloc]initWithArray:appDelegate.ARRAYTAG];
//                [arrayTag addObject:cmd];//= [[NSMutableArray alloc]initWithArray:appDelegate.ARRAYTAG];
//                [arrayTag1 addObject:cmd];// = [[NSMutableArray alloc] initWithArray:appDelegate.ARRAYTAG];
//                [arrayPrint1 addObject:cmd.strStatus];// = [[NSMutableArray alloc]initWithArray:appDelegate.ARRAYTAGVALUE];
//                [arrayPrint11 addObject:cmd.strStatus];//= [[NSMutableArray alloc]initWithArray:appDelegate.ARRAYTAGVALUE];
//            }
//        }
//        }else{
//            arrayTagFiletr = [[NSMutableArray alloc]initWithArray:appDelegate.ARRAYTAG];
//            arrayTag = [[NSMutableArray alloc]initWithArray:appDelegate.ARRAYTAG];
//            arrayTag1 = [[NSMutableArray alloc] initWithArray:appDelegate.ARRAYTAG];
//            arrayPrint1 = [[NSMutableArray alloc]initWithArray:appDelegate.ARRAYTAGVALUE];
//            arrayPrint11 = [[NSMutableArray alloc]initWithArray:appDelegate.ARRAYTAGVALUE];
//        }
//    }
    [picker reloadAllComponents];
    [picker reloadAllComponents];
}

-(void) GetSubtaskList:(myCompletion) compblock{

    
//-(void)GetSubtaskList{
    NSString *parameter=[@"&actionlog_id=" stringByAppendingString:getActionLogId];
    NSLog(@"Parameter %@",parameter);
    NSDictionary *dataDictionary = [Methods  WebServerData:urlSubTaskList andPostParameter:parameter];
    NSArray *dataAry = [dataDictionary objectForKey:@"info"];
    //
    NSString *strStatus = [dataDictionary objectForKey:@"status"];
    //NSLog(@"name %@",strStatus);
    //arraySubTask = [[NSMutableArray alloc]init];
    if([strStatus integerValue]){
        NSLog(@"Available %@",dataAry);
        arraySubTask = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in dataAry) {
            if([@"No Record found" isEqualToString:[dic valueForKey:@"success_message"]]){
                //NSLog(@"NO Record Found");
            }else{
                CustomData *cmd = [[CustomData alloc]init];
                cmd.strSubTaskName = [dic valueForKey:@"task_name"];
                cmd.strStatus = [dic valueForKey:@"status"];
                cmd.strSubTaskId = [dic valueForKey:@"subtask_id"];
                [arraySubTask addObject:cmd];
            }
        }
    }
    //NSLog(@"Subtask ");
    strManageTableView = @"SubTask";
    [table reloadData];
    compblock(YES);
//    [table reloadData];
//    [self ManageSubtaskView];
    //    int Hieght = 0;
    //    for (int i =0 ; i<arraySubTask.count; i++) {
    //        CGRect Frame = viewSubtask.frame;
    /*
     UILabel *lblCategoryDetail = [[UILabel alloc]initWithFrame:CGRectMake(viewSubtask.frame.origin.x, Hieght, viewSubtask.frame.size.width, viewSubtask.frame.size.height)];
     lblCategoryDetail.text = [dict valueForKey:@"name"];
     lblCategoryDetail.textColor = [UIColor whiteColor];
     [lblCategoryDetail setFont: [lblCategoryDetail.font fontWithSize: 13]];
     lblCategoryDetail.backgroundColor=[UIColor clearColor];
     
     UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, Hieght, viewCatogory.frame.size.width-30, 15)];
     [btn setTitle:@"" forState:UIControlStateNormal];
     [btn setTag:[[dict valueForKey:@"id"]intValue]];
     [btn addTarget:self
     action:@selector(blogView:)
     forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
     [self.view addSubview:btn];
     
     Hieght = Hieght+20;
     
     [viewCatogory addSubview:lblCategoryDetail];
     [arrayCategory addObject:cmd];
     [viewCatogory addSubview:btn];
     *///
    //}
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

-(void)ManageArchived{
    btnAssighnTo.hidden = YES;
    btnParcentages.hidden = YES;
    btnRevisedDate.hidden = YES;
    
    CGRect frame5 = table.frame;
    frame5.origin.y = 0;
    frame5.size.height = table.contentSize.height+10;
    table.frame = frame5;
    
    viewSubtask.hidden = YES;
    
    frame5 = viewSubtaskNotes.frame;
    frame5.size.height = table.frame.size.height+10;
    viewSubtaskNotes.frame = frame5;
    // viewSubtaskNotes.hidden = YES;
    
    //'Opened','Closed','Commented','Percentage','Revised','Assigned'
    
    viewComment.hidden = YES;
    
    //    frame5 = viewSubtaskNotes.frame;
    //    frame5.size.height = viewComment.frame.origin.y+viewComment.frame.size.height+10;
    //    viewSubtaskNotes.frame = frame5;
    //
    //frame5 = table1.frame;
    // frame5.size.height = table1.contentSize.height;
    // table1.frame = frame5;
    
    frame5  = viewList.frame;
    frame5.origin.y =    viewSubtaskNotes.frame.origin.y+viewSubtaskNotes.frame.size.height+20;
    frame5.size.height = viewSubtaskNotes.frame.size.height+viewSubtaskNotes.frame.origin.y+table1.frame.size.height+viewFilter.frame.size.height+30;
    viewList.frame = frame5;
    
    frame5  = viewFull.frame;
    frame5.size.height = viewList.frame.origin.y+viewList.frame.size.height+30;
    viewFull.frame = frame5;
    scroll.contentSize=CGSizeMake(0,viewFull.frame.size.height);
}

-(void)ManageTagView1{
    float yy;
    CGRect fram;
    
    if(arrayTesting.count !=0){
        viewTag.hidden = NO;
        CGRect fram = viewTag.frame;
        fram.origin.y = viewTagPluse.frame.size.height+viewTagPluse.frame.origin.y;
        viewTag.frame = fram;
        
        yy= viewTag.frame.size.height+viewTag.frame.origin.y;
    }else{
        viewTag.hidden =YES;
        yy=viewTagPluse.frame.size.height+viewTagPluse.frame.origin.y;
    }
    
    if([getStatus isEqualToString:@"Archived"]){
        CGRect frame5;
        float YY=00;
        if(arraySubTask.count!=0){
            frame5 = table.frame;
            frame5.origin.y =viewSubtask.frame.origin.y;
            frame5.size.height = table.contentSize.height;
            table.frame = frame5;
            frame5 = viewComment.frame;
            frame5.origin.y = table.frame.origin.y+table.frame.size.height+10;
            viewComment.frame = frame5;
            YY = viewSubtaskNotes.frame.origin.y+viewSubtaskNotes.frame.size.height+20;
            
            frame5 = table1.frame;
            frame5.size.height = table1.contentSize.height;
            table1.frame = frame5;
            
            frame5  = viewList.frame;
            frame5.origin.y =   viewInformation.frame.origin.y+viewInformation.frame.size.height+20;;// viewSubtaskNotes.frame.origin.y+viewSubtaskNotes.frame.size.height+20;
            frame5.size.height = viewSubtaskNotes.frame.size.height+viewSubtaskNotes.frame.origin.y+table1.frame.size.height+viewFilter.frame.size.height+30;
            viewList.frame = frame5;
            
            viewSubtask.hidden = YES;
            viewComment.hidden = YES;
        }else{
            YY = viewInformation.frame.origin.y+viewInformation.frame.size.height+30;
            
            frame5 = viewSubtaskNotes.frame;
            frame5.origin.y = YY;
            viewSubtaskNotes.frame = frame5;
            
            frame5 = table1.frame;
            frame5.size.height = table1.contentSize.height;
            table1.frame = frame5;
            
            frame5  = viewList.frame;
            frame5.origin.y =   viewInformation.frame.origin.y+viewInformation.frame.size.height+20;;// viewSubtaskNotes.frame.origin.y+viewSubtaskNotes.frame.size.height+20;
            frame5.size.height = viewSubtaskNotes.frame.size.height+viewSubtaskNotes.frame.origin.y+table1.frame.size.height+viewFilter.frame.size.height+30;
            viewList.frame = frame5;
            
            //YY = viewSubtaskNotes.frame.origin.y+20;
            viewSubtaskNotes.hidden = YES;
        }
        
        //        frame5 = table1.frame;
        //        frame5.size.height = table1.contentSize.height;
        //        table1.frame = frame5;
        //
        //        frame5  = viewList.frame;
        //        frame5.origin.y =   YY;// viewSubtaskNotes.frame.origin.y+viewSubtaskNotes.frame.size.height+20;
        //        frame5.size.height = viewSubtaskNotes.frame.size.height+viewSubtaskNotes.frame.origin.y+table1.frame.size.height+viewFilter.frame.size.height+30;
        //        viewList.frame = frame5;
        
        frame5  = viewFull.frame;
        frame5.size.height = viewList.frame.size.height+30;
        viewFull.frame = frame5;
        
        scroll.contentSize=CGSizeMake(0,viewFull.frame.size.height);
        
        
        
        fram = viewInfo.frame;
        fram.origin.y =yy;//viewTag.frame.size.height+viewTag.frame.origin.y;
        viewInfo.frame = fram;
        
        fram = viewInformation.frame;
        fram.size.height =viewInfo.frame.origin.y+viewInfo.frame.size.height;
        viewInformation.frame = fram;
        
//        fram=viewSubtaskNotes.frame;
//        fram.origin.y = viewInformation.frame.size.height+viewInformation.frame.origin.y+20;
//        viewSubtaskNotes.frame = fram;
//        
//        fram = viewList.frame;
//        fram.origin.y = viewSubtaskNotes.frame.size.height+viewSubtaskNotes.frame.origin.y;
//        viewList.frame = fram;
        
    }else{
    fram = viewInfo.frame;
    fram.origin.y =yy;//viewTag.frame.size.height+viewTag.frame.origin.y;
    viewInfo.frame = fram;
    
    fram = viewInformation.frame;
    fram.size.height =viewInfo.frame.origin.y+viewInfo.frame.size.height;
    viewInformation.frame = fram;
    
    fram=viewSubtaskNotes.frame;
    fram.origin.y = viewInformation.frame.size.height+viewInformation.frame.origin.y+20;
    viewSubtaskNotes.frame = fram;
    
    fram = viewList.frame;
    fram.origin.y = viewSubtaskNotes.frame.size.height+viewSubtaskNotes.frame.origin.y;
    viewList.frame = fram;
    }
}

-(void)ManageSubtaskView{
    
    if([getStatus isEqualToString:@"Archived"]){
        CGRect frame5;
        float YY=00;
        if(arraySubTask.count!=0){
            frame5 = table.frame;
            viewSubtaskNotes.hidden = NO;
            frame5.origin.y =viewSubtask.frame.origin.y;
            frame5.size.height = table.contentSize.height;
            table.frame = frame5;
            
            frame5 = viewComment.frame;
            frame5.origin.y = table.frame.origin.y+table.frame.size.height+10;
            viewComment.frame = frame5;
            YY = viewSubtaskNotes.frame.origin.y+viewSubtaskNotes.frame.size.height+20;
           
            frame5 = table1.frame;
            frame5.size.height = table1.contentSize.height;
            table1.frame = frame5;
            
            frame5 = viewSubtaskNotes.frame;
            frame5.size.height= table.frame.size.height+20;
            viewSubtaskNotes.frame = frame5;
            
            frame5  = viewList.frame;
            frame5.origin.y =   viewSubtaskNotes.frame.origin.y+viewSubtaskNotes.frame.size.height+20;//viewInformation.frame.origin.y+viewInformation.frame.size.height+20;;// viewSubtaskNotes.frame.origin.y+viewSubtaskNotes.frame.size.height+20;
            frame5.size.height = viewSubtaskNotes.frame.size.height+viewSubtaskNotes.frame.origin.y+table1.frame.size.height+viewFilter.frame.size.height+30;
            viewList.frame = frame5;
            
            viewSubtask.hidden = YES;
            viewComment.hidden = YES;
        }else{
            
            YY = viewInformation.frame.origin.y+viewInformation.frame.size.height+20;
            frame5 = table1.frame;
            frame5.size.height = table1.contentSize.height;
            table1.frame = frame5;
            
            frame5  = viewList.frame;
            frame5.origin.y =   viewInformation.frame.origin.y+viewInformation.frame.size.height+20;;// viewSubtaskNotes.frame.origin.y+viewSubtaskNotes.frame.size.height+20;
            frame5.size.height = viewSubtaskNotes.frame.size.height+viewSubtaskNotes.frame.origin.y+table1.frame.size.height+viewFilter.frame.size.height+30;
            viewList.frame = frame5;
            
            //YY = viewSubtaskNotes.frame.origin.y+20;
            viewSubtaskNotes.hidden = YES;
        }
        
//        frame5 = table1.frame;
//        frame5.size.height = table1.contentSize.height;
//        table1.frame = frame5;
//        
//        frame5  = viewList.frame;
//        frame5.origin.y =   YY;// viewSubtaskNotes.frame.origin.y+viewSubtaskNotes.frame.size.height+20;
//        frame5.size.height = viewSubtaskNotes.frame.size.height+viewSubtaskNotes.frame.origin.y+table1.frame.size.height+viewFilter.frame.size.height+30;
//        viewList.frame = frame5;
        
        frame5  = viewFull.frame;
        frame5.size.height = viewList.frame.size.height+30;
        viewFull.frame = frame5;
        
        scroll.contentSize=CGSizeMake(0,viewFull.frame.size.height);
    }else{
        CGRect frame5 = table.frame;
        frame5.size.height = table.contentSize.height;
        table.frame = frame5;
        
        frame5 = viewSubtaskNotes.frame;
        frame5.size.height = viewSubtask.frame.size.height+viewSubtask.frame.origin.y+table.frame.size.height+viewComment.frame.size.height+10;
        viewSubtaskNotes.frame = frame5;
    
        frame5 = viewComment.frame;
        frame5.origin.y = table.frame.origin.y+table.frame.size.height+10;
        viewComment.frame = frame5;
    
        frame5 = viewSubtaskNotes.frame;
        frame5.size.height = viewComment.frame.origin.y+viewComment.frame.size.height;
        viewSubtaskNotes.frame = frame5;
    
    
        int YY;
        if([@"Archived" isEqualToString:[[arrayGetDetail objectAtIndex:0]strFrom]]){
            btnAssighnTo.hidden = YES;
            btnParcentages.hidden = YES;
            btnRevisedDate.hidden = YES;
        
            CGRect frame5 = table.frame;
            frame5.origin.y = 0;
            frame5.size.height = table.contentSize.height+10;
            table.frame = frame5;
        
            viewSubtask.hidden = YES;
        
            frame5 = viewSubtaskNotes.frame;
            frame5.size.height = table.frame.size.height;
            viewSubtaskNotes.frame = frame5;
            // [self ManageArchived];
            viewComment.hidden = YES;
            if(arraySubTask.count == 0){
                YY = viewSubtaskNotes.frame.origin.y;
            }else{
                YY =  viewSubtaskNotes.frame.origin.y+viewSubtaskNotes.frame.size.height+20;
            }
        }else{
            YY =  viewSubtaskNotes.frame.origin.y+viewSubtaskNotes.frame.size.height+20;
        }
    
    //table1.scrollEnabled = NO;
        frame5 = table1.frame;
        frame5.size.height = table1.contentSize.height;
        table1.frame = frame5;
    
        frame5  = viewList.frame;
        frame5.origin.y =   YY;// viewSubtaskNotes.frame.origin.y+viewSubtaskNotes.frame.size.height+20;
        frame5.size.height = viewSubtaskNotes.frame.size.height+viewSubtaskNotes.frame.origin.y+table1.frame.size.height+viewFilter.frame.size.height+30;
        viewList.frame = frame5;
    
        frame5  = viewFull.frame;
        frame5.size.height = viewList.frame.size.height+30;
        viewFull.frame = frame5;
    
        scroll.contentSize=CGSizeMake(0,viewFull.frame.size.height);
    }
    //    frame5 = table1.frame;
    //    frame5.size.height = table1.contentSize.height;
    //    table.frame = frame5;
    //
    //    frame5 = viewList.frame;
    //    frame5.size.height = viewSubtaskNotes.frame.size.height+viewSubtaskNotes.frame.origin.y+table1.frame.size.height+viewFilter.frame.size.height+30;
    //    viewSubtaskNotes.frame = frame5;
    //    if([@"Archived" isEqualToString:[[arrayGetDetail objectAtIndex:0]strFrom]]){
    //        btnAssighnTo.hidden = YES;
    //        btnParcentages.hidden = YES;
    //        btnRevisedDate.hidden = YES;
    //
    //        CGRect frame5 = table.frame;
    //        frame5.origin.y = 0;
    //        frame5.size.height = table.contentSize.height+10;
    //        table.frame = frame5;
    //
    //        viewSubtask.hidden = YES;
    //
    //        frame5 = viewSubtaskNotes.frame;
    //        frame5.size.height = table.frame.size.height+10;
    //        viewSubtaskNotes.frame = frame5;
    //       // [self ManageArchived];
    //    }
}

-(void)ManageTableView{
    
}
-(void)manageFullView{
    scroll.contentSize=CGSizeMake(0,viewFull.frame.size.height);
    //    int Hieght =viewSubtaskNotes.frame.origin.y+viewSubtaskNotes.frame.size.height+30;
    //    for(int i =0; i<arrayActionHistory.count; i++) {
    //        CGRect Frame = viewSubtask.frame;
    //        UIView *viewHestory = [UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0);
    //         UILabel *lblCategoryDetail = [[UILabel alloc]initWithFrame:CGRectMake(viewSubtask.frame.origin.x, Hieght, viewSubtask.frame.size.width, viewSubtask.frame.size.height)];
    //         lblCategoryDetail.text = [dict valueForKey:@"name"];
    //         lblCategoryDetail.textColor = [UIColor whiteColor];
    //         [lblCategoryDetail setFont: [lblCategoryDetail.font fontWithSize: 13]];
    //         lblCategoryDetail.backgroundColor=[UIColor clearColor];
    //
    //         UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, Hieght, viewCatogory.frame.size.width-30, 15)];
    //         [btn setTitle:@"" forState:UIControlStateNormal];
    //         [btn setTag:[[dict valueForKey:@"id"]intValue]];
    //         [btn addTarget:self
    //         action:@selector(blogView:)
    //         forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
    //         [self.view addSubview:btn];
    //
    //         Hieght = Hieght+20;
    //         
    //         [viewCatogory addSubview:lblCategoryDetail];
    //         [arrayCategory addObject:cmd];
    //         [viewCatogory addSubview:btn];
    //    }
    //    
}

-(void)MoveDashboard{
    Dashboard *second=[self.storyboard instantiateViewControllerWithIdentifier:@"dashboard"] ;
    [self.navigationController pushViewController:second animated:YES];
}

-(void)PreeTag{
    
    if(arrayTesting.count ==0){
        NSString *string = [[arrayGetDetail objectAtIndex:0]strTagId];
        NSLog(@"%@",[[arrayGetDetail objectAtIndex:0]strTagId]);
        NSArray *tagData = [string componentsSeparatedByString:@","];
        NSLog(@"tagData.coun %lu",(unsigned long)tagData.count);
        
//        for(int i= 0; i<arrayTag1.count; i++){
//            
//           NSLog(@"%@",[[arrayTag1 objectAtIndex:i]strKey]);
//        }
//        for(int i= 0; i<tagData.count; i++){
//            NSLog(@"%@",[tagData objectAtIndex:i]);
//        }
//        
        for (int i= 0; i<tagData.count; i++) {
            for (int j=0; j<arrayTag1.count; j++) {
                if([[[arrayTag1 objectAtIndex:j]strKey] isEqualToString:[tagData objectAtIndex:i]]){
                    NSLog(@"[[arrayTag1 objectAtIndex:j]strKey] %@ data :=%@",[[arrayTag1 objectAtIndex:j]strKey],[arrayPrint1 objectAtIndex:j]);
                   // [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:3.0]];
                    [picker selectRow:j inComponent:0 animated:YES];
                    [self SaveTag:self];
                    CustomData *cmd = [[CustomData alloc]init];
                    cmd =[arrayTag1 objectAtIndex:j];
                    [arrayTag1 removeObject:cmd];
                }
            }
        }
    }
}

-(void)ReorderTask:(NSIndexPath *)ParamFirst AndSecondPAth:(NSIndexPath *)ParamSecond{
    CustomData *cmd= [[CustomData alloc]init];
    cmd= [arraySubTask objectAtIndex:ParamFirst.row];
    CustomData *cmd1 = [[CustomData alloc]init];
    cmd1=[arraySubTask objectAtIndex:ParamSecond.row];
    
    [arraySubTask replaceObjectAtIndex:ParamFirst.row withObject:cmd1];
    [arraySubTask replaceObjectAtIndex:ParamSecond.row withObject:cmd];
    NSString *strPara=[@"actionlog_id=" stringByAppendingString:getActionLogId];
    for(int i =0;i<arraySubTask.count;i++){
        strPara = [strPara stringByAppendingString:[@"&positions["stringByAppendingString:[[NSString stringWithFormat:@"%d",i]stringByAppendingString:[@"]="stringByAppendingString:[[arraySubTask objectAtIndex:i]strSubTaskId]]]]];
    }
    NSDictionary *dataDictionary = [[NSMutableDictionary alloc]init];
    dataDictionary = [Methods  WebServerData:urlReorderTask andPostParameter:strPara];
  //  NSArray *dataAry = [dataDictionary objectForKey:@"info"];
    [self stopGIF];
    [table reloadData];
    
}

//-(void)StatusArray{
-(void) StatusArray:(myCompletion) compblock{

    arrayStatus= [[NSMutableArray alloc]init];
   /*CustomData *cmd = [[CustomData alloc]init];
    cmd.strPropertyAddress = @"All Status";
    [arrayStatus addObject:cmd];
    
    cmd = [[CustomData alloc]init];
    cmd.strPropertyAddress = @"Opened";
    [arrayStatus addObject:cmd];
    
    cmd = [[CustomData alloc]init];
    cmd.strPropertyAddress = @"Closed";
    [arrayStatus addObject:cmd];
    
    cmd = [[CustomData alloc]init];
    cmd.strPropertyAddress = @"Commented";
    [arrayStatus addObject:cmd];
    
    cmd = [[CustomData alloc]init];
    cmd.strPropertyAddress = @"Percentage";
    [arrayStatus addObject:cmd];
    
    cmd = [[CustomData alloc]init];
    cmd.strPropertyAddress = @"Revised";
    [arrayStatus addObject:cmd];
    
    cmd = [[CustomData alloc]init];
    cmd.strPropertyAddress = @"Assigned";
    [arrayStatus addObject:cmd];
    */
    //arrayStatus= [[NSMutableArray alloc]init];
     CustomData *cmd = [[CustomData alloc]init];
     cmd.strPropertyAddress = @"All";
     [arrayStatus addObject:cmd];//
     
     cmd = [[CustomData alloc]init];
     cmd.strPropertyAddress = @"Assigned";
     [arrayStatus addObject:cmd];
     
     cmd = [[CustomData alloc]init];
     cmd.strPropertyAddress = @"% Completed";
     [arrayStatus addObject:cmd];
     
     cmd = [[CustomData alloc]init];
     cmd.strPropertyAddress = @"Closed";
     [arrayStatus addObject:cmd];
     
     cmd = [[CustomData alloc]init];
     cmd.strPropertyAddress = @"Post Notes";
     [arrayStatus addObject:cmd];
     
     cmd = [[CustomData alloc]init];
     cmd.strPropertyAddress = @"Opened";
     [arrayStatus addObject:cmd];
     
     cmd = [[CustomData alloc]init];
     cmd.strPropertyAddress = @"Revised Date";
     [arrayStatus addObject:cmd];
    
    cmd = [[CustomData alloc]init];
    cmd.strPropertyAddress = @"Work Date";
    [arrayStatus addObject:cmd];
    
    compblock(YES);
}

-(void)WebServices{
    AllWebServices *web = [[AllWebServices alloc]init];
    
    NSMutableArray *array = [web WebAddSubTask];
    urlActionHistory = [[array objectAtIndex:0]webActionHistory];
    urlSubTaskList = [[array objectAtIndex:0]webSubTaskList];
    urlAddUpdateSubTask = [[array objectAtIndex:0]webAddUpdateSubTask];
    urlUpdatAction = [[array objectAtIndex:0]webUpdateAction];
    urlAssignTo= [[array objectAtIndex:0]webAssignTo];
    urlPostNote =[[array objectAtIndex:0]webPostNote];
    urlChangeActionStatus = [[array objectAtIndex:0]webChangeActionStatus];
    urlTagList = [[array objectAtIndex:0]webTagList];
    urlReorderTask = [[array objectAtIndex:0]webReorderTask];
    //NSLog(@"All urlActionHistory %@",urlActionHistory);
}

-(void) webData:(myCompletion) compblock{
    //do stuff
   
//}
//
//-(void)webData{
    
    NSString *parameter=[@"actionlog_id=" stringByAppendingString:getActionLogId];
    NSLog(@"Parameter %@",parameter);
    NSDictionary *dataDictionary = [Methods  WebServerData:urlActionHistory andPostParameter:parameter];
    NSArray *dataAry = [dataDictionary objectForKey:@"info"];
    NSString *strStatus = [dataDictionary objectForKey:@"status"];
    if ([strStatus intValue]){
        //NSLog(@"Array history %@",dataAry);
        arrayPrint = [[NSMutableArray alloc]init];
        arrayActionHistory = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in dataAry) {
            CustomData *cmd = [[CustomData alloc]init];
            cmd.strId = [NSString stringWithFormat:@"%@",[dic valueForKey:@"note_id"]];
            if ([@"NotEmpty" isEqualToString:[Methods whitSpace:[dic valueForKey:@"description"]]])
                cmd.strDescription = [Methods stringByStrippingHTML:[dic valueForKey:@"description"]];
            else
                cmd.strDescription = @"NotAvailable";
            cmd.strActionUserName = [NSString stringWithFormat:@"%@",[dic valueForKey:@"action_user_name"]];
            NSString  *string = [[NSString stringWithFormat:@"%@",[dic valueForKey:@"percentage_compeleted"]] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if ([@"Empty" isEqualToString:[Methods whitSpace:string]] || [[NSString stringWithFormat:@"%@",[dic valueForKey:@"percentage_compeleted"]] isEqual:[NSNull null]]|| [string isEqualToString:@"(null)"] || [@"<null>" isEqualToString:string])
                cmd.strPercentageCompleted = @"NotAvailable";
            else{
                cmd.strPercentageCompleted = [NSString stringWithFormat:@"%@",[dic valueForKey:@"percentage_compeleted"]];
                cmd.strPercentageCompleted = [cmd.strPercentageCompleted stringByAppendingString:@" %"];
            }
            string = [[NSString stringWithFormat:@"%@",[dic valueForKey:@"description"]] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if ([@"Empty" isEqualToString:[Methods whitSpace:string]] ||[string isEqual:[NSNull null]] || [@"<null>" isEqualToString:string])
                cmd.strDescription = @"NotAvailable";
            else
                cmd.strDescription = [Methods stringByStrippingHTML:[dic valueForKey:@"description"]];
            string = [[NSString stringWithFormat:@"%@",[dic valueForKey:@"revised_date"]] stringByTrimmingCharactersInSet:  [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if ([@"Empty" isEqualToString:[Methods whitSpace:string]] ||[string isEqual:[NSNull null]] || [@"<null>" isEqualToString:string])
                cmd.strRevisedDate = @"NotAvailable";
            else
                cmd.strRevisedDate = [dic valueForKey:@"revised_date"];
            cmd.strCreatedDate = [NSString stringWithFormat:@"%@",[dic valueForKey:@"created_date"] ];
            NSString *datatt= @"yyyy-MM-dd HH-mm-ss";
            
            cmd.strCreatedDate =[Methods DateWithFormate:[dic valueForKey:@"created_date"] andCurrentFormate:datatt andNewFormateDate:appDelegate.STRDATEFORMATE];
            cmd.strKey =[NSString stringWithFormat:@"%@",[dic valueForKey:@"history_status"]];
            NSLog(@"cmd.strKey %@",cmd.strKey);
            
            NSString *strDeta = [NSString stringWithFormat:@"%@",[dic valueForKey:@"history_status"]];
            if([strDeta isEqualToString:@"Opened" ]||[strDeta isEqualToString:@"Closed"])
                cmd.strStatus = [strDeta stringByAppendingString:@" an Action"];
            else if([strDeta isEqualToString:@"Percentage"])
               cmd.strStatus = [@"Completed " stringByAppendingString:[[dic valueForKey:@"percentage_completed"] stringByAppendingString:@"%"]];
            else if([strDeta isEqualToString:@"Revised"])
                cmd.strStatus = [strDeta stringByAppendingString:[@" " stringByAppendingString:[Methods DateWithFormate:[dic valueForKey:@"revised_date"] andCurrentFormate:datatt andNewFormateDate:appDelegate.STRDATEFORMATE]]];//[dic valueForKey:@"revised_date"]]];
            else if([strDeta isEqualToString:@"Assigned"])
                cmd.strStatus = [@"Assigned To " stringByAppendingString:[dic valueForKey:@"assigned_user_name"]];
            else if([strDeta isEqualToString:@"Worked"])
                cmd.strStatus = [@"Revised Work date " stringByAppendingString:[Methods DateWithFormate:[dic valueForKey:@"work_date"] andCurrentFormate:datatt andNewFormateDate:appDelegate.STRDATEFORMATE]];//[dic valueForKey:@"revised_date"]]];
            else
                cmd.strStatus = strDeta;
            cmd.strWorkDate = [dic valueForKey:@"work_date"];
            {
                if([@"Percentage" isEqualToString:[dic valueForKey:@"history_status"]])
                    cmd.strPropertyAddress = @"% Completed";
                else if([@"Commented" isEqualToString:[dic valueForKey:@"history_status"]])
                    cmd.strPropertyAddress = @"Post Notes";
                else if([@"Revised" isEqualToString:[dic valueForKey:@"history_status"]])
                    cmd.strPropertyAddress = @"Revised Date";
                else if([@"Worked" isEqualToString:[dic valueForKey:@"history_status"]])
                    cmd.strPropertyAddress = @"Work Date";
                else
                    cmd.strPropertyAddress = [NSString stringWithFormat:@"%@",[dic valueForKey:@"history_status"] ];
            }
            [arrayPrint addObject:cmd];
            [arrayActionHistory addObject:cmd];
        }
        strManageTableView = @"History";
         compblock(YES);
//        [table1  reloadData];
//        [self ManageSubtaskView];
    }
}

-(void)webAssignToData{
    if(appDelegate.ARRAYASSIGNTO.count ==0){
        NSDictionary *dataDictionary = [Methods  WebServerData:urlAssignTo];
        NSArray *keys;
        int i, count;
        id key, value;
        arrayAssignTo = [[NSMutableArray alloc]init];
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
            [arrayAssignTo addObject:cmd];
            [appDelegate.ARRAYASSIGNTO addObject:cmd];
        }
    }else
        arrayAssignTo = [[NSMutableArray alloc]initWithArray:appDelegate.ARRAYASSIGNTO];
}
//

-(void)updatWeb1{
    NSString *parameter = [@"&actionlog_id=" stringByAppendingString:[[[arrayGetDetail objectAtIndex:0]strId] stringByAppendingString:[@"&edit_type=single" stringByAppendingString:[@"&page_view=" stringByAppendingString:@"Closed"]]]];
    NSDictionary *dataDictionary = [[NSMutableDictionary alloc]init];
    dataDictionary = [Methods WebServerData:urlUpdatAction andPostParameter:parameter];
}

#pragma -mark TextView Delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text{
    if(textView.tag == 11){
        if ([text isEqualToString:@"\n"]) {
    
        }
    }else if(textView.tag == 11000){
    }else if(textView.tag == 12000){
    }else{
        if ([text isEqualToString:@"\n"]) {
            NSString *parameter = [@"&actionlog_id=" stringByAppendingString:[[[arrayGetDetail objectAtIndex:0]strId] stringByAppendingString:[@"&action_type=update" stringByAppendingString:[@"&task_name=" stringByAppendingString:[textView.text stringByAppendingString:[@"&subtask_id=" stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)textView.tag]]]]]]];
            NSDictionary *dataDictionary = [[NSMutableDictionary alloc]init];
            dataDictionary = [Methods WebServerData:urlAddUpdateSubTask andPostParameter:parameter];
            //NSLog(@"textFieldShouldReturn Open View %@",dataDictionary);
            [self GetSubtaskList:^(BOOL finished) {
                if(finished){
//                    strManageTableView = @"SubTask";
//                    [table1 reloadData];
                    [self ManageSubtaskView];
                    NSLog(@"success StatusArray");
                }
            }];
//            [self GetSubtaskList ];
        }
    }
    return  true;
}

-(void)textViewDidChange:(UITextView *)textView{
    if(textView.tag == 11){
    }
    if ([@"Empty" isEqualToString:[Methods whitSpace:txtComments.text]]) {
        lblPalaceholder.hidden = NO;
    }
    else{
        lblPalaceholder.hidden = YES;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if(textField.tag == 10000){
        //NSLog(@"Main TextField %ld",(long)textField.tag);
    }else{
        //NSLog(@"TextField Tag %@",textField.text);
        NSString *parameter = [@"&actionlog_id=" stringByAppendingString:[[[arrayGetDetail objectAtIndex:0]strId] stringByAppendingString:[@"&action_type=update" stringByAppendingString:[@"&task_name=" stringByAppendingString:[textField.text stringByAppendingString:[@"&subtask_id=" stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)textField.tag]]]]]]];
        NSDictionary *dataDictionary = [[NSMutableDictionary alloc]init];
        dataDictionary = [Methods WebServerData:urlAddUpdateSubTask andPostParameter:parameter];
        //NSLog(@"textFieldShouldReturn Open View %@",dataDictionary);
        [self GetSubtaskList:^(BOOL finished) {
            if(finished){
//                strManageTableView = @"SubTask";
//                [table1 reloadData];
                [self ManageSubtaskView];
                NSLog(@"success StatusArray");
            }
        }];
//        [self GetSubtaskList ];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
     if(textField.tag ==100 ){
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        //first, check if the new string is numeric only. If not, return NO;
        NSCharacterSet *characterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789,."] invertedSet];
        if ([newString rangeOfCharacterFromSet:characterSet].location != NSNotFound)
        {
            return NO;
        }
        return [newString doubleValue] <= 100;
    }else
        return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showUiAlertWithMessage:(NSString *)message andtitle:(NSString *)title{
    UIAlertView *obj=[[UIAlertView alloc]initWithTitle:@""
                                               message:message
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles: nil];
    [obj show];
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
