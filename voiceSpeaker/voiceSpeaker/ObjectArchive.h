//
//  ObjectArchive.h
//  voiceSpeaker
//
//  Created by 金玉衡 on 16/8/24.
//  Copyright © 2016年 mit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectArchive : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *ObjectName;
@property (nonatomic, strong) NSString *ObjectAge;
@property (nonatomic, strong) NSString *ObjectCareer;

- (instancetype)initWithName: (NSString *)name  Age:(NSString *)age Career:(NSString *)career;

@end
