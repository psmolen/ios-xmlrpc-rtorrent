//
//  Torrent.h
//  rtorrent
//
//  Created by Patrick Smolen on 3/22/14.
//  Copyright (c) 2014 Patrick Smolen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Torrent : NSObject
@property (nonatomic, retain) NSString *torrentHash;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *completedBytes;
@property (nonatomic, retain) NSNumber *totalSize;
@property (nonatomic, retain) NSNumber *state;
@property (nonatomic, retain) NSNumber *downloadRate;

- (id)initWithTorrentHash:(NSString *)hash;
- (void)updateTorrent;
@end
