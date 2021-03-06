//: Playground - noun: a place where people can play
//https://www.raywenderlich.com/599-object-oriented-programming-in-swift
import Cocoa

class Instrument {
    let brand: String
    init(brand: String) {
        self.brand = brand
    }
    
    func tune() -> String { // Abstract method because they are not intended for Direct Use Instead we have to make a subclass which
        fatalError("Implement this method for \(brand)")
    }
    
    func play(_ music: Music) -> String {
        return music.prepared()
    }
    
    func perform(_ music: Music) {
        print(tune())
        print(play(music))
    }

}
// Encapsulation : - Functions defined inside a class are called methods because they have access to properties, such as brand in the case of Instrument. Organizing properties and related operations in a class is a powerful tool for taming complexity. It even has a fancy name: encapsulation

class Music {
    let notes: [String]
    
    init(notes: [String]) {
        self.notes = notes
    }
    
    func prepared() -> String {
        return notes.joined(separator: " ")
    }
}

// 1
class Piano: Instrument {
    let hasPedals: Bool
    // 2
    static let whiteKeys = 52
    static let blackKeys = 36
    
    // 3
    init(brand: String, hasPedals: Bool = false) {
        self.hasPedals = hasPedals
        // 4
        super.init(brand: brand)
    }
    
    // 5
    override func tune() -> String {
        return "Piano standard tuning for \(brand)."
    }
    
    override func play(_ music: Music) -> String {
        return play(music, usingPedals: hasPedals)
    }
    
    func play(_ music: Music, usingPedals: Bool) -> String {
        let preparedNotes = super.play(music)
        if hasPedals && usingPedals {
            return "Play piano notes \(preparedNotes) with pedals."
        }
        else {
            return "Play piano notes \(preparedNotes) without pedals."
        }
    }

}

//// 1
//let piano = Piano(brand: "Yamaha", hasPedals: true)
//piano.tune()
//// 2
//let music = Music(notes: ["C", "G", "F"])
//piano.play(music, usingPedals: false)
//// 3
//piano.play(music)
//// 4
//Piano.whiteKeys
//Piano.blackKeys

class Guitar: Instrument {
    let stringGauge: String
    
    init(brand: String, stringGauge: String = "medium") {
        self.stringGauge = stringGauge
        super.init(brand: brand)
    }
}

class AcousticGuitar: Guitar {
    static let numberOfStrings = 6
    static let fretCount = 20
    
    override func tune() -> String {
        return "Tune \(brand) acoustic with E A D G B E"
    }
    
    override func play(_ music: Music) -> String {
        let preparedNotes = super.play(music)
        return "Play folk tune on frets \(preparedNotes)."
    }
}

let roloandGuitar = AcousticGuitar.init(brand: "Roland")
roloandGuitar.tune()
let music = Music(notes: ["C", "G", "F"])
roloandGuitar.play(music)

// 1
class Amplifier {
    // 2
    private var _volume: Int
    // 3
    private(set) var isOn: Bool
    
    init() {
        isOn = false
        _volume = 0
    }
    
    // 4
    func plugIn() {
        isOn = true
    }
    
    func unplug() {
        isOn = false
    }
    
    // 5
    var volume: Int {
        // 6
        get {
            return isOn ? _volume : 0
        }
        // 7
        set {
            _volume = min(max(newValue, 0), 10)
        }
    }
}

// 1
class ElectricGuitar: Guitar {
    // 2
    let amplifier: Amplifier
    
    // 3
    init(brand: String, stringGauge: String = "light", amplifier: Amplifier) {
        self.amplifier = amplifier
        super.init(brand: brand, stringGauge: stringGauge)
    }
    
    // 4
    override func tune() -> String {
        amplifier.plugIn()
        amplifier.volume = 5
        return "Tune \(brand) electric with E A D G B E"
    }
    
    // 5
    override func play(_ music: Music) -> String {
        let preparedNotes = super.play(music)
        return "Play solo \(preparedNotes) at volume \(amplifier.volume)."
    }
}

class BassGuitar: Guitar {
    let amplifier: Amplifier
    
    init(brand: String, stringGauge: String = "heavy", amplifier: Amplifier) {
        self.amplifier = amplifier
        super.init(brand: brand, stringGauge: stringGauge)
    }
    
    override func tune() -> String {
        amplifier.plugIn()
        return "Tune \(brand) bass with E A D G"
    }
    
    override func play(_ music: Music) -> String {
        let preparedNotes = super.play(music)
        return "Play bass line \(preparedNotes) at volume \(amplifier.volume)."
    }
}

let amplifier = Amplifier()
let electricGuitar = ElectricGuitar(brand: "Gibson", stringGauge: "medium", amplifier: amplifier)
electricGuitar.tune()

let bassGuitar = BassGuitar(brand: "Fender", stringGauge: "heavy", amplifier: amplifier)
bassGuitar.tune()

// Notice that because of class reference semantics, the amplifier is a shared
// resource between these two guitars.

bassGuitar.amplifier.volume
electricGuitar.amplifier.volume

bassGuitar.amplifier.unplug()
bassGuitar.amplifier.volume
electricGuitar.amplifier.volume

bassGuitar.amplifier.plugIn()
bassGuitar.amplifier.volume
electricGuitar.amplifier.volume

//You may have heard that classes follow reference semantics. This means that variables holding a class instance actually hold a reference to that instance. If you have two variables with the same reference, changing data in one will change data in the other, and it’s actually the same thing. Show reference semantics in action by instantiating an amplifier and sharing it between a Gibson electric guitar and a Fender bass guitar.

// PolyMorphism : - One of the great strengths of object oriented programming is the ability to use different objects through the same interface while each behaves in its own unique way. This is polymorphism meaning “many forms”
