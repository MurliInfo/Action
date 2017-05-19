//
//  AllMethods.h
//  ActionLog
//
//  Created by Hardik Davda on 9/19/16.
//  Copyright © 2016 SLP-World. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AllWebServices.h"

#define appDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface AllMethods : NSObject

- (NSString *)DateWithFormate:(NSString *)pdate andCurrentFormate:(NSString *)CurrentDateFormate andNewFormateDate:(NSString *)NewFormateDate;
-(NSString *)stringByStrippingHTML:(NSString *)inputString;
-(NSString *)whitSpace:(NSString *)param;
-(UIColor*)colorWithHexString:(NSString*)hex;
- (NSDictionary *)WebServerData:(NSString *)Api andPostParameter:(NSString *)Parameter;
- (NSDictionary *)WebServerData:(NSString *)Api;
- (NSDictionary *)WebServerDataForLogin:(NSString *)Api andPostParameter:(NSString *)Parameter;
- (UIImage *)compressImage:(UIImage *)image;
@end
