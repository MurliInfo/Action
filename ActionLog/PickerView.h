//
//  PickerView.h
//  Polycab
//
//  Created by Nitesh on 20/09/16.
//  Copyright © 2016 ECOSMOB TECHNOLOGIES PVT. LTD. All rights reserved.
//

#import "CZPicker.h"
@interface PickerView : CZPickerView <CZPickerViewDataSource>

@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSMutableArray *values;
@property (strong, nonatomic) NSArray *confirmedRows;
@property (assign, nonatomic) BOOL isAllSelected;

- (id)initWithHeaderTitle:(NSString *)headerTitle values:(NSArray *)values; //default: allowMultipleSelection = NO
- (id)initWithHeaderTitle:(NSString *)headerTitle values:(NSArray *)values allowMultipleSelection:(BOOL)allowMultipleSelection;
- (id)initWithID:(NSString *)ID headerTitle:(NSString *)headerTitle values:(NSArray *)values allowMultipleSelection:(BOOL)allowMultipleSelection;

@end
