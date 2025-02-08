//
//  AppDelegate.swift
//  Nightguard
//
//  Created by tiramisu on 2/7/25.
//

import AppKit
import Combine

class AppDelegate: NSObject, NSApplicationDelegate {
	
	private let dnc = DistributedNotificationCenter.default()
	private var bag = Set<AnyCancellable>()
	
	private let loginMargin: Double = 6
	
	private var lastWake: Double?
	private var lastUnlock: Double?
	
	func applicationDidFinishLaunching(_ aNotification: Notification) {
		NSWorkspace.shared.notificationCenter.publisher(for: NSWorkspace.didWakeNotification)
			.sink { _ in
				self.lastWake = Date().timeIntervalSince1970
			}
			.store(in: &bag)
		dnc.publisher(for: .init("com.apple.screenIsUnlocked"))
			.sink { _ in
				self.lastUnlock = Date().timeIntervalSince1970
				if let lastWake = self.lastWake, let lastUnlock = self.lastUnlock {
					if (lastUnlock - lastWake) <= self.loginMargin {
						SACLockScreenImmediate()
					}
				}
			}
			.store(in: &bag)
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		bag.removeAll()
	}
}
