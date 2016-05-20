//
//  NNATreeNode.m
//  NNAMultilevelTree
//
//  Created by NNA on 16/5/17.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import "NNATreeNode.h"

@interface NNATreeNode () {
    BOOL _expanded;
}

@property (nonatomic) BOOL expanded;

@end

@implementation NNATreeNode

- (instancetype)initWithName:(NSString *)name children:(NSArray *)children {
    self = [super init];
    if (self) {
        self.children = [NSArray arrayWithArray:children];
        self.name = name;
        [children enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[NNATreeNode class]]) {
                NNATreeNode *node = (NNATreeNode *)obj;
                node.parent = self;
            }
        }];
    }
    return self;
}

+ (instancetype)dataObjectWithName:(NSString *)name children:(NSArray *)children {
    return [[self alloc] initWithName:name children:children];
}

- (NSInteger)depth {
    _depth = 0;
    [self getDepthWithNode:self];
    return _depth;
}

- (void)getDepthWithNode:(NNATreeNode *)node {
    if (node.parent) {
        _depth++;
        [self getDepthWithNode:node.parent];
    }
}

- (void)addChild:(id)child {
    NSMutableArray *children = [self.children mutableCopy];
    [children insertObject:child atIndex:children.count-1];
    self.children = [children copy];
}

- (void)removeChild:(id)child {
    NSMutableArray *children = [self.children mutableCopy];
    [children removeObject:child];
    self.children = [children copy];
}


- (BOOL)expanded {
    return _expanded;
}

- (void)setExpanded:(BOOL)expanded {
    _expanded = expanded;
}


@end
