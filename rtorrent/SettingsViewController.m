//
//  SettingsViewController.m
//  rtorrent
//
//  Created by Patrick Smolen on 3/16/14.
//  Copyright (c) 2014 Patrick Smolen. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults stringForKey:SERVER_ADDRESS]) {
        self.serverAddress.text = [defaults stringForKey:SERVER_ADDRESS];
    }
}

- (IBAction)saveSettings:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:self.serverAddress.text forKey:SERVER_ADDRESS];
    [defaults synchronize];
    [self.delegate settingsSaved];
}

@end
