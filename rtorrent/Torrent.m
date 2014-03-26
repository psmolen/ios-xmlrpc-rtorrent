//
//  Torrent.m
//  rtorrent
//
//  Created by Patrick Smolen on 3/22/14.
//  Copyright (c) 2014 Patrick Smolen. All rights reserved.
//

#import "Torrent.h"
#import "RTorrentXMLRPCClient.h"

@implementation Torrent {
    NSTimer *timer;
}

- (id)initWithTorrentHash:(NSString *)hash {
    self = [super init];
    if (self) {
        _torrentHash = hash;

    }
    
    return self;
}

- (NSString *)name {
    if (!_name) {
        [[RTorrentXMLRPCClient sharedClient] torrentName:[self torrentHash] success:^(XMLRPCResponse *response) {
            _name = response.object;
        } failure:^(XMLRPCResponse *response, NSError *error) {
            
        }];
    }
    return _name;
}

- (NSNumber *)totalSize {
    if (!_totalSize) {
        [[RTorrentXMLRPCClient sharedClient] torrentSize:[self torrentHash] success:^(XMLRPCResponse *response) {
            _totalSize = response.object;
        } failure:^(XMLRPCResponse *response, NSError *error) {
            
        }];
    }
    
    return _totalSize;
}

- (NSNumber *)completedBytes {
    if (!_completedBytes) {
        [[RTorrentXMLRPCClient sharedClient] torrentBytesDownloaded:[self torrentHash] success:^(XMLRPCResponse *response) {
            _completedBytes = response.object;
        } failure:^(XMLRPCResponse *response, NSError *error) {
            
        }];
    }
    
    return _completedBytes;
}

- (NSNumber *)state {
    if (!_state) {
        [[RTorrentXMLRPCClient sharedClient] torrentState:[self torrentHash] success:^(XMLRPCResponse *response) {
            _state = response.object;
        } failure:^(XMLRPCResponse *response, NSError *error) {
            
        }];
    }
    
    return _state;
}


- (NSNumber *)downloadRate {
    if (!_downloadRate) {
        [[RTorrentXMLRPCClient sharedClient] torrentDownloadRate:[self torrentHash] success:^(XMLRPCResponse *response) {
            _downloadRate = response.object;
        } failure:^(XMLRPCResponse *response, NSError *error) {
            
        }];
    }
    
    return _downloadRate;
}


- (void)updateTorrent {
   
    [[RTorrentXMLRPCClient sharedClient] torrentBytesDownloaded:[self torrentHash] success:^(XMLRPCResponse *response) {
        _completedBytes = response.object;
    } failure:^(XMLRPCResponse *response, NSError *error) {
        
    }];
    [[RTorrentXMLRPCClient sharedClient] torrentState:[self torrentHash] success:^(XMLRPCResponse *response) {
        _state = response.object;
    } failure:^(XMLRPCResponse *response, NSError *error) {
        
    }];
    [[RTorrentXMLRPCClient sharedClient] torrentDownloadRate:[self torrentHash] success:^(XMLRPCResponse *response) {
        _downloadRate = response.object;
    } failure:^(XMLRPCResponse *response, NSError *error) {
        
    }];
    
}



@end
