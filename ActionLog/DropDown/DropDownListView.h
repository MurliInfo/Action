//
//  DropDownListView.h
//  KDropDownMultipleSelection
//
//  Created by macmini17 on 03/01/14.
//  Copyright (c) 2014 macmini17. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DropDownListView;
@protocol kDropDownListViewDelegate;




@protocol kDropDownListViewDelegate;
@interface DropDownListView : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    NSMutableArray *arrayShort;
    NSMutableArray *arrayShort1;
    NSMutableArray *arrayDemo;
    int chekEro;
    int tblY;
    int tblH;
    UIView *nomatchesView;
    UITextField *txtSearch;
    NSString *strTemp;
    
    UITableView *_kTableView;
  //  UITextField *txtSearch;
    NSString *_kTitleText;
    NSMutableArray *_kDropDownOption;
    //NSArray *_kDropDownOption;
    CGFloat R,G,B,A;
    BOOL isMultipleSelection;
}
@property NSMutableArray *filltereList;


@property(nonatomic,strong)NSMutableArray *arryData;
@property (nonatomic, assign) id<kDropDownListViewDelegate> delegate;
- (void)fadeOut;
// The options is a NSArray, contain some NSDictionaries, the NSDictionary contain 2 keys, one is "img", another is "text".
- (id)initWithTitle:(NSString *)aTitle options:(NSMutableArray *)aOptions options1:(NSMutableArray *)aOptions1 xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple;
// If animated is YES, PopListView will be appeared with FadeIn effect.
- (void)showInView:(UIView *)aView animated:(BOOL)animated;
-(void)SetBackGroundDropDown_R:(CGFloat)r G:(CGFloat)g B:(CGFloat)b alpha:(CGFloat)alph;
@end

@protocol kDropDownListViewDelegate <NSObject>
- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex;
- (void)DropDownListView:(DropDownListView *)dropdownListView Datalist:(NSMutableArray*)ArryData;
//- (void)DropDownListViewDidCancel;
@end
