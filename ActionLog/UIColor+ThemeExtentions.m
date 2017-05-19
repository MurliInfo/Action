//
//  UIColor+AppExtentions.m
//  ServiceStation
//
//  Created by Kavit Goswami on 11/11/16.
//  Copyright © 2016 Kavit Goswami. All rights reserved.
//

#import "UIColor+ThemeExtentions.h"

/* 
 Apple suggested colors:
 Red = 0xFF3B30
 Green = 0x4CD964
 Orange = 0xFF9500
 */

/*
 App theme colors:
 Red = 0xE33A3A
 Green = 0x008000
 Orange = 0xF2A94B
 */

/*
 Nitesh colors:
 Red = 0xFF3B30
 Green = 0x009800
 Orange = 0xFF9500
 */

@implementation UIColor (ThemeExtentions)

+ (UIColor *) themeOrangeColor {
    return UIColorFromRGB(0xFF9500);
}

+ (UIColor *) themeRedColor {
    return UIColorFromRGB(0xFF3B30);
}

+ (UIColor *) themeGreenColor {
    return UIColorFromRGB(0x009800);
}

+ (UIColor *) themeDarkColor {
    return UIColorFromRGB(0x214859);
}

+ (UIColor *) themeTintColor {
    return UIColorFromRGB(0xFF600A);
}

+ (UIColor *) themeLoginButtonColor {
    return UIColorFromRGB(0x009688);
}

+ (UIColor *) themeTableCellBackgroundColor {
    return [[UIColor themeTintColor] colorWithAlphaComponent:0.1];
}

+ (UIColor *) themeGrayColor {
    return UIColorFromRGB(0x666666);
}

@end
