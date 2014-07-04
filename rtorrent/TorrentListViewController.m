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
    NSMutableArray *_torrents;
    NSTimer *_timer;
}

@end

@implementation TorrentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _torrents = [NSMutableArray array];
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(updateTorrentList) userInfo:nil repeats:YES];
    
}

- (void)updateTorrentList {

    for (Torrent *torrent in _torrents) {
        [torrent updateTorrent];
    }
    
    [[RTorrentXMLRPCClient sharedClient] downloadList:^(XMLRPCResponse *response) {
        
        for (NSString *hash in response.object) {
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"torrentHash == %@", hash];
            NSArray *filteredArray = [_torrents filteredArrayUsingPredicate:predicate];
            
            if (![filteredArray count]) {
                Torrent *torrent = [[Torrent alloc] initWithTorrentHash:hash];
                [_torrents addObject:torrent];
            }
            
        }
        
        [self.torrentList reloadData];
    } failure:^(XMLRPCResponse *response, NSError *error) {
        
        [_timer invalidate];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to connect to XMLRPC Server" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }];
}

- (IBAction)addTorrent:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Enter the magnet link:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_torrents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    TorrentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TorrentCell"];
    
    if (cell == nil) {
        cell = [[TorrentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TorrentCell"];
    }
    
    cell.torrent = [_torrents objectAtIndex:indexPath.row];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[RTorrentXMLRPCClient sharedClient] torrentRemove:[[_torrents objectAtIndex:indexPath.row] torrentHash] success:^(XMLRPCResponse *response) {
            
            [_torrents removeObjectAtIndex:indexPath.row];
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
            [self updateTorrentList];
        } failure:^(XMLRPCResponse *response, NSError *error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to add torrent" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }];
    }
}

@end
