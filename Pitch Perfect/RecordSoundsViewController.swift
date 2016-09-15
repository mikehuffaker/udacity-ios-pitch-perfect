//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Mike Huffaker on 8/28/16.
//  Copyright © 2016 Mike Huffaker. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController , AVAudioRecorderDelegate
{

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MHH - Handle when the user presses the record button
    @IBAction func RecordAudio(sender: AnyObject)
    {
        print("RecordSoundsViewController: Record button pressed")
        recordingLabel.text = "Recording in progress"
        stopRecordingButton.enabled = true
        recordButton.enabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print (filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    // MHH - Handle when the user presses the stop recording button
    @IBAction func StopRecording(sender: AnyObject)
    {
        print( "RecordSoundsViewController: Stop recording button pressed" )
        recordButton.enabled = true
        stopRecordingButton.enabled = false
        recordingLabel.text = "Tap to Record"
        
        // logic to stop recording class
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }

    // MHH - When view is about to appear, make sure the stop button is initially disabled
    override func viewWillAppear(animated: Bool)
    {
        print( "RecordSoundsViewController: viewWillAppear() was called" )
        stopRecordingButton.enabled = false
    }
    
    // MHH - Make sure audio recording is finished before transferring to playback view
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool)
    {
        print ( "RecordSoundsViewController: AVAudioRecorder finished saving recording" )
        if ( flag )
        {
            self.performSegueWithIdentifier( "stopRecording", sender: audioRecorder.url )
        }
        else
        {
            print( "RecordSoundsViewController: Saving of recording failed" )
        }
    }
    
    // MHH - Make sure the URL for the recorded 
    override func prepareForSegue( segue: UIStoryboardSegue, sender: AnyObject? )
    {
        if ( segue.identifier == "stopRecording" )
        {
            let playSoundsVC = segue.destinationViewController as!
                PlaySoundsViewController
            let recordedAudioURL = sender as! NSURL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
}

