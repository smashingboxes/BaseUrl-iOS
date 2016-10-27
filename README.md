## BaseUrl-iOS

### Why?

It's common to have several backend environments that you switch between while you're developing an iOS app. This provides a way to quickly point at a new URL without rebuilding the app.

### Usage:

1. Implement `BaseUrlDelegate` in your app
2. `let baseUrl = BaseUrl(delegate: delegate)`
3. Use `baseUrl.url`
4. To show the debug URL switcher, call `baseUrl.showDebugSwitcher(on: viewController)`.
5. Do what you need to in `baseUrlDidChange(newURL: String)` -- log out the user, clear credentials, etc.
