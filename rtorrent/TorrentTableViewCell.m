//
//  TorrentTableViewCell.m
//  rtorrent
//
//  Created by Patrick Smolen on 3/22/14.
//  Copyright (c) 2014 Patrick Smolen. All rights reserved.
//

#import "TorrentTableViewCell.h"

@implementation TorrentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setTorrent:(Torrent *)torrent {
    _torrent = torrent;

    self.torrentName.text = [self.torrent name];
    self.bytesDownloaded.text = [NSString stringWithFormat:@"%.2f GB of %.2f GB @ %.2f KB/s", [[self.torrent completedBytes] floatValue] / 1073741824.0, [[self.torrent totalSize] floatValue] / 1073741824.0,  [[self.torrent downloadRate] floatValue] / 1024];
    
    if ([self.torrent completedBytes] && [self.torrent totalSize]) {
        self.downloadProgress.progress = ([[self.torrent completedBytes] floatValue] / [[self.torrent totalSize] floatValue]);
    }

}

@end
