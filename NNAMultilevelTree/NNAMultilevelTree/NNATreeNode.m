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


- (NNATreeNode *)makeTreeNode:(NNATreeNode *)node children:(NSDictionary *)children depth:(NSUInteger)depth {
    node.depth = depth;
    node.expanded = NO;
    node.nodeId = [NSString stringWithFormat:@"%@", [children objectForKey:@"Id"]];
    node.nodeName = [NSString stringWithFormat:@"%@", [children objectForKey:@"Name"]];
    if (children == nil || [children objectForKey:@"children"] == nil) {
        return node;
    }
    NSArray *childrenArray = [children objectForKey:@"children"];
    if (children.count == 0) {
        return node;
    }
    depth++;
    node.children = @[].mutableCopy;

    [childrenArray enumerateObjectsUsingBlock:^(NSDictionary *childrenDic, NSUInteger idx, BOOL *stop) {
        NNATreeNode *tempNode = [[NNATreeNode alloc] init];
        tempNode.parent = node;
        [node addChild:[self makeTreeNode:tempNode children:childrenDic depth:depth]];
    }];
    return node;
}

+ (NNATreeNode *)dataWithTreeNode:(NNATreeNode *)node children:(NSDictionary *)children depth:(NSUInteger)depth {
    return [[self alloc] makeTreeNode:node children:children depth:depth];
}

- (NSInteger)depth {
    return _depth;
}

- (void)addChild:(NNATreeNode *)child {
    NSMutableArray *children = [self.children mutableCopy];
    [children addObject:child];
    self.children = [children copy];
}

- (void)removeChild:(NNATreeNode *)child {
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
