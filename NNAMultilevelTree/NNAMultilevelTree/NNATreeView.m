//
//  NNATreeView.m
//  NNAMultilevelTree
//
//  Created by NNA on 16/5/17.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import "NNATreeView.h"

static NSString *CellId = @"TreeViewCell";

@interface NNATreeView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *nodesArray;
@property (nonatomic, strong) NSMutableArray *recursionArray;
@property (nonatomic, assign) NSInteger end;

@end

@implementation NNATreeView

- (instancetype)init {
    return [self initWithFrame:CGRectMake(0, 0, 100, 100) style:UITableViewStylePlain];
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame style:UITableViewStylePlain];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        _nodesArray = @[].mutableCopy;
        _recursionArray = @[].mutableCopy;
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    _nodesArray = _dataArray.mutableCopy;
    [self reloadData];
}

- (void)insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    if (indexPaths.count>0) {
        [super insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    } else {
        NSLog(@"没有添加的节点");
    }
}

- (void)deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    if (indexPaths.count>0) {
        [super deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    } else {
        NSLog(@"没有可删除的节点");
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _nodesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
    }
    
    NNATreeNode *node = [_nodesArray objectAtIndex:indexPath.row];
    NSMutableString *name = [NSMutableString string];
    for (int i=0; i<node.depth; i++) {
        [name appendString:@"     "];
    }
    [name appendString:node.nodeName];
    cell.textLabel.text = name;
    
    return cell;
}

- (void)updateTreeNode:(NNATreeNode *)node didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //先修改数据源
    BOOL expanded = NO;
    if (node.expanded) {
        expanded = NO;
        [node setExpanded:NO];
    } else if (node.children.count>0) {
        expanded = YES;
        [node setExpanded:YES];
    }
    
    [_recursionArray removeAllObjects];
    [self recursiveTreeNode:node];
    
    __block NSInteger index = indexPath.row;
    NSMutableArray *indexPathArray = [NSMutableArray arrayWithCapacity:0];
    [_recursionArray enumerateObjectsUsingBlock:^(NNATreeNode *node, NSUInteger idx, BOOL *stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:++index inSection:0];
        [indexPathArray addObject:indexPath];
        if (expanded) {
            [_nodesArray insertObject:node atIndex:index];
        } else {
            [_nodesArray removeObjectsInArray:_recursionArray];
            
        }
    }];
    //插入或者删除相关节点
    if (expanded) {
        [self insertRowsAtIndexPaths:indexPathArray];
    } else {
        [self deleteRowsAtIndexPaths:indexPathArray];
    }
    
}


/**
 *  递归遍历节点
 *
 *  @param node 父节点
 */
- (void)recursiveTreeNode:(NNATreeNode *)node {
    if (node.children) {
        [node.children enumerateObjectsUsingBlock:^(NNATreeNode *treeNode, NSUInteger idx, BOOL *stop) {
            if (treeNode.expanded) {
                treeNode.expanded = NO;
                [_recursionArray addObject:treeNode];
                [self recursiveTreeNode:treeNode];
            }
            else {
                [_recursionArray addObject:treeNode];
            }
        }];
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NNATreeNode *parentNode = [_nodesArray objectAtIndex:indexPath.row];
    [self updateTreeNode:parentNode didSelectRowAtIndexPath:indexPath];
    
}



@end
