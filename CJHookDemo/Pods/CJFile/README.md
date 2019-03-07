# 数据库Database
包含CJFMDBFileManager和CommonSqliteUtil,可任选其一来操作数据库。

附：编辑CommonSqliteUtil.podspec的时候别忘了加 `s.libraries = "sqlite3"`

## 前言
增加CJFMDBFileManager此库的目的：在操作数据的时候，我们每次都必须先打开对应的数据库后才能对其进行增删改查等操作。为了避免每次操作的时候，都必须重复性的打开关闭数据库，这里专门写了个操作数据库Manager文件的类来操作数据库。该CJFMDBFileManager类不仅可以方便的实现增删改查等操作，同时还能很方便的操作数据库文件。

## CJFile/CJFileModel
文件模型的基类

## CJFile/CJFMDBFileManager
**一个不仅可以方便的操作数据库文件中的内容（一般为增删改查），还可以方便的操作数据库文件（如创建、删除、重建）的库。**
易忽略的需求：在每次登录(比如切换账号）的时候，我们要操作的数据库可能因为用户的变化而变化。所以我们必须在每次登录的时候重新设置当前库操作的数据是哪个数据库。这里由于我们已经将每次打开关闭数据库的操作集成到了了CJFMDBFileManager中了，所以我们这里当我们每次登录的时候，必须通过CJFMDBFileManager的`createDatabaseInFileRelativePath...`的方法来重新设置其操作的数据库是哪一个,该方法中的`CJFileExistActionType`值根据实际来填写。

附：当你有多个不同的类型数据库要管理的时候，你可以使用不同的CJFMDBFileManager子类来管理不同的数据库。当然如果你要在原来数据库中通过新增表来增加的话也是可以的。


## Example 
0、创建数据库

```
	NSString *directoryRelativePath = [CJFileManager getLocalDirectoryPathType:CJLocalPathTypeRelative
                                                            bySubDirectoryPath:@"DB/Account"
                                                         inSearchPathDirectory:NSDocumentDirectory
                                                               createIfNoExist:YES];
    NSString *fileRelativePath = [directoryRelativePath stringByAppendingPathComponent:databaseName];
    
	NSArray *createTableSqls = [self allCreateTableSqls];
    [[FirstFMDBFileManager sharedInstance] createDatabaseInFileRelativePath:fileRelativePath
                                                          byCreateTableSqls:createTableSqls
                                                            ifExistDoAction:CJFileExistActionRerecertIt];
```


1、插入记录

``` 
+ (BOOL)insertAccountInfos:(NSArray<AccountInfo *> *)infos {
    NSMutableArray *sqls = [[NSMutableArray alloc] init];
    for (AccountInfo *info in infos) {
        NSString *sql = [AccountTableSQL sqlForInsertInfo:info];
        [sqls addObject:sql];
    }
    
    return [[FirstFMDBFileManager sharedInstance] cjExecuteUpdate:sqls useTransaction:YES];
}
``` 

2、删除

``` 
+ (BOOL)removeAccountInfoWhereName:(NSString *)name {
    NSString *sql = [AccountTableSQL sqlForRemoveInfoWhereName:name];
    return [[FirstFMDBFileManager sharedInstance] cjExecuteUpdate:@[sql]];
}
``` 

3、修改

``` 
+ (BOOL)updateAccountInfoExceptUID:(AccountInfo *)info whereUID:(NSString *)uid {
    NSString *sql = [AccountTableSQL sqlForUpdateInfoExceptUID:info whereUID:uid];
    return [[FirstFMDBFileManager sharedInstance] cjExecuteUpdate:@[sql]];
}
``` 

4、查找querey

``` 
+ (NSDictionary *)selectAccountInfoWhereUID:(NSString *)uid {
    NSString *sql = [AccountTableSQL sqlForSelectInfoWhereUID:uid];
    
    NSArray *result = [[FirstFMDBFileManager sharedInstance] query:sql];
    return result.count > 0 ? result[0] : nil;
}
``` 


**More usage reference test case.**

## Attention

Does not support model collections, such as NSArray&lt;User&gt;* users;

## Author

[李xx](http://)

## License

MIT



