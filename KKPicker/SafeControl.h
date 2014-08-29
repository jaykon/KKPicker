//
//  NSArray+SafeControl.h
//  stock
//
//  Created by Jaykon on 14-5-16.
//  Copyright (c) 2014年 Maxicn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary(SafeControl)
- (id)safeObjectForKey:(id)aKey;
@end

@interface NSMutableArray (SafeControl)
-(BOOL)safeAddObject:(id)obj;
-(BOOL)safeSetObject:(id)obj atIndexedSubscript:(NSUInteger)idx default:(id)defalutValue;
@end

@interface NSArray (SafeControl)
-(id)safeObjectAtIndex:(NSUInteger)index;
@end
