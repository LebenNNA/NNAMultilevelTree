//
//  ViewController.m
//  NNAMultilevelTree
//
//  Created by NNA on 16/5/17.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import "ViewController.h"
#import "NNATreeView.h"
#import "NNATreeNode.h"

static NSString *CellId = @"TreeViewCell";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NNATreeView *treeView;
@property (nonatomic, assign) NSInteger end;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self buildTree];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loadData {
    NNATreeNode *node131 = [NNATreeNode dataObjectWithName:@"白🐭" children:nil];
    NNATreeNode *node132 = [NNATreeNode dataObjectWithName:@"黑🐭" children:nil];
    NNATreeNode *node133 = [NNATreeNode dataObjectWithName:@"灰🐭" children:nil];
    
    NNATreeNode *node121 = [NNATreeNode dataObjectWithName:@"波斯🐱" children:nil];
    NNATreeNode *node122 = [NNATreeNode dataObjectWithName:@"加菲🐱" children:nil];
    
    NNATreeNode *node11 = [NNATreeNode dataObjectWithName:@"🐶" children:nil];
    NNATreeNode *node12 = [NNATreeNode dataObjectWithName:@"🐱" children:@[node121, node122]];
    NNATreeNode *node13 = [NNATreeNode dataObjectWithName:@"🐭" children:@[node131, node132, node133]];

    NNATreeNode *node1 = [NNATreeNode dataObjectWithName:@"动物" children:@[node11, node12, node13]];
    
    _dataArray = @[node1].mutableCopy;
    
}

- (void)buildTree {
    _treeView = [[NNATreeView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:_treeView];
    _treeView.dataSource = self;
    _treeView.delegate = self;
    
}

- (void)checkNodesWithParent:(NNATreeNode *)parent endPosition:(NSInteger)endPosition {
    _end = endPosition;
    for (int i=0; i<parent.children.count; i++) {
        NNATreeNode *node = [parent.children objectAtIndex:i];
        [_dataArray insertObject:node atIndex:_end];
        _end++;
        if ((node.children.count>0)&&node.expanded) {
            [self checkNodesWithParent:node endPosition:_end];
        }
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
    }
    
    NNATreeNode *node = [_dataArray objectAtIndex:indexPath.row];
    NSMutableString *name = [NSMutableString string];
    for (int i=0; i<node.depth; i++) {
        [name appendString:@"     "];
    }
    [name appendString:node.name];
    cell.textLabel.text = name;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //先修改数据源
    NNATreeNode *parentNode = [_dataArray objectAtIndex:indexPath.row];
    NSUInteger startPosition = indexPath.row+1;
    NSUInteger endPosition = startPosition;
    BOOL expanded = NO;
    if (parentNode.expanded) {
        expanded = NO;
        [parentNode setExpanded:NO];
        endPosition = [self removeAllNodesAtParent:parentNode];
    } else if (parentNode.children.count>0) {
        expanded = YES;
        [parentNode setExpanded:YES];
        [self checkNodesWithParent:parentNode endPosition:endPosition];
        endPosition = _end;
    }
    
    //获得需要修正的indexPath
    NSMutableArray *indexPathArray = [NSMutableArray array];
    for (NSUInteger i=startPosition; i<endPosition; i++) {
        NSIndexPath *tempIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [indexPathArray addObject:tempIndexPath];
    }
    
    //插入或者删除相关节点
    if (expanded) {
        [_treeView insertRowsAtIndexPaths:indexPathArray];
    } else {
        [_treeView deleteRowsAtIndexPaths:indexPathArray];
    }
}

/**
 *  删除该父节点下的所有子节点（包括孙子节点）
 *
 *  @param parentNode 父节点
 *
 *  @return 邻接父节点的位置距离该父节点的长度，也就是该父节点下面所有的子孙节点的数量
 */
- (NSUInteger)removeAllNodesAtParent:(NNATreeNode *)parent {
    NSUInteger startPosition = [_dataArray indexOfObject:parent];
    NSUInteger endPosition = startPosition;
    for (NSUInteger i=startPosition+1; i<_dataArray.count; i++) {
        NNATreeNode *node = [_dataArray objectAtIndex:i];
        endPosition++;
        if (node.depth == parent.depth) {
            break;
        }
        if (i==_dataArray.count-1) {
            endPosition = _dataArray.count;
        }
    }
    if (endPosition>startPosition) {
        [_dataArray removeObjectsInRange:NSMakeRange(startPosition+1, endPosition-startPosition-1)];
    }
    return endPosition;
}

@end
