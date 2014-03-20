//
//  PSXMLRPCConnectionManager.h
//  rtorrent
//
//  Created by Patrick Smolen on 3/19/14.
//  Copyright (c) 2014 Patrick Smolen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XMLRPCConnection, XMLRPCRequest, XMLRPCResponse;

@interface PSXMLRPCConnectionManager : NSObject
+ (void)asyncRequest:(XMLRPCRequest *)request success:(void(^)(XMLRPCResponse *))successBlock_ failure:(void(^)(XMLRPCResponse *, NSError *))failureBlock_;

@end
