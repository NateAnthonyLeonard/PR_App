//
//  NFCHelper.swift
//  PRapp
//
//  Created by Nathaniel Leonard on 11/24/20.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation
import CoreNFC

class NFCHelper: NSObject, NFCNDEFReaderSessionDelegate{

func restartSession(){
    let session = NFCNDEFReaderSession(delegate: self,
                                        queue: nil,
                                        invalidateAfterFirstRead: true)
    //session.alertMessage = "Hold your phone near reader"
    session.begin()
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("didInvalidate: \(error)")
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        print("didDetect")
    }
    
}
