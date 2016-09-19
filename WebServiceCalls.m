//
//  WebServiceCalls.m
//  Ponder_remake
//
//  Created by Wang Xiaoming on 04/07/13.
//  Copyright (c) 2013 Wang Xiaoming. All rights reserved.
//

#import "WebServiceCalls.h"
#import "AFNetworking.h"
#import "SEAppDelegate.h"

static AFHTTPRequestOperationManager *manager;


@interface WebServiceCalls(){
}
+(void)simpleGetMethodWithRelativePath:(NSString*)relativePath paramater:(NSDictionary*)param block:(WebCallBlock)block;
@end

static NSString *getuserphone;

@implementation WebServiceCalls

+ (void)initialize
{
    manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:kBasePath]];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments | NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves];
}

+ (void)simpleGetMethodWithRelativePath:(NSString*)relativePath
                              paramater:(NSDictionary*)param
                                  block:(WebCallBlock)block
{
    NSLog(@"realtivePath: %@",relativePath);
    NSLog(@"paramaters : %@",param);
    
    [manager GET:relativePath
      parameters:param
         success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Response : %@",responseObject);
         NSString *status=[NSString stringWithFormat:@"%@",responseObject[@"status"]];
         if ([status isEqualToString:@"0"])
         {
             block(responseObject,WebServiceResultSuccess);
         }
         else
         {
             if(responseObject[@"message"])
                 showAletViewWithMessage(responseObject[@"message"]);
             block(responseObject,WebServiceResultFail);
         }
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
        // showAletViewWithMessage(error.localizedDescription);
         block(error,WebServiceResultError);
         NSLog(@"Operation: %@",operation);
         NSLog(@"Error : %@",error);
     }];
}

+(void)newRidePush:(NSString *)iFeedID driver:(NSString *)iDriverID block:(WebCallBlock)block{
    
    [manager POST:@"user/newRidePush" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Pushed to all drivers");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed to push to drivers");
        NSLog(@"%@", error);
    }];
}


+ (void)simplePostMethodWithRelativePath:(NSString*)relativePath
                               paramater:(NSDictionary*)param
                                   block:(WebCallBlock)block
{
    NSLog(@"realtivePath: %@",relativePath);
    NSLog(@"paramaters : %@",param);
        
    [manager POST:relativePath
       parameters:param
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Response : %@",responseObject);
         NSString *status=[NSString stringWithFormat:@"%@",responseObject[@"status"]];
         if ([status isEqualToString:@"0"])
         {
             block(responseObject,WebServiceResultSuccess);
         }
         else
         {
             if(responseObject[@"message"])
                 showAletViewWithMessage(responseObject[@"message"]);
             block(responseObject,WebServiceResultFail);
         }
     }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         showAletViewWithMessage(error.localizedDescription);
         block(error,WebServiceResultError);
         NSLog(@"Operation: %@",operation);
         NSLog(@"Error : %@",error);
     }];
}
#pragma mark - Delete route
+(void)deleteRide:(NSString *)iFeedID block:(WebCallBlock)block{
    [manager POST:@"user/deleteRide" parameters:@{@"iFeedID":iFeedID} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure");
        NSLog(@"%@", error);
    }];
}

+(void)pickedup:(NSString *)iFeedID block:(WebCallBlock)block{
    [manager POST:@"user/pickedupRide" parameters:@{@"iFeedID":iFeedID} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure");
        NSLog(@"%@", error);
    }];
}

+(void)sendMessageToDriver:(NSString *)iDriverID message:(NSString *)Message block:(WebCallBlock)block{
    
    [manager POST:@"user/sendMessage" parameters:@{@"iUserID":iDriverID,@"message":Message} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure");
        NSLog(@"%@", error);
    }];
}


+(void)isitCanceled:(NSString *)iFeedID iDriver:(NSString *)iDriverID block:(WebCallBlock)block{
    
    [manager POST:@"user/isitcanceled" parameters:@{@"iFeedID":iFeedID,@"iDriverID":iDriverID} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success");
        block(responseObject, WebServiceResultSuccess);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure");
        NSLog(@"%@", error);
    }];
}

+(void)getUserInformation:(NSString *)iFeedID block:(WebCallBlock)block{
    
    [manager POST:@"user/getUsernamefromiUserID" parameters:@{@"iFeedID":iFeedID} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success");
        block(responseObject, WebServiceResultSuccess);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure");
        NSLog(@"%@", error);
    }];
}

+(void)getInfoForPopUp:(NSString *)iFeedID block:(WebCallBlock)block{
    
    [manager POST:@"user/getInfoForPopUp" parameters:@{@"iFeedID":iFeedID} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success");
        block(responseObject, WebServiceResultSuccess);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure");
        NSLog(@"%@", error);
    }];
}

+(void)pushdelete:(NSString *)iFeedID driver:(NSString *)iDriverID block:(WebCallBlock)block{
    
    [manager POST:@"user/pushdeletedride" parameters:@{@"iFeedID":iFeedID,@"iDriverID":iDriverID} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure");
        NSLog(@"%@", error);
    }];
}


+(void)updatePaypalEmailAddress:(NSString *)paypal driver:(NSString *)iDriverID block:(WebCallBlock)block{
    
    [manager POST:@"user/updatePaypalAddress" parameters:@{@"paypal":paypal,@"iDriverID":iDriverID} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success");
        block(responseObject, WebServiceResultSuccess);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure");
        NSLog(@"%@", error);
    }];
}

+(void)updateBankInformation:(NSString *)nameofbank routing:(NSString *)routingnr account:(NSString *)accountnr block:(WebCallBlock)block{
    
    [manager POST:@"user/updateDriverBank" parameters:@{@"iDriverID":__CURRENT_USER,@"routingnr":routingnr,@"accountnr":accountnr,@"nameofbank":nameofbank} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success");
        block(responseObject, WebServiceResultSuccess);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure");
        NSLog(@"%@", error);
    }];
}

+(void)getDriverCurrentEarnings:(NSString *)iDriverID block:(WebCallBlock)block{
    
    [manager GET:@"user/getDriverEarnings" parameters:@{@"iDriverID":iDriverID} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success");
        block(responseObject, WebServiceResultSuccess);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure");
        NSLog(@"%@", error);
    }];
}

+(void)updateCurrentEarnings:(NSString *)iDriverID cost:(NSString *)cost block:(WebCallBlock)block{
    
    [manager GET:@"user/updateDriverEarnings" parameters:@{@"iDriverID":iDriverID,@"earnings":cost} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success");
        block(responseObject, WebServiceResultSuccess);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure");
        NSLog(@"%@", error);
    }];
}

#pragma mark - Feedback
+(void)feedback:(NSString *)feedback iFeedID:(NSString *)iFeedID block:(WebCallBlock)block{
    [manager POST:@"user/feedback" parameters:@{@"iFeedID":iFeedID,@"feedback":feedback} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure");
        NSLog(@"%@", error);
    }];
}

#pragma mark - Update driver location
+(void)getFeed:(NSString *)iFeedID latitude:(float)latitude longitude:(float)longitude block:(WebCallBlock)block{
    if(iFeedID != nil)
    [manager GET:@"user/getFeed" parameters:@{@"iFeedID":iFeedID} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success. responseObject: %@", responseObject);
        NSLog(@"Operation response: %@", operation.response);
        block(responseObject, WebServiceResultSuccess);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure");
        NSLog(@"%@", error);
    }];
}

+(void)getDriver:(NSString *)iDriverID block:(WebCallBlock)block
{
    NSLog(@"WebServiceCalls.m getDriver with iDriverID %@",iDriverID);
    
    if(iDriverID != nil)
    [manager GET:@"user/getDriver" parameters:@{@"iDriverID":iDriverID} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success. responseObject: %@", responseObject);
        NSLog(@"Operation response: %@", operation.response);
        block(responseObject, WebServiceResultSuccess);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure");
        NSLog(@"%@", error);
    }];
}


//http://ec2-52-24-193-7.us-west-2.compute.amazonaws.com/ws/user/updateApplicationStatusPending?iUserID=
+(void)pendingApplication:(NSString *)iUserID block:(WebCallBlock)block{
    [manager POST:@"user/updateApplicationStatusPending" parameters:@{@"iUserID":iUserID} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure");
        NSLog(@"%@", error);
    }];
}


//http://ec2-52-24-193-7.us-west-2.compute.amazonaws.com/ws/user/coupondelete?iUserID=449&coupon=used
+(void)deletecoupon:(NSString *)iUserID coupon:(NSString *)coupon block:(WebCallBlock)block{
    [manager POST:@"user/coupondelete" parameters:@{@"iUserID":iUserID,@"coupon":coupon} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure");
        NSLog(@"%@", error);
    }];
}

+(void)checkFoodDrivers:(WebCallBlock)block{
   [WebServiceCalls simpleGetMethodWithRelativePath:@"user/foodDriversOnline" paramater:nil block:block];
}


+(void)sendtextverification:(NSString *)phonenumber block:(WebCallBlock)block{
    [manager GET:@"user/SMSVerification" parameters:@{@"userPhone":phonenumber} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"status"] isEqualToString:@"0"])
            block(responseObject,WebServiceResultSuccess);
        else
        {
            block(responseObject,WebServiceResultFail);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure");
        NSLog(@"%@", error);
    }];

}
+(void)sendtextverificationSweden:(NSString *)phonenumber block:(WebCallBlock)block{
    [manager GET:@"user/SMSVerificationSweden" parameters:@{@"userPhone":phonenumber} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"status"] isEqualToString:@"0"])
            block(responseObject,WebServiceResultSuccess);
        else
        {
            block(responseObject,WebServiceResultFail);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure");
        NSLog(@"%@", error);
    }];
    
}
+(void)successverification:(NSString *)phonenumber block:(WebCallBlock)block{
    [manager GET:@"user/SMSVerifiedPhone" parameters:@{@"userPhone":phonenumber} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"status"] isEqualToString:@"0"])
            block(responseObject,WebServiceResultSuccess);
        else
        {
            block(responseObject,WebServiceResultFail);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure");
        NSLog(@"%@", error);
    }];
    
}
+(void)updatePhoneNumber:(NSString *)phonenumber block:(WebCallBlock)block{
    [manager GET:@"user/updatePhoneNumber" parameters:@{@"iUserID":__CURRENT_USER,@"userPhone":phonenumber} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"status"] isEqualToString:@"0"])
            block(responseObject,WebServiceResultSuccess);
        else
        {
            block(responseObject,WebServiceResultFail);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure");
        NSLog(@"%@", error);
    }];
    
}
+(void)loginwithPhone:(NSString *)phonenumber block:(WebCallBlock)block{
    [manager GET:@"user/getUserEmailViaPhone" parameters:@{@"userPhone":phonenumber} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"status"] isEqualToString:@"0"]){
            block(responseObject,WebServiceResultSuccess);
        }
        else if ([responseObject[@"status"] isEqualToString:@"1"]){
            block(responseObject,WebServiceResultSuccess);
        }
        else
        {
            block(responseObject,WebServiceResultFail);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure");
        NSLog(@"%@", error);
    }];
    
}

+(void)getpasswordPhone:(NSString *)phonenumber block:(WebCallBlock)block{
    [manager GET:@"user/getUserInfoviaPhone" parameters:@{@"userPhone":phonenumber} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"status"] isEqualToString:@"0"]){
            block(responseObject,WebServiceResultSuccess);
        }
        else if ([responseObject[@"status"] isEqualToString:@"1"]){
            block(responseObject,WebServiceResultSuccess);
        }
        else
        {
            block(responseObject,WebServiceResultFail);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure");
        NSLog(@"%@", error);
    }];
    
}

#pragma mark - Access Token

////isa-nu.org/social_events/ws/user/adddevicedoken?iUserID=4&vDeviceToken=11111111
+ (void)addAccessToken:(NSString*)accessToken toUserID:(NSString*)userId completionBlock:(WebCallBlock)block
{
    NSLog(@"------- add token ------------");
    if(accessToken)
        [WebServiceCalls simpleGetMethodWithRelativePath: @"user/adddevicedoken"
                                               paramater: @{ @"iUserID"      : userId,
                                                             @"vDeviceToken" : accessToken }
                                                   block:block];
    else
        [WebServiceCalls simpleGetMethodWithRelativePath: @"user/adddevicedoken"
                                               paramater: @{ @"iUserID"      : userId}
                                                   block:block];
}

////isa-nu.org/social_events/ws/user/removedevicetoken?iUserID=4
+ (void)removeAccessTokenofUserID:(NSString *)userId completionBlock:(WebCallBlock)block
{
    NSLog(@"------- delete token ------------");
    [WebServiceCalls simpleGetMethodWithRelativePath: @"user/removedevicetoken"
                                           paramater: @{ @"iUserID"    : userId }
                                               block:block];
}

#pragma mark -checkFBUser

//isa-nu.org/social_events/ws/user/getuserdatabyfbid?vFbID=1234567338
+ (void)checkFBUser:(NSString*)fbid block:(WebCallBlock)block{
    
    
    [manager GET:@"user/getuserdatabyfbid"
      parameters:@{@"vFbID":fbid}
         success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Response : %@",responseObject);
         block(responseObject,WebServiceResultSuccess);
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         showAletViewWithMessage(error.localizedDescription);
         block(error,WebServiceResultError);
         NSLog(@"Operation: %@",operation);
         NSLog(@"Error : %@",error);
     }];
}

#pragma mark -User

//isa-nu.org/social_events/ws/registration?vUsername=dipesh&vPassword=admin123&vFbID=1234567338&vEmail=dipesh@yudiz.com&vFirst=Dipesh&vLast=Parmar&vDeviceToken=6edc55f12ca78f78fb2fd71e4cd97392a333a1fa8dce85eceffaf09f27266b71
+(void)registerWithPramater:(NSDictionary*)param image:(UIImage*)image imagename:(NSString*)imageName block:(WebCallBlock)block
{
    
    [manager POST:@"registration"
       parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         if(image)
             [formData appendPartWithFileData:UIImagePNGRepresentation(image) name:imageName fileName:NSImageNameStringFromCurrentDate() mimeType:@"image/png"];
     }
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Response : %@",responseObject);
         if ([responseObject[@"status"] isEqualToString:@"0"])
             block(responseObject,WebServiceResultSuccess);
         else
         {
             showAletViewWithMessage(responseObject[@"message"]);
             block(responseObject,WebServiceResultFail);
         }
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         showAletViewWithMessage(error.localizedDescription);
         block(error,WebServiceResultError);
         NSLog(@"Operation: %@",operation);
         NSLog(@"Error : %@",error);
     }];
}

//isa-nu.org/social_events/ws/login?vUsername=dipesh&vPassword=admin123
+(void)loginWithUsername:(NSDictionary*)param block:(WebCallBlock)block
{
    [WebServiceCalls simpleGetMethodWithRelativePath:@"login"
                                           paramater:param
                                               block:block];
}

//http://socialeventsapp.com/ws/user/doLike?iFeedID=45&iUserID=156&LikeStatus=Like

+ (void)likeFeed:(NSDictionary *)param block:(WebCallBlock)block{
    
    [WebServiceCalls simpleGetMethodWithRelativePath:@"user/doLike" paramater:param block:block];
}
//http://socialeventsapp.com/ws/user/doComment?iFeedID=45&iUserID=156&Comment=testing%20comments

+ (void)addCommentToFeed:(NSDictionary *)param block:(WebCallBlock)block{
    
    [WebServiceCalls simplePostMethodWithRelativePath:@"user/doComment" paramater:param block:block];
}

//isa-nu.org/social_events/ws/forgotpassword?vEmail=alpesh@yudiz.com
+(void)forgotPassword:(NSString*)email block:(WebCallBlock)block
{
    [WebServiceCalls simpleGetMethodWithRelativePath:@"forgotpassword" paramater:@{@"vEmail":email} block:block];
}

//isa-nu.org/social_events/ws/changepassword?vOldPassword=admin123&vNewPassword=admin1234&iUserID=3
+(void)changeUserOldPassword:(NSString*)oldPassword toNewPassword:(NSString*)newPassword block:(WebCallBlock)block
{
    [WebServiceCalls simpleGetMethodWithRelativePath:@"changepassword" paramater:@{@"vOldPassword":oldPassword, @"vNewPassword":newPassword, @"iUserID":__CURRENT_USER} block:block];
}




//isa-nu.org/social_events/ws/user/editprofile?vUsername=Dipesh&iUserID=2
+(void)editUserInformation:(NSDictionary*)param Image:(UIImage*)image imageTagName:(NSString*)imageName block:(WebCallBlock)block
{
    
    [manager POST:@"user/editprofile" parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         if(image)
             [formData appendPartWithFileData:UIImagePNGRepresentation(image) name:imageName fileName:NSImageNameStringFromCurrentDate() mimeType:@"image/png"];
     }
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Response : %@",responseObject);
         if ([responseObject[@"status"] isEqualToString:@"0"])
             block(responseObject,WebServiceResultSuccess);
         else
         {
             showAletViewWithMessage(responseObject[@"message"]);
             block(responseObject,WebServiceResultFail);
         }
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         showAletViewWithMessage(error.localizedDescription);
         block(error,WebServiceResultError);
         NSLog(@"Error : %@",error);
     }];
    
}

+(void)close:(NSString *)iFeedID block:(WebCallBlock)block{
    
    [manager POST:@"user/arrivingPushing" parameters:@{@"iFeedID":iFeedID} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"testing responce %@", responseObject);
        NSLog(@"Success");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure");
        NSLog(@"%@", error);
    }];
}



+(void)completedRide:(NSString *)iFeedID block:(WebCallBlock)block{
    [manager POST:@"user/completedRide" parameters:@{@"iFeedID":iFeedID} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure");
        NSLog(@"%@", error);
    }];
}

+(void)driverLocation:(NSString *)iFeedID latitude:(float)latitude longitude:(float)longitude block:(WebCallBlock)block
{
    [manager POST:@"user/driverLocation" parameters:@{@"iFeedID":iFeedID, @"currentLat": [NSNumber numberWithFloat:latitude], @"currentLong": [NSNumber numberWithFloat:longitude]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure");
        NSLog(@"%@", error);
    }];
}

+(void)acceptNotify:(NSString *)ID status:(NSString *)statusString feedID:(NSString *)iFeedID block:(WebCallBlock)block
{
    [manager POST:@"user/updateBookingStatus" parameters:@{@"ID":ID,@"status":statusString,@"iFeedID":iFeedID} success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Success");
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Failure");
         NSLog(@"%@", error);
     }];
}

+(void)acceptRide:(NSString *)iFeedID driver:(NSString *)iDriverID block:(WebCallBlock)block{
    
    [manager POST:@"user/acceptedRide" parameters:@{@"iFeedID":iFeedID,@"iDriverID":iDriverID} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure");
        NSLog(@"%@", error);
    }];
}


+(void)getNearestDriver:(NSString *)iFeedID block:(WebCallBlock)block{
    [WebServiceCalls simpleGetMethodWithRelativePath:@"user/selectnearestdriver" paramater:@{@"iFeedID":iFeedID} block:block];
}

+(void)getLatestInfoblock:(WebCallBlock)block
{
    NSLog(@"%@",__CURRENT_USER);
    [WebServiceCalls simpleGetMethodWithRelativePath:@"user/getLatestInfo" paramater:@{@"iUserID":__CURRENT_USER} block:block];
}

+(void)driverCurrentLocation:(double)latitude longitude:(double)longitude block:(WebCallBlock)block
{
    [manager POST:@"user/driverCurrentLocation" parameters:@{@"iUserID":__CURRENT_USER, @"fLat": [NSNumber numberWithDouble:latitude], @"fLong": [NSNumber numberWithDouble:longitude]} success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Success");
         NSLog(@"%@",responseObject);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Failure");
         NSLog(@"%@", error);
     }];
}

+(void)onlineoroffline:(NSString *)iUserID :(NSString *)status block:(WebCallBlock)block
{
    [manager POST:@"user/driverstatus" parameters:@{@"iUserID":iUserID,@"status":status} success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Success");
         if ([responseObject[@"status"] isEqualToString:@"0"]){
             block(responseObject,WebServiceResultSuccess);
         }
         else
         {
             block(responseObject,WebServiceResultFail);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Failure");
         NSLog(@"%@", error);
     }];
}

+(void)checkuserBalance:(NSString*)iUserID block:(WebCallBlock)block
{
    [manager GET:@"user/checkBalance" parameters:@{@"iUserID":iUserID} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"status"] isEqualToString:@"0"])
            block(responseObject,WebServiceResultSuccess);
        else
        {
            block(responseObject,WebServiceResultFail);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure");
        NSLog(@"%@", error);
    }];
}

+(void)updateuserBalance:(NSString*)iUserID balance:(NSString *)balance block:(WebCallBlock)block{
    [manager GET:@"user/updateBalance" parameters:@{@"iUserID":iUserID,@"balance":balance} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"status"] isEqualToString:@"0"])
            block(responseObject,WebServiceResultSuccess);
        else
        {
            block(responseObject,WebServiceResultFail);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure");
        NSLog(@"%@", error);
    }];
}

//isa-nu.org/social_events/ws/user/info?iUserID=1
+(void)singleUserDetail:(NSString*)userId block:(WebCallBlock)block
{
    ////isa-nu.org/social_events/ws/user/info?iUserID=1
    [WebServiceCalls simpleGetMethodWithRelativePath:@"user/info" paramater:@{@"iUserID":userId} block:block];
}

#pragma mark -Friends

//isa-nu.org/social_events/ws/connection/send_fb_request?iSenderID=2&vFbID[]=15
+ (void)sendFbRequest:(NSArray *)fbIdArray completionBlock:(WebCallBlock)block
{
    NSString *url = [NSString stringWithFormat:@"connection/send_fb_request"];
    [WebServiceCalls simpleGetMethodWithRelativePath:url paramater:@{@"iSenderID":__CURRENT_USER,
                                                                     @"vFbID":fbIdArray} block:block];
}

//isa-nu.org/social_events/ws/user/search?q=alpesh@yudiz.com&iUserID=2
+ (void)searchForUserWithName:(NSString *)searchText completionBlock:(WebCallBlock)block
{
    NSDictionary *param=@{@"q": searchText,
                          @"iUserID":__CURRENT_USER
                          };
    [WebServiceCalls simpleGetMethodWithRelativePath:@"user/search" paramater:param block:block];
}

//isa-nu.org/social_events/ws/connection/send_request?iSenderID=1&iFriendID[0]=2&iFriendID[1]=3&iFriendID[2]=4
+ (void)sendFriendRequest:(NSString*)friendId completionBlock:(WebCallBlock)block
{
    [WebServiceCalls simpleGetMethodWithRelativePath:@"connection/send_request" paramater:@{@"iFriendID":@[friendId], @"iSenderID":__CURRENT_USER} block:block];
}

//isa-nu.org/social_events/ws/connection/pending_list?iUserID=15
+ (void)getPendingFriendListWithcompletionBlock:(WebCallBlock)block
{
    [WebServiceCalls simpleGetMethodWithRelativePath:@"connection/pending_list" paramater:@{@"iUserID":__CURRENT_USER} block:block];
}

//isa-nu.org/social_events/ws/connection/friend_list?iUserID=3
+ (void)getFriendListWithcompletionBlock:(WebCallBlock)block
{
    [WebServiceCalls simpleGetMethodWithRelativePath:@"connection/friend_list" paramater:@{@"iUserID":__CURRENT_USER} block:block];
}

//isa-nu.org/social_events/ws/connection/accept?iConnectionID=2&iFriendID=15
+ (void)acceptFrinedReuqest:(NSDictionary *)param completionBlock:(WebCallBlock)block
{
    NSString *url = [NSString stringWithFormat:@"connection/accept"];
    [WebServiceCalls simpleGetMethodWithRelativePath:url paramater:param block:block];
}

//isa-nu.org/social_events/ws/connection/reject?iConnectionID=3&iFriendID=3
+ (void)rejectFriendRequest:(NSDictionary *)param completionBlock:(WebCallBlock)block
{
    NSString *url = [NSString stringWithFormat:@"connection/reject"];
    [WebServiceCalls simpleGetMethodWithRelativePath:url paramater:param block:block];
}

//isa-nu.org/social_events/ws/user/locationRequest?iSenderID=3&iRecieverID=14&eStatus=0
+ (void)sendLocationRequest:(NSDictionary*)param  completionBlock:(WebCallBlock)block
{
    NSString *url = [NSString stringWithFormat:@"user/locationRequest"];
    [WebServiceCalls simpleGetMethodWithRelativePath:url paramater:param block:block];
}

//isa-nu.org/social_events/ws/user/pendingLocationRequest?iUserID=2
+ (void)getLocationPendingRequestListCompletionBlock:(WebCallBlock)block
{
    NSString *url = [NSString stringWithFormat:@"user/pendingLocationRequest"];
    [WebServiceCalls simpleGetMethodWithRelativePath:url paramater:@{@"iUserID":__CURRENT_USER} block:block];
}

//isa-nu.org/social_events/ws/user/locationRequest?iSenderID=3&iRecieverID=14&eStatus=1&fLat=0.21233&fLong=0.21232
+ (void)locationRequestAcceptReject:(NSDictionary*)param  completionBlock:(WebCallBlock)block
{
    NSString *url = [NSString stringWithFormat:@"user/locationRequest"];
    [WebServiceCalls simpleGetMethodWithRelativePath:url paramater:param block:block];
}

//isa-nu.org/social_events/ws/user/userLocationRequestResponseList?iUserID=3
+ (void)getLocationRequestStatusListCompletionBlock:(WebCallBlock)block
{
    NSString *url = [NSString stringWithFormat:@"user/userLocationRequestResponseList"];
    [WebServiceCalls simpleGetMethodWithRelativePath:url paramater:@{@"iUserID":__CURRENT_USER} block:block];
}

+(void)sendApplicationInfo:(NSDictionary *)param completionBlock:(WebCallBlock)block{
    
    NSString *url = [NSString stringWithFormat:@"user/applicationAddValues"];
    
    [WebServiceCalls simplePostMethodWithRelativePath:url paramater:param block:block];
}

+ (void)changeToPendingApplication:(WebCallBlock)block
{
    NSString *url = [NSString stringWithFormat:@"user/changeApplicationStatustoPending"];
    [WebServiceCalls simpleGetMethodWithRelativePath:url paramater:@{@"iUserID":__CURRENT_USER} block:block];
}

+(void)updateUserCardTokenToserver:(NSDictionary *)param completionBlock:(WebCallBlock)block{
    
    NSString *url = [NSString stringWithFormat:@"user/updateToken"];
    
    [WebServiceCalls simplePostMethodWithRelativePath:url paramater:param block:block];
}

+(void)updateUserCardTokenToserverSweden:(NSDictionary *)param completionBlock:(WebCallBlock)block{
    
    NSString *url = [NSString stringWithFormat:@"user/updateTokenSweden"];
    
    [WebServiceCalls simplePostMethodWithRelativePath:url paramater:param block:block];
}

+(void)cardRegister:(NSDictionary *)param completionBlock:(WebCallBlock)block{
    
    NSString *url = [NSString stringWithFormat:@"user/updateUserToken"];
    
    [WebServiceCalls simplePostMethodWithRelativePath:url paramater:param block:block];
}


//isa-nu.org/social_events/ws/user/feedAdd?iUserID=2&vFeedTitle=My%20First%20Feed%20Title&tFeedDescription=My%20First%20Feed%20Description&iFriendID[0]=3&iFriendID[1]=4&iFriendID[2]=5
//vMapImage & vItemImage


+ (void)addNewFeed:(NSDictionary*)param completionBlock:(WebCallBlock)block
{
    
    NSLog(@"params  : %@",param);
    
    [manager POST:@"user/feedAdd"
       parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
     }
       success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"PARAM BEFORE SEND: %@",param);
         NSLog(@"Response : %@",responseObject);
         if ([responseObject[@"status"] isEqualToString:@"0"])
         {
             block(responseObject,WebServiceResultSuccess);
         }
         else
         {
             showAletViewWithMessage(responseObject[@"message"]);
             block(responseObject,WebServiceResultFail);
         }
     }
       failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         showAletViewWithMessage(error.localizedDescription);
         block(error,WebServiceResultError);
         NSLog(@"Operation: %@",operation);
         NSLog(@"Error : %@",error);
     }];
    
    
}

+ (void)checkDriverFeedListCompBlock:(WebCallBlock)block
{
    NSString *url = [NSString stringWithFormat:@"user/driverFeedList"];
    [WebServiceCalls simpleGetMethodWithRelativePath:url paramater:@{@"iUserID":__CURRENT_USER} block:block];
}


//isa-nu.org/social_events/ws/user/feedList?iUserID=2
+ (void)getFeedListCompletionBlock:(WebCallBlock)block
{
    
    NSString *url = [NSString stringWithFormat:@"user/feedList"];
    
    [WebServiceCalls simpleGetMethodWithRelativePath:url paramater:@{@"iUserID":__CURRENT_USER} block:block];
}
//http://socialeventsapp.com/ws/user/get_highlight_post?iUserID=156

+ (void)getHighLightListCompletionBlock:(WebCallBlock)block
{
    NSString *url = [NSString stringWithFormat:@"user/get_highlight_post?"];
    [WebServiceCalls simpleGetMethodWithRelativePath:url paramater:@{@"iUserID":__CURRENT_USER} block:block];
}

//isa-nu.org/social_events/ws/report?iUserID=15&iFeedID=1
+ (void)feedReport:(NSString*)iFeedID CompletionBlock:(WebCallBlock)block
{
    NSString *url = [NSString stringWithFormat:@"report"];
    [WebServiceCalls simpleGetMethodWithRelativePath:url paramater:@{@"iFeedID":iFeedID,
                                                                     @"iUserID":__CURRENT_USER
                                                                     } block:block];
}

//http://socialeventsapp.com/ws/connection/remove_friend?iUserID=4&frienduserid=3
+ (void)removeFriend:(NSString *)frienduserid completionBlock:(WebCallBlock)block
{
    NSString *url = [NSString stringWithFormat:@"connection/remove_friend"];
    [WebServiceCalls simplePostMethodWithRelativePath:url paramater:@{@"iUserID":__CURRENT_USER,
                                                                     @"frienduserid":frienduserid} block:block];
}

//http://socialeventsapp.com/ws/message/send_message?iUserID=156&otherUserId=1&message=Testing
+ (void)sendMessage:(NSString *)Message otherUserId:(NSString *)otheruserid completionBlock:(WebCallBlock)block
{
    NSString *url = [NSString stringWithFormat:@"message/send_message"];
    [WebServiceCalls simplePostMethodWithRelativePath:url paramater:@{@"iUserID":__CURRENT_USER,
                                                                      @"otherUserId":otheruserid,
                                                                      @"message":Message} block:block];
}

//http://socialeventsapp.com/ws/message/get_messages?iUserID=156&otherUserId=1

+ (void)getMessage:(NSString *)otheruserid completionBlock:(WebCallBlock)block
{
     NSString *url = [NSString stringWithFormat:@"message/get_messages"];
    [WebServiceCalls simpleGetMethodWithRelativePath:url paramater:@{@"iUserID":__CURRENT_USER,
                                                                      @"otherUserId":otheruserid
                                                                      } block:block];
}

@end

