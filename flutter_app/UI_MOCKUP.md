# Flutter App UI Mockup (Text Description)

Since actual screenshots can't be generated in this environment, here's a detailed text-based mockup of what the app looks like:

## 📱 Home Screen Layout

```
┌─────────────────────────────────────┐
│  🏋️ Gym Workout Tracker            │ ← AppBar (Purple)
└─────────────────────────────────────┘

┌──────────────────┬──────────────────┐
│                  │                  │
│       💪         │       🔙         │
│                  │                  │
│   Push Day       │   Pull Day       │
│                  │                  │
│ Chest, Shoulders │   Back, Biceps   │
│    Triceps       │                  │
│                  │                  │
│  [RED GRADIENT]  │ [BLUE GRADIENT]  │
└──────────────────┴──────────────────┘

┌──────────────────┬──────────────────┐
│                  │                  │
│       🦵         │       📊         │
│                  │                  │
│    Leg Day       │  Workout History │
│                  │                  │
│  Quads, Hams,    │   Last 7 days    │
│  Glutes, Calves  │                  │
│                  │                  │
│ [GREEN GRADIENT] │[ORANGE GRADIENT] │
└──────────────────┴──────────────────┘

┌──────────────────┬──────────────────┐
│                  │                  │
│       📈         │       🎯         │
│                  │                  │
│    Exercise      │  Missed Groups   │
│    Breakdown     │                  │
│                  │   Check gaps     │
│  Detailed stats  │   in training    │
│                  │                  │
│[PURPLE GRADIENT] │ [TEAL GRADIENT]  │
└──────────────────┴──────────────────┘
```

## 💪 Log Workout Screen (Push Day Example)

```
┌─────────────────────────────────────┐
│ ← Push Day 💪                       │ ← AppBar
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ ┌─────────────────────────────────┐ │
│ │ Push-ups                    ⊕   │ │
│ │ Chest                           │ │
│ └─────────────────────────────────┘ │
│                                     │
│ ┌─────────────────────────────────┐ │
│ │ Bench Press                 ⊕   │ │
│ │ Chest                           │ │
│ └─────────────────────────────────┘ │
│                                     │
│ ┌─────────────────────────────────┐ │
│ │ Shoulder Press              ⊕   │ │
│ │ Shoulders                       │ │
│ └─────────────────────────────────┘ │
│                                     │
│ ┌─────────────────────────────────┐ │
│ │ Tricep Dips                 ⊕   │ │
│ │ Triceps                         │ │
│ └─────────────────────────────────┘ │
│                                     │
│      ... (more exercises) ...       │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│  Logged: 3 exercise(s)              │ ← Bottom bar
│                                     │   (appears after
│  [  ✓  Finish Workout  ]            │    logging)
└─────────────────────────────────────┘
```

## 💬 Set Entry Dialog

```
┌───────────────────────────────────┐
│  Log Bench Press                  │
├───────────────────────────────────┤
│                                   │
│  Already logged sets:             │
│                                   │
│  ⓵ 60kg × 10 reps         [🗑️]   │
│  ⓶ 65kg × 8 reps          [🗑️]   │
│                                   │
│  ────────────────────────────     │
│                                   │
│  Weight (kg)                      │
│  ┌─────────────────────────┐     │
│  │ [          ]            │     │
│  └─────────────────────────┘     │
│                                   │
│  Reps                             │
│  ┌─────────────────────────┐     │
│  │ [          ]            │     │
│  └─────────────────────────┘     │
│                                   │
│  [    ⊕  Add Set    ]             │
│                                   │
├───────────────────────────────────┤
│  [Cancel]            [Done]       │
└───────────────────────────────────┘
```

## 📊 Workout History Screen

```
┌─────────────────────────────────────┐
│ ← Workout History                   │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ Monday, February 3, 2026            │
├─────────────────────────────────────┤
│                                     │
│ • Bench Press                       │
│   Chest                             │
│   3 sets • 1575kg vol               │
│                                     │
│ • Shoulder Press                    │
│   Shoulders                         │
│   3 sets • 1122kg vol               │
│                                     │
│ • Tricep Dips                       │
│   Triceps                           │
│   3 sets • 0kg vol                  │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ Sunday, February 2, 2026            │
├─────────────────────────────────────┤
│                                     │
│ • Pull-ups                          │
│   Back                              │
│   4 sets • 0kg vol                  │
│                                     │
│ • Barbell Rows                      │
│   Back                              │
│   3 sets • 1650kg vol               │
└─────────────────────────────────────┘
```

## 📈 Exercise Breakdown Screen

```
┌─────────────────────────────────────┐
│ ← Exercise Breakdown                │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ 📅 Monday, February 3, 2026    ▼    │ ← Date selector
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ ▶ Chest                             │
│   3 sets • 1575kg total volume      │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ ▼ Shoulders                         │
│   3 sets • 1122kg total volume      │
├─────────────────────────────────────┤
│                                     │
│   Shoulder Press:                   │
│     Set 1: 40kg × 10 reps           │
│     Set 2: 42.5kg × 9 reps          │
│     Set 3: 42.5kg × 8 reps          │
│                                     │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ ▶ Triceps                           │
│   3 sets • 0kg total volume         │
└─────────────────────────────────────┘
```

## 🎯 Missed Muscle Groups Screen

```
┌─────────────────────────────────────┐
│ ← Missed Muscle Groups              │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ 📅 Monday, February 3, 2026    ▼    │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ ✓ Worked Muscle Groups              │
│                                     │
│  [Chest]  [Shoulders]  [Triceps]    │
│                                     │
│  (Green chips with fitness icons)   │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ ⚠ Missed Muscle Groups              │
│                                     │
│  [Back]  [Biceps]  [Quads]          │
│  [Hamstrings]  [Glutes]  [Calves]   │
│                                     │
│  (Orange chips with warning icons)  │
└─────────────────────────────────────┘
```

## 🎨 Color Scheme

### Light Mode
```
Backgrounds:  White (#FFFFFF), Light Gray (#F5F5F5)
Text:         Dark Gray (#212121), Medium Gray (#757575)
Primary:      Deep Purple (#673AB7)
Cards:        White with shadow

Workout Type Gradients:
- Push:   #EF5350 → #E91E63 (Red to Pink)
- Pull:   #2196F3 → #03A9F4 (Blue shades)
- Legs:   #4CAF50 → #8BC34A (Green shades)
- History: #FF9800 → #FF5722 (Orange shades)
- Breakdown: #9C27B0 → #673AB7 (Purple shades)
- Missed: #009688 → #00BCD4 (Teal shades)
```

### Dark Mode
```
Backgrounds:  Dark Gray (#121212), Darker Gray (#1E1E1E)
Text:         White (#FFFFFF), Light Gray (#E0E0E0)
Primary:      Light Purple (#9575CD)
Cards:        Elevated dark surfaces

(Same gradients but with adjusted opacity)
```

## 📐 Layout Specifications

### Home Screen Cards
- Size: Equal width/height squares
- Padding: 16px around grid
- Spacing: 16px between cards
- Corner Radius: 12px
- Elevation: 4px shadow

### Text Sizes
- AppBar Title: 20px, Bold
- Card Title: 18px, Bold
- Card Subtitle: 12px, Regular
- Emoji: 48px
- Body Text: 14px, Regular

### Touch Targets
- Minimum: 48×48px
- Buttons: 48px height
- Cards: Full card tappable
- Icons: 24×24px with 48×48px tap area

## 🎭 Animations

- Card tap: Ripple effect from touch point
- Screen transitions: Slide animation (300ms)
- Dialog appear: Fade + scale (200ms)
- Loading: Circular progress indicator
- Snackbar: Slide up from bottom (250ms)

## 📱 Responsive Behavior

### Phone (Portrait)
- 2 columns grid
- Full width cards
- Bottom navigation ready

### Tablet
- 3 columns grid
- Wider dialogs
- More visible content

### Desktop
- Fixed max width (1200px)
- Larger text
- Mouse hover effects
- Keyboard shortcuts support

This gives you a complete picture of how the Flutter app looks and behaves across all platforms!
```
