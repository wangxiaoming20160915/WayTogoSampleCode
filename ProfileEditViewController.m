//
//  TLProfileEditViewController.m
//  
//
//  Created by Wang Xiaoming on 25/02/14.
//  Copyright (c) 2014 Wang Xiaoming. All rights reserved.
//

#import "ProfileEditViewController.h"
#import "WebServiceCalls.h"
#import "Config.h"


@interface ProfileEditViewController (){
    
    IBOutlet UITextField *txtFirstName;
    IBOutlet UITextField *txtLastName;
    IBOutlet UITextField *phonenumber;
    IBOutlet UILabel *currentearnings;
    
    __weak IBOutlet UIButton *_btnProfile;
    __weak IBOutlet UILabel *lblEdit;
    __weak IBOutlet UIButton *editBtn;
    __weak IBOutlet UIButton *payoutBtnReference;
    
    IBOutlet UIView *directdepositUIView;
    IBOutlet UITextField *paypalemailtextfield;
    
    IBOutlet UILabel *setuppaypalpayouttext;
    IBOutlet UILabel            *fareLbl;
    IBOutlet UILabel            *etaLbl;
    IBOutlet UILabel            *driverLbl;
    IBOutlet UILabel            *paymentLbl;
    IBOutlet UILabel            *tripLbl;
    IBOutlet UIView *topview;
    IBOutlet UIButton *savePaypalBtnRef;
    
    IBOutlet UIButton           *splitFarebtn;
    IBOutlet UIButton           *sharemyETAbtn;
    IBOutlet UIButton           *contactDriverbtn;
    IBOutlet UIButton           *changePaymentbtn;
    
    IBOutlet UILabel *setupdirectdepositlabel;
    IBOutlet UIButton *menuBtn;
    IBOutlet UIImageView        *fareImg;
    IBOutlet UIImageView        *etaImg;
    IBOutlet UIImageView        *driverImg;
    IBOutlet UIImageView        *paymentImg;
    IBOutlet UIButton *bringupPaypalViewRef;
    IBOutlet UIButton *bringupDirectDepositView;
    
    IBOutlet UIPickerView *picker;
    IBOutlet UIView *menuView;
    
    BOOL isAnimation;
    NSTimer *showline;
    IBOutlet UITextField *routingnrtextfield;

    IBOutlet UITextField *accountnrtextfield;
    IBOutlet UIView *paypalview;
    
    NSArray *_pickerData;
    NSString *selectedBank;
    __weak IBOutlet UILabel *referralcode;
}
@end

@implementation ProfileEditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([userInformation[@"vDriverorNot"]isEqualToString:@"driver"]) {
        [menuBtn setEnabled:YES];
        [menuBtn setHidden:NO];
        [referralcode setHidden:NO];
        NSString *formatReferralcode = [NSString stringWithFormat:@"Refferal code: %@%@",userInformation[@"vFirst"],userInformation[@"iUserID"]];
        referralcode.text = formatReferralcode;
    }else if([userInformation[@"vDriverorNot"]isEqualToString:@"pending"]){
        [menuBtn setEnabled:YES];
        [menuBtn setHidden:NO];
    }else if([userInformation[@"vDriverorNot"]isEqualToString:@"carpicture"]){
        [menuBtn setEnabled:YES];
        [menuBtn setHidden:NO];
    }else if([userInformation[@"vDriverorNot"]isEqualToString:@"registration"]){
        [menuBtn setEnabled:YES];
        [menuBtn setHidden:NO];
    }else if([userInformation[@"vDriverorNot"]isEqualToString:@"picture"]){
        [menuBtn setEnabled:YES];
        [menuBtn setHidden:NO];
    }else if([userInformation[@"vDriverorNot"]isEqualToString:@"progress"]){
        [menuBtn setEnabled:YES];
        [menuBtn setHidden:NO];
    }else if([userInformation[@"vDriverorNot"]isEqualToString:@"insurance"]){
        [menuBtn setEnabled:YES];
        [menuBtn setHidden:NO];
    }
    
    if ([[[NSUserDefaults standardUserDefaults]
         stringForKey:@"Depositdetails"] isEqualToString:@"DDSaved"]) {
        if ([currentLanguage isEqualToString:@"sv"]) {
            setupdirectdepositlabel.text=@"ÄNDRA BANK INFORMATION";
        }else{
        setupdirectdepositlabel.text=@"UPDATE DIRECT DEPOSIT";
        }
    }
    if ([[[NSUserDefaults standardUserDefaults]
                    stringForKey:@"Paypaldetails"] isEqualToString:@"PPSaved"]) {
        if ([currentLanguage isEqualToString:@"sv"]) {
            setuppaypalpayouttext.text=@"ÄNDRA SWISH INFORMATION";
        }else{
            setuppaypalpayouttext.text=@"UPDATE PAYPAL PAYOUT";
        }
    }
    
    driverImg.frame=CGRectMake(setuppaypalpayouttext.frame.size.width-20, setuppaypalpayouttext.frame.origin.y+20, driverImg.frame.size.width, driverImg.frame.size.height);

    paymentImg.frame=CGRectMake(setupdirectdepositlabel.frame.size.width-20, setupdirectdepositlabel.frame.origin.y+20, paymentImg.frame.size.width, paymentImg.frame.size.height);

    
    
    if ([currentLanguage isEqualToString:@"sv"]) {
        _pickerData = @[@"Välj er bank",@"Swedbank", @"Handelsbanken", @"SEB", @"Nordea",@"ICA Banken"];
    }else{
        _pickerData = @[@"Select your Bank",@"Bank of America", @"Wells Fargo", @"Citibank", @"Chase Bank",@"Bank of the West"];
    }
    picker.dataSource = self;
    picker.delegate = self;
    
    if ([userInformation[@"vDriverorNot"]isEqualToString:@"driver"]) {
        editBtn.hidden=YES;
        editBtn.enabled=NO;
    }else if ([userInformation[@"vDriverorNot"]isEqualToString:@"driver"]){
        editBtn.hidden=YES;
        editBtn.enabled=NO;
    }
    
    lblEdit.hidden=YES;
    txtFirstName.text=userInformation[@"vFirst"];
    txtLastName.text=userInformation[@"vLast"];
    phonenumber.text=userInformation[@"userPhone"];
    downloadImageFromUrl(userInformation[@"profileImage"][@"original"], self.imgProfile);
    imgVProfile.image=profileImage;
    imgVProfile=imageWithRoundedCornersSize(imgVProfile.frame.size.height/2, imgVProfile);
    
    
    [APPhotoLibrary sharedInstance].delegate=self;
	
    
    // Do any additional setup after loading the view.
    
    imgVProfile.frame = CGRectMake((self.view.frame.size.width/2) - (imgVProfile.frame.size.width/2),imgVProfile.frame.origin.y,
                                    imgVProfile.frame.size.width,
                                    imgVProfile.frame.size.height);
    
    //Menu Starts
    
    
    menuView.hidden=YES;
    alphaView.hidden=YES;
    
    isAnimation =NO;

//        [menuView setFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame), 320, 505)];

    // Menu Ends
    
    
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(completepaypalemail)],
                           nil];
    [numberToolbar sizeToFit];
    paypalemailtextfield.inputAccessoryView = numberToolbar;
    
    UIToolbar* bankaccounttoolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    bankaccounttoolbar.barStyle = UIBarStyleDefault;
    bankaccounttoolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(completebankdetails)],
                           nil];
    [bankaccounttoolbar sizeToFit];
    accountnrtextfield.inputAccessoryView = bankaccounttoolbar;
    
    selectedBank = @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)completebankdetails{
    
    if (accountnrtextfield.text.length==0) {
        showAletViewWithMessage(@"Account number can't be empty");
        [accountnrtextfield becomeFirstResponder];
    }else if (routingnrtextfield.text.length==0) {
        showAletViewWithMessage(@"Routing number can't be empty");
        [routingnrtextfield becomeFirstResponder];
    }else{
        [routingnrtextfield resignFirstResponder];
        [accountnrtextfield resignFirstResponder];
    }
}

-(void)completepaypalemail{
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    if ([currentLanguage isEqualToString:@"sv"]) {
        [self addLoading:self];
        [self LoadingText:@"Laddar upp Swish information.."];
        
        [WebServiceCalls updatePaypalEmailAddress:paypalemailtextfield.text driver:__CURRENT_USER block:^(id JSON, WebServiceResult result) {
            if ([JSON[@"status"] isEqualToString:@"0"]) {
                NSLog(@"");
                [self removeLoading];
                [paypalemailtextfield resignFirstResponder];
                [self closePayoutSettings:self];
                showAletViewWithMessage(@"Nästa utbetalning kommer att ske via Swish.");
                paypalemailtextfield.text=@"";
                setuppaypalpayouttext.text=@"ÄNDRA SWISH INFORMATION";
                [[NSUserDefaults standardUserDefaults] setObject:@"PPSaved" forKey:@"Paypaldetails"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else{
                [self removeLoading];
                showAletViewWithMessage(@"Something went wrong..");
            }
        }];
    }else{
    if ([emailTest evaluateWithObject:paypalemailtextfield.text] == NO) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid E-mail Address!" message:@"Please Enter Valid Email Address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        return;
    }else{
        [self addLoading:self];
        [self LoadingText:@"Updating your PayPal address.."];
        
    [WebServiceCalls updatePaypalEmailAddress:paypalemailtextfield.text driver:__CURRENT_USER block:^(id JSON, WebServiceResult result) {
        if ([JSON[@"status"] isEqualToString:@"0"]) {
            NSLog(@"");
            [self removeLoading];
            [paypalemailtextfield resignFirstResponder];
            [self closePayoutSettings:self];
            showAletViewWithMessage(@"Thank you for successfully submitting your payout details.");
            paypalemailtextfield.text=@"";
            setuppaypalpayouttext.text=@"UPDATE PAYPAL PAYOUT";
            [[NSUserDefaults standardUserDefaults] setObject:@"PPSaved" forKey:@"Paypaldetails"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else{
            [self removeLoading];
            showAletViewWithMessage(@"Something went wrong..");
        }
    }];
    }
    }
}

- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerData[row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    selectedBank = _pickerData[row];
    NSLog(@"Bank: %@",selectedBank);
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 44)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
    label.text = [NSString stringWithFormat:@" %@", _pickerData[row]];
    
    return label;
}

- (IBAction)paypalViewBtn:(id)sender {
    
    NSLog(@"bringing up paypal view");
    [paypalview setHidden:NO];
    bringupDirectDepositView.enabled=NO;
    bringupPaypalViewRef.enabled=NO;
    [UIView animateWithDuration:1.0 animations:^{
        
        
        paypalview.frame=CGRectMake(0, (currentearnings.frame.origin.y+currentearnings.frame.size.height)+20, paypalview.frame.size.width, paypalview.frame.size.height);
        
    }];
    [self.view bringSubviewToFront:paypalview];
}
- (IBAction)saveDirectDepositInfo:(id)sender {
    
    if ([selectedBank isEqualToString:@""]) {
        if ([currentLanguage isEqualToString:@"sv"]) {
        showAletViewWithMessage(@"Glöm inte att välja vilken bank ni har");
        }else{
        showAletViewWithMessage(@"Please don't forget to select your bank");
        }
    }else{
    
    [self addLoading:self];
        if ([currentLanguage isEqualToString:@"sv"]) {
    [self LoadingText:@"Laddar upp information.."];
        }else{
    [self LoadingText:@"Updating bank details.."];
        }
    [WebServiceCalls updateBankInformation:selectedBank routing:routingnrtextfield.text account:accountnrtextfield.text block:^(id JSON, WebServiceResult result) {
        if ([JSON[@"status"] isEqualToString:@"0"]) {
            [self removeLoading];
            [self closePayoutSettings:self];
            if ([currentLanguage isEqualToString:@"sv"]) {
                setupdirectdepositlabel.text=@"ÄNDRA BANK INFORMATION";
            }else{
            setupdirectdepositlabel.text=@"UPDATE DIRECT DEPOSIT";
            }
            routingnrtextfield.text=@"";
            accountnrtextfield.text=@"";
            if ([currentLanguage isEqualToString:@"sv"]) {
                showAletViewWithMessage(@"Tack! Nästa utbetalning kommer att synas på ert konto.");
            }else{
            showAletViewWithMessage(@"Thank you for successfully submitting your bank account details.");
            }
            [[NSUserDefaults standardUserDefaults] setObject:@"DDSaved" forKey:@"Depositdetails"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else{
            showAletViewWithMessage(@"Something went wrong..");
            [self removeLoading];
        }
    }];
    }
    
}
- (IBAction)savePaypalinfo:(id)sender {
    [self closePayoutSettings:self];
}
- (IBAction)directDepositView:(id)sender {
    NSLog(@"Bringing up direct deposit view");
    [directdepositUIView setHidden:NO];
    bringupPaypalViewRef.enabled=NO;
    bringupDirectDepositView.enabled=NO;
    [UIView animateWithDuration:1.0 animations:^{
        
            directdepositUIView.frame=CGRectMake(0, (currentearnings.frame.origin.y+currentearnings.frame.size.height)+20, directdepositUIView.frame.size.width, directdepositUIView.frame.size.height);
    }];
    [self.view bringSubviewToFront:directdepositUIView];
    picker.hidden=NO;
    
    
}

- (IBAction)payoutSettingsBtn:(id)sender {
    [WebServiceCalls getDriverCurrentEarnings:__CURRENT_USER block:^(id JSON, WebServiceResult result) {
        if ([JSON[@"status"]isEqualToString:@"0"]) {
            
            if ([currentLanguage isEqualToString:@"sv"]) {
                NSLog(@"Current earnings: %@",JSON[@"data"]);
                double formatingearnings = [JSON[@"data"] doubleValue];
                NSString *earnings = [NSString stringWithFormat:@"%.02f KR", formatingearnings];
                currentearnings.text=earnings;
            }else{
            NSLog(@"Current earnings: %@",JSON[@"data"]);
            double formatingearnings = [JSON[@"data"] doubleValue];
            NSString *earnings = [NSString stringWithFormat:@"$%.02f", formatingearnings];
            currentearnings.text=earnings;
            }
        }else{
            if ([currentLanguage isEqualToString:@"sv"]) {
                currentearnings.text=@"0.00 KR";
            }
                currentearnings.text=@"$0.00";
        }
        
    }];
    
        [menuView setHidden:NO];
        [alphaView setHidden:NO];
    
    
        [UIView animateWithDuration:1.0 animations:^{
            
            alphaView.backgroundColor = [UIColor colorWithRed:0 green:0.109 blue:0.167 alpha:0.5];
            
                menuView.frame=CGRectMake(0, topview.frame.size.height, menuView.frame.size.width, menuView.frame.size.height);
        }];
        [self.view bringSubviewToFront:menuView];
}
-(void)removeErrorView{
    
    if (IS_IPHONE6) {
        [UIView animateWithDuration:1.0 animations:^{menuView.frame=CGRectMake(0, 750, menuView.frame.size.width, menuView.frame.size.height);} completion:^(BOOL finished){}];
    }else if (IS_IPHONE6_Plus){
        [UIView animateWithDuration:1.0 animations:^{menuView.frame=CGRectMake(0, 750, menuView.frame.size.width, menuView.frame.size.height);} completion:^(BOOL finished){}];
    }
    else{
        [UIView animateWithDuration:1.0 animations:^{menuView.frame=CGRectMake(0, 850, menuView.frame.size.width, menuView.frame.size.height);} completion:^(BOOL finished){}];
    }
    alphaView.backgroundColor = [UIColor clearColor];
    [alphaView setAlpha:0.0];
    
    
}

-(void)removeDirectDepositView{
    if (IS_IPHONE6) {
        [UIView animateWithDuration:1.0 animations:^{directdepositUIView.frame=CGRectMake(0, 750, directdepositUIView.frame.size.width, directdepositUIView.frame.size.height);} completion:^(BOOL finished){}];
    }else if (IS_IPHONE6_Plus){
        [UIView animateWithDuration:1.0 animations:^{directdepositUIView.frame=CGRectMake(0, 750, directdepositUIView.frame.size.width, directdepositUIView.frame.size.height);} completion:^(BOOL finished){}];
    }
    else{
        [UIView animateWithDuration:1.0 animations:^{directdepositUIView.frame=CGRectMake(0, 850, directdepositUIView.frame.size.width, directdepositUIView.frame.size.height);} completion:^(BOOL finished){}];
    }
    picker.hidden=YES;
}

-(void)removePaypalView{
    if (IS_IPHONE6) {
        [UIView animateWithDuration:1.0 animations:^{paypalview.frame=CGRectMake(0, 750, paypalview.frame.size.width, paypalview.frame.size.height);} completion:^(BOOL finished){}];
    }else if (IS_IPHONE6_Plus){
        [UIView animateWithDuration:1.0 animations:^{paypalview.frame=CGRectMake(0, 750, paypalview.frame.size.width, paypalview.frame.size.height);} completion:^(BOOL finished){}];
    }
    else{
        [UIView animateWithDuration:1.0 animations:^{paypalview.frame=CGRectMake(0, 850, paypalview.frame.size.width, paypalview.frame.size.height);} completion:^(BOOL finished){}];
    }
}

- (IBAction)closePayoutSettings:(id)sender {
    NSLog(@"Close Works!");
    [self removeErrorView];
    [self removeDirectDepositView];
    [self removePaypalView];
    bringupDirectDepositView.enabled=YES;
    bringupPaypalViewRef.enabled=YES;
}

#pragma mark -Photo Delegate Method

-(void)apActionSheetGetImage:(UIImage *)selectedPhoto{
    CGRect rect = CGRectMake(0,0,150,150);
    UIGraphicsBeginImageContext( rect.size );
    [selectedPhoto drawInRect:rect];
    UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImagePNGRepresentation(picture1);
    UIImage *img=[UIImage imageWithData:imageData];
    [imgVProfile setImage:img];
}
-(void)apActionSheetGetVideo:(NSURL *)selectedVideo
{}
-(void)apActionSheetGetVideoThumbImage:(UIImage *)selectedVideoThumbImage
{}

#pragma mark -Support Method

-(BOOL)checkUserInput
{
    if(![NSStringWithoutSpace(txtFirstName.text) length])
    {
        showAletViewWithMessage(@"FirstName should not be blank.");
        return NO;
    }
    else if(![NSStringWithoutSpace(txtLastName.text) length])
    {
        showAletViewWithMessage(@"LastName should not be blank.");
        return NO;
    }else if(![NSStringWithoutSpace(phonenumber.text) length])
    {
        showAletViewWithMessage(@"Phonenumber should not be blank.");
        return NO;
    }
    return YES;
}

#pragma mark -Button Action

- (IBAction)sendImageAction:(id)sender
{
    [self.view endEditing:YES];
    [[APPhotoLibrary sharedInstance]openPhotoFromCameraAndLibrary:self];
}
- (IBAction)doneButtonAction:(id)sender {
    UIButton *btn=(UIButton *)sender;
    if(!btn.selected)
    {
        btn.selected=YES;
        
        _btnProfile.enabled=YES;
        lblEdit.hidden=NO;
        [txtFirstName becomeFirstResponder];
    }
    else{
         btn.selected=NO;
        
        txtFirstName.enabled=NO;
        txtLastName.enabled=NO;
        phonenumber.enabled=NO;
        _btnProfile.enabled=NO;
        lblEdit.hidden=YES;
        if(![self checkUserInput])
            return;
        [self showHud];
        NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
        
        param[@"vFirst"]= txtFirstName.text;
        param[@"vLast"] = txtLastName.text;
        
        [param setObject:__CURRENT_USER forKey:@"iUserID"];
        
        [WebServiceCalls editUserInformation:param Image:imgVProfile.image imageTagName:@"vImage" block:^(id JSON, WebServiceResult result) {
            [self hideHud];
            if(result==WebServiceResultSuccess){
                userInformation =JSON[@"data"];
                profileImage=imgVProfile.image;
                [DefaultCenter postNotificationName:NMNotificationUserDataChange object:nil ];
                
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }   
}

#pragma mark -Button Action

- (IBAction)changePaswwordButtonAction:(id)sender {
 
        [self performSegueWithIdentifier:@"changePasswordSegue" sender:self];
 
}

#pragma mark Loading

- (void)addLoading:(UIViewController *)controller
{
    progressHUD = [[MBProgressHUD alloc] init];
    progressHUD = [[MBProgressHUD alloc] initWithView:controller.view];
    progressHUD.userInteractionEnabled=NO;
    [controller.view addSubview:progressHUD];
    progressHUD.dimBackground = YES;
    [progressHUD show:YES];
}
-(void)addLoadingview:(UIView *)controller
{
    progressHUD = [[MBProgressHUD alloc] init];
    progressHUD = [[MBProgressHUD alloc] initWithView:controller];
    progressHUD.userInteractionEnabled=NO;
    [controller addSubview:progressHUD];
    progressHUD.dimBackground = YES;
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
    [progressHUD removeFromSuperview];
}
-(void)Addloading
{
    progressHUD = [[MBProgressHUD alloc] init];
    progressHUD.userInteractionEnabled=NO;
    progressHUD.dimBackground = YES;
    [progressHUD show:YES];
}
-(void)userinteraction:(BOOL)value
{
    progressHUD.userInteractionEnabled=value;
}




@end
