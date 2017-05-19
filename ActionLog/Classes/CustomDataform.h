//
//  CustomDataform.h
//  ActionLog
//
//  Created by Hardik Davda on 4/17/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CustomDataform : NSObject

@property(nonatomic,retain) NSString *strPlaceholder;
@property(nonatomic) int Id;
@property(nonatomic,retain) NSString *strParameter;
@property(nonatomic,retain) NSString *strValue;
@property(nonatomic,retain) NSString *strSelectedValue;
@property(nonatomic) bool isDate;
@property(nonatomic) bool isSingal;
@property(nonatomic) int btnTag;
@property(nonatomic,retain) UIImage *imgAerro;
@property(nonatomic,retain) UIButton *btnSelectIteam;


@property(nonatomic,retain) NSString *strPlaceholder1;
@property(nonatomic,retain) NSString *strParameter1;
@property(nonatomic,retain) NSString *strValue1;

@property(nonatomic,retain) NSString *strSelectedValue1;
@property(nonatomic) bool isDate1;
@property(nonatomic) int btnTag1;
@property(nonatomic,retain) UIImage *imgAerro1;
@property(nonatomic,retain) UIButton *btnSelectIteam1;



-(NSMutableArray *)ADSDSuperAdmin;
-(NSMutableArray *)ADSDAdmn;
-(NSMutableArray *)ADSDStaff;
-(NSMutableArray *)ADSDFSuperAdmin;

-(NSMutableArray *)ADSASuperAdmin;
-(NSMutableArray *)ADSAAdmin;
-(NSMutableArray *)ADSAStaff;

@end
