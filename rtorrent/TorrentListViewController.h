//
//  TorrentListViewController.h
//  rtorrent
//
//  Created by Patrick Smolen on 2/9/14.
//  Copyright (c) 2014 Patrick Smolen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TorrentListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *torrentList;

- (IBAction)addTorrent:(id)sender;
@end
