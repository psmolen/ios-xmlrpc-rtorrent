//
//  RTorrentXMLRPCClient.h
//  rtorrent
//
//  Created by Patrick Smolen on 3/22/14.
//  Copyright (c) 2014 Patrick Smolen. All rights reserved.
//

#import "PSXMLRPCConnectionManager.h"
#import "XMLRPC.h"

typedef void (^RTorrentXMLRPCClientSuccess)(XMLRPCResponse *response);
typedef void (^RTorrentXMLRPCClientFailure)(XMLRPCResponse *response, NSError *error);

@interface RTorrentXMLRPCClient : PSXMLRPCConnectionManager
@property (nonatomic, strong) NSURL *baseURL;
+ (instancetype)sharedClient;
- (instancetype)initWithBaseURL:(NSURL *)url;
- (void)updateBaseURL:(NSURL *)url;

- (void)downloadList:(RTorrentXMLRPCClientSuccess)success failure:(RTorrentXMLRPCClientFailure)failure;

- (void)torrentName:(NSString *)hash success:(RTorrentXMLRPCClientSuccess)success failure:(RTorrentXMLRPCClientFailure)failure;
- (void)torrentSize:(NSString *)hash success:(RTorrentXMLRPCClientSuccess)success failure:(RTorrentXMLRPCClientFailure)failure;
- (void)torrentBytesDownloaded:(NSString *)hash success:(RTorrentXMLRPCClientSuccess)success failure:(RTorrentXMLRPCClientFailure)failure;
- (void)torrentState:(NSString *)hash success:(RTorrentXMLRPCClientSuccess)success failure:(RTorrentXMLRPCClientFailure)failure;
- (void)torrentRemove:(NSString *)hash success:(RTorrentXMLRPCClientSuccess)success failure:(RTorrentXMLRPCClientFailure)failure;
- (void)torrentStart:(NSString *)magnetLink success:(RTorrentXMLRPCClientSuccess)success failure:(RTorrentXMLRPCClientFailure)failure;
- (void)torrentDownloadRate:(NSString *)hash success:(RTorrentXMLRPCClientSuccess)success failure:(RTorrentXMLRPCClientFailure)failure;
@end
