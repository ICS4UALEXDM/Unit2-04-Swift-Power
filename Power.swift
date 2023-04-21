import Foundation
import Glibc
//
//  FileIO.swift
//
//  Created by Alex De Meo
//  Created on 2023/02/11
//  Version 1.0
//  Copyright (c) 2023 Alex De Meo. All rights reserved.
//
// This program calculates reverses a string

// creating constants and variables
var errorMessage = ""

// Defining the file paths
let baseFile = "base.txt"
let expFile = "exp.txt"
let outputFile = "output.txt"

// opening the input files for reading
guard let input = FileHandle(forReadingAtPath: baseFile) else {
    print("Error: Cannot open input file.")
    exit(1)
}
guard let input2 = FileHandle(forReadingAtPath: expFile) else {
    print("Error: cannot open input file")
    exit(1)
}

// opening the output file for writing
guard let output = FileHandle(forWritingAtPath: outputFile) else {
    print("Error: Cannot open output file.")
    exit(1)
}

// Reading contents of input file
let inputData = input.readDataToEndOfFile()
let inputData2 = input2.readDataToEndOfFile()

// Converting data to a string
guard let inputString = String(data: inputData, encoding: .utf8) else {
    print("Error: Cannot convert data to string.")
    exit(1)
}
guard let inputString2 = String(data: inputData2, encoding: .utf8) else {
    print("Error: Cannot convert data to string.")
    exit(1)
}
// Splitting string into separate lines
let lines = inputString.components(separatedBy: .newlines)
let lines2 = inputString2.components(separatedBy: .newlines)

for i in 0...lines.count - 1{
    // checking for empty lines
    if (lines[i].count == 0 || lines2[i].count == 0) {
        let outputData = "ERROR: Empty line in one of the files.\n"
        output.write(outputData.data(using: .utf8)!)
    } else {
        // Conversions to ensure int
        if let base = Int(lines[i]) {
            if let exp = Int(lines2[i]) {
                if (exp < 0) {
                    // throwing error if its negatiev
                    let outputData = "ERROR: For this program, exponent can't be negative\n"
                    output.write(outputData.data(using: .utf8)!)
                } else {
                    // Calling the function and outputting the results
                    let power = recPower(base, exp)
                    let outputData = String("\(base)^\(exp) = \(power)\n")
                    output.write(outputData.data(using: .utf8)!)
                }
            } else {
                let outputData = "ERROR: Invalid input for this line \n"
                output.write(outputData.data(using: .utf8)!)
            }
        } else {
            let outputData = "ERROR: Invalid input for this line\n"
            output.write(outputData.data(using: .utf8)!)
        }
    }
}

// This function Finds the power of a base with a specified exponent
func recPower(_ base: Int, _ exp: Int) -> Int {
    // base case
    if (exp == 0) {
        return 1
    } else {
        // recursion case
        return base * recPower(base, exp - 1)
    }
}