//
//  FlutterDeveloper.m
//  Runner
//
//  Created by Ying Wang on 2020/4/30.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

#import "FlutterDeveloper.h"

@implementation FlutterDeveloper
- (instancetype) initWith: (NSString *)name andAge:(int)age{
    if (self = [super init]) {
        self->_name = name;
        self->_age = age;
    }
    
    return self;
}

- (void)say: (NSString *)hi{
    NSLog(@"%@, %d years old. flghting!", self->_name, self->_age);
}
@end
