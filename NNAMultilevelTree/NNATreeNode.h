//
//  NNATreeNode.h
//  NNAMultilevelTree
//
//  Created by NNA on 16/5/17.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNATreeNode : NSObject

@property (nonatomic, readonly) BOOL expanded;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *children;
@property (nonatomic, strong) NNATreeNode *parent;
@property (nonatomic, assign) NSInteger depth;

/**
 *  初始化方法
 *
 *  @param name  节点名
 *  @param array 子节点集合
 *
 *  @return TreeNode
 */

- (instancetype)initWithName:(NSString *)name children:(NSArray *)children;
+ (instancetype)dataObjectWithName:(NSString *)name children:(NSArray *)children;

- (void)setExpanded:(BOOL)expanded;

- (void)addChild:(id)child;
- (void)removeChild:(id)child;

@end
