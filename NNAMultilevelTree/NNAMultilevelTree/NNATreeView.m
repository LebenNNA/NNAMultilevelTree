//
//  NNATreeView.m
//  NNAMultilevelTree
//
//  Created by NNA on 16/5/17.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import "NNATreeView.h"

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
    }
    return self;
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


@end
