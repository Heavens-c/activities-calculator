import Testing
@testable import ActivitiesCalculator

// MARK: - caloriesBurned

@Test func caloriesBurnedRunning() {
    let calculator = ActivitiesCalculator()
    let activity = Activity(type: .running, durationMinutes: 60, distanceKm: 10, weightKg: 70)
    let calories = calculator.caloriesBurned(for: activity)
    // MET 9.8 × 70 kg × 1 h = 686
    #expect(abs(calories - 686.0) < 0.01)
}

@Test func caloriesBurnedWalking() {
    let calculator = ActivitiesCalculator()
    let activity = Activity(type: .walking, durationMinutes: 30, distanceKm: 2, weightKg: 80)
    let calories = calculator.caloriesBurned(for: activity)
    // MET 3.5 × 80 kg × 0.5 h = 140
    #expect(abs(calories - 140.0) < 0.01)
}

// MARK: - pace

@Test func paceCalculation() {
    let calculator = ActivitiesCalculator()
    let activity = Activity(type: .running, durationMinutes: 50, distanceKm: 10, weightKg: 70)
    let pace = calculator.pace(for: activity)
    // 50 min / 10 km = 5 min/km
    #expect(pace == 5.0)
}

@Test func paceReturnsNilForZeroDistance() {
    let calculator = ActivitiesCalculator()
    let activity = Activity(type: .running, durationMinutes: 30, distanceKm: 0, weightKg: 70)
    #expect(calculator.pace(for: activity) == nil)
}

// MARK: - speed

@Test func speedCalculation() {
    let calculator = ActivitiesCalculator()
    let activity = Activity(type: .cycling, durationMinutes: 60, distanceKm: 30, weightKg: 75)
    let speed = calculator.speed(for: activity)
    // 30 km / 1 h = 30 km/h
    #expect(speed == 30.0)
}

@Test func speedReturnsNilForZeroDuration() {
    let calculator = ActivitiesCalculator()
    let activity = Activity(type: .cycling, durationMinutes: 0, distanceKm: 10, weightKg: 75)
    #expect(calculator.speed(for: activity) == nil)
}

// MARK: - distance

@Test func distanceCalculation() {
    let calculator = ActivitiesCalculator()
    let distance = calculator.distance(durationMinutes: 90, speedKmh: 20)
    // 20 km/h × 1.5 h = 30 km
    #expect(distance == 30.0)
}

// MARK: - ActivityType

@Test func activityTypeMETValues() {
    #expect(ActivityType.running.metValue == 9.8)
    #expect(ActivityType.cycling.metValue == 7.5)
    #expect(ActivityType.swimming.metValue == 8.0)
    #expect(ActivityType.walking.metValue == 3.5)
    #expect(ActivityType.hiking.metValue == 6.0)
}

@Test func allActivityTypesHavePositiveMET() {
    for type in ActivityType.allCases {
        #expect(type.metValue > 0)
    }
}
