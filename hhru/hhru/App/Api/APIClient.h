//
//  APIClient.h
//
//

#import "Constants.h"

typedef void (^Success)(id response);
typedef void (^Failure)(NSInteger code, NSString *message);

@interface APIClient : NSObject

@property(nonatomic, assign, getter=isDisabledNotificationToasts) BOOL disableNotificationToasts;
@property(nonatomic, assign, getter=isDisabledAlerts) BOOL disabledAlerts;

+ (APIClient *)sharedClient;
+ (void)setJSONRequestSerializer;
+ (void)setHTTPRequestSerializer;

+ (void)POST:(NSString *)path parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure;
+ (void)POST:(NSString *)path success:(Success)success failure:(Failure)failure;
+ (void)POST:(NSString *)path parameters:(NSDictionary *)parameters showMessage:(BOOL)showMessage success:(Success)success failure:(Failure)failure;
+ (void)POST:(NSString *)path uploadImage:(NSData *)imageData dataName:(NSString *)dataName parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure;

+ (void)PUT:(NSString *)path success:(Success)success failure:(Failure)failure;
+ (void)PUT:(NSString *)path parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure;
+(void)PUT:(NSString *)path parameters:(NSDictionary *)parameters showMessage:(BOOL)showMessage success:(Success)success failure:(Failure)failure;

+ (void)GET:(NSString *)path parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure;
+ (void)GET:(NSString *)path success:(Success)success failure:(Failure)failure;
+ (void)GET:(NSString *)path parameters:(NSDictionary *)parameters showMessage:(BOOL)showMessage success:(Success)success failure:(Failure)failure;

+ (void)DELETE:(NSString *)path parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure;

// Tasks
+ (void)cancelAllOperations;
+ (void)cancelTaskWithPath:(NSString *)path;
+ (void)cancelTaskWithPath:(NSString *)path result:(void(^)(BOOL cancelled))result;
+ (void)cancelTasksWithPaths:(NSArray *)paths;
+ (void)cancelTaskWithPathID:(NSString *)pathID;
+ (void)cancelTaskWithPathID:(NSString *)pathID result:(void(^)(BOOL cancelled))result;

@end
