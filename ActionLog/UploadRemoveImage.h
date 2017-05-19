//
//  UploadRemoveImage.h
//  SLP World
//
//  Created by Hardik Davda on 8/3/16.
//  Copyright © 2016 Sell Lease Property. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface UploadRemoveImage : NSObject
{
    NSMutableDictionary *responseDictionary;
    NSError *failureError;
}
-(void) postImageToURL: (NSString*)URL withMethod:(NSString*)method andParams:(NSDictionary*)params andImage:(NSArray *)userImage noteId:(NSString*)tempNoteId eventId:(NSString*)getEventId fileType:(NSString*)getFile completion:(void (^)(BOOL success, NSDictionary *responseObj)) completion;

-(void) postImageToURL1: (NSString*)URL withParams:(NSDictionary*)params andImage:(NSArray *)userImage fileType:(NSString*)getFile completion:(void (^)(BOOL success, NSDictionary *responseObj)) completion;


-(void) postImageAndTag: (NSString*)URL withParams:(NSDictionary*)params  andTag:(NSArray *)userTag andImage:(NSArray *)userImage fileType:(NSString*)getFile completion:(void (^)(BOOL success, NSDictionary *responseObj)) completion;


@end
