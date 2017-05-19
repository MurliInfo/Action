//
//  ViewAdvanceSearchSection.h
//  ActionLog
//
//  Created by Hardik Davda on 4/14/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewAdvanceSearchSection;
@protocol AdvanceSearchDelegate;



@protocol AdvanceSearchDelegate;

@interface ViewAdvanceSearchSection : UIView<UITableViewDelegate,UITableViewDataSource>{
    IBOutlet UITableView *table;
}
@property (nonatomic, assign) id<AdvanceSearchDelegate> delegate;

@end
