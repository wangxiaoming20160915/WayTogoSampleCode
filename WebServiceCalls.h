
#import <Foundation/Foundation.h>

#define kBasePath @"http://yourwebhostURL.com/ws/"

typedef NS_ENUM (NSInteger, WebServiceResult)
{
    WebServiceResultSuccess = 0,
    WebServiceResultFail,
    WebServiceResultError
};

typedef NS_ENUM (NSInteger, NMVisibility)
{
    NMVisibilityAll = 0,
    NMVisibilityFriend,
    NMVisibilityNone,
};

typedef void(^WebCallBlock)(id JSON,WebServiceResult result);

@interface WebServiceCalls : NSObject

+(void)updateCurrentEarnings:(NSString *)iDriverID cost:(NSString *)cost block:(WebCallBlock)block;

+(void)isitCanceled:(NSString *)iFeedID iDriver:(NSString *)iDriverID block:(WebCallBlock)block;

+(void)getInfoForPopUp:(NSString *)iFeedID block:(WebCallBlock)block;

+(void)getUserInformation:(NSString *)iFeedID block:(WebCallBlock)block;


+(void)updateBankInformation:(NSString *)nameofbank routing:(NSString *)routingnr account:(NSString *)accountnr block:(WebCallBlock)block;

+(void)checkFoodDrivers:(WebCallBlock)block;

+(void)sendtextverificationSweden:(NSString *)phonenumber block:(WebCallBlock)block;

+(void)updatePhoneNumber:(NSString *)phonenumber block:(WebCallBlock)block;

+ (void)changeToPendingApplication:(WebCallBlock)block;

+(void)updateUserCardTokenToserverSweden:(NSDictionary *)param completionBlock:(WebCallBlock)block;

+(void)updatePaypalEmailAddress:(NSString *)paypal driver:(NSString *)iDriverID block:(WebCallBlock)block;

+(void)getDriverCurrentEarnings:(NSString *)iDriverID block:(WebCallBlock)block;

+ (void)checkDriverFeedListCompBlock:(WebCallBlock)block;

+(void)completedRide:(NSString *)iFeedID block:(WebCallBlock)block;

+(void)pickedup:(NSString *)iFeedID block:(WebCallBlock)block;

+(void)acceptNotify:(NSString *)ID status:(NSString *)statusString feedID:(NSString *)iFeedID block:(WebCallBlock)block;

+(void)close:(NSString *)iFeedID block:(WebCallBlock)block;

+(void)sendMessageToDriver:(NSString *)iDriverID message:(NSString *)Message block:(WebCallBlock)block;

+(void)pushdelete:(NSString *)iFeedID driver:(NSString *)iDriverID block:(WebCallBlock)block;

+(void)acceptRide:(NSString *)iFeedID driver:(NSString *)iDriverID block:(WebCallBlock)block;

+(void)getLatestInfoblock:(WebCallBlock)block;

+(void)driverLocation:(NSString *)iFeedID latitude:(float)latitude longitude:(float)longitude block:(WebCallBlock)block;

#pragma mark - newRidePush
+(void)newRidePush:(NSString *)iFeedID driver:(NSString *)iDriverID block:(WebCallBlock)block;


+(void)onlineoroffline:(NSString *)iUserID :(NSString *)status block:(WebCallBlock)block;

+(void)getNearestDriver:(NSString *)iFeedID block:(WebCallBlock)block;


#pragma mark -addAccessToken

+(void)pendingApplication:(NSString *)iUserID block:(WebCallBlock)block;

+ (void)addAccessToken:(NSString*)accessToken toUserID:(NSString*)userId completionBlock:(WebCallBlock)block;

+(void)driverCurrentLocation:(double)latitude longitude:(double)longitude block:(WebCallBlock)block;

+ (void)removeAccessTokenofUserID:(NSString*)userId completionBlock:(WebCallBlock)block;

#pragma mark - deleteride
+(void)deleteRide:(NSString *)iFeedID block:(WebCallBlock)block;

#pragma mark -Check FBID

+ (void)checkFBUser:(NSString*)fbid block:(WebCallBlock)block;

#pragma mark - Sending application info
+(void)sendApplicationInfo:(NSDictionary *)param completionBlock:(WebCallBlock)block;

#pragma mark -Driver location
+(void)getFeed:(NSString *)iFeedID latitude:(float)latitude longitude:(float)longitude block:(WebCallBlock)block;

#pragma mark -getDriverID
+(void)getDriver:(NSString *)iDriverID block:(WebCallBlock)block;

#pragma mark -User

+ (void)registerWithPramater:(NSDictionary*)param image:(UIImage*)image imagename:(NSString*)imageName block:(WebCallBlock)block;

+ (void)loginWithUsername:(NSDictionary*)param block:(WebCallBlock)block;

+ (void)forgotPassword:(NSString*)email block:(WebCallBlock)block;

+ (void)changeUserOldPassword:(NSString*)oldPassword toNewPassword:(NSString*)newPassword block:(WebCallBlock)block;

+ (void)editUserInformation:(NSDictionary*)param Image:(UIImage*)image imageTagName:(NSString*)imageName block:(WebCallBlock)block;

+ (void)singleUserDetail:(NSString*)userId block:(WebCallBlock)block;

#pragma mark -Friends

+ (void)sendFbRequest:(NSArray *)fbIdArray completionBlock:(WebCallBlock)block;

+ (void)searchForUserWithName:(NSString *)searchText completionBlock:(WebCallBlock)block;

+ (void)sendFriendRequest:(NSString*)friendId completionBlock:(WebCallBlock)block;

+ (void)getPendingFriendListWithcompletionBlock:(WebCallBlock)block;

+ (void)getFriendListWithcompletionBlock:(WebCallBlock)block;

+ (void)acceptFrinedReuqest:(NSDictionary*)param  completionBlock:(WebCallBlock)block;

+ (void)rejectFriendRequest:(NSDictionary*)param  completionBlock:(WebCallBlock)block;

+ (void)sendLocationRequest:(NSDictionary*)param  completionBlock:(WebCallBlock)block;

+ (void)getLocationPendingRequestListCompletionBlock:(WebCallBlock)block;

+ (void)locationRequestAcceptReject:(NSDictionary*)param  completionBlock:(WebCallBlock)block;

+ (void)getLocationRequestStatusListCompletionBlock:(WebCallBlock)block;

+ (void)addNewFeed:(NSDictionary*)param completionBlock:(WebCallBlock)block;

+ (void)getFeedListCompletionBlock:(WebCallBlock)block;

+ (void)getHighLightListCompletionBlock:(WebCallBlock)block;

+ (void)feedReport:(NSString*)iFeedID CompletionBlock:(WebCallBlock)block;

+ (void)removeFriend:(NSString *)frienduserid completionBlock:(WebCallBlock)block;

+ (void)sendMessage:(NSString *)Message otherUserId:(NSString *)otheruserid completionBlock:(WebCallBlock)block;

+ (void)getMessage:(NSString *)otheruserid completionBlock:(WebCallBlock)block;

+(void)updateUserCardTokenToserver:(NSDictionary *)param completionBlock:(WebCallBlock)block;

+(void)cardRegister:(NSDictionary *)param completionBlock:(WebCallBlock)block;

+(void)feedback:(NSString *)feedback iFeedID:(NSString *)iFeedID block:(WebCallBlock)block;

+(void)deletecoupon:(NSString *)iUserID coupon:(NSString *)coupon block:(WebCallBlock)block;

+(void)checkuserBalance:(NSString*)iUserID block:(WebCallBlock)block;

+(void)updateuserBalance:(NSString*)iUserID balance:(NSString *)balance block:(WebCallBlock)block;

+(void)sendtextverification:(NSString *)phonenumber block:(WebCallBlock)block;

+(void)successverification:(NSString *)phonenumber block:(WebCallBlock)block;

+(void)loginwithPhone:(NSString *)phonenumber block:(WebCallBlock)block;

+(void)getpasswordPhone:(NSString *)phonenumber block:(WebCallBlock)block;

#pragma mark - Like Dislike feed

+ (void)likeFeed:(NSDictionary *)param block:(WebCallBlock)block;

#pragma mark - Add comment to feed

+ (void)addCommentToFeed:(NSDictionary *)param block:(WebCallBlock)block;


#pragma mark - add post

@end
