# CJNetwork
AFN基类
替换掉了CommonAFNUtil的使用

## CJNetworkMonitor
网络状态监听类

注：使用`AFNetworkReachabilityManager`一定要记得调用`startMonitoring`，如下。否则容易造成网络判断出错。同时为了频繁的调用`startMonitoring`，所以自然想到只在程序启动的时候调用。另外为了在之后能够随时获取当前的网络状态，我们故而封装了个CJNetworkMonitor，通过在启动的时候`[[CJNetworkMonitor sharedInstance] startNetworkMonitoring];`开启网络状况监听。之后需要的时候，随时通过它的networkStatus或者networkSuccess来获取他的状态。

```
AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
[reachabilityManager startMonitoring];
```

##### How to Use
我们在`AppDelegate`中调用`[[CJNetworkMonitor sharedInstance] startNetworkMonitoring];`开启网络状况监听。则之后当网络状态改变的时候，AFNetworking会自动发送AFNetworkingReachabilityDidChangeNotification通知，我们则只需要对那些需要处理网络状态改变的控制器里，添加通知网络状态改变通知的捕获就行，如
`[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityDidChangeNotification:) name:AFNetworkingReachabilityDidChangeNotification object:nil];`

## AFNetworking一些API介绍
必知点：AFNetworking框架默认请求类型`requestSerializer`和响应类型`responseSerializer`都是JSON格式的，即默认请求类型为`AFJSONRequestSerializer`，默认相应类型为`AFJSONResponseSerializer`。

#### 1、关于请求类型及请求参数的书写
所以在进行请求时候，我们必须根据自己请求的参数类型parameters，对AFNetworking的请求类型进行设置。主要设置为：

1. 如果请求参数是字典类型`NSDictionary`，则请求类型应设置`AFHTTPRequestSerializer`。
2. 如果请求参数是JSON类型，则请求类型应设置`AFJSONRequestSerializer `。

因为设置的类型不同，AFNetworking会根据设置的类型执行该类型下面对应的`- (NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request withParameters:(id)parameters error:(NSError *__autoreleasing *)error`方法。

其中

AFHTTPRequestSerializer对参数会有如下第496行的处理`query = AFQueryStringFromParameters(parameters);`该处理为将字典类型转为一串请求的字符串格式。

AFJSONRequestSerializer对参数的处理主要为第1260行的
`[mutableRequest setHTTPBody:[NSJSONSerialization dataWithJSONObject:parameters options:self.writingOptions error:error]];`


#### 2、关于响应类型及响应response
响应的时候，`AFURLSessionManager`其会调用`AFURLSessionManagerTaskDelegate`协议，执行该协议里第292的`responseObject = [manager.responseSerializer responseObjectForResponse:task.response data:data error:&serializationError];`可以看出这里会根据我们设置的不同响应类型，调用该响应类型下的

```
- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
```

所以，这里我们衍生出一个继承自AFJSONResponseSerializer的**CJJSONResponseSerializer**的新响应类型，重写该方法，用来处理服务端返回的JSON不是标准的json格式的问题，即主要处理AFNetworking 3840的错误。


## 断点续传
#### 1、关于断点续传原理：
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

##### NSJSONSerialization
```
NSData *data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *responseObject_dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
```
//NSJSONReadingMutableContainers的作用: http://blog.csdn.net/chenyong05314/article/details/45691041
     NSJSONReadingMutableContainers：返回可变容器，NSMutableDictionary或NSMutableArray。
     NSJSONReadingMutableLeaves：返回的JSON对象中字符串的值为NSMutableString
     NSJSONReadingAllowFragments：允许JSON字符串最外层既不是NSArray也不是NSDictionary，但必须是有效的JSON Fragment。例如使用这个选项可以解析 @“123” 这样的字符串。


#### Screenshots
![Example](./Screenshots/Demo.gif "Demo")
![Example](./Screenshots/Demo.png "Demo")

CommonAFNInstance需

```
#import "NetworkManager.h"
#import "CommonDataCacheManager.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <AFNetworking.h>
```

CommonDataCacheManager需

```
#import "NSDictionary+Convert.h"
#import "NSData+Convert.h"
#import "NSString+MD5.h"
```

##基础知识了解
1、单例：dispatch_once （使用dispatch_once时，不用使用@synchronized）
单例是一种用于实现单例的数学概念，即将类的实例化限制成仅一个对象的设计模式。
或者我的理解是：单例是一种类，该类只能实例化一个对象。

实现单例模式的函数就是void dispatch_once( dispatch_once_t *predicate, dispatch_block_t block);
该函数接收一个dispatch_once用于检查该代码块是否已经被调度的谓词（是一个长整型，实际上作为BOOL使用）。它还接收一个希望在应用的生命周期内仅被调度一次的代码块，对于本例就用于shared实例的实例化。
dispatch_once不仅意味着代码仅会被运行一次，而且还是线程安全的，这就意味着你不需要使用诸如@synchronized之类的来防止使用多个线程或者队列时不同步的问题。
Apple的GCD Documentation证实了这一点:
如果被多个线程调用，该函数会同步等等直至代码块完成。

示例：在整个应用中访问某个类的共享实例
```
+ (NetworkManager *)sharedInstance
{
    static NetworkManager *sharedManager;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[NetworkManager alloc] init];
    });

    return sharedManager;
}
```
就这些，你现在在应用中就有一个共享的实例，该实例只会被创建一次。
下次你任何时候访问共享实例，需要做的仅是：NetworkManager *networkManager = [NetworkManager sharedInstance];

2、线程的同步执行@synchronized
为了防止多个线程同时执行同一个代码块，OC提供了@synchronized()指令。使用@synchronized()指令可以锁住在线程中执行的某一个代码块。存在被保护（即被锁住）的代码块的其他线程，将被阻塞，这也就意味着，他们将在@synchronized()代码块的最后一条语句执行结束后才能继续执行。
@synchronized()指令的唯一参数可以使用任何OC对象，包括self。这个对象就是我们所谓的信号量。

