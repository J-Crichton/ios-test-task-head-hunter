//
//  APIClient.m
//

#import <AFNetworking/AFHTTPSessionManager.h>
#import "APIClient.h"
#import "NSObject+PWObject.h"
#import "NSObject+Json.h"
#import "NSString+Ext.h"
#import "AlertHelper.h"
#import "Connection.h"
#import "ModelObject.h"
#import "ToastManager.h"
#import "ModelObject.h"

@interface APIClient()

@end

static NSMutableDictionary *_activeTasks = nil;

@implementation APIClient

+ (APIClient *)sharedClient {
    static APIClient *_sharedClient = nil;
    @synchronized(self) {
        if (_sharedClient == nil)
            _sharedClient = [[self alloc] init];
    }
    return _sharedClient;
}

+ (AFHTTPSessionManager *)manager
{
    static dispatch_once_t once;
    static AFHTTPSessionManager *_manager;
    dispatch_once(&once, ^ {
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:API_BASE_URL] sessionConfiguration:sessionConfiguration];
        [_manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        [_manager setResponseSerializer:[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments]];
    });

    return _manager;
}

+ (void)setJSONRequestSerializer {
    [[self manager] setRequestSerializer:[AFJSONRequestSerializer serializer]];
}

+ (void)setHTTPRequestSerializer {
    [[self manager] setRequestSerializer:[AFHTTPRequestSerializer serializer]];
}


#pragma mark -
#pragma mark POST

+ (void)POST:(NSString *)path success:(Success)success failure:(Failure)failure {
    [self POST:path parameters:nil success:success failure:failure];
}

+ (void)POST:(NSString *)path parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure {
    [self METHOD:@"POST" path:path parameters:parameters body:nil success:success failure:failure];
}

+ (void)POST:(NSString *)path uploadImage:(NSData *)imageData dataName:(NSString *)dataName parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure
{
    NSString *pathCopy = [path copy];

    // Extract the path
    NSString *pathID = nil;
    [self parsePath:&path intoPathID:&pathID];
    
    if(kDEBUG_LOGS) NSLog(@"POST PARAMS (%@):%@", pathCopy, [parameters JSONRepresentation]);

    [self requestWithPath:path uploadFile:imageData formDataName:dataName fileName:@"photo.jpg" mimeType:@"image/jpeg" parameters:parameters success:success failure:failure];
}

+ (void)requestWithPath:(NSString *)path
             uploadFile:(NSData *)uploadData
           formDataName:(NSString *)formDataName
               fileName:(NSString *)fileName
               mimeType:(NSString *)mimeType
             parameters:(NSDictionary *)parameters
                success:(Success)success failure:(Failure)failure {

    // Extract the path
    NSString *pathID = nil;
    [self parsePath:&path intoPathID:&pathID];
    
    [[self manager] POST:[self apiUrlWithPath:path] parameters:parameters constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {
        [formData appendPartWithFileData:uploadData name:formDataName fileName:fileName mimeType:mimeType];
    } progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self handleSuccessResponse:responseObject pathID:pathID success:success failure:failure];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self handleFailureWithError:error task:task pathID:pathID failure:failure];
    }];
}

#pragma mark -
#pragma mark GET

+ (void)GET:(NSString *)path success:(Success)success failure:(Failure)failure {
    [self GET:path parameters:nil success:success failure:failure];
}

+ (void)GET:(NSString *)path parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure {
    [self METHOD:@"GET" path:path parameters:parameters body:nil success:success failure:failure];
}


#pragma mark -
#pragma mark PUT

+(void)PUT:(NSString *)path success:(Success)success failure:(Failure)failure {
    [self PUT:path parameters:nil body:nil success:success failure:failure contentType:nil];
}

+(void)PUT:(NSString *)path parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure {
    [self PUT:path parameters:parameters body:nil success:success failure:failure contentType:nil];
}

+(void)PUT:(NSString *)path body:(NSString *)body success:(Success)success failure:(Failure)failure {
    [self PUT:path parameters:nil body:body success:success failure:failure contentType:nil];
}

+(void)PUT:(NSString *)path body:(NSString *)body success:(Success)success failure:(Failure)failure contentType:(NSString *)contentType {
    [self PUT:path parameters:nil body:body success:success failure:failure contentType:contentType];
}

+ (void)PUT:(NSString *)path parameters:(NSDictionary *)parameters body:(NSString *)body success:(Success)success failure:(Failure)failure contentType:(NSString *)contentType {
    [self METHOD:@"PUT" path:path parameters:parameters body:body success:success failure:failure];
}

#pragma mark -
#pragma mark - DELETE

+ (void)DELETE:(NSString *)path parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure {
    [self METHOD:@"DELETE" path:path parameters:parameters body:nil success:success failure:failure];
}


#pragma mark -
#pragma mark Mix methods

+ (void)METHOD:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters body:(NSString *)body success:(Success)success failure:(Failure)failure
{
    if ([Connection isReachableM]) {
        
        // Extract the path
        NSString *pathID = nil;
        [self parsePath:&path intoPathID:&pathID];
        if(kDEBUG_LOGS) NSLog(@"%@ path: %@", method, path);
        if(kDEBUG_LOGS) NSLog(@"parameters: %@", parameters);
        
        AFHTTPSessionManager *manager = [self manager];
        
        NSURLSessionDataTask *requestTask = nil;
        if(body)
        {
            NSMutableURLRequest *request = [[manager requestSerializer] requestWithMethod:method URLString:[self apiUrlWithPath:path] parameters:parameters error:nil];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody: [[body JSONRepresentation] dataUsingEncoding:NSUTF8StringEncoding]];

            requestTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                if(!error) {
                    [self handleSuccessResponse:responseObject pathID:pathID success:success failure:failure];
                } else {
                    [self handleFailureWithError:error task:nil pathID:pathID failure:failure];
                }
            }];
            [requestTask resume];
        }
        else
        {
            if([method isEqual:@"POST"])
            {
                requestTask = [manager POST:[self apiUrlWithPath:path] parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                    [self handleSuccessResponse:responseObject pathID:pathID success:success failure:failure];
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    [self handleFailureWithError:error task:task pathID:pathID failure:failure];
                }];
            }
            else if([method isEqual:@"PATCH"])
            {
                requestTask = [manager PATCH:[self apiUrlWithPath:path] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
                    [self handleSuccessResponse:responseObject pathID:pathID success:success failure:failure];
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    [self handleFailureWithError:error task:task pathID:pathID failure:failure];
                }];
            }
            else if([method isEqual:@"PUT"])
            {
                requestTask = [manager PUT:[self apiUrlWithPath:path] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
                    [self handleSuccessResponse:responseObject pathID:pathID success:success failure:failure];
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    [self handleFailureWithError:error task:task pathID:pathID failure:failure];
                }];
            }
            else if([method isEqual:@"GET"])
            {
                
                requestTask = [manager GET:[self apiUrlWithPath:path] parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                    [self handleSuccessResponse:responseObject pathID:pathID success:success failure:failure];
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    [self handleFailureWithError:error task:task pathID:pathID failure:failure];
                }];
            }
            else if([method isEqual:@"DELETE"])
            {
                requestTask = [manager DELETE:path parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    [self handleSuccessResponse:responseObject pathID:pathID success:success failure:failure];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [self handleFailureWithError:error task:task pathID:pathID failure:failure];
                }];
            }

        }
        

        // Add operation
        if(pathID) {
            [self addTask:requestTask forPathID:pathID];
        }
    } else {
        [self performBlock:^{
            failure(-1, @"");
        } afterDelay:2.0];
    }
}

#pragma mark -
#pragma mark Handle Success / Failure

+ (void)handleSuccessResponse:(id)response pathID:(NSString *)pathID success:(Success)success failure:(Failure)failure {
    
    if (kDEBUG_LOGS) NSLog(@"RESPONSE_OBJECT (%@): %@", pathID, [response JSONRepresentation]);

    // Remove / Clear operation
    [self removeTaskWithPathID:pathID];

    if(response) {
        success(response);
    } else {
        success(nil);
    }
}

+ (void)handleFailureWithError:(NSError *)error
                          task:(NSURLSessionDataTask*)task
                        pathID:(NSString *)pathID
                       failure:(Failure)failure
{
    
    NSInteger errorCode = error.code;
    if (task) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        errorCode = httpResponse.statusCode;
    }
    
    // Remove / Clear operation
    [self removeTaskWithPathID:pathID];

    // Log error
    NSString *ErrorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
    if(kDEBUG_LOGS) NSLog(@"ErrorResponse:%@",ErrorResponse);

    NSString *localizedDescription = error.localizedDescription;

    if(kDEBUG_LOGS) NSLog(@"2) %li, %@", (long)error.code, localizedDescription);
    
    NSData *data= error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
    if (data != nil) {
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        if ([json objectForKey:@"description"]) {
            NSString *str = [json objectForKey:@"description"];
            [self showNotification:str];
        } else {
            [self showNotification:localizedDescription];
        }
    }
    
    if(failure) failure(errorCode, error.localizedDescription);

}

+(void)handleFailureResponseWithObject:(id)response withFailure:(Failure)failure
{
    NSInteger errorCode = 0;
    errorCode = [[response objectForKey:@"status_code"] integerValue];

    NSString *title = [response objectForKey:@"error"];
    [ToastManager showError:title];
    
    if(failure) {
        failure(errorCode, title);
    }
}

#pragma mark -
#pragma mark Helper

+ (NSString *)apiUrlWithPath:(NSString *)path {
    if([path containsString:@"http://"] || [path containsString:@"https://"]) {
        return path;
    }
    return [API_BASE_URL stringByAppendingString:path];
}

+ (void)showNotification:(NSString *)message
{
    // If internet connection fine.
    if([Connection isReachable] && ![[self sharedClient] isDisabledNotificationToasts]) {
        [ToastManager showError:message];
    } else {
        [ToastManager showError:@"Интернет соединение отсутствует"];
    }
}

+ (void)showAlertWithErrorCode:(NSInteger)code title:(NSString *)title message:(NSString *)message
{
    if((title && ![title isEqual:@""]) || (message && ![message isEqual:@""])) {
        [AlertHelper showInController:nil title:title message:message];
    }
}

#pragma mark -
#pragma mark NSURLSessionDataTask

+ (void)addTask:(id)task forPathID:(NSString *)pathID
{
    if(!task) return;
    if(!pathID) {
        NSLog(@"Passed nil pathID");
        return;
    }

    if(!_activeTasks) {
        _activeTasks = [[NSMutableDictionary alloc] init];
    }

    // Cancel previous active tasks
    [self cancelTaskWithPathID:pathID];

    _activeTasks[pathID] = task;
}

+ (void)cancelTasksWithPaths:(NSArray *)paths
{
    if(!paths) return;
    for(NSString *path in paths) {
        [self cancelTaskWithPath:path];
    }
}

+ (void)cancelTaskWithPathID:(NSString *)pathID {
    [self cancelTaskWithPathID:pathID result:nil];
}

+ (void)cancelTaskWithPathID:(NSString *)pathID result:(void(^)(BOOL cancelled))result
{
    NSURLSessionDataTask *task = [self taskWithPathID:pathID];
    if(task && task.state == NSURLSessionTaskStateRunning) {
        [task cancel];
        if(result) result(YES);
    }
    if(result) result(NO);
}

+ (void)removeTaskWithPathID:(NSString *)pathID {
    if(_activeTasks[pathID]) {
        [_activeTasks removeObjectForKey:pathID];
    }
}

+ (NSURLSessionDataTask *)taskWithPathID:(NSString *)pathID {
    if(_activeTasks) {
        return _activeTasks[pathID];
    }
    return nil;
}

+ (void)cancelAllOperations {
    [[[self manager] operationQueue] cancelAllOperations];
    _activeTasks = nil;
}

+ (void)cancelTaskWithPath:(NSString *)path {
    [self cancelTaskWithPath:path result:nil];
}

+ (void)cancelTaskWithPath:(NSString *)path result:(void(^)(BOOL cancelled))result
{
    NSString *pathID = nil;
    [self parsePath:&path intoPathID:&pathID];

    [self cancelTaskWithPathID:pathID result:result];
}

+ (void)parsePath:(NSString **)pathString intoPathID:(NSString **)pathID
{
    NSArray *pathArray = [*pathString componentsSeparatedByString:@"|"];
    NSString *pathStringOriginal = [pathArray firstObject];
    *pathString = [pathStringOriginal stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    if(pathArray.count > 1) {
        *pathID = [pathArray lastObject];

        NSInteger pathIdLen = [NSString stringWithFormat:@"%@", *pathID].length;
        if(pathIdLen == 0) *pathID = pathStringOriginal;
    } else {
        *pathID = pathStringOriginal;
    }
}

@end
