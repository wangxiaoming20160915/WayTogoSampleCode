//
//  PAAboutUsViewController.m
//  POP
//
//  Created by iOSDeveloper4 on 23/04/14.
//  Copyright (c) 2014 iOSDeveloper4. All rights reserved.
//

#import "UserWallViewController.h"
#import <MapKit/MapKit.h>
#import "APLocationManager.h"
#import "UserWalllCell.h"
#import "FeedDetailMapViewController.h"
#import "WebServiceCalls.h"
#import "Asyncimageview.h"
#import <MediaPlayer/MediaPlayer.h>
#import "Config.h"
#import "NewEventViewController.h"
#import "SEPaymentViewController.h"
#import "SEReceiptVC.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import "SEDriverPopup.h"
#import "SEDriverPickup.h"
#import "SEDriverOnRoute.h"
#import "Canvas.h"
#import "SEMoreInfoApplication.h"
#import "SEPhoneVerification.h"
#import "SEFoodViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface UserWallViewController ()<MKMapViewDelegate,UIActionSheetDelegate>
{
    
    __weak IBOutlet UITextField *weightTextField;
    __weak IBOutlet CSAnimationView *confirmPhotoView;
    __weak IBOutlet UIView *cameraView;
    __weak IBOutlet UIView *infoShipLabel;
    __weak IBOutlet UIView *takePhotoBackground;
    __weak IBOutlet UIButton *takePhotoButton;
    __weak IBOutlet UIView *frameforCapture;
    __weak IBOutlet UIButton *usethisPhotoBtnRef;
    __weak IBOutlet UIButton *retakePhotoBtn;
    __weak IBOutlet CSAnimationView *weightView;
    AVCaptureSession *session;
    AVCaptureStillImageOutput *stillImageOutput;
    AVCaptureVideoPreviewLayer *previewLayer;
    __weak IBOutlet UIImageView *imageOutput;
    
    IBOutlet UIButton *changeablesliderreference;
    __weak IBOutlet UIView *confirmpickupref;
    __weak IBOutlet UIImageView *changeableride;
    __weak IBOutlet UIView *fromaddressbar;
    NSInteger selectedTagValue;
    NSMutableArray *anoArray;
    NSString *checkingifitsdone;
    IBOutlet UITextField *fromLocation;
    
    double AddressLatitude;
    double AddressLongitude;
    
    NSMutableDictionary *pickupInfo;
    NSMutableDictionary *driverFeedList;
    __weak IBOutlet UILabel *fromLabel;
    
    CLLocation                  *driverLocation;
    
    NSTimer *myTimer;
    NSTimer *searchforrides;
    
    IBOutlet UIView *tinter;
    
    UITapGestureRecognizer *lpgtr;
    
    __weak IBOutlet UILabel *confirmpickup;
    __weak IBOutlet MKMapView *mapViewLocation;
    __weak IBOutlet UISegmentedControl *segmentControl;
    
    NSMutableArray *locationLatLongArray;
    NSMutableArray *feedList;
    MKPointAnnotation           *pinAnnotation;
    
    NSInteger buttonTag;
    
    NSString *userLatitude;
    NSString *userLongitude;
    
    NSString *fromAddressLocation;
    NSString *toAddressLocation;
    
    CSAnimationView *popupView;
    
    MKPointAnnotation *pinTwo;
    NSMutableArray *profileImageArr;
    NSMutableArray *feedImageArr;
    
    double                      completesearchLat;
    double                      completesearchLong;
    
    double                      useroriginallat;
    double                      useroriginallong;
    
    __weak IBOutlet CSAnimationView *hideForDriverMode;
    
    CLLocation                  *selectedLocation;
    CLLocation                  *checkuserlocation;
    CLLocation                  *completedLocation;
    NSString                    *sendthisaddress;
    IBOutlet UIView *mainview;
    __weak IBOutlet UIView *viewi6;
    NSString *due;
    
    __weak IBOutlet UIButton *invitefriendsref;
    
    IBOutlet UIButton *confirmunavailableref;
    IBOutlet UIButton *cancelunavailableref;
    IBOutlet UIButton *steeringwheelimage;
    APLocationManager *locationManager;
    
    __weak IBOutlet UIButton *foodTinterBtnRef;
    NSInteger preload;
    NSTimer *preloadNStimer;
    __weak IBOutlet UILabel *courierLabel;
    __weak IBOutlet UILabel *foodLabel;
    __weak IBOutlet UILabel *rideLabel;
    
    __weak IBOutlet CSAnimationView *foodView;
    __weak IBOutlet UIView *sliderView;
    NSString *selections;
    
    __weak IBOutlet UISlider *selectionslider;
    
    NSArray *numbers;
    NSNumber *Slidernumber;
    __weak IBOutlet UITextView *fooddescriptionTextView;
    
    NSString *activeView;
    
    UIButton *taptoHideBtn;
    
    __weak IBOutlet UIButton *cancelBtn;
    __weak IBOutlet UIButton *OKButton;
}
@end

#define iPhone6 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 667)
#define iPhone6Plus ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 736)
@implementation UserWallViewController
@synthesize globalString;

- (void)viewDidLoad
{
    [super viewDidLoad];
    preload=2;
    
    
    
    NSLog(@"Current language: %@",currentLanguage);
    
    NSLog(@"Current Country: %@", currentCountry);
    
    if (IS_IPHONE4) {
        fooddescriptionTextView.frame = CGRectMake(fooddescriptionTextView.frame.origin.x, fooddescriptionTextView.frame.origin.y-hideForDriverMode.frame.origin.y, fooddescriptionTextView.frame.size.width, fooddescriptionTextView.frame.size.height);
        foodTinterBtnRef.frame = CGRectMake(foodTinterBtnRef.frame.origin.x, foodTinterBtnRef.frame.origin.y-hideForDriverMode.frame.origin.y, foodTinterBtnRef.frame.size.width, foodTinterBtnRef.frame.size.height);
    
    }
    
    confirmpickupref.layer.cornerRadius = 5;
    confirmpickupref.layer.masksToBounds = YES;
    cancelunavailableref.layer.cornerRadius = 5;
    cancelunavailableref.layer.masksToBounds = YES;
    confirmunavailableref.layer.cornerRadius = 5;
    confirmunavailableref.layer.masksToBounds = YES;
    foodTinterBtnRef.layer.cornerRadius = 5;
    foodTinterBtnRef.layer.masksToBounds = YES;
    fooddescriptionTextView.layer.cornerRadius = 5;
    fooddescriptionTextView.layer.masksToBounds = YES;
    retakePhotoBtn.layer.cornerRadius = 2;
    retakePhotoBtn.layer.masksToBounds = YES;
    usethisPhotoBtnRef.layer.cornerRadius = 2;
    usethisPhotoBtnRef.layer.masksToBounds = YES;
    weightView.layer.cornerRadius = 3;
    weightView.layer.masksToBounds = YES;
    
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, OKButton.frame.origin.y, weightView.frame.size.width, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    lineView.alpha = 0.7;
    [weightView addSubview:lineView];
    
    UIView *leftBorder = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 1, OKButton.frame.size.height)];
    leftBorder.backgroundColor = [UIColor grayColor];
    [OKButton addSubview:leftBorder];
    
    
    [self additionalInfoForDriverApplication];
    NSLog(@"PrintY %f",fromaddressbar.frame.origin.y);
    NSLog(@"PrintX %f",fromaddressbar.frame.origin.x);
    NSLog(@"PrintArrowX %f", self.btnresize.frame.origin.x);
    NSLog(@"PrintArrowY %f", self.btnresize.frame.origin.y);
    
    //[[NSUserDefaults standardUserDefaults]stringForKey:@"preferenceName"];
    
    if ([[[NSUserDefaults standardUserDefaults]stringForKey:@"driversideActivated"]isEqualToString:@"activated"]) {
        if ([userInformation[@"vDriverorNot"]isEqualToString:@"driver"]) {
        changeableride.hidden=YES; // Here loading drivers view
        hideForDriverMode.hidden=YES;
        changeablesliderreference.enabled=NO;
        fromaddressbar.hidden=YES;
        self.coverbtn.hidden=YES;
        self.btnresize.hidden=YES;
        [self.mainMapc removeGestureRecognizer:lpgtr];
        [self.mainMapc removeAnnotation:pinAnnotation];
            steeringwheelimage.selected=YES;
        
        [WebServiceCalls onlineoroffline:__CURRENT_USER :@"online" block:^(id JSON, WebServiceResult result) {
            if(result==WebServiceResultSuccess){
                playSound=YES;
                myTimer=[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(loadusercurrentLocation) userInfo:nil repeats:YES];
                searchforrides=[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(checkDriverFeed) userInfo:nil repeats:YES];
            
            }else{
                showAletViewWithMessage(@"Check your internet connection and try again..");
            }
        }];
        
       
    }
        

    }
    
    if ([userInformation[@"vDriverorNot"]isEqualToString:@"driver"]) {
        steeringwheelimage.hidden=NO;
        steeringwheelimage.enabled=YES;
        invitefriendsref.enabled=NO;
        invitefriendsref.hidden=YES;
        UIImage *nonCheckedImage = [UIImage imageNamed:@"notactive_steeringwheel.png"];
        UIImage *checkedImage = [UIImage imageNamed:@"steeringwheel.png"];
        [steeringwheelimage setImage:checkedImage forState:UIControlStateSelected];
        [steeringwheelimage setImage:nonCheckedImage forState:UIControlStateNormal];
        
    }
    if (IS_IPHONE6_Plus) {
        fromaddressbar.frame=CGRectMake(10, 592, fromaddressbar.frame.size.width, fromaddressbar.frame.size.height);
        self.btnresize.frame=CGRectMake(self.btnresize.frame.origin.x, self.btnresize.frame.origin.y-20, self.btnresize.frame.size.width, self.btnresize.frame.size.height);
    }else if (IS_IPHONE6){
        fromaddressbar.frame=CGRectMake(fromaddressbar.frame.origin.x, fromaddressbar.frame.origin.y-10, fromaddressbar.frame.size.width, fromaddressbar.frame.size.height);
        self.btnresize.frame=CGRectMake(self.btnresize.frame.origin.x, self.btnresize.frame.origin.y-10, self.btnresize.frame.size.width, self.btnresize.frame.size.height);
    }
    [self setupReachabilityNotification];
    
    locationManager =[[APLocationManager alloc]init];
    
    feedList =[[NSMutableArray alloc]init];
    locationLatLongArray =[[NSMutableArray alloc]init];
    anoArray =[[NSMutableArray alloc]init];
    
    
    mapViewLocation.hidden=NO;
    
    pinTwo =[[MKPointAnnotation alloc]init];

    lpgtr =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureHandler:)];
    
    lpgtr.delegate=(id)self;
    [self.mainMapc addGestureRecognizer:lpgtr];
    
    [self loaduserLocation];

    fromLocation.delegate = self;
    
    [fromLocation addTarget:self
                          action:@selector(textFieldDidEndEditing)
                forControlEvents:UIControlEventEditingDidEnd];
    
    [fromLocation addTarget:self
                     action:@selector(textFieldDidBeginEditing)
           forControlEvents:UIControlEventEditingDidBegin];
 
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"hasvalue"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"downloaded"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cashorcc"];

    [self refreshTableViewData];
    
    if ([userInformation[@"userPhone"]isEqualToString:@"0"] || [userInformation[@"verifiedPhone"]isEqualToString:@"0"]) {
        NSLog(@"No phonenumber registerered");
        SEPhoneVerification *addPhoneNumber = [self.storyboard instantiateViewControllerWithIdentifier:@"verifyPhoneFB"];
        [self.navigationController pushViewController:addPhoneNumber animated:YES];
    }
    
    [self checkingbalance];

    UIImage *image = [UIImage imageNamed:@"sliderbtn.png"];
    CGRect rect = CGRectMake(0.0f, 40.0f, sliderView.frame.size.width, sliderView.frame.size.height);
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:rect];
    [imageView setImage:image];
    
    selectionslider.layer.cornerRadius = 5;
    selectionslider.layer.masksToBounds = YES;
    selectionslider.frame=CGRectMake(0, 0, sliderView.frame.size.width, sliderView.frame.size.height);
    [selectionslider setMinimumTrackImage:[UIImage alloc] forState:UIControlStateNormal];
    [selectionslider setMaximumTrackImage:[UIImage alloc] forState:UIControlStateNormal];
    [[UISlider appearance] setThumbImage:imageView.image forState:UIControlStateNormal];
    NSLog(@"printing feedlist %@", feedList);
    
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sliderTapped:)];
    [selectionslider addGestureRecognizer:gr];
    
    numbers = @[@(0), @(5), @(10)];
    // slider values go from 0 to the number of values in your numbers array
    NSInteger numberOfSteps = ((float)[numbers count] - 1);
    selectionslider.maximumValue = numberOfSteps;
    selectionslider.minimumValue = 0;
    
    // As the slider moves it will continously call the -valueChanged:
    selectionslider.continuous = YES; // NO makes it call only once you let go
    [selectionslider addTarget:self
               action:@selector(valueChanged:)
     forControlEvents:UIControlEventValueChanged];
    [selectionslider addTarget:self action:@selector(stageSelected:) forControlEvents:UIControlEventTouchUpInside];
    [selectionslider addTarget:self action:@selector(stageSelected:) forControlEvents:UIControlEventTouchUpOutside];
    courierLabel.textColor = [UIColor colorWithRed:138.0/255.0 green:140.0/255.0 blue:141.0/255.0 alpha:1];
    foodLabel.textColor = [UIColor colorWithRed:138.0/255.0 green:140.0/255.0 blue:141.0/255.0 alpha:1];
    rideLabel.textColor = [UIColor colorWithRed:255.0/255.0 green:170.0/255.0 blue:0/255.0 alpha:1];
    courierLabel.text = @"Courier";
    foodLabel.text = @"Food";
    rideLabel.text = @"Taxi";
    rideLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
}
- (IBAction)swedenSelectRide:(id)sender {
    showAletViewWithMessage(@"Mat & Kurir är ännu inte tillgängligt i Sverige.");
}
#pragma checking internet connection
- (void)setupReachabilityNotification{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged) name:kReachabilityChangedNotification object:nil];
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    
    [self setReachability: reachability];
}
- (void)valueChanged:(UISlider *)sender {
    // round the slider position to the nearest index of the numbers array);
    if (selectionslider.value == 0) {
        [selectionslider setValue:0 animated:NO];
    }
    NSUInteger index = (NSUInteger)(selectionslider.value + 0.5);
    [selectionslider setValue:index animated:NO];
    Slidernumber = numbers[index]; // <-- This numeric value you want
    NSLog(@"sliderIndex: %i", (int)index);
    NSLog(@"number: %@", Slidernumber);
    [self changingLabelStages];

}
-(void)stageSelected:(UISlider *)sender{
    NSLog(@"Released!");
    if ([activeView isEqualToString:@"ride"]) {
        NSLog(@"Switching to Ride View");
        [session stopRunning];
        [frameforCapture setHidden:YES];
        [previewLayer setHidden:YES];
        
        [foodView setHidden:YES];
        [tinter setHidden:YES];
        if ([currentLanguage isEqualToString:@"sv"]) {
            fromLabel.text = @"Från:";
        }else{
            fromLabel.text = @"From:";
        }
    }else if ([activeView isEqualToString:@"courier"]) {
        NSLog(@"Switching to Courier View");
        if ([currentLanguage isEqualToString:@"sv"]) {
            fromLabel.text = @"Hämta från:";
        }else{
            fromLabel.text = @"Pickup From:";
        }
    }else if ([activeView isEqualToString:@"food"]) {
        NSLog(@"Switching to Food view");
        [session stopRunning];
        [frameforCapture setHidden:YES];
        [previewLayer setHidden:YES];
        if ([currentLanguage isEqualToString:@"sv"]) {
            fromLabel.text = @"Leverera Till:";
        }else{
        fromLabel.text = @"Deliver To:";
        }
    }
}
-(void)backtoRideView{
    [taptoHideBtn removeFromSuperview];
    [fooddescriptionTextView resignFirstResponder];
    [self getMyLocationNow:self];
    [selectionslider setValue:0 animated:YES];
    [self valueChanged:selectionslider];
    [self stageSelected:selectionslider];
}
- (IBAction)drivernotes:(id)sender {
    NSLog(@"Notes: %@",fooddescriptionTextView.text);
    [tinter setHidden:YES];
    [taptoHideBtn removeFromSuperview];
    [foodView setHidden:YES];
    [self addLoading:self];
    [fooddescriptionTextView resignFirstResponder];
    if ([currentLanguage isEqualToString:@"sv"]) {
        [self LoadingText:@"Söker efter restauranger.."];
    }else{
    [self LoadingText:@"Loading restaurants near you.."];
    }
    NSString *noteText = fooddescriptionTextView.text;
    [[NSUserDefaults standardUserDefaults] setObject:noteText forKey:@"drivernotessaved"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(doneWaiting) userInfo:nil repeats:NO];
}
-(void)doneWaiting{
    [self removeLoading];
    if ([currentCountry isEqualToString:@"SE"] || [currentLanguage isEqualToString:@"SV"]) {
        showAletViewWithMessage(@"Mat är ännu inte tillgängligt i Sverige. Håll ögonen öppna! :)");
    }else{
    SEFoodViewController *newevent = [self.storyboard instantiateViewControllerWithIdentifier:@"foodVC"];
    [self.navigationController pushViewController:newevent animated:NO];
    }
}
-(void)changingLabelStages{
    if ([Slidernumber intValue]==0) {
        rideLabel.textColor = [UIColor colorWithRed:255.0/255.0 green:170.0/255.0 blue:0/255.0 alpha:1];
        rideLabel.text = @"Taxi";
        rideLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18]; 
        
        courierLabel.textColor = [UIColor colorWithRed:138.0/255.0 green:140.0/255.0 blue:141.0/255.0 alpha:1];
        foodLabel.textColor = [UIColor colorWithRed:138.0/255.0 green:140.0/255.0 blue:141.0/255.0 alpha:1];
        courierLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
        foodLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
        NSLog(@"Ride Active");
        activeView = @"ride";
    }else if ([Slidernumber intValue]==5){
        courierLabel.textColor = [UIColor colorWithRed:255.0/255.0 green:170.0/255.0 blue:0/255.0 alpha:1];
        courierLabel.text = @"Courier";
        courierLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
        
        
        rideLabel.textColor = [UIColor colorWithRed:138.0/255.0 green:140.0/255.0 blue:141.0/255.0 alpha:1];
        foodLabel.textColor = [UIColor colorWithRed:138.0/255.0 green:140.0/255.0 blue:141.0/255.0 alpha:1];
        rideLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
        foodLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
        
        NSLog(@"Courier active");
        activeView = @"courier";
    }else if([Slidernumber intValue]==10){
        foodLabel.textColor = [UIColor colorWithRed:255.0/255.0 green:170.0/255.0 blue:0/255.0 alpha:1];
        foodLabel.text = @"Food";
        foodLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
        
        rideLabel.textColor = [UIColor colorWithRed:138.0/255.0 green:140.0/255.0 blue:141.0/255.0 alpha:1];
        courierLabel.textColor = [UIColor colorWithRed:138.0/255.0 green:140.0/255.0 blue:141.0/255.0 alpha:1];
        rideLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
        courierLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
        
        
        NSLog(@"Food Active");
        activeView = @"food";
    }

}
- (void)sliderTapped:(UIGestureRecognizer *)g
{
    
    UISlider* s = (UISlider*)g.view;
    if (s.highlighted)
        return; // tap on thumb, let slider deal with it
    CGPoint pt = [g locationInView: s];
    CGFloat percentage = pt.x / s.bounds.size.width;
    CGFloat delta = percentage * (s.maximumValue - s.minimumValue);
    CGFloat value = s.minimumValue + delta;
    [s setValue:value animated:YES];
    
    [self valueChanged:selectionslider];
    [self stageSelected:selectionslider];
}

-(void)reachabilityChanged{
    
    if(![self  isReachable])
        [self refreshTableViewData];
}
-(void)confirmpickuplocation{
    confirmpickup.text=sendthisaddress;
    confirmpickupref.hidden=NO;
    [tinter setHidden:NO];
    [mainview bringSubviewToFront:tinter];

    [confirmpickupref startCanvasAnimation];
    
    //[UIColor colorWithR:52 G:64: B:79 A:0.8]
    
    [mainview addSubview:confirmpickupref];
    [mainview bringSubviewToFront:confirmpickupref];
}
- (IBAction)confirmbutton:(id)sender {
    confirmpickupref.hidden=YES;
    [tinter setHidden:YES];
    if ([SEAppDelegate appDelegate].balance == NO) {
        [self next];
    }else{
        if ([currentLanguage isEqualToString:@"sv"]) {
            NSString *balancealert = [NSString stringWithFormat:@"Du kommer inte att tillåtas att boka en annan resa tills du har rensat ditt saldo: %@ KR. För mer information, vänligen kontakta support@rideapp.us.", due];
            showAletViewWithMessage(balancealert);
        }else{
        NSString *balancealert = [NSString stringWithFormat:@"You won't be allowed to book another trip until you've cleared your balance: $%@. Please contact support@rideapp.us for more information on how to clear this.", due];
        showAletViewWithMessage(balancealert);
        }
    }
}
-(void)additionalInfoForDriverApplication{
    if ([userInformation[@"vDriverorNot"]isEqualToString:@"insurance"]) {
        [self performSegueWithIdentifier:@"ApplicationInfo" sender:self];
    }else if ([userInformation[@"vDriverorNot"]isEqualToString:@"carpicture"]) {
        [self performSegueWithIdentifier:@"ApplicationInfo" sender:self];
    }else if ([userInformation[@"vDriverorNot"]isEqualToString:@"picture"]) {
        [self performSegueWithIdentifier:@"ApplicationInfo" sender:self];
    }else if ([userInformation[@"vDriverorNot"]isEqualToString:@"registration"]) {
        [self performSegueWithIdentifier:@"ApplicationInfo" sender:self];
    }
 
}
-(void)removeadditionalInfo{
    [tinter setHidden:YES];
    [popupView setHidden:YES];
}
- (IBAction)switchtoDriver:(id)sender {
    steeringwheelimage.enabled=NO;
    steeringwheelimage.selected = !steeringwheelimage.selected;
    
    if (steeringwheelimage.selected) {
        NSLog(@"Switching to drivers view!");
        [[NSUserDefaults standardUserDefaults] setObject:@"activated" forKey:@"driversideActivated"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self PreloadStart];
    }else if (!steeringwheelimage.selected){
        NSLog(@"Switching Back!");
        [WebServiceCalls onlineoroffline:__CURRENT_USER :@"offline" block:^(id JSON, WebServiceResult result) {
            NSLog(@"Done");
        }];
        [self driverisoffline];
        [[NSUserDefaults standardUserDefaults] setObject:@"deactivated" forKey:@"driversideActivated"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self UserviewStart];
        
    }
}
- (IBAction)cancelconfirmbtn:(id)sender {
    confirmpickupref.hidden=YES;
    [tinter setHidden:YES];
}
- (BOOL)isReachable {
    
    Reachability *reachability   = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    
    if (internetStatus != NotReachable) {
        //my web-dependent code
        return YES;
    }
    else {
        //there-is-no-connection warning
        return NO;
    }
}
#pragma done
-(void)checkingbalance{
    
    [WebServiceCalls checkuserBalance:__CURRENT_USER block:^(id JSON, WebServiceResult result) {
        NSLog(@"logging JSON checkingbalance %@", JSON);
        if(result==WebServiceResultSuccess){
             [SEAppDelegate appDelegate].balance=NO;
        }
        if (result==WebServiceResultFail) {
             [SEAppDelegate appDelegate].balance=YES;
            due = JSON[@"balance"];
            if ([currentLanguage isEqualToString:@"sv"]) {
                NSString *balancealert = [NSString stringWithFormat:@"Du kommer inte att tillåtas att boka en annan resa tills du har rensat ditt saldo: %@ KR. För mer information, vänligen kontakta support@rideapp.us.", due];
                showAletViewWithMessage(balancealert);
            }else{
            NSString *balancealert = [NSString stringWithFormat:@"You won't be allowed to book another trip until you've cleared your balance: $%@. Please contact support@rideapp.us for more information on how to clear this.", due];
            showAletViewWithMessage(balancealert);
            }
        }
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self getMyLocationNow:self];
    mainview.userInteractionEnabled=YES;
    [selectionslider setValue:0 animated:YES];
    [self valueChanged:selectionslider];
    [self stageSelected:selectionslider];
//    if(IS_IPHONE4){
//        NSLog(@"heeellloo!");
//        self.coverbtn.frame=CGRectMake(0,420,320,60);
//        self.btnresize.frame=CGRectMake(260, 370, 50, 50);
//    }
    if (IS_IPHONE6)
    {
//        self.coverbtn.frame=CGRectMake(0,605,375,64);
//        [self.coverbtn setImage:[UIImage imageNamed:@"request6.png"] forState:UIControlStateNormal];
        [segmentControl setFrame:CGRectMake(115, segmentControl.frame.origin.y, segmentControl.frame.size.width, segmentControl.frame.size.height)];
    }
    if (IS_IPHONE6_Plus)
    {
//        self.coverbtn.frame=CGRectMake(0,676,414,64);
//        [self.coverbtn setImage:[UIImage imageNamed:@"request6plus.png"] forState:UIControlStateNormal];
        [segmentControl setFrame:CGRectMake(135, segmentControl.frame.origin.y, segmentControl.frame.size.width, segmentControl.frame.size.height)];
    }
}
-(void)startCameraSession{
    [confirmPhotoView setHidden:YES];
    session = [[AVCaptureSession alloc]init];
    [session setSessionPreset:AVCaptureSessionPresetPhoto];
    
    AVCaptureDevice *inputDevice =  [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:&error];
    if ([session canAddInput:deviceInput]) {
        [session addInput:deviceInput];
    }
    
    previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:session];
    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    CALayer *rootLayer = [[self view]layer];
    [rootLayer setMasksToBounds:YES];
    CGRect frame = frameforCapture.frame;
    [previewLayer setFrame:frame];
    
    [rootLayer insertSublayer:previewLayer above:0];
    stillImageOutput = [[AVCaptureStillImageOutput alloc]init];
    NSDictionary *outputSettings = [[NSDictionary alloc]initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey ,nil];
    
    [stillImageOutput setOutputSettings:outputSettings];
    [session addOutput:stillImageOutput];
    
    [session startRunning];
    float y = [UIScreen mainScreen].bounds.size.height - takePhotoBackground.frame.size.height;
    
        takePhotoBackground.frame = CGRectMake(takePhotoBackground.frame.origin.x, y, takePhotoBackground.frame.size.width, takePhotoBackground.frame.size.height);
    
    
    takePhotoButton.frame = CGRectMake(takePhotoButton.frame.origin.x, y + (takePhotoBackground.frame.size.height / 2) - (takePhotoButton.frame.size.height / 2), takePhotoButton.frame.size.width, takePhotoButton.frame.size.height);
    
    
    float placement = [UIScreen mainScreen].bounds.size.height - (takePhotoBackground.frame.size.height + infoShipLabel.frame.size.height);
    
    NSLog(@"placement: %f",placement);
    infoShipLabel.frame = CGRectMake(infoShipLabel.frame.origin.x,placement, infoShipLabel.frame.size.width, infoShipLabel.frame.size.height);
    
    // X = (self.view.frame.size.width/2) - (image.size.width/2)
    // Y = (self.view.frame.size.height / 2) - (image.size.height / 2)
    [cameraView setHidden:NO];
    [takePhotoBackground setHidden:NO];
    [infoShipLabel setHidden:NO];
    [takePhotoButton setHidden:NO];
    [frameforCapture setHidden:NO];
    [self.view addSubview:infoShipLabel];
    [self.view addSubview:takePhotoBackground];
    [self.view addSubview:takePhotoButton];
    [self.view bringSubviewToFront:infoShipLabel];
    [self.view bringSubviewToFront:takePhotoBackground];
    [self.view bringSubviewToFront:takePhotoButton];
}
-(IBAction)takePhoto:(id)sender{
    AVCaptureConnection *videoConnection = nil;
    
    
    for (AVCaptureConnection *connection in stillImageOutput.connections) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType]isEqual:AVMediaTypeVideo]) {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) {
            break;
        }
    }
    
    [stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer != NULL) {
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            UIImage *image = [UIImage imageWithData:imageData];
            [cameraView setHidden:YES];
            [takePhotoBackground setHidden:YES];
            [infoShipLabel setHidden:YES];
            [takePhotoButton setHidden:YES];
            
            imageOutput.image = image;
            imageOutput.frame = frameforCapture.frame;
            [self.view addSubview:imageOutput];
            [self.view bringSubviewToFront:imageOutput];
            [self.view addSubview:confirmPhotoView];
            [self.view bringSubviewToFront:confirmPhotoView];
            [imageOutput setHidden:NO];
            [confirmPhotoView setHidden:NO];
            [confirmPhotoView startCanvasAnimation];
            
        }
    }];
}
- (IBAction)takeNewPhoto:(id)sender {
    [session stopRunning];
    [self startCameraSession];
}
- (IBAction)useThisPhoto:(id)sender {
    [confirmPhotoView setHidden:YES];
    
    [self.view addSubview:weightView];
    [self.view bringSubviewToFront:weightView];
    [weightView setHidden:NO];
    [weightTextField becomeFirstResponder];
    [weightView startCanvasAnimation];
}
- (IBAction)allSetBtn:(id)sender {
    // here push to next segue with the photo that the user took
    if ([userInformation[@"vToken"] isEqualToString:@""]) {
        NSLog(@"User does not have a CC registered");
        showAletViewWithMessage(@"Please add a creditcard for your order. Cash is only available when you request a Ride.");
        SEPaymentViewController *paymentView = [self.storyboard instantiateViewControllerWithIdentifier:@"payment"];
        paymentView.typeStr = @"updateToken";
        [self.navigationController pushViewController:paymentView animated:NO];
        
    }else{
        if (weightTextField.text.length == 0) {
            NSLog(@"No weight entered");
            showAletViewWithMessage(@"Please enter the weight of your item before proceeding");
        }else{
        NSLog(@"User has CC registered");
        NSLog(@"Weight of item: %@",weightTextField.text);
        [SEAppDelegate appDelegate].fromaddresscache = sendthisaddress;
        [self performSegueWithIdentifier:@"courierPush" sender:self];
        }
    }
    
}
- (IBAction)cancelCourierBtn:(id)sender {
    [self getMyLocationNow:self];
    [selectionslider setValue:0 animated:YES];
    [self valueChanged:selectionslider];
    [self stageSelected:selectionslider];
    [weightView setHidden:YES];
    [imageOutput setHidden:YES];
    [takePhotoBackground setHidden:YES];
    [infoShipLabel setHidden:YES];
    [takePhotoButton setHidden:YES];
    [cameraView setHidden:YES];
    [frameforCapture setHidden:YES];
    [weightTextField resignFirstResponder];
    [self.view bringSubviewToFront:self.mainMapc];
    [self.view bringSubviewToFront:hideForDriverMode];
    [self.view bringSubviewToFront:self.coverbtn];
    [self.view bringSubviewToFront:fromaddressbar];
    [self.view bringSubviewToFront:self.btnresize];
    mainview.userInteractionEnabled=YES;
}



-(void)refreshTableViewData
{
    [WebServiceCalls getFeedListCompletionBlock:^(id JSON, WebServiceResult result) {
        if(result == WebServiceResultSuccess)
        {
            
            feedList=[JSON[@"data"] mutableCopy];
            [locationLatLongArray removeAllObjects];
            [feedList enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                NSDictionary *param=@{
                                      @"latitude":obj[@"fLat"],
                                      @"longitude":obj[@"fLong"],
                                      @"title":obj[@"vFeedTitle"],
                                      @"subtitle":obj[@"tFeedDescription"]
                                      };
                [locationLatLongArray addObject:param];
                
            }];
            
            profileImageArr = [[NSMutableArray alloc] init];
            feedImageArr = [[NSMutableArray alloc]init];
            
            for (int i = 0; i < [feedList count]; i++) {
                [profileImageArr addObject:@""];
                [feedImageArr addObject:@""];
            }
            [self setMapPin];
            
            self.imgDownloader=[[JPLazyImageDownloader alloc]init];
            self.imgDownloaderSecond=[[JPLazyImageDownloader alloc]init];
            
            
            if (!feedList || !feedList.count) {
                NSLog(@"its empty");
                [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"hasvalue"];
            }else{
                NSLog(@"has objects");
                [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"hasvalue"];
                [self pushtodeserve];
            }
        }
    }];
}
-(void)pushtodeserve{
    BOOL value = [[NSUserDefaults standardUserDefaults]boolForKey:@"hasvalue"];
    
    
    if (value == NO) {
        NSLog(@"its null");
    }
    if (value == YES) {
        [self checkpush];
    }
}
-(void)checkpush{
    NSIndexPath *indexPath;
    
    if (feedList == nil || [feedList count] == 0) {
    }else{
    
    if ([feedList[indexPath.row]objectForKey:@"vUserView"] == nil) {
        NSLog(@"its nil");
    }else{
        
    NSString *result = [feedList[indexPath.row]objectForKey:@"vUserView"];
    
    if (result == nil) {
    }
    NSLog(@"logging result from checkpush %@", result);
        
            if ([[feedList[indexPath.row]objectForKey:@"iUserID"]isEqualToString:__CURRENT_USER]) {
    if ([result isEqualToString:@"friends"]) {
            [self performSelector:@selector(friendspush) withObject:nil afterDelay:1];
    }
    if ([result isEqualToString:@"pickedup"]) {
        [self performSelector:@selector(friendspush) withObject:nil afterDelay:1];
    }
    if ([result isEqualToString:@"public"]) {
        NSString *feedID = [feedList[indexPath.row]objectForKey:@"iFeedID"];
        [WebServiceCalls deleteRide:feedID block:^(id JSON, WebServiceResult result) {
            NSLog(@"done");
        }];
        [WebServiceCalls deleteRide:feedID block:^(id JSON, WebServiceResult result) {
            NSLog(@"done");
        }];
        [WebServiceCalls deleteRide:feedID block:^(id JSON, WebServiceResult result) {
            NSLog(@"done");
        }];
    }
    }
    }
    }
}

-(void)friendspush{
    FeedDetailMapViewController *feedDetailMapVC=[self.storyboard instantiateViewControllerWithIdentifier:@"FeedDetailMapVC"];
    feedDetailMapVC.dataDict        = [feedList firstObject];
    feedDetailMapVC.feedDictionary  = [feedList firstObject];
    feedDetailMapVC.strBackTo       = @"UserWallViewController";
    [self.navigationController pushViewController:feedDetailMapVC animated:YES];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"hasvalue"];
}
-(void)loaduserLocation{
    locationManager=[APLocationManager new];
    [self.mainMapc setShowsUserLocation:YES];
    
    NSLog(@"thisisstart");
    
    
    [locationManager getCurrentLocationData:^(float latitude, float longitude, CLLocation *location) {
        [self.mainMapc removeAnnotations:@[pinTwo]];
        
        CLLocationCoordinate2D annotationCoord;
        annotationCoord.latitude = latitude;
        annotationCoord.longitude = longitude;
        pinTwo.coordinate = annotationCoord;
        
        selectedLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
        [SEAppDelegate appDelegate].fLat=selectedLocation.coordinate.latitude;
        [SEAppDelegate appDelegate].fLong=selectedLocation.coordinate.longitude;

        
        [self.mainMapc addAnnotation:pinTwo];
        [locationManager zoomToLocation:self.mainMapc latitude:latitude longitude:longitude];
        [self completeSearch:nil];
        [[NSUserDefaults standardUserDefaults] boolForKey: @"downloaded"];
    }];
}

-(void)currentuserlocation{
    locationManager=[APLocationManager new];
    
    [locationManager getCurrentLocationData:^(float latitude, float longitude, CLLocation *location) {
        
        CLLocationCoordinate2D annotationCoord;
        annotationCoord.latitude = latitude;
        annotationCoord.longitude = longitude;
        pinTwo.coordinate = annotationCoord;
        
        checkuserlocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
        useroriginallat=checkuserlocation.coordinate.latitude;
        useroriginallong=checkuserlocation.coordinate.longitude;
        
        NSLog(@"test1 %f",useroriginallat);
        NSLog(@"test2 %f",useroriginallong);
        
        NSString *currentlat = [NSString stringWithFormat:@"%f",useroriginallat];
        NSString *currentlong = [NSString stringWithFormat:@"%f",useroriginallong];
        
        userLatitude = [currentlat substringToIndex:5];
        userLongitude = [currentlong substringToIndex:7];
        
        NSLog(@"here2 %@",userLatitude);
        NSLog(@"here1 %@",userLongitude);
        
        NSString *markedfLat = [NSString stringWithFormat:@"%f",[SEAppDelegate appDelegate].fLat];
        NSString *markedfLong = [NSString stringWithFormat:@"%f",[SEAppDelegate appDelegate].fLong];
        
        NSString *formatedfLat = [markedfLat substringToIndex:5];
        NSString *formatedfLong = [markedfLong substringToIndex:7];
        
        if ([formatedfLat isEqualToString:userLatitude] && [formatedfLong isEqualToString:userLongitude]) {
            if ([SEAppDelegate appDelegate].balance == NO) {
                [self next];
            }else{
                if ([currentLanguage isEqualToString:@"sv"]) {
                    NSString *balancealert = [NSString stringWithFormat:@"Du kommer inte att tillåtas att boka en annan resa tills du har rensat ditt saldo: %@ KR. För mer information, vänligen kontakta support@rideapp.us.", due];
                    showAletViewWithMessage(balancealert);
                }else{
                NSString *balancealert = [NSString stringWithFormat:@"You won't be allowed to book another trip until you've cleared your balance: $%@. Please contact support@rideapp.us for more information on how to clear this.", due];
                showAletViewWithMessage(balancealert);
                }
            }
        }else{
            NSLog(@"not equal");
            [self confirmpickuplocation];
        }
    }];
}

-(void)loadMapview{
    [self loaduserLocation];
    MKCoordinateRegion region;
    self.mainMapc.delegate=self;
    
    CLLocationCoordinate2D location;
    location.latitude   = [SEAppDelegate appDelegate].fLat;
    location.longitude  = [SEAppDelegate appDelegate].fLong;
    
    region.center = location;
    region.center.latitude      = location.latitude;
    region.center.longitude     = location.longitude;
    region.span.longitudeDelta  = 0.03;
    region.span.latitudeDelta   = 0.03;
    [self.mainMapc setRegion:region animated:YES];

    [self.mainMapc setRegion:region animated:YES];
    [self.mainMapc regionThatFits:region];
    pinTwo.coordinate = location;
}

- (void)tapGestureHandler:(UITapGestureRecognizer *)tgr
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey: @"downloaded"];
    [self.mainMapc setShowsUserLocation:NO];
    [self.mainMapc removeAnnotations:@[pinTwo]];
    CGPoint touchPoint = [tgr locationInView:self.mainMapc];
    CLLocationCoordinate2D touchMapCoordinate = [self.mainMapc convertPoint:touchPoint toCoordinateFromView:self.mainMapc];
    selectedLocation = [[CLLocation alloc] initWithLatitude:touchMapCoordinate.latitude longitude:touchMapCoordinate.longitude];
    [SEAppDelegate appDelegate].fLat=selectedLocation.coordinate.latitude;
    [SEAppDelegate appDelegate].fLong=selectedLocation.coordinate.longitude;
    [pinTwo setCoordinate:touchMapCoordinate];
    [self.mainMapc   addAnnotation:pinTwo];
    [self completeSearch:nil];
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"pinned"];
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"searched"];
}

- (IBAction)addPinAction:(id)sender {
    
    [self.mainMapc setShowsUserLocation:NO];
    [locationManager getCurrentLocationData:^(float latitude, float longitude, CLLocation *location) {
        [self.mainMapc removeAnnotations:@[pinTwo]];
        
        CLLocationCoordinate2D annotationCoord;
        annotationCoord.latitude = latitude;
        annotationCoord.longitude = longitude;
        pinTwo.coordinate = annotationCoord;
        
        selectedLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
        [SEAppDelegate appDelegate].fLat=selectedLocation.coordinate.latitude;
        [SEAppDelegate appDelegate].fLong=selectedLocation.coordinate.longitude;
        [self.mainMapc addAnnotation:pinTwo];
        
    }];
}

- (IBAction)nxtBtn:(id)sender {
    if ([activeView isEqualToString:@"courier"]) {
        [frameforCapture startCanvasAnimation];
        [self startCameraSession];
        [frameforCapture setHidden:NO];
        [foodView setHidden:YES];
        [tinter setHidden:YES];
        [self checkingbalance];
    }else if ([activeView isEqualToString:@"food"]){
        [foodView setHidden:NO];
        [foodView startCanvasAnimation];
        [tinter setHidden:NO];
        [mainview bringSubviewToFront:tinter];
        [mainview bringSubviewToFront:foodView];
        
        taptoHideBtn = [[UIButton alloc] initWithFrame:mainview.bounds];
        taptoHideBtn.backgroundColor = [UIColor clearColor];
        [mainview insertSubview:taptoHideBtn belowSubview:foodView];
        [taptoHideBtn addTarget:self action:@selector(backtoRideView) forControlEvents:UIControlEventTouchUpInside];
        
        NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                                stringForKey:@"drivernotessaved"];
        if (!savedValue) {
            [fooddescriptionTextView selectAll:nil];
        }else{
            NSLog(@"Running..");
            fooddescriptionTextView.text = savedValue;
        }
        [fooddescriptionTextView becomeFirstResponder];
        [self checkingbalance];
    }else{
    [self checkingbalance];
    [self currentuserlocation];
    }
}
-(void)next{
    if ([SEAppDelegate appDelegate].fLat == 0) {
        if ([currentLanguage isEqualToString:@"sv"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Er position kunde ej hittas"
                                                            message:@"Har du tillåtit oss att använda er position?"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Your location cant be found"
                                                        message:@"Did you allow us to use your location?"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        }
    }
    
    NSLog(@"test1insidefirstone %f", [SEAppDelegate appDelegate].fLat);
    NSLog(@"test1insidefirstone %f", [SEAppDelegate appDelegate].fLong);
    NSLog(@"printing from address: %@", fromLocation.text);
    [SEAppDelegate appDelegate].fromaddresscache = sendthisaddress;
    NSLog(@"test completelat %f",completesearchLat);
    NSLog(@"test completelat %f",completesearchLong);
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"searched"] == YES) {
        [SEAppDelegate appDelegate].fLat = completesearchLat;
        [SEAppDelegate appDelegate].fLong = completesearchLong;
    }
    UserWallViewController *newevent = [self.storyboard instantiateViewControllerWithIdentifier:@"Neweventview"];
    [self.navigationController pushViewController:newevent animated:NO];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)fLatAddress{
    NSIndexPath *indexPath;
    double addressfLat = [[feedList[indexPath.row]objectForKey:@"fLat"]doubleValue];
    double addressfLong = [[feedList[indexPath.row]objectForKey:@"fLong"]doubleValue];
    [self loaduserLocation];

    CLLocation *location = [[CLLocation alloc]initWithLatitude:addressfLat
                                                     longitude:addressfLong];

    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks,NSError *error){
        
        
        CLPlacemark *placemark=[placemarks objectAtIndex:0];
        CLLocationCoordinate2D coordinate = location.coordinate;
        [SEAppDelegate appDelegate].fLat=coordinate.latitude;
        [SEAppDelegate appDelegate].fLong=coordinate.longitude;
        
        NSLog(@"From this address %@", placemarks);
        placemark = [placemarks lastObject];
        
        fromAddressLocation = [NSString stringWithFormat:@"%@ %@ %@", placemark.thoroughfare, placemark.postalCode, placemark.locality];
        
        NSLog(@"FromThisAddress %@", fromAddressLocation);
    }];
    
}

#pragma mark -Custom Annotaion Delegate Methods
-(void)setMapPin
{
    __block MKPointAnnotation *myAnnotation;
    
    [mapViewLocation removeAnnotations:mapViewLocation.annotations];
    [mapViewLocation removeAnnotations:anoArray];
    [anoArray removeAllObjects];
    
    [locationLatLongArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        
        float latitude=[obj[@"latitude"] floatValue];
        float longitude=[obj[@"longitude"] floatValue];
        
        myAnnotation = [[MKPointAnnotation alloc] init];
        myAnnotation.coordinate = CLLocationCoordinate2DMake(latitude,longitude);
        myAnnotation.title = obj[@"title"];
        myAnnotation.subtitle = obj[@"subtitle"] ;
        [mapViewLocation addAnnotation:myAnnotation];
        
        [anoArray addObject:myAnnotation];
        
        selectedLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
        
    }];
    
}
- (IBAction)invitefriends:(id)sender {
    if([MFMessageComposeViewController canSendText]) {
        if ([currentLanguage isEqualToString:@"sv"]) {
            MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
            controller.body = @"Jag älskar WayToGo. De erbjuder billigare resor än Taxi och det är mycket enklare att få tag i en :). Ladda ner via: https://rideapp.us/download/";
            controller.messageComposeDelegate = self;
            [self presentViewController:controller animated:YES completion:nil];
        }else{
        MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
        controller.body = @"I love WayToGo. They offer cheaper rides than Uber, Lyft or Sidecar! Try it out for yourself: http://waytogoapp.com/download/";
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        }
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result {
    switch(result) {
        case MessageComposeResultCancelled:
            // user canceled sms
            NSLog(@"canceled");
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case MessageComposeResultSent:
            NSLog(@"sent sms");
            [self dismissViewControllerAnimated:YES completion:nil];
            if ([currentLanguage isEqualToString:@"sv"]) {
                showAletViewWithMessage(@"Tack för att ni hjälper oss sprida WayToGo!");
            }else{
            showAletViewWithMessage(@"Thank you for sharing WayToGo!");
            }
            // user sent sms
            //perhaps put an alert here and dismiss the view on one of the alerts buttons
            break;
        case MessageComposeResultFailed:
            NSLog(@"failed");
            [self dismissViewControllerAnimated:YES completion:nil];
            // sms send failed
            //perhaps put an alert here and dismiss the view when the alert is canceled
            break;
        default:
            break;
    }
}

#pragma completeSearch
-(void)textFieldDidEndEditing{
    if (IS_IPHONE6_Plus) {
        fromaddressbar.frame=CGRectMake(10, 592, fromaddressbar.frame.size.width, fromaddressbar.frame.size.height);
    }else if (IS_IPHONE4){
        fromaddressbar.frame=CGRectMake(10, 356, fromaddressbar.frame.size.width, fromaddressbar.frame.size.height);
    }else if (IS_IPHONE6){
        fromaddressbar.frame=CGRectMake(10, 533, fromaddressbar.frame.size.width, fromaddressbar.frame.size.height);
    }else{
    fromaddressbar.frame=CGRectMake(10, 444, fromaddressbar.frame.size.width, fromaddressbar.frame.size.height);
    }
    [fromLocation resignFirstResponder];
    if ([fromLocation.text isEqualToString:@""]) {
    }else{
    [self completeSearch:fromLocation.text];
        [self checkingtext];
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"searched"];
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"pinned"];
    }
}
-(void)textFieldDidBeginEditing{
    fromaddressbar.frame=CGRectMake(10, 130, fromaddressbar.frame.size.width, fromaddressbar.frame.size.height);
}
-(void)getLat_LongitudeFromAddress:(NSString *)_address{
    
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder geocodeAddressString:_address completionHandler:^(NSArray *placemarks,NSError *error){
        
        if (error==nil) {
            
            CLPlacemark *placemark=[placemarks objectAtIndex:0];
            CLLocation *location = placemark.location;
            CLLocationCoordinate2D coordinate = location.coordinate;
            
            [SEAppDelegate appDelegate].fLat=coordinate.latitude;
            [SEAppDelegate appDelegate].fLong=coordinate.longitude;
            
        }
        
    }];
    
    
}
    
- (void)completeSearch:(NSString *)_address{
    [self.mainMapc setShowsUserLocation:YES];
    NSLog(@"printing address from completesearch %@", _address);
    
    
    
    
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    
    if(_address) {
        [geoCoder geocodeAddressString:_address completionHandler:^(NSArray *placemarks,NSError *error){
            
            if (error==nil) {
                
                
                CLPlacemark *placemark=[placemarks objectAtIndex:0];
                CLLocation *location = placemark.location;
                CLLocationCoordinate2D coordinate = location.coordinate;
                
                completesearchLat=coordinate.latitude;
                completesearchLong=coordinate.longitude;
                
                NSLog(@"ttttt %@", placemarks);
                placemark = [placemarks lastObject];
                
                fromLocation.text = [NSString stringWithFormat: @"%@ %@\n%@ %@\n%@",
                                      placemark.subThoroughfare, placemark.thoroughfare,
                                      placemark.postalCode, placemark.locality,
                                      placemark.administrativeArea];
                // that string may contain nil values, so remove them.
                
                sendthisaddress = [NSString stringWithFormat: @"%@ %@\n%@ %@\n%@",
                                   placemark.subThoroughfare, placemark.thoroughfare,
                                   placemark.postalCode, placemark.locality,
                                   placemark.administrativeArea];

                
                NSString *undesired = @"(null)";
                NSString *desired   = @"\n";
                
                currentCountry = placemark.ISOcountryCode;
                NSLog(@"currentCountry: %@",placemark.ISOcountryCode);
                
                fromLocation.text = [fromLocation.text stringByReplacingOccurrencesOfString:undesired
                                                                                   withString:desired];
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"done"];
                [self checkingtext];
            }
            
        }];
    }
    else{
        [geoCoder reverseGeocodeLocation:selectedLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            BOOL downloaded = [[NSUserDefaults standardUserDefaults] boolForKey: @"downloaded"];
            
            if (!downloaded) {
                
                
                CLPlacemark *placemark=[placemarks objectAtIndex:0];
                CLLocation *location = placemark.location;
                CLLocationCoordinate2D coordinate = location.coordinate;
                
                [SEAppDelegate appDelegate].fLat=coordinate.latitude;
                [SEAppDelegate appDelegate].fLong=coordinate.longitude;
                
                NSLog(@"ttttt %@", placemarks);
                placemark = [placemarks lastObject];
                
                fromLocation.text = [NSString stringWithFormat: @"%@ %@\n%@ %@\n%@",
                                     placemark.subThoroughfare, placemark.thoroughfare,
                                     placemark.postalCode, placemark.locality,
                                     placemark.administrativeArea];
                
                sendthisaddress = [NSString stringWithFormat: @"%@ %@\n%@ %@\n%@",
                                   placemark.subThoroughfare, placemark.thoroughfare,
                                   placemark.postalCode, placemark.locality,
                                   placemark.administrativeArea];
                
                currentCountry = placemark.ISOcountryCode;
                NSLog(@"currentCountry: %@",placemark.ISOcountryCode);
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey: @"downloaded"];
            }
            
        }];
    }
}

- (IBAction)getMyLocationNow:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"downloaded"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"searched"];
    [self.mainMapc setShowsUserLocation:YES];
    [self loadMapview];
}

-(void)checkingtext{
    MKCoordinateRegion region;
    self.mainMapc.delegate=self;
    [self showHud];
    BOOL done = [[NSUserDefaults standardUserDefaults] boolForKey:@"done"];
    if (done == YES){
        CLLocationCoordinate2D location;
        location.latitude   = completesearchLat;
        location.longitude  = completesearchLong;
        NSLog(@"logging completelat %f",completesearchLong);
        NSLog(@"logging completelong %f",completesearchLat);
        region.center = location;
        region.center.latitude      = location.latitude;
        region.center.longitude     = location.longitude;
        region.span.longitudeDelta  = 0.03;
        region.span.latitudeDelta   = 0.03;
        [self.mainMapc setRegion:region animated:YES];
        
        [self.mainMapc setRegion:region animated:YES];
        [self.mainMapc regionThatFits:region];
        pinTwo.coordinate = location;
        
        locationManager=[APLocationManager new];
        
        [self.mainMapc removeAnnotations:@[pinTwo]];
        
        CLLocationCoordinate2D annotationCoord;
        annotationCoord.latitude = completesearchLat;
        annotationCoord.longitude = completesearchLong;
        pinTwo.coordinate = annotationCoord;
        
        completedLocation = [[CLLocation alloc] initWithLatitude:completesearchLat longitude:completesearchLong];
        completesearchLat=completedLocation.coordinate.latitude;
        completesearchLong=completedLocation.coordinate.longitude;
        
        [self.mainMapc addAnnotation:pinTwo];
        [locationManager zoomToLocation:self.mainMapc latitude:completesearchLat longitude:completesearchLong];
        
        [self.mainMapc setShowsUserLocation:NO];
        [self hideHud];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"done"];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"move"])
    {
        FeedDetailMapViewController *vc=(FeedDetailMapViewController *)segue.destinationViewController;
        vc.dataDict=feedList[selectedTagValue];
        vc.feedDictionary = feedList[selectedTagValue];
    }
    else if([[segue identifier] isEqualToString:@"UserWallNextBtn"])
    {
        NewEventViewController *vc=(NewEventViewController *)segue.destinationViewController;

        if([[feedList firstObject] isKindOfClass:[NSDictionary class]]){
            vc.token = userInformation[@"vToken"];
            
        }
        else{
            vc.token = @"";
        }
    }else if ([[segue identifier]isEqualToString:@"courierPush"]){
        NewEventViewController *newEvent = segue.destinationViewController;
        newEvent.token = userInformation[@"vToken"];
        newEvent.weightofItem = weightTextField.text;
        newEvent.courierImage = imageOutput.image;
        newEvent.courierSelected = @"true";
    }else if([[segue identifier] isEqualToString:@"OpeningPage"])
            {
                SEDriverPopup *home=(SEDriverPopup *)segue.destinationViewController;
                home.pickupInfoDetails=pickupInfo;
                home.feedInfoDict=feedList[selectedTagValue];
                
                // call the following function when the sound is no longer used
                // (must be done AFTER the sound is done playing)
            }
            else if([[segue identifier] isEqualToString:@"pushingtoaccept"]) {
                SEDriverPickup *vc=(SEDriverPickup *)segue.destinationViewController;
                vc.dataDict = feedList[selectedTagValue];
                [myTimer invalidate]; // invalidate timers
                myTimer = nil;
                [searchforrides invalidate];
                searchforrides = nil;
                [WebServiceCalls onlineoroffline:__CURRENT_USER :@"offline" block:^(id JSON, WebServiceResult result) {
                    NSLog(@"Done");
                }];
            }
            else if([[segue identifier] isEqualToString:@"pushingtopickedup"]) {
                SEDriverOnRoute *vc=(SEDriverOnRoute *)segue.destinationViewController;
                vc.dataDict = feedList[selectedTagValue];
                [myTimer invalidate]; // invalidate timers
                myTimer = nil;
                [searchforrides invalidate];
                searchforrides = nil;
                [WebServiceCalls onlineoroffline:__CURRENT_USER :@"offline" block:^(id JSON, WebServiceResult result) {
                    NSLog(@"Done");
                }];
            }
    
    
}

-(void)checkDriverFeed{
    [WebServiceCalls checkDriverFeedListCompBlock:^(id JSON, WebServiceResult result) {
        if(result == WebServiceResultSuccess)
        {
            feedList=[JSON[@"data"] mutableCopy];
            [locationLatLongArray removeAllObjects];
            [feedList enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                NSDictionary *param =@{
                                       @"latitude":obj[@"fLat"],
                                       @"longitude":obj[@"fLong"],
                                       @"title":obj[@"vFeedTitle"],
                                       @"subtitle":obj[@"tFeedDescription"],
                                       @"cost":obj[@"vCost"],
                                       @"time":obj[@"vStartDate"]
                                       };
                
                [locationLatLongArray addObject:param];
            }];
            
            profileImageArr = [[NSMutableArray alloc] init];
            feedImageArr = [[NSMutableArray alloc]init];
            
            for (int i = 0; i < [feedList count]; i++) {
                [profileImageArr addObject:@""];
                [feedImageArr addObject:@""];
            }
            
            
            self.imgDownloader=[[JPLazyImageDownloader alloc]init];
            self.imgDownloaderSecond=[[JPLazyImageDownloader alloc]init];
        }
    }];
}


-(void)driverisoffline{
    [myTimer invalidate]; // invalidate timers
    myTimer = nil;
    [searchforrides invalidate];
    searchforrides = nil;
}


-(void)loadusercurrentLocation
{
    [self.mainMapc removeAnnotation:pinAnnotation];
    
    
    apLoc=[APLocationManager new];
    
    [apLoc getCurrentLocationData:^(float latitude, float longitude, CLLocation *location) {
        
        CLLocationCoordinate2D annotationCoord;
        
        annotationCoord.latitude = latitude;
        
        annotationCoord.longitude = longitude;
        
        driverLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
        
        AddressLatitude=selectedLocation.coordinate.latitude;
        
        AddressLongitude=selectedLocation.coordinate.longitude;
        
        [WebServiceCalls driverCurrentLocation:AddressLatitude longitude:AddressLongitude block:^(id JSON, WebServiceResult result)
         {
             
         }];
        
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(annotationCoord, 500, 500);
        MKCoordinateRegion adjustedRegion = [self.mainMapc regionThatFits:viewRegion];
        [self.mainMapc setRegion:adjustedRegion animated:YES];
        self.mainMapc.showsUserLocation = YES;
    }];
    
    
    [self getLatestInfo];
    
}

-(void)getLatestInfo
{
    NSLog(@"printing feedList: %@",feedList);
    
    NSIndexPath *indexPath;
    
    
    if (!feedList || !feedList.count){
        NSLog(@"its nil");
    }else{
        
        NSString *acceptedroute = feedList[indexPath.row][@"vUserView"];
        
        if ([acceptedroute isEqual: @"friends"]) {
            [self performSegueWithIdentifier:@"pushingtoaccept" sender:self];
        }
        if ([acceptedroute isEqual: @"pickedup"]) {
            [self performSegueWithIdentifier:@"pushingtopickedup" sender:self];
        }
        
        NSString *feedId = feedList[indexPath.row][@"iFeedID"];
        currentFeed = feedId;
        NSLog(@"printing feedID %@", feedId);
        [WebServiceCalls getNearestDriver:feedId block:^(id JSON, WebServiceResult result) {
            NSLog(@"JSON IS %@", JSON);
            if (result == WebServiceResultSuccess) {
                
                if ([JSON[@"message"]isEqualToString:@"No current route"]) {
                    NSLog(@"no current route, quitting here");
                }else{
                    
                    NSString *nearestdriverID = [JSON[@"message"]mutableCopy];
                    
                    if ([nearestdriverID isEqualToString:__CURRENT_USER]) {
                        NSLog(@"Youre the closest driver.");
                        [WebServiceCalls getLatestInfoblock:^(id JSON, WebServiceResult result)
                         {
                             if(result == WebServiceResultSuccess)
                             {
                                 pickupInfo=[[NSMutableDictionary alloc]init];
                                 pickupInfo=[JSON[@"data"] mutableCopy];
                                 
                                 NSString *replyMessage=[JSON[@"message"] mutableCopy];
                                 if([replyMessage isEqualToString:@"Nearest Driver Info"])
                                 {
                                     double distance = [[pickupInfo objectForKey:@"distance"]doubleValue];
                                     NSString *statusID = [pickupInfo objectForKey:@"ID"];
                                     NSString *iFeedID=[pickupInfo objectForKey:@"iFeedID"];
                                     if (distance>15) {
                                         NSLog(@"Driver seems to be far away..");
                                         [WebServiceCalls acceptNotify:statusID status:@"rejected" feedID:iFeedID block:^(id JSON, WebServiceResult result)
                                          {
                                              if(result == WebServiceResultSuccess)
                                              {
                                                  NSLog(@"Success");
                                              }
                                          }];
                                         
                                     }else{
                                     if (playSound==YES) {
                                         
                                     NSString *path  = [[NSBundle mainBundle] pathForResource:@"newrequest" ofType:@"mp3"];
                                     NSURL *pathURL = [NSURL fileURLWithPath : path];
                                     SystemSoundID audioEffect;
                                        
                                     AudioServicesCreateSystemSoundID((__bridge CFURLRef) pathURL, &audioEffect);
                                     AudioServicesPlaySystemSound(audioEffect);
                                         playSound=NO;
                                         }
                                     onroute = YES;
                                     [self performSegueWithIdentifier:@"OpeningPage" sender:self];
                                     }
                                 }
                             }
                         }];
                    }
                }
            }
        }];
        
    }
}

#pragma mark Loading User View

-(void)UserviewStart
{
    [self addLoading:self];
    if ([currentLanguage isEqualToString:@"sv"]) {
        [self LoadingText:@"Byter till användarläge.."];
    }else{
    [self LoadingText:@"Changing to user mode.."];
    }
    preloadNStimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(UserviewTimeChange) userInfo:nil repeats:YES];
    progressHUD.userInteractionEnabled=NO;
}
-(void)UserviewTimeChange
{
    preload--;
    if(preload==-1)
    {
        changeableride.hidden=NO; // here loading User view
        changeablesliderreference.enabled=YES;
        fromaddressbar.hidden=NO;
        self.coverbtn.hidden=NO;
        self.btnresize.hidden=NO;
        [self.mainMapc addGestureRecognizer:lpgtr];
        steeringwheelimage.enabled=YES;
        [self removeLoading];
        hideForDriverMode.hidden=NO;
        [hideForDriverMode startCanvasAnimation];
        [self ClearPreload];
    }
    else
    {
        NSLog(@"Current: %ld",(long)preload);
    }
    
}


#pragma mark Loading Drivers View

-(void)PreloadStart
{
    [self addLoading:self];
    progressHUD.userInteractionEnabled=NO;
    if ([currentLanguage isEqualToString:@"sv"]) {
        [self LoadingText:@"Byter till förarläge"];
    }else{
    [self LoadingText:@"Changing to driver mode.."];
    }
    [WebServiceCalls onlineoroffline:__CURRENT_USER :@"online" block:^(id JSON, WebServiceResult result) {
        if(result==WebServiceResultSuccess){
            preloadNStimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(PreloadTimeChange) userInfo:nil repeats:YES];
        }else{
            showAletViewWithMessage(@"Check your internet connection and try again..");
        }
    }];

}
-(void)PreloadTimeChange
{
    preload--;
    if(preload==-1)
    {
        changeableride.hidden=YES; // Here loading drivers view
        changeablesliderreference.enabled=NO;
        hideForDriverMode.hidden=YES;
        fromaddressbar.hidden=YES;
        self.coverbtn.hidden=YES;
        self.btnresize.hidden=YES;
        [self.mainMapc removeGestureRecognizer:lpgtr];
        [self.mainMapc removeAnnotation:pinAnnotation];
        steeringwheelimage.enabled=YES;
        playSound=YES;
        myTimer=[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(loadusercurrentLocation) userInfo:nil repeats:YES];
        searchforrides=[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(checkDriverFeed) userInfo:nil repeats:YES];
        [self removeLoading];
        [self ClearPreload];
    }
    else
    {
        NSLog(@"Current: %ld",(long)preload);
    }
    
}
-(void)ClearPreload
{
    [preloadNStimer invalidate];
    preloadNStimer =   nil;
    progressHUD.userInteractionEnabled=YES;
    preload=2;
}


#pragma mark Loading

- (void)addLoading:(UIViewController *)controller
{
    progressHUD = [[MBProgressHUD alloc] init];
    progressHUD = [[MBProgressHUD alloc] initWithView:controller.view];
    progressHUD.userInteractionEnabled=NO;
    mainview.userInteractionEnabled=NO;
    [controller.view addSubview:progressHUD];
    [progressHUD show:YES];
}
-(void)addLoadingview:(UIView *)controller
{
    progressHUD = [[MBProgressHUD alloc] init];
    progressHUD = [[MBProgressHUD alloc] initWithView:controller];
    progressHUD.userInteractionEnabled=NO;
    mainview.userInteractionEnabled=NO;
    [controller addSubview:progressHUD];
    [progressHUD show:YES];
}

- (void)LoadingText:(NSString *)string
{
    progressHUD.labelText=string;
    progressHUD.labelFont=[UIFont fontWithName:@"Helvatica" size:12];
}
-(void)removeLoading
{
    [progressHUD hide:YES];
    mainview.userInteractionEnabled=YES;
    [progressHUD removeFromSuperview];
}
-(void)Addloading
{
    progressHUD = [[MBProgressHUD alloc] init];
    progressHUD.userInteractionEnabled=NO;
    [progressHUD show:YES];
}
-(void)userinteraction:(BOOL)value
{
    progressHUD.userInteractionEnabled=value;
}


@end
