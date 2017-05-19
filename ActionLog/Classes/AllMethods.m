//
//  AllMethods.m
//  ActionLog
//
//  Created by Hardik Davda on 9/19/16.
//  Copyright © 2016 SLP-World. All rights reserved.
//

#import "AllMethods.h"
#import "Macro.h"

NSDateFormatter *dateFormat;

@implementation AllMethods

#pragma - mark Dashborad All WebservicesCall
//#define PAGELANGTH @"10";

-(void)PrintGrid :(NSString *)parameter AndOfcet:(int)of{
  
}


- (NSString *)DateWithFormate:(NSString *)pdate andCurrentFormate:(NSString *)CurrentDateFormate andNewFormateDate:(NSString *)NewFormateDate{
  //  NSLog(@"DATE %@",pdate);
   dateFormat = [[NSDateFormatter alloc] init];
    NSString *bdate =pdate;
    [dateFormat setDateFormat:CurrentDateFormate];
    NSDate *date1 = [dateFormat dateFromString:bdate];
    [dateFormat setDateFormat:NewFormateDate];
    NSString *newDate = [dateFormat stringFromDate:date1];
    //NSLog(@"newDate %@",newDate);
    return newDate;
}

-(NSString *)whitSpace:(NSString *)param{
    NSString *rawString = param;
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
    if ([trimmed length] == 0)
        return @"Empty";
    else
        return @"NotEmpty";
}

-(UIColor*)colorWithHexString:(NSString*)hex{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) return [UIColor grayColor];
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0];//
    //return [UIColor colorWithRed:255/255.0f green:124/255.0f blue:64/255.0f alpha:1.0f];
}
- (NSDictionary *)WebServerData:(NSString *)Api {
    NSDictionary *dataDictionary;
    NSURL *url;
    url = [NSURL URLWithString:Api];
    NSMutableURLRequest *theRequest   = [[NSMutableURLRequest alloc] initWithURL:url];
    [ theRequest setHTTPMethod: @"POST" ];
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [theRequest setValue:@"Basic a2FtbGVzaDphZG1pbg==" forHTTPHeaderField:@"Authorization"];
    [theRequest setValue:appDelegate.STRTOKEN forHTTPHeaderField:@"Token"];
    [ theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    //  [theRequest addValue:VALUE forHTTPHeaderField:@"Field You Want To Set"];
    NSError *errorReturned = nil;
    NSURLResponse *theResponse =[[NSURLResponse alloc]init];
    NSData *data;
    data = [NSURLConnection sendSynchronousRequest:theRequest
                                 returningResponse:&theResponse
                                             error:&errorReturned];
    if (errorReturned){
        dataDictionary = [[NSDictionary alloc]init];
        dataDictionary = @{@"status":@0,@"info":@[@{@"error_message":@"Please try to connect your network and try it again",}]};
    //    [self showUiAlertWithMessage:@"Please try to connect your network and try it again" andtitle:@"Alert"];
    }
    else{
        dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errorReturned];
        // NSString *retVal = [NSString stringWithUTF8String:[data bytes]];
       // NSLog(@"DATA From WEBSERVER %@",retVal);
    }

    return dataDictionary;
}

- (NSDictionary *)WebServerDataForLogin:(NSString *)Api andPostParameter:(NSString *)Parameter{
    NSDictionary *dataDictionary;
    NSURL *url;
    url = [NSURL URLWithString:Api];
    NSMutableURLRequest *theRequest   = [[NSMutableURLRequest alloc] initWithURL:url];
    [theRequest setHTTPMethod: @"POST" ];
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [theRequest setValue:@"Basic a2FtbGVzaDphZG1pbg==" forHTTPHeaderField:@"Authorization"];
  //  [theRequest setValue:appDelegate.STRTOKEN forHTTPHeaderField:@"Token"];
    [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [theRequest setHTTPBody:[Parameter dataUsingEncoding:NSUTF8StringEncoding]];
    //  [theRequest addValue:VALUE forHTTPHeaderField:@"Field You Want To Set"];
    NSError *errorReturned = nil;
    NSURLResponse *theResponse =[[NSURLResponse alloc]init];
    NSData *data;
    data = [NSURLConnection sendSynchronousRequest:theRequest
                                 returningResponse:&theResponse
                                             error:&errorReturned];
    if (errorReturned){
        NSLog(@"errorReturned %@",errorReturned);
        dataDictionary = [[NSDictionary alloc]init];
        dataDictionary = @{@"status":@0,@"info":@[@{@"error_message":@"Please try to connect your network and try it again",}]};
        //    [self showUiAlertWithMessage:@"Please try to connect your network and try it again" andtitle:@"Alert"];
    }
    else{
        //dataDictionary = [[NSDictionary alloc]init];
        dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errorReturned];
        NSString *retVal = [NSString stringWithUTF8String:[data bytes]];
        //NSLog(@"DATA From WEBSERVER %@",retVal);
    }
    return dataDictionary;
}

- (NSDictionary *)WebServerData:(NSString *)Api andPostParameter:(NSString *)Parameter{
    //Pass Header and boday with secure
    //NSString *STRTESt = @"http://test1.rettest.com/service_station/api/v1/users/login";
    //NSString *STRTEStPA = [@"email=riya@yopmail.com" stringByAppendingString:@"&password=admin"];
    NSString *str= PAGELANGTH;
    
   // NSLog(@"Page length %@",demo);
    NSURL *url;
    NSDictionary *dataDictionary = [[NSDictionary alloc]init];;
    url = [NSURL URLWithString:Api];
    NSMutableURLRequest *theRequest   = [[NSMutableURLRequest alloc] initWithURL:url];
    [theRequest setHTTPMethod: @"POST" ];
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [theRequest setValue:@"Basic a2FtbGVzaDphZG1pbg==" forHTTPHeaderField:@"Authorization"];
    [theRequest setValue:appDelegate.STRTOKEN forHTTPHeaderField:@"Token"];
     NSLog(@"Token %@",appDelegate.STRTOKEN);
    [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    //NSString *postString = STRTEStPA;
    //[theRequest addValue:VALUE forHTTPHeaderField:@"Field You Want To Set"];
    [theRequest setHTTPBody:[Parameter dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *errorReturned = nil;
    NSURLResponse *theResponse =[[NSURLResponse alloc]init];
    NSData *data;
    data = [NSURLConnection sendSynchronousRequest:theRequest
                                    returningResponse:&theResponse
                                                error:&errorReturned];
    if (errorReturned){
        NSLog(@"errorReturned");
        //dataDictionary = [[NSDictionary alloc]init];
        dataDictionary = @{@"status":@0,@"info":@[@{@"error_message":@"Please try to connect your network and try it again",}]};
        //[dataDictionary setValue:@"Please try to connect your network and try it again" forKey:@"status"];
        // [self showUiAlertWithMessage:@"Please try to connect your network and try it again" andtitle:@"Alert"];
    }
    else{
        dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errorReturned];
     //   NSString *retVal = [NSString stringWithUTF8String:[data bytes]];
     //    NSLog(@"DATA From WEBSERVER %@",retVal);
    }
  /*
    NSURL *url;
    NSDictionary *dataDictionary;
    url = [NSURL URLWithString:Api];
    NSMutableURLRequest *theRequest   = [[NSMutableURLRequest alloc] initWithURL:url];
    [ theRequest setHTTPMethod: @"POST" ];
    [ theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    NSString *postString = Parameter;
    [theRequest setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *errorReturned = nil;
    NSURLResponse *theResponse =[[NSURLResponse alloc]init];
    NSData *data;
    data = [NSURLConnection sendSynchronousRequest:theRequest
                                 returningResponse:&theResponse
                                             error:&errorReturned];
    if (errorReturned){
       // [self showUiAlertWithMessage:@"Please try to connect your network and try it again" andtitle:@"Alert"];
    }
    else{
        dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errorReturned];
        //NSString *retVal = [NSString stringWithUTF8String:[data bytes]];
        //NSLog(@"DATA From WEBSERVER %@",retVal);
    }
   */
    return dataDictionary;
}


#pragma mark - String Stripping HTML Data remove tag
-(NSString *)stringByStrippingHTML:(NSString *)inputString{
    NSMutableString *outString;
    if (inputString){
        outString = [[NSMutableString alloc] initWithString:inputString];
        if ([inputString length] > 0){
            NSRange r;
            while ((r = [outString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound){
                [outString deleteCharactersInRange:r];
            }
        }
    }
    return outString;
}


#pragma mark - compressImage for upload image

- (UIImage *)compressImage:(UIImage *)image{
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float maxHeight = 200.0;
    float maxWidth = 350.0;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = maxWidth/maxHeight;
    float compressionQuality = 0.5;//50 percent compression
    
    if (actualHeight > maxHeight || actualWidth > maxWidth) {
        if(imgRatio < maxRatio){
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }
        else if(imgRatio > maxRatio){
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }else{
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    NSData *imageData = UIImageJPEGRepresentation(img, compressionQuality);
    UIGraphicsEndImageContext();
    return [UIImage imageWithData:imageData];
}


@end
