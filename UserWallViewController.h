//
//  PAAboutUsViewController.h
//  POP
//
//  Created by Wang Xiaoming on 23/04/14.
//  Copyright (c) 2014 Wang Xiaoming. All rights reserved.
//

#import "NMHeadViewController.h"
#import "UserWalllCell.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>

@interface UserWallViewController : NMHeadViewController<UITableViewDataSource,UITableViewDelegate,MFMessageComposeViewControllerDelegate>{
    
    IBOutlet UserWalllCell *userwallcell;
    IBOutlet UIView *userwallView;
    APLocationManager           *apLoc;
    MBProgressHUD           *progressHUD;
}
@property(nonatomic,retain)NSString *globalString;
@property (weak, nonatomic) IBOutlet MKMapView *mainMapc;
@property (weak, nonatomic) IBOutlet UITableView *fromAddressTableView;
@property (weak, nonatomic) IBOutlet UIButton *btnresize;
@property (weak, nonatomic) IBOutlet UIButton *coverbtn;
@property (nonatomic, strong) Reachability *reachability;
@end
