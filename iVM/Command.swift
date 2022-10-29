//
//  Command.swift
//  iVM
//
//  Created by Yoshimasa Niwa on 1/12/21.
//

import ArgumentParser
import Foundation
import Virtualization

@main
struct Command: ParsableCommand {
    @Option(help: "path to ungziped linux kernel.")
    var vmlinux: String

    @Option(help: "path to ramdisk.")
    var initrd: String

    @Option(help: "path to disk image")
    var image: String

    mutating func run() throws {
        var viewModel = VirtualMachineViewModel()

        viewModel.kernelURL = URL(fileURLWithPath: vmlinux)
        viewModel.initialRamdiskURL = URL(fileURLWithPath: initrd)
        viewModel.bootableImageURL = URL(fileURLWithPath: image)


        viewModel.start()

        RunLoop.main.run()
    }
}
