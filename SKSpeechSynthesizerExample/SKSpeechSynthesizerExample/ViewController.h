//
//  ViewController.h
//  SKSpeechSynthesizerExample
//
//  Created by Saroj Sharma on 06/05/14.
//  Copyright (c) 2014 Saroj Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVSpeechSynthesis.h>

@interface ViewController : UIViewController <UITextViewDelegate, AVSpeechSynthesizerDelegate>{
    
}

- (IBAction)startSpeaking:(id)sender;
- (IBAction)pauseSpeaking:(id)sender;
- (IBAction)stopSpeaking:(id)sender;
- (IBAction)segmentControlValueChanged:(id)sender;

@end
