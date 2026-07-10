# CJNetwork

免费api：[https://api.you-fire.com/youapi/api/index](https://api.you-fire.com/youapi/api/index)

* [免费api-网易新闻](https://api.you-fire.com/youapi/api/detail/2332fc38958311e986e700163e0e0ef0)



## 一、功能介绍(Feature introduce)

二次封装AFNetworking，增加实现

* 1、在接口请求中加密、解密
* 2、资源文件的上传(比如上传一张或多张图片等)
* 3、对请求接口进行缓存数据的功能
* 4、按指定格式输出请求信息(比如①你要在控制台查看请求信息、②当你脱离调试模式时候，你希望通过一个alert弹出显示你的log)

#### 包含组件
>
- CJNetwork/CJNetworkCommon：AFN请求过程中需要的几个公共方法(包含请求前获取缓存、请求后成功与失败操作)
- CJNetwork/AFNetworkingSerializerEncrypt：AFN的请求方法(加解密方法写在Method方法中)
- CJNetwork/AFNetworkingMethodEncrypt：AFN的请求方法(加解密方法写在Method方法中)
- CJNetwork/AFNetworkingUploadComponent：AFN的上传请求方法
- CJNetwork/CJNetworkClient：网络请求的管理类，其他NetworkClient可通过本CJNetworkClient继承，也可自己再实现
>
- CJNetwork/CJRequestUtil：原生(非AFN)的请求
>
- CJNetwork/CJCacheManager：自己实现的非第三方的缓存机制

#### Screenshots
> ![CJNetwork](./Screenshots/CJNetwork.jpg "CJNetwork")





## 二、最少代码的实现自己的网络库 CJNetworkClient

`CJNetworkClient`类是依赖基于`AFNetworking`进行二次封装的请求接口类`AFHTTPSessionManager+CJSerializerEncrypt.h`来实现的网络库。

#### 1、实现方式

子类直接继承`CJNetworkClient`，并进行如下的初始化后，即可直接使用接口

#### 2、代码示例

```objective-c
@interface TestNetworkClient : CJNetworkClient

+ (TestNetworkClient *)sharedInstance;

@end



@implementation TestNetworkClient

+ (TestNetworkClient *)sharedInstance {
    static TestNetworkClient *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        AFHTTPSessionManager *cleanHTTPSessionManager = [TestHTTPSessionManager sharedInstance];
        TestHTTPSessionManager *cryptHTTPSessionManager = [TestHTTPSessionManager sharedInstance];
        [self setupCleanHTTPSessionManager:cleanHTTPSessionManager cryptHTTPSessionManager:cryptHTTPSessionManager];
        
        NSString *simulateDomain = @"http://localhost/CJDemoDataSimulationDemo";
        [self setupSimulateDomain:simulateDomain];
    }
    return self;
}
```







```objective-c
@interface TestNetworkClient : CJNetworkClient

+ (TestNetworkClient *)sharedInstance;

@end



@implementation TestNetworkClient

+ (TestNetworkClient *)sharedInstance {
    static TestNetworkClient *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        AFHTTPSessionManager *cleanHTTPSessionManager = [TestHTTPSessionManager sharedInstance];
        TestHTTPSessionManager *cryptHTTPSessionManager = [TestHTTPSessionManager sharedInstance];
        [self setupCleanHTTPSessionManager:cleanHTTPSessionManager cryptHTTPSessionManager:cryptHTTPSessionManager];
        
        //TestEnvironmentManager *environmentManager = [TestEnvironmentManager sharedInstance];
        [self setupCompleteFullUrlBlock:^NSString *(NSString *apiSuffix) {
            NSString *baseUrl = @"http://xxx.xxx.xxx";
            NSString *mainUrl = [[baseUrl stringByAppendingString:apiSuffix] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            return mainUrl;
            //return [environmentManager completeUrlWithApiSuffix:apiSuffix];
        } completeAllParamsBlock:^NSDictionary *(NSDictionary *customParams) {
            NSMutableDictionary *allParams = [NSMutableDictionary dictionaryWithDictionary:customParams];
            NSDictionary *commonParams = @{@"phone": @"iPhone6"};
            [allParams addEntriesFromDictionary:commonParams];
            return allParams;
            //return [environmentManager completeParamsWithCustomParams:customParams];
        }];
        
        [self setupResponseConvertBlock:^CJResponseModel *(id responseObject, BOOL isCacheData) {
            NSDictionary *responseDictionary = responseObject;
            CJResponseModel *responseModel = [[CJResponseModel alloc] init];
            responseModel.statusCode = [responseDictionary[@"status"] integerValue];
            responseModel.message = responseDictionary[@"message"];
            responseModel.result = responseDictionary[@"result"];
            responseModel.isCacheData = isCacheData;

            return responseModel;
            
        } checkIsCommonBlock:^BOOL(CJResponseModel *responseModel) {
            return NO;
            
        } getRequestFailureMessageBlock:^NSString *(NSError *error) {
            return @"网络错误";
        }];
        
        NSString *simulateDomain = @"http://localhost/CJDemoDataSimulationDemo";
        [self setupSimulateDomain:simulateDomain];
    }
    return self;
}

```



如果你想自己从头实现CJNetworkClient，那么您可以调用`#import "AFHTTPSessionManager+CJSerializerEncrypt.h"`,只要再请求的时候调用里面的方法即可。



## 三、基于`AFNetworking`进行二次封装的请求接口类`AFHTTPSessionManager+CJSerializerEncrypt`

###### (1)、功能：

在接口请求中加密、解密、缓存、log输出。

###### (2)、场景：

我们平时的接口，为保证数据安全，经常需要加密请求、解密返回数据。原始的AFNetworking并未提供相关功能。所这里我们对AFNetworking进行一次二次封装，方便以后使用。

###### (3)、How to Use

所提供的接口有两个，分别为GET和POST，根据需要调用相应的即可。

```objective-c
/**
 *  发起GET请求
 *
 *  @param Url              Url
 *  @param allParams        allParams
 *  @param settingModel     settingModel
 *  @param success          请求成功的回调success
 *  @param failure          请求失败的回调failure
 *
 *  @return NSURLSessionDataTask
 */
- (nullable NSURLSessionDataTask *)cj_getUrl:(nullable NSString *)Url
                                      params:(nullable NSDictionary *)allParams
                                settingModel:(CJRequestSettingModel *)settingModel
                                     success:(nullable void (^)(id _Nullable responseObject))success
                                     failure:(void (^)(NSString *errorMessage))failure;

/**
 *  发起POST请求(是否加密等都通过Serializer处理)
 *
 *  @param Url              Url
 *  @param allParams        allParams
 *  @param settingModel     settingModel
 *  @param success          请求成功的回调success
 *  @param failure          请求失败的回调failure
 *
 *  @return NSURLSessionDataTask
 */
- (nullable NSURLSessionDataTask *)cj_postUrl:(nullable NSString *)Url
                                       params:(nullable id)allParams
                                 settingModel:(CJRequestSettingModel *)settingModel
                                      success:(nullable void (^)(id _Nullable responseObject))success
                                      failure:(void (^)(NSString *errorMessage))failure;
```



#### 2、文件上传：AFHTTPSessionManager+CJUploadFile

资源文件的上传(比如上传一张或多张图片等)。这里提供两个接口。

> ①一个是只是上传文件，不对上传过程中的各个时刻信息的进行保存;
> 
> ②一个是除了上传文件，还对上传过程中的各个时刻信息的进行保存(momentInfo：上传请求的各个时刻信息）。这个在需要显示进度的时候常会需要用到。

两个接口分别如下：

```objective-c
/**
 *  上传文件的请求方法：除了上传文件，还对上传过程中的各个时刻信息的进行保存(momentInfo：上传请求的各个时刻信息）
 *  @brief 回调中momentInfoOwner其实就是传进来的fileValueOwner
 *
 *  @param Url              Url
 *  @param params           除fileKey之外的参数
 *  @param fileKey          fileKey
 *  @param fileValueOwner   要操作的上传模型组uploadFileModels的拥有者，fileValueOwner的uploadFileModels有值，而uploadFileModels中的operation和momentInfo是在请求过程中生成的（在执行过程中上传请求的各个时刻信息(正在上传、上传完成)的保存位置会被保存到此拥有者下）
 *  @param uploadMomentInfoChangeBlock          请求成功(上传成功、上传失败)、请求失败以及请求执行过程中的回调，即整个上传过程中各个时刻信息变化的回调(回调中momentInfoOwner其实就是传进来的fileValueOwner，请求成功、请求失败的返回信息都放在其responseModel属性里，且responseModel值在请求成功时候为在getUploadMomentInfoFromResopnseBlock中设置的，而请求失败的responseModel值为nil)
 *  @param getUploadMomentInfoFromResopnseBlock 上传成功后从response中获取该时刻信息的方法(正在上传、以及上传失败的以用默认方法)
 *
 *  @return 上传文件的请求
 */
- (nullable NSURLSessionDataTask *)cj_postUploadUrl:(nullable NSString *)Url
                                             params:(nullable id)params
                                            fileKey:(nullable NSString *)fileKey
                                     fileValueOwner:(nullable CJUploadFileModelsOwner *)fileValueOwner
                        uploadMomentInfoChangeBlock:(nullable void(^)(CJUploadFileModelsOwner * _Nonnull momentInfoOwner))uploadMomentInfoChangeBlock
               getUploadMomentInfoFromResopnseBlock:(nullable CJUploadMomentInfo * _Nonnull (^)(id _Nonnull responseObject))getUploadMomentInfoFromResopnseBlock;

/**
 *  上传文件的请求方法：只是上传文件，不对上传过程中的各个时刻信息的进行保存
 *
 *  @param Url              Url
 *  @param parameters       parameters
 *  @param fileKey          文件参数：有些人会用file,有些人用upfile
 *  @param uploadFileModels 文件数据：要上传的数据组uploadFileModels
 *  @param uploadProgress   uploadProgress
 *  @param success          上传成功执行的回调
 *  @param failure          上传失败执行的回调
 *
 *  @return 上传文件的请求
 */
- (nullable NSURLSessionDataTask *)cj_postUploadUrl:(nullable NSString *)Url
                                             params:(nullable id)parameters
                                            fileKey:(nullable NSString *)fileKey
                                          fileValue:(nullable NSArray<CJUploadFileModel *> *)uploadFileModels
                                           progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                            success:(nullable void (^)(NSURLSessionDataTask * _Nonnull task, id _Nonnull responseObject))success
                                            failure:(nullable void (^)(NSURLSessionDataTask *_Nonnull task, NSError *_Nonnull error))failure;
```

同时，这里还为UIView增加类目，实现view直接调用上传接口的功能，该类目名称为`UIView+AFNetworkingUpload`。



#### 4、断点续传
###### (1)、关于断点续传原理：
首先,如果想要进行断点续传，那么需要简单了解一下断点续传的工作机制，在HTTP请求头中，有一个Range的关键字，通过这个关键字可以告诉服务器返回哪些数据给我。比如:

	bytes=500-999		表示从第500字节-第999字节
	bytes=500- 		表示从第500字节往后的所有字节

然后我们再根据服务器返回的数据，将得到的data数据拼接到文件后面,就可以实现断点续传了。

1、AFNetworking3.0+ 实现文件断点下载的方法：直接调用以下方法即可

```
- (NSURLSessionDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request
                                             progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                                          destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                                    completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler
```

2、[AFNetworking2.0+ 实现文件断点下载的方法](https://github.com/iTofu/LCDownloadManager)   

3、使用NSURLSessionDataTask可以很轻松实现**断点续传**，可是有个致命的缺点就是无法进行**后台下载**，一点应用程序进入了后台，便会停止下载。所以无法满足我们的需求。而NSURLSessionDownloadTask是唯一可以实现后台下载的类，所以我们只能从这个类进行下手了。

当使用`NSURLSessionDownloadTask`进行下载的时候，系统会在cache文件夹下创建一个下载的路径，路径下会有一个以"CFNetworking"打头的.tmp文件(以下简称"下载文件"防止混淆),这个就是我们正在下载中的文件。而当我们调用了cancelByProducingResumeData:方法后，会得到一个data文件,通过String格式化后，发现是一个XML文件，里面包含了关于.tmp文件的一些关键点的描述,包括"Range","key","下载文件的路径"等等.而原本存在于download文件下的下载文件，则被移动到了系统tmp文件夹目录下.而当我们再次进行resume操作的时候，下载文件则又被移回到了download文件夹下。



## 版本介绍/更新记录

* V1.5.0 2025-02-09

> 1. 重构CJNetworkClient，增加回调方式可以使用原始的 `CJNetworkRequestOriginCallbackProtocal` ( CJSuccessRequestInfo * **_Nullable** successRequestInfo, CJFailureRequestInfo * **_Nullable** failureRequestInfo )；也可以使用 `CJNetworkRequestResponseCallbackProtocal`( CJResponeFailureType failureType, CJResponseModel *responseModel )

* V0.6.4 2018-12-12

> 1. 完善CJNetworkClient，增加回调只用一个的情况，并优化接口分类；


* V0.6.1 2018-11-21

> 1. 为AFNetworking增加dns处理时候的拦截及处理完之后的并发数控制，并发数的控制放在Manager中，而非每个请求的settingModel中；
> 2. 将并发数的控制和Ulr的拦截独立抽取到Manager的一个分类中，方便问题的调查和以后方案的替换；
> 3. 增加记录并发数个数的信号量，确保所记录的并发数个数的正确性。
> 4. 增加一个独立测试并发数的TestConcurrenModel和一个测试并发数和拦截的TestConcurrenceManager，用于在测试网络前，测试所添加的并发数控制方法是否正确的问题。

* V0.6.0 2018-11-15

> 1. 通过不同的加密方式，实现不同的加密接口，并分类；
> 2. 优化每个请求的参数设置，避免接口太长，同时提高扩展性；
> 3. 抽取每个请求的结果回调处理，为加入缓存处理预备；
> 4. 导入`YYCache`以方便的使用缓存以及获取整个模型，而非只有模型的数据。并实现`CJNetworkCacheManager`缓存类。
> 5. 增加缓存策略CJNetworkCacheStrategy，支持以下几种实现。
> 
```
///缓存策略
typedef NS_ENUM(NSUInteger, CJNetworkCacheStrategy) {
    CJNetworkCacheStrategyNoneCache,            /**< 成功/失败的时候，都不使用缓存，直接使用网络数据 */
    CJNetworkCacheStrategyEndWithCacheIfExist,  /**< 成功/失败的时候，如果有缓存，则不用再去取网络实际值 */
    CJNetworkCacheStrategyUseCacheToTransition, /**< 成功/失败的时候，如果有缓存，使用缓存过渡来快速显示，最终以网络数据显示 */
};
```
以及对每个请求结果根据对应的缓存策略，进行结果输出与显示；


* V0.5.0 2018-09-26
> 1. 修改每个请求的回调结果为Model，以提供更全面的信息；

* V0.4.2 2018-09-13
> 增加打印加密后的body的值；

* V0.4.1 2018-09-11
> 修复0.4.0版本中加密算法不会调用的问题；
> 
> 增加一个额外的post方法

* V0.4.0 2018-08-14
> 请求内部方法改为直接调用AFNetworking方法，使得默认回调处于主线程中。

* V0.3.1 2018-08-13
> 增加cjNetworkLog代码，用于有时候调试时候可直接弹窗显示，接口请求信息。不过考虑需要额外开辟内存保存cjNetworkLog，所以该信息默认注释了，需要时候，自己去CJNetworkLogUtil中打开即可。

* V0.3.0 2018-07-06
> 优化资源文件上传接口，使其更易理解，参数更少。


## Author Or Contact
* [邮箱：studyroad@qq.com](studyroad@qq.com)
* [简书：https://www.jianshu.com/u/498d9e6a26e1](https://www.jianshu.com/u/498d9e6a26e1)
* [码云：https://gitee.com/dvlproad](https://gitee.com/dvlproad)


## 结束语
欢迎Stat、Follow、Fork、Pull Request！
