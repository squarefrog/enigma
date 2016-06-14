import Foundation

/**
 The rotor position as represented in a RotorBox.

 - First:  The first rotor from the right.
 - Second: The second rotor from the right.
 - Third:  The third rotor from the right.
 - Fourth: The fourth rotor from the right. This is only available on the M4
   enigma model.
 */
enum RotorPosition {
    case First
    case Second
    case Third
    case Fourth
}
