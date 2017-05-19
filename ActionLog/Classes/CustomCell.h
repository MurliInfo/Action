//  
//  CustomCell.h
//  ActionLog
//
//  Created by Hardik Davda on 9/14/16.
//  Copyright © 2016 SLP-World. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property(nonatomic,retain) IBOutlet UILabel *lblTitle;
@property(nonatomic,retain) IBOutlet UILabel *lblAssignName;
@property(nonatomic,retain) IBOutlet UILabel *lblStatus;
@property(nonatomic,retain) IBOutlet UILabel *lblDueDate;
@property(nonatomic,retain) IBOutlet UILabel *lblPercentages;
@property(nonatomic,retain) IBOutlet UILabel *lblWorkDate;
@property(nonatomic,retain) IBOutlet UILabel *lblViewCount;
@property(nonatomic,retain) IBOutlet UIButton *btnViewNote;
@property(nonatomic,retain) IBOutlet UIImageView *imgCheck;
@property(nonatomic,retain) IBOutlet UIButton *btnCheck;
@property(nonatomic,retain) IBOutlet UIImageView *imgStatus;
@property(nonatomic,retain) IBOutlet UITextView *txtSubTask;
@property(nonatomic,retain) IBOutlet UIButton *btnCompleteTask;
@property(nonatomic,retain) IBOutlet UIButton *btnCancelTask;
@property(nonatomic,retain) IBOutlet UIImageView *imgCompleteTask;
@property(nonatomic,retain) IBOutlet UIImageView *imgCancelTask;
@property(nonatomic,retain) IBOutlet UIImageView *imgIcone;
@property(nonatomic,retain) IBOutlet UIImageView *imgIcone1;
@property(nonatomic,retain) IBOutlet UIImageView *imgChat;
@property(nonatomic,retain) IBOutlet UIImageView *imgProfile;
@property(nonatomic,retain) IBOutlet UIImageView *imgNoteView;
@property(nonatomic,retain) IBOutlet UIImageView *imgNoteViewCount;


@property(nonatomic,retain) IBOutlet UIView *viewComments;
@property(nonatomic,retain) IBOutlet UIView *viewAction;

@property(nonatomic,retain) IBOutlet UIView *viewActive;
@property(nonatomic,retain) IBOutlet UIView *viewInActive;

@property(nonatomic,retain) IBOutlet UILabel *lblName;
@property(nonatomic,retain) IBOutlet UILabel *lblDate;

@property(nonatomic,retain) IBOutlet UILabel *lblDate1;
@property(nonatomic,retain) IBOutlet UILabel *lblAction;
;
@property(nonatomic,retain) IBOutlet UILabel *lblDescription;
@property(nonatomic,retain) IBOutlet UILabel *lblActionStatus;

@end
