//
//  PickerView.m
//  Polycab
//
//  Created by Nitesh on 20/09/16.
//  Copyright © 2016 ECOSMOB TECHNOLOGIES PVT. LTD. All rights reserved.
//

#import "PickerView.h"
#import "UIColor+ThemeExtentions.h"
#import "CustomData.h"
#import "AllMethods.h"
@interface PickerView ()

@property (readonly, nonatomic) UIImage *buttonImage;
@property (strong, nonatomic) UIButton *checkBoxButton;

@end

@implementation PickerView

- (id)initWithHeaderTitle:(NSString *)headerTitle values:(NSArray *)values {
    return [self initWithHeaderTitle:headerTitle values:values allowMultipleSelection:NO];
}

- (id)initWithHeaderTitle:(NSString *)headerTitle values:(NSArray *)values allowMultipleSelection:(BOOL)allowMultipleSelection {
   
    return [self initWithID:@"" headerTitle:headerTitle values:values allowMultipleSelection:allowMultipleSelection];
}

- (id)initWithID:(NSString *)ID headerTitle:(NSString *)headerTitle values:(NSMutableArray *)values allowMultipleSelection:(BOOL)allowMultipleSelection {
   
    self = [super initWithHeaderTitle:headerTitle cancelButtonTitle:@"Cancel" confirmButtonTitle:@"Select"];
    AllMethods *methods = [[AllMethods alloc]init];
    if (self) {
        self.isAllSelected = NO;
        self.values = values;
        self.needFooterView = YES;
        self.headerBackgroundColor = [methods colorWithHexString:@"102D3F"];//  [UIColor themeTintColor];
        self.confirmButtonBackgroundColor = [methods colorWithHexString:@"102D3F"];// [UIColor themeTintColor];
        self.allowMultipleSelection = allowMultipleSelection;
        self.tintColor = [methods colorWithHexString:@"102D3F"];// [UIColor themeTintColor];
        self.ID = (ID.length > 0) ? ID : @"";
        self.dataSource = self;
        self.confirmedRows = @[];
        
        self.checkBoxButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.checkBoxButton.tintColor = [UIColor whiteColor];
        [self.checkBoxButton setImage:self.buttonImage forState:UIControlStateNormal];
        [self.checkBoxButton addTarget:self action:@selector(toggleButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark - Setters
- (void)setSelectedRows:(NSArray *)rows {
    [super setSelectedRows:rows];
    
    if (rows.count == self.values.count) {
        _isAllSelected = YES;
    }
    else {
        _isAllSelected = NO;
    }
    
    [self updateCheckBoxButton];
    [self reloadData];
}

- (void)setIsAllSelected:(BOOL)isAllSelected {
    _isAllSelected = isAllSelected;
    
    if (_isAllSelected) {
        [self selectAll];
    }
    else {
        [self unselectAll];
    }
    [self updateCheckBoxButton];
}

#pragma mark - Getters
- (UIImage *)buttonImage {
    return [UIImage imageNamed: self.isAllSelected ? @"ic_check_box" : @"ic_check_box_outline_blank"];
}

- (void) updateCheckBoxButton {
    [self.checkBoxButton setImage:self.buttonImage forState:UIControlStateNormal];
}

- (UIView *)buildHeaderView {
    if (!self.allowMultipleSelection) {
        return [super buildHeaderView];
    }
    
    UIView *headerView = [super buildHeaderView];
    UILabel *headerLabel;
    
    for (UIView *i in headerView.subviews){
        if([i isMemberOfClass:[UILabel class]]){
            headerLabel = (UILabel *)i;
        }
    }
    
    if (headerLabel) {
        CGRect frame = headerView.frame;
        frame.origin.x = 10;
        frame.size.width -= CGRectGetHeight(headerView.frame) + frame.origin.x;
    
        headerLabel.frame = frame;
        headerLabel.textAlignment = NSTextAlignmentLeft;
        headerLabel.adjustsFontSizeToFitWidth = YES;
    }
    
    CGRect frame = headerView.frame;
    frame.origin.x = CGRectGetWidth(frame) - CGRectGetHeight(frame);
    frame.size.width = CGRectGetHeight(frame);
    
    if (self.allowMultipleSelection) {
        self.checkBoxButton.frame = frame;
        [headerView addSubview:self.checkBoxButton];
    }
    
    return headerView;
}

#pragma mark - Methods
- (void)show {
    [self setSelectedRows:self.confirmedRows];
    [super show];
}

- (void) toggleButton {
    self.isAllSelected = !self.isAllSelected;
}

- (void) selectAll {
    NSMutableArray *temp = [NSMutableArray new];
    for (NSInteger i = 0; i < self.values.count; i++) {
        [temp addObject:[NSNumber numberWithInteger:i]];
    }
    [self setSelectedRows:temp];
}

#pragma mark - CZPickerView Datasource and Delegate

- (NSInteger)numberOfRowsInPickerView:(PickerView *)pickerView {
    NSInteger count = self.values.count;
    return count;
}

- (NSString *)czpickerView:(PickerView *)pickerView
               titleForRow:(NSInteger)row {
    NSString *title = [[self.values objectAtIndex:row]strPropertyAddress];
    return title;
}

@end
