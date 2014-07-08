//
//  SettingsViewController.h
//  rtorrent
//
//  Created by Patrick Smolen on 3/16/14.
//  Copyright (c) 2014 Patrick Smolen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingsViewControllerDelegate
@required
-(void)settingsSaved;

@end

@interface SettingsViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITextField *serverAddress;
@property (nonatomic, assign) id delegate;

- (IBAction)saveSettings:(id)sender;
@end
