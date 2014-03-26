//
//  RTorrentXMLRPCClient.m
//  rtorrent
//
//  Created by Patrick Smolen on 3/22/14.
//  Copyright (c) 2014 Patrick Smolen. All rights reserved.
//

#import "RTorrentXMLRPCClient.h"
#import "XMLRPC.h"

static NSString * const XMLRPCBaseURL = @"http://192.168.1.132:8080/RPC2";

@implementation RTorrentXMLRPCClient


+ (instancetype)sharedClient {
    static RTorrentXMLRPCClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[RTorrentXMLRPCClient alloc] initWithBaseURL:[NSURL URLWithString:XMLRPCBaseURL]];

    });
    
    return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.baseURL = url;
    
    return self;
}

- (void)downloadList:(RTorrentXMLRPCClientSuccess)success failure:(RTorrentXMLRPCClientFailure)failure {

    XMLRPCRequest *request = [[XMLRPCRequest alloc] initWithURL: self.baseURL];
    [request setMethod: @"download_list" withParameter: nil];
    
    [PSXMLRPCConnectionManager asyncRequest:request success:^(XMLRPCResponse *response) {
        success(response);
    } failure:^(XMLRPCResponse *response, NSError *error) {
        failure(response, error);
        
    }];
}

- (void)torrentName:(NSString *)hash success:(RTorrentXMLRPCClientSuccess)success failure:(RTorrentXMLRPCClientFailure)failure {
    
    XMLRPCRequest *request = [[XMLRPCRequest alloc] initWithURL: self.baseURL];
    [request setMethod: @"d.name" withParameter: hash];
    
    [PSXMLRPCConnectionManager asyncRequest:request success:^(XMLRPCResponse *response) {
        success(response);
    } failure:^(XMLRPCResponse *response, NSError *error) {
        failure(response, error);
        
    }];
}

- (void)torrentSize:(NSString *)hash success:(RTorrentXMLRPCClientSuccess)success failure:(RTorrentXMLRPCClientFailure)failure {
    
    XMLRPCRequest *request = [[XMLRPCRequest alloc] initWithURL: self.baseURL];
    [request setMethod: @"d.size_bytes" withParameter: hash];
    
    [PSXMLRPCConnectionManager asyncRequest:request success:^(XMLRPCResponse *response) {
        success(response);
    } failure:^(XMLRPCResponse *response, NSError *error) {
        failure(response, error);
        
    }];
}

- (void)torrentBytesDownloaded:(NSString *)hash success:(RTorrentXMLRPCClientSuccess)success failure:(RTorrentXMLRPCClientFailure)failure {
    
    XMLRPCRequest *request = [[XMLRPCRequest alloc] initWithURL: self.baseURL];
    [request setMethod: @"d.completed_bytes" withParameter: hash];
    
    [PSXMLRPCConnectionManager asyncRequest:request success:^(XMLRPCResponse *response) {
        success(response);
    } failure:^(XMLRPCResponse *response, NSError *error) {
        failure(response, error);
        
    }];
}

- (void)torrentState:(NSString *)hash success:(RTorrentXMLRPCClientSuccess)success failure:(RTorrentXMLRPCClientFailure)failure {
    
    XMLRPCRequest *request = [[XMLRPCRequest alloc] initWithURL: self.baseURL];
    [request setMethod: @"d.state" withParameter: hash];
    
    [PSXMLRPCConnectionManager asyncRequest:request success:^(XMLRPCResponse *response) {
        success(response);
    } failure:^(XMLRPCResponse *response, NSError *error) {
        failure(response, error);
        
    }];
}

- (void)torrentRemove:(NSString *)hash success:(RTorrentXMLRPCClientSuccess)success failure:(RTorrentXMLRPCClientFailure)failure {
    
    XMLRPCRequest *request = [[XMLRPCRequest alloc] initWithURL: self.baseURL];
    [request setMethod: @"d.erase" withParameter: hash];
    
    [PSXMLRPCConnectionManager asyncRequest:request success:^(XMLRPCResponse *response) {
        success(response);
    } failure:^(XMLRPCResponse *response, NSError *error) {
        failure(response, error);
        
    }];
}

- (void)torrentStart:(NSString *)magnetLink success:(RTorrentXMLRPCClientSuccess)success failure:(RTorrentXMLRPCClientFailure)failure {
    
    XMLRPCRequest *request = [[XMLRPCRequest alloc] initWithURL: self.baseURL];
    [request setMethod: @"load_start" withParameter: magnetLink];
    
    [PSXMLRPCConnectionManager asyncRequest:request success:^(XMLRPCResponse *response) {
        success(response);
    } failure:^(XMLRPCResponse *response, NSError *error) {
        failure(response, error);
        
    }];
}

- (void)torrentDownloadRate:(NSString *)hash success:(RTorrentXMLRPCClientSuccess)success failure:(RTorrentXMLRPCClientFailure)failure {
    
    XMLRPCRequest *request = [[XMLRPCRequest alloc] initWithURL: self.baseURL];
    [request setMethod: @"d.down.rate" withParameter: hash];
    
    [PSXMLRPCConnectionManager asyncRequest:request success:^(XMLRPCResponse *response) {
        success(response);
    } failure:^(XMLRPCResponse *response, NSError *error) {
        failure(response, error);
        
    }];
}



@end
