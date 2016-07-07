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
@property (nonatomic, strong) NSString *nodeId;
@property (nonatomic, strong) NSString *nodeName;
@property (nonatomic, strong) NSArray *children;
@property (nonatomic, strong) NNATreeNode *parent;
@property (nonatomic, assign) NSInteger depth;

/**
 *  初始化方法
 *
 *  @param node 节点
 *  @param children 子节点字典
 *  @param depth 深度
 *
 *  @return TreeNode
 */

- (instancetype)makeTreeNode:(NNATreeNode *)node children:(NSDictionary *)children depth:(NSUInteger)depth;
+ (instancetype)dataWithTreeNode:(NNATreeNode *)node children:(NSDictionary *)children depth:(NSUInteger)depth;

- (void)setExpanded:(BOOL)expanded;

- (void)addChild:(NNATreeNode *)child;
- (void)removeChild:(NNATreeNode *)child;

@end
