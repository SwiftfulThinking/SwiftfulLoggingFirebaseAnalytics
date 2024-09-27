import Foundation
import FirebaseAnalytics
import SwiftfulLogging
import SendableDictionary

public struct FirebaseAnalyticsService: LogService {
    
    public init() {
        
    }

    public func trackEvent(event: LoggableEvent) {
        var params = event.parameters ?? [:]
        cleaningUnsupportedValues(&params)

        let name = event.eventName.clipped(maxCharacters: 40)
        Analytics.logEvent(name, parameters: params)
    }

    public func trackScreenView(event: any LoggableEvent) {
        trackEvent(event: event)

        Analytics.logEvent(AnalyticsEventScreenView, parameters: [
            AnalyticsParameterScreenName: event.eventName
        ])
    }

    public func identifyUser(userId: String?) {
        Analytics.setUserID(userId)
    }

    public func identifyUser(userId: String, name: String?, email: String?) {
        Analytics.setUserID(userId)
        Analytics.setUserProperty(name ?? "unknown", forName: "UserName")
        Analytics.setUserProperty(email ?? "unknown", forName: "UserEmail")
    }

    public func addUserProperties(dict: SendableDict) {
        for (key, value) in dict.dict {
            if let string = value as? String {
                Analytics.setUserProperty(string, forName: key)
            }
        }
    }

    public func deleteUserProfile() {
        Analytics.setAnalyticsCollectionEnabled(false)
    }

    /// Remove types that are not supported
    private func cleaningUnsupportedValues(_ parameters: inout [String: Any]) {
        for (key, value) in parameters {

            // Firebase Analytics does not support Date
            if let date = value as? Date {
                parameters[key] = date.description
            }

            // Firebase Analytics doesn't allow Arrays
            if let stringArray = value as? [String] {
                parameters[key] = stringArray.joined(separator: ", ")
            } else if (value as? [Any]) != nil {
                parameters[key] = nil
            }
        }

        // Firebase Analytics Event Names have a limit of 40 characters
        parameters.clippingKeys(maxCharacters: 40)

        // Firebase Analytics Event Parameters are limited to 25
        parameters.limitToFirst(maxItems: 25)
    }
}
