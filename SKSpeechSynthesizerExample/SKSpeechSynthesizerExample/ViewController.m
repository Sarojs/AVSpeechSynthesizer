//
//  ViewController.m
//  SKSpeechSynthesizerExample
//
//  Created by Saroj Sharma on 06/05/14.
//  Copyright (c) 2014 Saroj Sharma. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,retain) IBOutlet UITextView *tvTextToSpeak;
@property(nonatomic,retain) IBOutlet UILabel *lblSpeakingText;
@property(nonatomic,retain) IBOutlet UIButton *btnStartSpeaking;
@property(nonatomic,retain) IBOutlet UIButton *btnStopSpeaking;
@property(nonatomic,retain) IBOutlet UIButton *btnPauseSpeaking;
@property(nonatomic,retain) AVSpeechSynthesizer *synthesizer;
@end

@implementation ViewController
@synthesize synthesizer = _synthesizer;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    NSString *textToSpeak = @"Do any additional setup after loading the view, typically from a nib";
    NSString *textToSpeak = [_tvTextToSpeak text];
    [self performSelector:@selector(speakText:) withObject:textToSpeak afterDelay:3.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startSpeaking:(id)sender{
    if ([_synthesizer isPaused]) {
        [_synthesizer continueSpeaking];
    }else{
        [self speakText:_tvTextToSpeak.text];
    }
}

- (IBAction)pauseSpeaking:(id)sender{
    if ([_synthesizer isSpeaking]) {
        [_synthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryWord];
    }
}

- (IBAction)stopSpeaking:(id)sender{
    if ([_synthesizer isSpeaking]) {
        [_synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    }
}

- (void)speakText:(NSString*)text{
    AVSpeechUtterance *utterence = [[AVSpeechUtterance alloc] initWithString:text];
    utterence.rate = 0.20f;
    if(_synthesizer == nil)
    _synthesizer = [[AVSpeechSynthesizer alloc] init];
    _synthesizer.delegate = self;
    [_synthesizer speakUtterance:utterence];
}


- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance{
    [self enableAllButton];
    _btnStartSpeaking.enabled = NO;
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance{
    [self enableAllButton];
    _btnPauseSpeaking.enabled = NO;
    _btnStopSpeaking.enabled = NO;
    [_tvTextToSpeak setText:[utterance speechString]];
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance{
    [self enableAllButton];
    _btnPauseSpeaking.enabled = NO;
    _btnStopSpeaking.enabled = NO;
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance{
    [self enableAllButton];
    _btnStartSpeaking.enabled = NO;
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance{
    [self enableAllButton];
    _btnPauseSpeaking.enabled = NO;
    _btnStopSpeaking.enabled = NO;
    [_tvTextToSpeak setText:[utterance speechString]];
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance{
    NSString *text = [utterance speechString];
    NSString *willSpeak = [text substringWithRange:characterRange];
    
    NSMutableAttributedString * all = [[NSMutableAttributedString alloc] initWithString:text];
    [all addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:characterRange];
    [_tvTextToSpeak setAttributedText:all];
    
    NSLog(@"Will speak: %@", willSpeak);
    
}

- (void)enableAllButton{
    _btnStartSpeaking.enabled = YES;
    _btnPauseSpeaking.enabled = YES;
    _btnStopSpeaking.enabled = YES;
}

@end
