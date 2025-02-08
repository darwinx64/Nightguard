//
//  main.swift
//  Nightguard
//
//  Created by tiramisu on 2/7/25.
//

import AppKit

autoreleasepool { () -> () in
	let app = NSApplication.shared
	let delegate = AppDelegate()
	app.delegate = delegate
	app.run()
}
