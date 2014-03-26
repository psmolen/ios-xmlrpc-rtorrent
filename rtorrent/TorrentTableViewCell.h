//
//  TorrentTableViewCell.h
//  rtorrent
//
//  Created by Patrick Smolen on 3/22/14.
//  Copyright (c) 2014 Patrick Smolen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Torrent.h"

@interface TorrentTableViewCell : UITableViewCell
@property (nonatomic, retain) Torrent *torrent;
@property (nonatomic, weak) IBOutlet UILabel *torrentName;
@property (nonatomic, weak) IBOutlet UILabel *bytesDownloaded;
@property (nonatomic, weak) IBOutlet UIProgressView *downloadProgress;
@end
