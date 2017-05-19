//
//  UploadRemoveImage.m
//  SLP World
//
//  Created by Hardik Davda on 8/3/16.
//  Copyright © 2016 Sell Lease Property. All rights reserved.
//

#import "UploadRemoveImage.h"

#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
//{
//RET: http://162.144.107.20:2082
//
//Username: slpadmin
//Password: @DDmm!!nnpA$$16
//}

@implementation UploadRemoveImage
-(void) postImageToURL: (NSString*)URL withMethod:(NSString*)method andParams:(NSDictionary*)params andImage:(NSArray *)userImage noteId:(NSString*)tempNoteId eventId:(NSString*)getEventId fileType:(NSString*)getFile completion:(void (^)(BOOL success, NSDictionary *responseObj)) completion
{
    {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURL *url = [NSURL URLWithString:URL];
    AFHTTPRequestOperationManager *httpManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
    [httpManager setResponseSerializer:[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments]];
    [httpManager POST:@"addAction" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *imagedata;
        if (userImage.count){
            int i=0;
            for(UIImage *img in userImage){
                imagedata = [[NSData alloc]init];
                imagedata = UIImageJPEGRepresentation(img, 1.0);
                [formData appendPartWithFileData:imagedata name:[getFile stringByAppendingString:@"[]"] fileName:[@"Image" stringByAppendingString:[NSString stringWithFormat:@"%d",i]] mimeType:@"image/jpeg"];
                i++;
            }
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (!responseDictionary) responseDictionary = [[NSMutableDictionary alloc] init];
        [responseDictionary removeAllObjects];
        [responseDictionary addEntriesFromDictionary:(NSDictionary*)responseObject];
        NSLog(@"response   %@",responseDictionary );
        if([[responseDictionary objectForKey:@"response"] isEqualToString:@"success"]){
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                if(completion)completion(YES, responseDictionary);
        }
        else{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            NSLog(@"response Fail : %@",responseObject);
            if(completion)completion(NO, responseDictionary);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error.code == NSURLErrorTimedOut) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Request timed out. Try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        }
        NSLog(@"Response Fail. Error : %@",error.localizedDescription);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if(completion)completion(NO, nil);
        }];
    }
}

/*
-(void) postImageAndTag: (NSString*)URL withParams:(NSDictionary*)params  andTag:(NSArray *)userTag andImage:(NSArray *)userImage fileType:(NSString*)getFile completion:(void (^)(BOOL success, NSDictionary *responseObj)) completion{
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        NSURL *url = [NSURL URLWithString:URL];
        AFHTTPRequestOperationManager *httpManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
        [httpManager setResponseSerializer:[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments]];
        [httpManager POST:@"pts_fallover_add.php" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            NSData *imagedata;
            if (userImage.count){
                int i=0;
                for(UIImage *img in userImage){
                    imagedata = [[NSData alloc]init];
                    imagedata = UIImageJPEGRepresentation(img, 1.0);
                    [formData appendPartWithFileData:imagedata name:[getFile stringByAppendingString:@"[]"] fileName:[@"Image" stringByAppendingString:[NSString stringWithFormat:@"%d",i]] mimeType:@"image/jpeg"];
                    i++;
                }
            }
            if (userTag.count){
                for (int i= 0; i<userTag.count; i++) {
                    NSString *tag = [userTag objectAtIndex:i];
                    //[formData appendPartWithFormData:tag name:tag];
                    
                    [formData appendPartWithFileData:imagedata name:[getFile stringByAppendingString:@"[]"] fileName:tag mimeType:@"text"];
                }
            }

        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (!responseDictionary) responseDictionary = [[NSMutableDictionary alloc] init];
            [responseDictionary removeAllObjects];
            [responseDictionary addEntriesFromDictionary:(NSDictionary*)responseObject];
            NSLog(@"response   %@",responseDictionary );
            if([[responseDictionary objectForKey:@"response"] isEqualToString:@"success"]){
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                if(completion)completion(YES, responseDictionary);
            }
            else{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                NSLog(@"response Fail : %@",responseObject);
                if(completion)completion(NO, responseDictionary);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (error.code == NSURLErrorTimedOut) {
                [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Request timed out. Try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
            }
            NSLog(@"Response Fail. Error : %@",error.localizedDescription);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            if(completion)completion(NO, nil);
        }];
    }

}













-(void) postImageToURL1: (NSString*)URL withParams:(NSDictionary*)params andImage:(NSArray *)userImage fileType:(NSString*)getFile completion:(void (^)(BOOL success, NSDictionary *responseObj)) completion{
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        NSURL *url = [NSURL URLWithString:URL];
        AFHTTPRequestOperationManager *httpManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
        [httpManager setResponseSerializer:[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments]];
        [httpManager POST:@"pts_fallover_add.php" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            NSData *imagedata;
            if (userImage.count){
                int i=0;
                for(UIImage *img in userImage){
                    imagedata = [[NSData alloc]init];
                    imagedata = UIImageJPEGRepresentation(img, 1.0);
                    [formData appendPartWithFileData:imagedata name:[getFile stringByAppendingString:@"[]"] fileName:[@"Image" stringByAppendingString:[NSString stringWithFormat:@"%d",i]] mimeType:@"image/jpeg"];
                    i++;
                }
            }
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (!responseDictionary) responseDictionary = [[NSMutableDictionary alloc] init];
            [responseDictionary removeAllObjects];
            [responseDictionary addEntriesFromDictionary:(NSDictionary*)responseObject];
            NSLog(@"response   %@",responseDictionary );
            if([[responseDictionary objectForKey:@"response"] isEqualToString:@"success"]){
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                if(completion)completion(YES, responseDictionary);
            }
            else{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                NSLog(@"response Fail : %@",responseObject);
                if(completion)completion(NO, responseDictionary);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (error.code == NSURLErrorTimedOut) {
                [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Request timed out. Try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
            }
            NSLog(@"Response Fail. Error : %@",error.localizedDescription);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            if(completion)completion(NO, nil);
        }];
    }

}













-(void) postImageToURL11: (NSString*)URL withMethod:(NSString*)method andParams:(NSDictionary*)params andImage:(NSArray *)userImage noteId:(NSString*)tempNoteId eventId:(NSString*)getEventId fileType:(NSString*)getFile completion:(void (^)(BOOL success, NSDictionary *responseObj)) completion
{
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        NSURL *url = [NSURL URLWithString:URL];
        AFHTTPRequestOperationManager *httpManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
        [httpManager setResponseSerializer:[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments]];
        [httpManager POST:@"pts_fallover_add.php" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            NSData *imagedata;
            if (userImage.count){
                int i=0;
                for(UIImage *img in userImage){
                    imagedata = [[NSData alloc]init];
                    imagedata = UIImageJPEGRepresentation(img, 1.0);
                    [formData appendPartWithFileData:imagedata name:[getFile stringByAppendingString:@"[]"] fileName:[@"Image" stringByAppendingString:[NSString stringWithFormat:@"%d",i]] mimeType:@"image/jpeg"];
                    i++;
                }
            }
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (!responseDictionary) responseDictionary = [[NSMutableDictionary alloc] init];
            [responseDictionary removeAllObjects];
            [responseDictionary addEntriesFromDictionary:(NSDictionary*)responseObject];
            NSLog(@"response   %@",responseDictionary );
            if([[responseDictionary objectForKey:@"response"] isEqualToString:@"success"]){
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                if(completion)completion(YES, responseDictionary);
            }
            else{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                NSLog(@"response Fail : %@",responseObject);
                if(completion)completion(NO, responseDictionary);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (error.code == NSURLErrorTimedOut) {
                [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Request timed out. Try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
            }
            NSLog(@"Response Fail. Error : %@",error.localizedDescription);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            if(completion)completion(NO, nil);
        }];
    }
}
*/


@end
