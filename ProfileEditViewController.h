//
//  TLProfileEditViewController.h
//  
//
//  Created by Wang Xiaoming on 25/02/14.
//  Copyright (c) 2014 Wang Xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NMHeadViewController.h"
#import "MBProgressHUD.h"

#import "APPhotoLibrary.h"
@interface ProfileEditViewController : NMHeadViewController<APPhotoPickerDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    IBOutlet UIImageView *imgVProfile;
    IBOutlet UIView *alphaView,*lineView;
    MBProgressHUD           *progressHUD;
}
@property (strong, nonatomic) IBOutlet UIImageView *imgProfile;

@end
