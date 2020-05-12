/*
 * Created by Ubique Innovation AG
 * https://www.ubique.ch
 * Copyright (c) 2020. All rights reserved.
 */

import Foundation

/// Mobdel used for grouping and filtering Handshakes
struct Contact {
    let identifier: Int?
    let ephID: EphID
    let date: Date
    let windowCount: Int
    let associatedKnownCase: Int?
#if CALIBRATION
    let ketjuUserPrefix: String
    let ketjuStartDate: Date
    let ketjuEndDate: Date
    let ketjuMinutes: Int
    let ketjuMeanAttenuation: Double
    let ketjuMeanDistance: Double
#endif
}

extension Contact: Equatable {}
