//
//  NSArray+SafeControl.m
//  stock
//
//  Created by Jaykon on 14-5-16.
//  Copyright (c) 2014年 Maxicn. All rights reserved.
//

#import "SafeControl.h"
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

@end

@implementation NSArray(SafeControl)
-(id)safeObjectAtIndex:(NSUInteger)index
{
    if(index<[self count]){
        return [self objectAtIndex:index];
    }else{
        return nil;
    }
}

@end
