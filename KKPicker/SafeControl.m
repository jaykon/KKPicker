//
//  NSArray+SafeControl.m
//  stock
//
//  Created by Jaykon on 14-5-16.
//  Copyright (c) 2014年 Maxicn. All rights reserved.
//

#import "SafeControl.h"
@implementation SafeControl
@end

@implementation NSDictionary(SafeControl)
- (id)safeObjectForKey:(id)aKey
{
    id result = [self objectForKey:aKey];
    if ([result isKindOfClass:[NSNull class]])
    {
        result = nil;
    }
    return result;
}

- (BOOL)safeWriteToPlistWithPath:(NSString*)path
{
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:self];
    NSLog(@"写入DIC文件:%@",path);
    return [data writeToFile:path atomically:YES];
}

+ (instancetype)safeReadFromPlistWithPath:(NSString*)path
{
    NSLog(@"读取DIC文件:%@",path);
    NSData * data = [NSData dataWithContentsOfFile:path];
    return  [NSKeyedUnarchiver unarchiveObjectWithData:data];
}
@end

@implementation NSMutableDictionary(SafeControl)
- (BOOL)safeSetObject:(id)anObject forKey:(id <NSCopying>)aKey
{
    if(!anObject||!aKey){
        return NO;
    }
    [self setObject:anObject forKey:aKey];
    return YES;
}
@end

@implementation NSMutableArray (SafeControl)
-(BOOL)safeAddObject:(id)obj
{
    if(obj!=nil&&[obj isKindOfClass:[NSObject class]]){
        [self addObject:obj];
        return YES;
    }
    return NO;
}

-(BOOL)safeAddObject:(id)obj defalut:(id)defalutValue
{
    if(obj!=nil&&[obj isKindOfClass:[NSObject class]]){
        [self addObject:obj];
        return YES;
    }else if(defalutValue!=nil && [obj isKindOfClass:[NSObject class]]){
        [self addObject:defalutValue];
        return YES;
    }
    return NO;
}

-(BOOL)safeSetObject:(id)obj atIndexedSubscript:(NSUInteger)idx default:(id)defalutValue
{
    if(obj!=nil&&[obj isKindOfClass:[NSObject class]]){
        [self setObject:obj atIndexedSubscript:idx];
        return YES;
    }
    
    if(defalutValue!=nil&&[defalutValue isKindOfClass:[NSObject class]]){
        [self setObject:defalutValue atIndexedSubscript:idx];
    }
    
    return NO;
}

- (BOOL)safeWriteToPlistWithPath:(NSString*)path
{
     NSLog(@"写入Array文件:%@",path);
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:self];
    return [data writeToFile:path atomically:YES];
}

+ (instancetype)safeReadFromPlistWithPath:(NSString*)path
{
     NSLog(@"读取Array文件:%@",path);
    NSData * data = [NSData dataWithContentsOfFile:path];
    return  [NSKeyedUnarchiver unarchiveObjectWithData:data];
}
@end

@implementation NSArray(SafeControl)
- (id)safeObjectForKey:(id)aKey
{
    return nil;
}

-(id)safeObjectAtIndex:(NSUInteger)index
{
    if(index<[self count]){
        return [self objectAtIndex:index];
    }else{
        return nil;
    }
}

@end
