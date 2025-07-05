# Login Unresponsiveness Investigation & Fix Tracker

## Problem Description
After login, the app becomes unresponsive for a period of time. Users can see the interface but cannot interact with it - no navigation, taps, or gestures work. The issue resolves automatically after some time but creates a poor user experience.

## Investigation Summary
Through comprehensive code analysis, we've identified 5 primary hypotheses for the root cause. This document tracks our investigation progress and implementation of fixes.

## Hypotheses (Ranked by Likelihood)

### 🔥 Hypothesis 1: AnimatedSplashScreen Race Condition (MOST LIKELY)
**Root Cause:** The `AnimatedSplashScreen` component covers the entire app with absolute positioning. While it has a 4-second force hide timeout, the `initApp` function may take longer to complete, especially on slower networks. If the splash screen animation completes but `hideAnimatedSplashScreen` state doesn't update properly, it leaves an invisible overlay blocking all touch events.

**Evidence:**
- Uses `StyleSheet.absoluteFillObject` positioning (app/src/components/AnimatedSplashScreen.tsx:138)
- Complex async operations in `initApp` that could exceed 4 seconds
- State update happens in animation callback which could fail silently
- Timing matches symptom: resolves "after some time"

**Status:** ✅ Complete
**Fix Strategy:** 
- [x] Add timeout logging to identify when initApp exceeds 4 seconds
- [x] Implement proper error handling for animation callbacks
- [x] Add failsafe to ensure splash screen always dismisses
- [x] Consider increasing timeout or making it dynamic based on operations

**Implementation Details:**
- Extended force timeout from 4s to 8s for complex operations
- Added ultimate failsafe timeout at 12s that bypasses animation
- Implemented comprehensive logging for timing analysis
- Added race condition protection with `isHiding` flag
- Enhanced error handling for animation callbacks
- Added operation-level timing and state tracking

---

### 🔥 Hypothesis 2: Stellar Network Operations Blocking
**Root Cause:** Both `initApp` and `useWalletForegroundCheck` perform Stellar blockchain operations (checking/creating accounts and trustlines). These network calls could hang or timeout, especially if the Stellar network is congested or the user has poor connectivity.

**Evidence:**
- `checkAccountAndTrustline` and `createWalletAccount` calls in both hooks
- No visible timeout configuration for these operations
- Operations run on every app foreground, not just login
- Network operations can be unpredictable

**Status:** ⏳ Not Started
**Fix Strategy:**
- [ ] Add explicit timeouts to Stellar network operations
- [ ] Implement retry logic with exponential backoff
- [ ] Add error handling for network failures
- [ ] Consider making operations non-blocking for UI

---

### 🔥 Hypothesis 3: Multiple Concurrent GraphQL Queries Overwhelming
**Root Cause:** The Home component fires 3+ simultaneous GraphQL queries on mount with aggressive fetch policies (`network-only`, `cache-and-network`). This could overwhelm the JavaScript thread, especially on lower-end devices.

**Evidence:**
- HomeQuery, RESTORE_ONBOARDING_DATA, and PaymentMethodsQuery all fire on mount
- Real-time subscription also established immediately
- No request debouncing or prioritization
- Heavy data processing for onboarding state restoration

**Status:** ⏳ Not Started
**Fix Strategy:**
- [ ] Implement query prioritization/sequencing
- [ ] Add loading states to prevent UI blocking
- [ ] Consider lazy loading for non-critical queries
- [ ] Add request throttling

---

### 🔥 Hypothesis 4: Navigation State Transition Race Condition
**Root Cause:** The `isLoggedIn()` function has complex logic involving multiple state variables. During login, there's a critical moment where the app transitions from OnboardingStack to AppStack. If state updates don't happen in the correct order, the navigation could get stuck in an intermediate state.

**Evidence:**
- Complex conditions in `isLoggedIn()` (app/src/hooks/useUser.ts:74-104)
- Depends on `isEmailVerified`, `sessionToken`, `user`, and `isLoggingOut` states
- Navigation decision made in App.tsx based on this logic
- Multiple state management systems involved

**Status:** ⏳ Not Started
**Fix Strategy:**
- [ ] Add state transition logging
- [ ] Implement state machine for login flow
- [ ] Add guards against race conditions
- [ ] Simplify login state logic

---

### 🔥 Hypothesis 5: AuthOverlay or Bottom Sheet Modal Persistence
**Root Cause:** If the `AuthOverlay` component or any bottom sheet modal doesn't properly dismiss after authentication, it could block interaction. The app uses multiple overlay systems that could conflict.

**Evidence:**
- AuthOverlay uses absolute positioning covering entire screen
- Multiple modal providers (BottomSheetModalProvider, PortalProvider)
- No clear dismissal logic visible for AuthOverlay after successful auth
- Complex overlay management system

**Status:** ⏳ Not Started
**Fix Strategy:**
- [ ] Audit all overlay components for proper dismissal
- [ ] Add overlay state debugging
- [ ] Implement centralized overlay management
- [ ] Add failsafe overlay cleanup

---

## Key Files to Monitor

### Critical Components
- `app/src/components/AnimatedSplashScreen.tsx` - Primary suspect
- `app/src/hooks/useAppInit.ts` - Initialization logic
- `app/src/hooks/useUser.ts` - Authentication state
- `app/src/App.tsx` - Navigation logic
- `app/src/scenes/Home/Home.tsx` - Post-login component

### Supporting Files
- `app/src/hooks/useWalletForegroundCheck.ts` - Stellar operations
- `app/src/navigation/AppContainer.tsx` - App structure
- `app/src/scenes/AuthOverlay/AuthOverlay.tsx` - Authentication overlay
- `app/src/navigation/TabNavigator.tsx` - Main navigation

## Testing Strategy

### Reproduction Steps
1. Log out of the app
2. Log back in with existing account
3. Observe app behavior immediately after login
4. Note duration of unresponsiveness
5. Test on different devices/network conditions

### Success Criteria
- [ ] No unresponsive period after login
- [ ] Immediate navigation functionality
- [ ] No blocking overlays
- [ ] Smooth transition to main app

### Test Scenarios
- [ ] Fast network connection
- [ ] Slow network connection
- [ ] Network interruption during login
- [ ] Different device types (iOS/Android)
- [ ] First-time vs returning users

## Implementation Progress

### Phase 1: Diagnosis & Logging
- [x] Add comprehensive logging to identify timing issues
- [x] Implement performance monitoring
- [x] Add state transition tracking

### Phase 2: Quick Wins
- [x] Fix AnimatedSplashScreen timeout issues
- [ ] Add network operation timeouts
- [ ] Implement overlay cleanup

### Phase 3: Architectural Improvements
- [ ] Refactor initialization flow
- [ ] Implement proper loading states
- [ ] Optimize GraphQL query strategy

## Notes
- Focus on Hypothesis 1 first as it's most likely and has clear fix path
- Consider device performance variations in testing
- Monitor both timing and user interaction capabilities
- Test thoroughly on both iOS and Android platforms

## Status Legend
- ⏳ Not Started
- 🔄 In Progress  
- ✅ Complete
- ❌ Failed/Abandoned
- 🧪 Testing