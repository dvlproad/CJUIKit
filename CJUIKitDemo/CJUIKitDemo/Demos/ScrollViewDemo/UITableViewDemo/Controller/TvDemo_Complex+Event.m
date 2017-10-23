//
//  TvDemo_Complex+Event.m
//  AllScrollViewDemo
//
//  Created by ciyouzen on 8/26/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "TvDemo_Complex+Event.h"

@implementation TvDemo_Complex (Event)

#pragma mark - 辅助按钮Accessories (disclosures).
////点击辅助按钮后调用的方法即小按钮的响应事件
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"accessoryButton的响应事件");
}


#pragma mark - 表格选中Selection事件(注：在下一行将要选中后才取消上一行的选中。)
/* 例如：
 已经选中第一行的情况下：执行顺序
 willSelectRowAtIndexPath 当前行为:0
 didSelectRowAtIndexPath 当前行为:0
 
 继续从第一行去选中第二行的时候，执行顺序为：
 willSelectRowAtIndexPath 当前行为:1
 willDeselectRowAtIndexPath 当前行为:0
 didDeselectRowAtIndexPath 当前行为:0
 didSelectRowAtIndexPath 当前行为:1
 */

//选中 indexPath 位置的 cell 之前，调用的方法，返回一个新位置
//通知委托指定行被将要选中，返回值为NSIndexPath是指返回响应行的索引，即可以点击一行而返回另一行索引，如果不想点击事件响应则返回nil。
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath;
}

//已经选中 indexPath 位置的 cell 后，调用的方法
//通知委托指定行被选中。
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

//离开 indexPath 位置的 cell 之前，调用的方法，返回一个新位置
//通知委托指定行将取消选中。
- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath;
}


//已经离开 indexPath 位置的 cell 后 调用的方法
//通知委托指定行被取消选中。
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}




#pragma mark - 设置表格可编辑
- (IBAction)didEditTableView:(UIButton *)sender{
    isEditing = !isEditing;
    NSString *string = isEditing ? @"完成" : @"编辑";
    [sender setTitle:string forState:UIControlStateNormal];
    [self.tv setEditing:isEditing animated:YES];    //启动表格的编辑模式
}

// The willBegin/didEnd methods are called whenever the 'editing' property is automatically changed by the table (allowing insert/delete/move). This is done by a swipe activating a single row
//tableview 的 editing 属性改变时，调用这两个方法
//通知委托，表视图将要被编辑
- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

//表视图完成编辑
- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    
}



//对当前行设置编辑模式（ 删除(默认)、增加、不可编辑 ）
/*
 - (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
 return UITableViewCellEditingStyleNone;//打开编辑模式后，默认情况下每行左边会出现红的删除按钮，这个方法就是关闭这些按钮的
 //另外还有两个分别为:UITableViewCellEditingStyleDelete, UITableViewCellEditingStyleInsert
 }
 */

//在删除模式启动下，改变每行删除按钮的文字（默认为“Delete”）
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"确认删除";
}



#pragma mark - 缩进Indentation
// Controls whether the background is indented while editing.  If not implemented, the default is YES.  This is unrelated to the indentation level below.  This method only applies to grouped style table views.
//当 (UITableViewCellEditingStyle === UITableViewCellEditingStyleNone)的时候，取消缩进有效
//通知委托在编辑模式下是否需要对表视图指定行进行缩进，NO为关闭缩进,这个方法可以用来去掉move时row前面的空白
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

//设置Cell行缩进量 // return 'depth' of row for hierarchies
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


#pragma mark - 表格删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {//当用第一行来替换sectionHead的时候，尤其有用
        return NO;
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {//如果删除
        [datas removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
        //        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
        //                         withRowAnimation:UITableViewRowAnimationAutomatic];
    }else if (editingStyle == UITableViewCellEditingStyleInsert){//如果增加
        //在所选行的位置插入一行
        NSArray *insertIndexPaths = [NSArray arrayWithObjects:indexPath,nil];
        [datas insertObject:@"新添加的行" atIndex:indexPath.row];
        [tableView insertRowsAtIndexPaths:insertIndexPaths
                         withRowAnimation:UITableViewRowAnimationRight];//代码中也可以不用insertRowsAtIndexPaths方法，而直接使用[tableView reloadData];语句，但是这样就没有添加的效果了。
    }
}


#pragma mark - 表格移动Move
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSUInteger fromRow = [sourceIndexPath row];
    NSUInteger toRow = [destinationIndexPath row];
    
    id object = [datas objectAtIndex:fromRow];
    [datas removeObjectAtIndex:fromRow];
    [datas insertObject:object atIndex:toRow];
}

/*
 //移动行的过程中会多次调用此方法，返回值代表进行移动操作后回到的行，如果设置为当前行，则不论怎么移动都会回到当前行。
 - (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath{
 return proposedDestinationIndexPath;
 }
 */



#pragma mark - 表格复制/粘贴(Copy/Paste) //All three methods must be implemented by the delegate.
//通知委托是否在指定行显示菜单，返回值为YES时，长按显示菜单。
- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//弹出选择菜单时会调用此方法（复制、粘贴、全选、剪切）
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{
    return YES;
}

//选择菜单项完成之后调用此方法。
- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{
    
}

@end
