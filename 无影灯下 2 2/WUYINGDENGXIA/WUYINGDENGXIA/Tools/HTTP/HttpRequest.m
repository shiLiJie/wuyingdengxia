//
//  HttpRequest.m
//  网络请求1116Demo
//
//  Created by 凤凰八音 on 16/10/25.
//  Copyright © 2016年 凤凰八音. All rights reserved.
//

#import "HttpRequest.h"
#import "AFHTTPSessionManager.h"
/**
 *  存放 网络请求的线程
 */
static NSMutableArray *sg_requestTasks;

@interface HttpRequest ()

@end


@implementation HttpRequest
-(void)haha{
    self.netState = NETStateError;
}

static HttpRequest * webUtil = nil;

+ (HttpRequest *) shardWebUtil
{
    @synchronized([HttpRequest class])
    {
        if (!webUtil) {
            webUtil = [[[self class] alloc] init];
        }
        return webUtil;
    }
    return nil;
}

#pragma mark 检测网路状态
+ (void)netWorkStatus{
    
    /**
     *  AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     *  AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     *  AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G
     *  AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络Wifi
     */
    // 如果要检测网络状态的变化, 必须要用检测管理器的单例startMoitoring
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if(status == AFNetworkReachabilityStatusNotReachable){
            NSLog(@"断网了");
            
            return ;
        }
        if(status == AFNetworkReachabilityStatusReachableViaWiFi){
            NSLog(@"wifi");

            return ;
        }
        if(status == AFNetworkReachabilityStatusReachableViaWWAN){
            NSLog(@"4G");
            
            return ;
        }
    }];
    
}

#pragma mark - AFnetworking manager getter

- (AFHTTPSessionManager *)createAFHTTPSessionManager
{
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置请求参数的类型:HTTP (AFJSONRequestSerializer,AFHTTPRequestSerializer)
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //设置请求的超时时间
    manager.requestSerializer.timeoutInterval = 30.f;
    //设置服务器返回结果的类型:JSON (AFJSONResponseSerializer,AFHTTPResponseSerializer)
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    
    return manager;
}

/**
 *JSON方式获取数据 GET
 *urlStr:获取数据的url地址
 *
 */
- (void)getNetworkRequestURLString:(NSString *) urlString  andParas:(id) params andTransferGottenData:(transferValue) transfer
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPSessionManager *manager = [self createAFHTTPSessionManager];

    [manager GET:urlString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        transfer(responseObject,nil);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        transfer(nil,error);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
}

/**
 *JSON方式获取数据 POST
 *urlStr:获取数据的url地址
 *
 */
-(void)postNetworkRequestURLString:(NSString *) urlString  andParas:(id) params andTransferGottenData:(transferValue) transfer
{

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPSessionManager *manager = [self createAFHTTPSessionManager];
   
    [manager POST:urlString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         transfer(responseObject,nil);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         transfer(nil,error);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
}

/**
 *JSON方式获取数据 GET
 *url_path:获取数据的url地址
 *有返回值 类型
 */
- (PPURLSessionTask *)getNetworkRequestURLString:(NSString *)url_path parameters:(id)parameters success:(void (^)(id obj))success fail:(void (^)(NSError *error))fail
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPSessionManager *manager = [self createAFHTTPSessionManager];
    
    PPURLSessionTask *session=nil;
    
    session = [manager GET:url_path parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
    
    if (session) {
        [[self allTasks] addObject:session];
    }
    return session;
}

/**
 *JSON方式获取数据 POST
 *url_path:获取数据的url地址
 *有返回值 类型
 */
- (PPURLSessionTask *)postNetworkRequestURLString:(NSString *)url_path parameters:(id)parameters success:(void (^)(id obj))success fail:(void (^)(NSError *error))fail
{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPSessionManager *manager = [self createAFHTTPSessionManager];
    
     PPURLSessionTask *session=nil;
    
    session = [manager POST:url_path parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
    
    if (session) {
        [[self allTasks] addObject:session];
    }
    
    return session;
}

- (NSMutableArray *)allTasks {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sg_requestTasks == nil) {
            sg_requestTasks = [[NSMutableArray alloc] init];
        }
    });
    
    return sg_requestTasks;
}

- (void)cancelRequestWithURL:(NSString *)url {
    
    if (url == nil) {
        return;
    }
    
    @synchronized(self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(PPURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[PPURLSessionTask class]]
                && [task.currentRequest.URL.absoluteString hasSuffix:url]) {
                [task cancel];
                [[self allTasks] removeObject:task];
                return;
            }
        }];
    };
}

- (void)cancelAllRequest {
    @synchronized(self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(PPURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[PPURLSessionTask class]]) {
                [task cancel];
            }
        }];
        
        [[self allTasks] removeAllObjects];
    };
}

/**
 *  上传图片
 *
 *  @param url        请求url
 *  @param image      要上传的文件流
 *  @param completion 文件上传成功的回调
 *  @param errorBlock 文件上传失败的回调
 *
 *  @return 请求体
 */
- (PPURLSessionTask *)uploadImageWithUrl:(NSString *)url
                              WithParams:(NSDictionary*)params
                                   image:(NSData *)imageData
                                filename:(NSString *)name
                                mimeType:(NSString *)mimetype
                              completion:(requestSuccessBlock)completion
                              errorBlock:(requestFailureBlock)errorBlock
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [self createAFHTTPSessionManager];
     PPURLSessionTask *operation = [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
         NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
         formatter.dateFormat = @"yyyyMMddHHmmss";
         NSString *str = [formatter stringFromDate:[NSDate date]];
         NSString *fileName = [NSString stringWithFormat:@"%@.png",str];
         
         // 上传图片，以文件流的格式
         [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:mimetype];
     } progress:^(NSProgress * _Nonnull uploadProgress) {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
         completion(responseObject);
         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         errorBlock(error);
         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
     }];
    return operation;
}

/**
 *  上传音视频文件
 *
 *  @param url        请求url
 *  @param image      要上传的文件流
 *  @param completion 文件上传成功的回调
 *  @param errorBlock 文件上传失败的回调
 *
 *  @return 请求体
 */
- (PPURLSessionTask *)uploadVedioWithUrl:(NSString *)url
                              WithParams:(NSDictionary*)params
                                   image:(NSData *)vedioData
                                filename:(NSString *)name
                                mimeType:(NSString *)mimetype
                              completion:(requestSuccessBlock)completion
                              errorBlock:(requestFailureBlock)errorBlock
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [self createAFHTTPSessionManager];
    
    PPURLSessionTask *operation = [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.mp4",str];
        [formData appendPartWithFileData:vedioData name:name fileName:fileName mimeType:mimetype];

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completion(responseObject);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
    
    return operation;
}


/**
 *  上传txt文件
 *
 *  @param url        请求url
 *  @param image      要上传的文件流
 *  @param completion 文件上传成功的回调
 *  @param errorBlock 文件上传失败的回调
 *
 *  @return 请求体
 */
- (PPURLSessionTask *)uploadTextWithUrl:(NSString *)url
                              WithParams:(NSDictionary*)params
                                   image:(NSData *)txtData
                                filename:(NSString *)name
                                mimeType:(NSString *)mimetype
                                fileName:(NSString *)fileName
                              completion:(requestSuccessBlock)completion
                              errorBlock:(requestFailureBlock)errorBlock
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [self createAFHTTPSessionManager];
    
    PPURLSessionTask *operation = [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

        [formData appendPartWithFileData:txtData name:name fileName:fileName mimeType:mimetype];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completion(responseObject);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
    
    
    return operation;
}

@end
