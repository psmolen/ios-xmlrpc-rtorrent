//
//  ViewController.m
//  rtorrent
//
//  Created by Patrick Smolen on 2/9/14.
//  Copyright (c) 2014 Patrick Smolen. All rights reserved.
//

#import "ViewController.h"
#import "XMLRPC.h"
#import "PSXMLRPCConnectionManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *URL = [NSURL URLWithString: @"http://192.168.1.132:8080/RPC2"];
    XMLRPCRequest *request = [[XMLRPCRequest alloc] initWithURL: URL];
    
    [request setMethod: @"system.listMethods" withParameter: nil];
    
    [PSXMLRPCConnectionManager asyncRequest:request success:^(XMLRPCResponse *response) {
        NSLog(@"success: %@",response.object);
        
    } failure:^(XMLRPCResponse *response, NSError *error) {
        NSLog(@"response:%@ error:%@", response, error);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
