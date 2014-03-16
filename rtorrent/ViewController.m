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
