//
//  FlutterDeveloper.h
//  Runner
//
//  Created by Ying Wang on 2020/4/30.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FlutterDeveloper : NSObject
@property NSString *name;
@property int age;

- (instancetype) initWith: (NSString *)name andAge:(int)age;

- (void)say: (NSString *)hi;
@end

NS_ASSUME_NONNULL_END
