//
//  NSArray+SafeControl.h
//  stock
//
//  Created by Jaykon on 14-5-16.
//  Copyright (c) 2014年 Maxicn. All rights reserved.
//

#import <Foundation/Foundation.h>

 //如果_string_==nil时，返回@""
#define SAFE_NIL_STRING(_string_) (_string_==nil?@"":_string_)

//如果 _obj_ 不是NSDictionary或者不存在_k_，返回nil
#define SAFE_VALUE_FOR_KEY(_obj_,_k_) ([_obj_ isKindOfClass:[NSDictionary class]]?[_obj_ safeObjectForKey:_k_]:nil)

//如果 _obj_ 不是 NSMutableDictionary或者_value_不是NSObject，不赋值
#define SAFE_SET_VALUE_OF_KEY(_obj_,_key_,_value_) ([_obj_ isKindOfClass:[NSMutableDictionary class]] && [_value_ isKindOfClass:[NSObject class]]?[_obj_ setValue:_value_ forKey:_key_]:nil)

//如果 _obj_ 不是 NSArray 或者_index_越界，返回nil
#define SAFE_VALUE_AT_INDEX(_obj_,_index_) ([_obj_ isKindOfClass:[NSArray class]]?[_obj_ safeObjectAtIndex:_index_]:nil)

//如果 _obj_ 不是 NSMutableArray 或者 _value_ 不是NSObject，则使用_default_赋值，如果_default_为nil,则不赋值,返回NO
#define SAFE_SET_VALUE_AT_INDEX(_obj_,_index_,_value_,_default_) ([_obj_ isKindOfClass:[NSMutableArray class]]?[_obj_ safeSetObject:_value_ atIndexedSubscript:_index_ default:_default_]:NO)

//如果 _obj_ 不是 NSMutableArray 或者 _value_ 不是NSObject，则使用_default_赋值，如果_default_为nil,则不赋值,返回NO
#define SAFE_ADD_VALUE(_obj_,_value_,_default_) ([_obj_ isKindOfClass:[NSMutableArray class]]?[_obj_ safeAddObject:_value_ defalut:_default_]:NO)

//安全除法，避免除数或被除数为零导致崩溃
#define SAFE_DIV(_a_,_b_) ((_a_==0||_b_==0)?0:_a_/_b_)

@interface SafeControl : NSObject {
}
@end

@interface NSDictionary(SafeControl)
- (id)safeObjectForKey:(id)aKey;
- (BOOL)safeWriteToPlistWithPath:(NSString*)path;
+ (instancetype)safeReadFromPlistWithPath:(NSString*)path;
@end

@interface NSMutableDictionary(SafeControl)
- (BOOL)safeSetObject:(id)anObject forKey:(id <NSCopying>)aKey;
@end

@interface NSMutableArray (SafeControl)
- (BOOL)safeWriteToPlistWithPath:(NSString*)path;
+ (instancetype)safeReadFromPlistWithPath:(NSString*)path;
-(BOOL)safeAddObject:(id)obj;
-(BOOL)safeAddObject:(id)obj defalut:(id)defalutValue;
-(BOOL)safeSetObject:(id)obj atIndexedSubscript:(NSUInteger)idx default:(id)defalutValue;
@end

@interface NSArray (SafeControl)
- (id)safeObjectForKey:(id)aKey;
- (id)safeObjectAtIndex:(NSUInteger)index;
@end
