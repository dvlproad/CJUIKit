# CJNetwork
## 一、功能介绍(Feature introduce)
二次封装AFNetworking，增加实现

* 1、在接口请求中加密、解密
* 2、资源文件的上传(比如上传一张或多张图片等)
* 3、对请求接口进行缓存数据的功能
* 4、按指定格式输出请求信息(比如①你要在控制台查看请求信息、②当你脱离调试模式时候，你希望通过一个alert弹出显示你的log)

#### Screenshots
> ![CJNetwork](./Screenshots/CJNetwork.jpg "CJNetwork")

#### 1、加解密：AFHTTPSessionManager+CJEncrypt
###### (1)、功能：
在接口请求中加密、解密。

###### (2)、场景：
我们平时的接口，为保证数据安全，经常需要加密请求、解密返回数据。原始的AFNetworking并未提供相关功能。所这里我们对AFNetworking进行一次二次封装，方便以后使用。


###### (3)、How to Use
所提供的接口有两个，分别为GET和POST，根据需要调用相应的即可。

```
/**
 *  发起GET请求
 *
 *  @param Url              Url
 *  @param params           params
 *  @param uploadProgress   uploadProgress
 *  @param success          请求成功的回调success
 *  @param failure          请求失败的回调failure
 *
 *  @return NSURLSessionDataTask
 */
- (nullable NSURLSessionDataTask *)cj_getUrl:(nullable NSString *)Url
                                      params:(nullable NSDictionary *)params
                                    progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                     success:(nullable void (^)(NSDictionary *_Nullable responseObject))success
                                     failure:(nullable void (^)(NSError * _Nullable error))failure;


/**
 *  发起POST请求
 *
 *  @param Url              Url
 *  @param params           params
 *  @param encrypt          是否加密
 *  @param encryptBlock     对请求的参数requestParmas加密的方法
 *  @param decryptBlock     对请求得到的responseString解密的方法
 *  @param uploadProgress   uploadProgress
 *  @param success          请求成功的回调success
 *  @param failure          请求失败的回调failure
 *
 *  @return NSURLSessionDataTask
 */
- (nullable NSURLSessionDataTask *)cj_postUrl:(nullable NSString *)Url
                                       params:(nullable id)params
                                      encrypt:(BOOL)encrypt
                                 encryptBlock:(nullable NSData * _Nullable (^)(NSDictionary * _Nullable requestParmas))encryptBlock
                                 decryptBlock:(nullable NSDictionary * _Nullable (^)(NSString * _Nullable responseString))decryptBlock
                                     progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                      success:(nullable void (^)(NSDictionary *_Nullable responseObject))success
                                      failure:(nullable void (^)(NSError * _Nullable error))failure;
```


#### 2、文件上传：AFHTTPSessionManager+CJUploadFile
资源文件的上传(比如上传一张或多张图片等)。这里提供两个接口。

> ①一个是只是上传文件，不对上传过程中的各个时刻信息的进行保存;
> 
> ②一个是除了上传文件，还对上传过程中的各个时刻信息的进行保存(momentInfo：上传请求的各个时刻信息）。这个在需要显示进度的时候常会需要用到。

两个接口分别如下：

```
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


#### 3、接口数据缓存：AFHTTPSessionManager+CJCacheRequest
对请求接口进行缓存数据的功能。这个有别于NSURLCache，更偏向SDWebImage的图片存储原理。

```
/**
 *  发起POST请求
 *
 *  @param Url              Url
 *  @param params           params
 *  @param shouldCache      需要缓存网络数据的情况(如果有缓存，则即代表可以从缓存中获取数据)
 *  @param uploadProgress   uploadProgress
 *  @param success          请求成功的回调success
 *  @param failure          请求失败的回调failure
 *
 *  return NSURLSessionDataTask
 */
- (nullable NSURLSessionDataTask *)cj_postUrl:(nullable NSString *)Url
                                       params:(nullable id)params
                                  shouldCache:(BOOL)shouldCache
                                     progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                      success:(nullable void (^)(NSDictionary *_Nullable responseObject, BOOL isCacheData))success
                                      failure:(nullable void (^)(NSError * _Nullable error))failure;

#pragma mark - CJCacheEncrypt
/**
 *  发起POST请求
 *
 *  @param Url              Url
 *  @param params           params
 *  @param shouldCache      需要缓存网络数据的情况(如果有缓存，则即代表可以从缓存中获取数据)
 *  @param encrypt          是否加密
 *  @param encryptBlock     对请求的参数requestParmas加密的方法
 *  @param decryptBlock     对请求得到的responseString解密的方法
 *  @param uploadProgress   uploadProgress
 *  @param success          请求成功的回调success
 *  @param failure          请求失败的回调failure
 *
 *  return NSURLSessionDataTask
 */
- (nullable NSURLSessionDataTask *)cj_postUrl:(nullable NSString *)Url
                                       params:(nullable id)params
                                  shouldCache:(BOOL)shouldCache
                                      encrypt:(BOOL)encrypt
                                 encryptBlock:(nullable NSData * _Nullable (^)(NSDictionary * _Nullable requestParmas))encryptBlock
                                 decryptBlock:(nullable NSDictionary * _Nullable (^)(NSString * _Nullable responseString))decryptBlock
                                     progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                      success:(nullable void (^)(NSDictionary *_Nullable responseObject, BOOL isCacheData))success
                                      failure:(nullable void (^)(NSError * _Nullable error))failure;
```

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
* V0.4.2 2018-09-13
> 增加打印加密后的body的值

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
