//
//  TextSizeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "TextSizeViewController.h"
#import "TextSizeCompareView.h"

@implementation TextSizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = NSLocalizedString(@"使用TextSize的视图高度", nil);
    
    UIView *parentView = self.containerView;
    
    
    
    CGFloat leftMargin = 2;
    CGFloat viewWidth = [UIScreen mainScreen].bounds.size.width - 2*leftMargin;
    
    // 1、1行情况的文本占视图的长度
    NSString *text1 = @"1行情况的文本占视图的长度：天天向上";
    UIFont *font1 = [UIFont systemFontOfSize:16];
    TextSizeCompareView *container1 = [[TextSizeCompareView alloc] initWithWithText:text1 font:font1 viewWidth:viewWidth];
    [parentView addSubview:container1];
    [container1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(parentView).mas_offset(24);
        make.left.mas_equalTo(parentView).mas_offset(leftMargin);
        make.centerX.mas_equalTo(parentView);
    }];
    
    
    // 2、2行情况的文本占视图的长度
    NSString *text2 = @"2行情况的文本占视图的长度：英语不能落下，非常有用，技术要学会积累，学会延伸，横向展开";
    UIFont *font2 = [UIFont systemFontOfSize:16];
    TextSizeCompareView *container2 = [[TextSizeCompareView alloc] initWithWithText:text2 font:font2 viewWidth:viewWidth];
    [parentView addSubview:container2];
    [container2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(container1.mas_bottom).mas_offset(24);
        make.left.mas_equalTo(container1);
        make.centerX.mas_equalTo(container1);
    }];
    
    // 3、多行情况的文本占视图的长度
    NSString *text3 = @"多行情况的文本占视图的长度：凡事都有一定的定数，我们只不过在自己的人行道上重复了虚幻中看到的方向，然后一步步向前，直到路的尽头。";
    UIFont *font3 = [UIFont systemFontOfSize:16];
    TextSizeCompareView *container3 = [[TextSizeCompareView alloc] initWithWithText:text3 font:font3 viewWidth:viewWidth];
    [parentView addSubview:container3];
    [container3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(container2.mas_bottom).mas_offset(24);
        make.left.mas_equalTo(container2);
        make.centerX.mas_equalTo(container2);
    }];
    
    // 4、非常多行情况的文本占视图的长度
    NSString *text4 = @"非常多行情况的文本占视图的长度：生活在我的记忆中没有痕迹，稍纵即逝。也许这样的方式对其他人人来说有点虚无，但是对于我来说是最合适的不过的。喜欢没有方向的风，这样就不会顺着它的脾气，丢失了自己的本真，我想我可以在凌乱的风中找到适合自己的方向，笑逐颜开，尽管会很难，但是花开的季节，我能看见的除了它的美丽，还有它的消亡，记忆是一种过程，还是一种很混乱的过程，我试着理清思绪，但到头来我理清的除了比混乱还混乱的思绪，看见的还是混乱的思绪，也许我该明白有些东西真的不是说你想要如何就能如何的，凡事都有一定的定数，我们只不过在自己的人行道上重复了虚幻中看到的方向，然后一步步向前，直到路的尽头";
    UIFont *font4 = [UIFont systemFontOfSize:16];
    TextSizeCompareView *container4 = [[TextSizeCompareView alloc] initWithWithText:text4 font:font4 viewWidth:viewWidth];
    [parentView addSubview:container4];
    [container4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(container3.mas_bottom).mas_offset(24);
        make.left.mas_equalTo(container3);
        make.centerX.mas_equalTo(container3);
    }];
    
    // 4、超级多行情况的文本占视图的长度
    NSString *text5 = @" 时光兜转，在一段段花事里绽放、凋落，循环成一程程山水的模样。沾染上多彩人生的笔，落墨在岁月里，低吟浅唱，写意成诗的韵，平平仄仄起伏跌宕。那一树树繁华落幕，素笔泼墨狂放不羁，也终究成了记忆。夕阳向晚，一滴眼泪破裂成海，无边的落寞在黄昏蔓延，生命终究成为一个不可逆转的记忆。一切那么远，远到成为了飘渺的虚幻，那曾经月下横笛的翩翩少年，也终幻化是午夜梦回的念。那青衣女子踏雪寻梅的足印，在历史的回廊中演变成葬花人的痴嗔。凝眸轻语，徜徉在岁月的河流，曾经青春的衣袂在季风交替中破旧如往事，而生命在这山一程，水一程的匆忙里撰写着沧桑的年轮，蓦然回首发现那些平淡如水的日子充满了倦怠的温馨，原来如此美好！\n清风明月，月下独酌一壶清茶，江南烟雨，踏青寻春翩翩起舞……意境唯美让人留恋。秋风落叶，落花成泥，凄风苦雨淫雨霏霏……几分苍凉徒增伤感。而我，该拿什么撰写这生命的小札，是一笔岁月静好，还是一笔人生苦短；是凝墨成殇还是落墨为歌，淡淡的墨迹该如何书写岁月的篇章！\n落笔，过滤掉凝结的忧伤，却依旧写不出那曾经的洒脱，透过纸张，那浅浅的哀怨渗透在扉页上，记忆里留的最久的总是忧伤。岁月带走了青春的炫彩，却为何不一起带走那些沧桑。\n执笔涂鸦，墨香沁心，曾经的烹雪煮茶，白首天涯；曾经的待我高头大马，许你十里桃花；曾经的待我弦断音垮，许你青丝白发……也不过成就了一段段凄美的谎话！\n执一壶岁月的酒，慢酌红尘往事，斟半盏时光的茶，细品人生沧桑。红尘陌上花开花谢，有多少深情遗失路上，有多少理想被命运碾轧成尘。时光飞逝，又有多少誓言唯美了辞海茫茫，又有多少王侯将相成就了有志之士的愿望。\n浅语轻歌，落笔成殇，这些不是我们最初要的模样，是岁月刮破了曾经最美的时光，浮世的繁华凌乱了曾经的梦想。长路漫漫，怀揣着遗憾感伤有多少归人正忙；花事荼蘼，又有多少痴心人掩落花泪几行；霓虹迷离，纸醉金迷中又有几人迷茫；世事沧桑，还有几多人正把命运抵抗……\n余生浅末，时光流逝，还有多少岁月可供挥霍，又有多少时光能在一起分享。捻一抹熏风，沾几点雨滴，写一阙词，滤除忧伤，只要那一份宁静，夕阳向晚，清风絮语，给自己一片蓝天，临摹着年轻的心性，放歌蓝天下，把那一圈一圈的年轮刻成洒脱的轮廓。\n余生不长，岁月可数，可是快乐没有度，幸福不可量，只要把生命的笔，沾满阳光，在蓝天下泼墨狂书，忧伤也能写成快乐幸福的模样。一笔开心，一笔平淡，一笔青春，一笔宁静，就着这向晚的阳光随意而行，随遇而安，随心而走。\n不再执迷于那些困惑自己的痴念，不再纠缠那理不完的牵绊，不再等待不再祈盼……放飞灵魂在蓝天下自由自在的翱翔，让心灵在阳光中绽放成自己喜欢的样子。\n余生不长，墨写岁月，那里有一片蓝天，是我为自己速写的时光！";
    UIFont *font5 = [UIFont systemFontOfSize:16];
    TextSizeCompareView *container5 = [[TextSizeCompareView alloc] initWithWithText:text5 font:font5 viewWidth:viewWidth];
    [parentView addSubview:container5];
    [container5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(container4.mas_bottom).mas_offset(24);
        make.left.mas_equalTo(container4);
        make.centerX.mas_equalTo(container4);
    }];
    
    [self updateScrollHeightWithBottomInterval:40
                     accordingToLastBottomView:container5];
}



-  (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
