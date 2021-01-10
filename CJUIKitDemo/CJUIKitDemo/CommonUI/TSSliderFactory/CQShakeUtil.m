//
//  CQShakeUtil.m
//  BiaoliApp
//
//  Created by qian on 2020/12/24.
//

#import "CQShakeUtil.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation CQShakeUtil

+ (void)shake {
    AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate, ^{
        //播放震动完事调用的块
    });
}

@end
