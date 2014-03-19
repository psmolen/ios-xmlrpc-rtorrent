//
//  ViewController.m
//  rtorrent
//
//  Created by Patrick Smolen on 2/9/14.
//  Copyright (c) 2014 Patrick Smolen. All rights reserved.
//

#import "ViewController.h"
#import "XMLRPC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *URL = [NSURL URLWithString: @"http://192.168.1.132:8080/RPC2"];
    XMLRPCRequest *request = [[XMLRPCRequest alloc] initWithURL: URL];
    XMLRPCConnectionManager *manager = [XMLRPCConnectionManager sharedManager];
    
    //[request setMethod: @"load_start" withParameter: @"magnet:?xt=urn:btih:4956a4e976ea948025c3c3554567ca2820f65f64&dn=Frozen+%282013%29+1080p+BrRip+x264+-+YIFY&tr=udp%3A%2F%2Ftracker.openbittorrent.com%3A80&tr=udp%3A%2F%2Ftracker.publicbt.com%3A80&tr=udp%3A%2F%2Ftracker.istole.it%3A6969&tr=udp%3A%2F%2Ftracker.ccc.de%3A80&tr=udp%3A%2F%2Fopen.demonii.com%3A1337"];
    
    [request setMethod: @"download_list" withParameter: nil];
    
    NSLog(@"Request body: %@", [request body]);
    
    [manager spawnConnectionWithXMLRPCRequest: request delegate: self];
}

- (void)request:(XMLRPCRequest *)request didReceiveResponse:(XMLRPCResponse *)response {
    NSLog(@"%@", response);
}

- (void)request:(XMLRPCRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
