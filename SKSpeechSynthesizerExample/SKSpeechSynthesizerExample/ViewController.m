//
//  ViewController.m
//  SKSpeechSynthesizerExample
//
//  Created by Saroj Sharma on 06/05/14.
//  Copyright (c) 2014 Saroj Sharma. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,retain) AVSpeechSynthesizer *synthesizer;
@end

@implementation ViewController
@synthesize synthesizer = _synthesizer;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *textToSpeak = @"Do any additional setup after loading the view, typically from a nib";
    [self performSelector:@selector(speakText:) withObject:textToSpeak afterDelay:3.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)speakText:(NSString*)text{
    AVSpeechUtterance *utterence = [[AVSpeechUtterance alloc] initWithString:text];
    utterence.rate = 0.25f;
    _synthesizer = [[AVSpeechSynthesizer alloc] init];
    _synthesizer.delegate = self;
    [_synthesizer speakUtterance:utterence];
}

/*
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance{
    NSLog(@"didStartSpeechUtterance:%@", [utterance description]);
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance{
    NSLog(@"didFinishSpeechUtterance:%@", [utterance description]);
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance{
     NSLog(@"didPauseSpeechUtterance:%@", [utterance description]);
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance{
     NSLog(@"didContinueSpeechUtterance:%@", [utterance description]);
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance{
     NSLog(@"didCancelSpeechUtterance:%@", [utterance description]);
}
*/

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance{
    NSString *text = [utterance speechString];
    NSLog(@"Will speak: %@", [text substringWithRange:characterRange]);
}


@end
