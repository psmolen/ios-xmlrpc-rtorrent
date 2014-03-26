//
//  PSXMLRPCConnectionManager.m
//  rtorrent
//
//  Created by Patrick Smolen on 3/19/14.
//  Copyright (c) 2014 Patrick Smolen. All rights reserved.
//

#import "PSXMLRPCConnectionManager.h"
#import "XMLRPCConnection.h"
#import "XMLRPCRequest.h"

@implementation PSXMLRPCConnectionManager

+ (void)asyncRequest:(XMLRPCRequest *)request success:(void(^)(XMLRPCResponse *))successBlock_ failure:(void(^)(XMLRPCResponse *,NSError *))failureBlock_
{
    [self performSelectorInBackground:@selector(backgroundSync:) withObject:@{@"request": request, @"success": successBlock_, @"failure": failureBlock_}];
}

#pragma mark Private
+ (void)backgroundSync:(NSDictionary *)dictionary {
    void(^success)(XMLRPCResponse *) = [dictionary objectForKey:@"success"];
    void(^failure)(XMLRPCResponse *,NSError *) = [dictionary objectForKey:@"failure"];
    XMLRPCRequest *request = [dictionary objectForKey:@"request"];
    NSError *error = nil;
    
    XMLRPCResponse *response = [XMLRPCConnection sendSynchronousXMLRPCRequest:request error:&error];

    if(error) {
        failure(response,error);
    } else {
        success(response);
    }
}

@end
