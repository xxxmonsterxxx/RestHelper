//
//  SecondViewController.h
//  new4
//
//  Created by Dev on 15/04/2017.
//  Copyright © 2017 Dev. All rights reserved.
//
#import "Restaurant.h"
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface SecondViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
{
    UIBarButtonItem *_addToFav;
    Restaurant *_restaurant;
    UITableView *_tableView;
    NSMutableDictionary *_restDictionary;
    NSURL *_buttonURL;
    SystemSoundID _soundID;
}


@property (nonatomic, retain) NSMutableDictionary *restDictionary;
@property (nonatomic, retain) AVAudioPlayer *player;
@property (nonatomic, retain) Restaurant *restaurant;


@end
