// ActivitiesCalculator
// A Swift library for calculating activity metrics such as calories, pace, and distance.

/// The type of physical activity.
public enum ActivityType: String, CaseIterable, Sendable {
    case running
    case cycling
    case swimming
    case walking
    case hiking

    /// MET (Metabolic Equivalent of Task) value for a typical intensity of this activity.
    public var metValue: Double {
        switch self {
        case .running:  return 9.8
        case .cycling:  return 7.5
        case .swimming: return 8.0
        case .walking:  return 3.5
        case .hiking:   return 6.0
        }
    }
}

/// Represents a single activity session.
public struct Activity: Sendable {
    public let type: ActivityType
    /// Duration of the activity in minutes.
    public let durationMinutes: Double
    /// Distance covered in kilometres.
    public let distanceKm: Double
    /// Body weight of the participant in kilograms.
    public let weightKg: Double

    public init(type: ActivityType, durationMinutes: Double, distanceKm: Double, weightKg: Double) {
        self.type = type
        self.durationMinutes = durationMinutes
        self.distanceKm = distanceKm
        self.weightKg = weightKg
    }
}

/// Provides calculations for physical activity metrics.
public struct ActivitiesCalculator: Sendable {

    public init() {}

    /// Calculates the estimated calories burned during an activity.
    ///
    /// Uses the MET formula: Calories = MET × weight (kg) × duration (hours)
    /// - Parameter activity: The activity session to evaluate.
    /// - Returns: Estimated kilocalories burned.
    public func caloriesBurned(for activity: Activity) -> Double {
        let hours = activity.durationMinutes / 60.0
        return activity.type.metValue * activity.weightKg * hours
    }

    /// Calculates the average pace in minutes per kilometre.
    ///
    /// - Parameter activity: The activity session to evaluate.
    /// - Returns: Pace in minutes per kilometre, or `nil` when distance is zero.
    public func pace(for activity: Activity) -> Double? {
        guard activity.distanceKm > 0 else { return nil }
        return activity.durationMinutes / activity.distanceKm
    }

    /// Calculates the average speed in kilometres per hour.
    ///
    /// - Parameter activity: The activity session to evaluate.
    /// - Returns: Speed in km/h, or `nil` when duration is zero.
    public func speed(for activity: Activity) -> Double? {
        guard activity.durationMinutes > 0 else { return nil }
        let hours = activity.durationMinutes / 60.0
        return activity.distanceKm / hours
    }

    /// Estimates the distance covered in kilometres based on duration and speed.
    ///
    /// - Parameters:
    ///   - durationMinutes: Duration of the activity in minutes.
    ///   - speedKmh: Average speed in kilometres per hour.
    /// - Returns: Distance in kilometres.
    public func distance(durationMinutes: Double, speedKmh: Double) -> Double {
        let hours = durationMinutes / 60.0
        return speedKmh * hours
    }
}
