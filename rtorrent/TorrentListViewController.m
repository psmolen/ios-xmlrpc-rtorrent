//
//  TorrentListViewController.m
//  rtorrent
//
//  Created by Patrick Smolen on 2/9/14.
//  Copyright (c) 2014 Patrick Smolen. All rights reserved.
//

#import "TorrentListViewController.h"
#import "RTorrentXMLRPCClient.h"
#import "TorrentTableViewCell.h"
#import "Torrent.h"

@interface TorrentListViewController () {
    NSMutableArray *torrents;
    NSMutableArray *torrentHashes;
    NSTimer *timer;
}

@end

@implementation TorrentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    torrents = [NSMutableArray array];
    torrentHashes = [NSMutableArray array];
    
    [self downloadTorrentList];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(downloadTorrentList) userInfo:nil repeats:YES];
    
}

- (void)downloadTorrentList {
    NSLog(@"downloading");
    for (Torrent *torrent in torrents) {
        [torrent updateTorrent];
    }
    [[RTorrentXMLRPCClient sharedClient] downloadList:^(XMLRPCResponse *response) {
        for (NSString *hash in response.object) {
            if ([torrentHashes indexOfObject:hash] == NSNotFound) {
                Torrent *torrent = [[Torrent alloc] initWithTorrentHash:hash];
                [torrent completedBytes];
                [torrent name];
                [torrent totalSize];
                [torrent downloadRate];
                [torrent updateTorrent];
                [torrents addObject:torrent];
                [torrentHashes addObject:hash];
            }
            
        }
        
        [self.torrentList reloadData];
    } failure:^(XMLRPCResponse *response, NSError *error) {
        [timer invalidate];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to connect to XMLRPC Server" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addTorrent:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Enter the magnet link:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [alertView show];
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [torrents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    TorrentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TorrentCell"];
    
    if (cell == nil) {
        cell = [[TorrentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TorrentCell"];
    }
    

    cell.torrentName.text = [[torrents objectAtIndex:indexPath.row] name];
    cell.bytesDownloaded.text = [NSString stringWithFormat:@"%.2f GB of %.2f GB @ %.2f KB/s", [[[torrents objectAtIndex:indexPath.row] completedBytes] floatValue] / 1073741824.0, [[[torrents objectAtIndex:indexPath.row] totalSize] floatValue] / 1073741824.0,  [[[torrents objectAtIndex:indexPath.row] downloadRate] floatValue] / 1024];
    if ([[torrents objectAtIndex:indexPath.row] completedBytes] && [[torrents objectAtIndex:indexPath.row] totalSize]) {
        cell.downloadProgress.progress = ([[[torrents objectAtIndex:indexPath.row] completedBytes] floatValue] / [[[torrents objectAtIndex:indexPath.row] totalSize] floatValue]);
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[RTorrentXMLRPCClient sharedClient] torrentRemove:[[torrents objectAtIndex:indexPath.row] torrentHash] success:^(XMLRPCResponse *response) {
            
            [torrents removeObjectAtIndex:indexPath.row];
            [self.torrentList deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.torrentList reloadData];
        } failure:^(XMLRPCResponse *response, NSError *error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to remove torrent" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }];
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [[RTorrentXMLRPCClient sharedClient] torrentStart:[[alertView textFieldAtIndex:0] text] success:^(XMLRPCResponse *response) {
            [self downloadTorrentList];
        } failure:^(XMLRPCResponse *response, NSError *error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to add torrent" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }];
    }
}

@end
