//
//  ObjectArchive.m
//  voiceSpeaker
//
//  Created by 金玉衡 on 16/8/24.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "ObjectArchive.h"

@implementation ObjectArchive


- (instancetype)initWithName: (NSString *)name  Age:(NSString *)age Career:(NSString *)career
{
    self = [super init];
    if(self)
    {
        _ObjectName = name;
        _ObjectAge = age;
        _ObjectCareer = career;
    }
    
    return self;
}


- (id)copyWithZone:(nullable NSZone *)zone
{
    ObjectArchive *objectCopy = [[[self class] allocWithZone:zone] init];
    objectCopy.ObjectName = [_ObjectName copy];
    objectCopy.ObjectAge = [_ObjectAge copy];
    objectCopy.ObjectCareer = [_ObjectCareer copy];
    
    return objectCopy;
}


- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder // NS_DESIGNATED_INITIALIZER
{
    self = [super init];
    if(self)
    {
        _ObjectName = [aDecoder decodeObjectForKey:@"Name"];
        _ObjectAge = [aDecoder decodeObjectForKey:@"Age"];
        _ObjectCareer = [aDecoder decodeObjectForKey:@"Career"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_ObjectName forKey:@"Name"];
    [aCoder encodeObject:_ObjectAge forKey:@"Age"];
    [aCoder encodeObject:_ObjectCareer forKey:@"Career"];
}



@end
