//
//  UIColor+AppExtentions.h
//  ServiceStation
//
//  Created by Kavit Goswami on 11/11/16.
//  Copyright © 2016 Kavit Goswami. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@interface UIColor (ThemeExtentions)

+ (UIColor *) themeDarkColor;
+ (UIColor *) themeGreenColor;
+ (UIColor *) themeRedColor;
+ (UIColor *) themeTintColor;
+ (UIColor *) themeLoginButtonColor;
+ (UIColor *) themeOrangeColor;
+ (UIColor *) themeTableCellBackgroundColor;
+ (UIColor *) themeGrayColor;

@end
