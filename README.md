# Circular Progress Pie

A highly customizable, animated pie chart progress indicator for Flutter with smooth animations, gradients, and multiple animation types.

![Demo](https://raw.githubusercontent.com/abqamar/circular_progress_pie/refs/heads/main/screenshot/sample_video.gif)

## Features

- 🎨 **Highly customizable** - Colors, sizes, strokes, gradients
- ⚡ **Smooth animations** - Multiple animation types
- 🎯 **Multiple variants** - Filled pie, circular ring, percentage indicator
- 🔄 **Flexible** - Custom start angles, reverse direction
- 📱 **Easy to use** - Simple API with sensible defaults

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  circular_progress_pie: ^0.0.1
```

### Basic Usage
```dart
PieProgressIndicator(
  value: 0.75, // Value between 0.0 and 1.0
  size: 100,
  progressColor: Colors.blue,
)
```

### Circular Ring Style
```dart
PieProgressIndicator.circular(
  value: 0.6,
  size: 60,
  progressColor: Colors.green,
  strokeWidth: 5,
)
```

### Percentage Indicator
```dart
PieProgressIndicator.percentage(
  value: 0.8,
  size: 120,
  progressColor: Colors.purple,
)
```

### Gradient Progress
```dart
PieProgressIndicator.gradient(
  value: 0.7,
  gradient: LinearGradient(colors: [Colors.red, Colors.blue]),
)
```
## Properties
| Property            | Type             | Default                | Description                                     |  
|---------------------|------------------|------------------------|-------------------------------------------------|
| value               | double           | required               | Progress value between 0.0 and 1.0              |  
| size                | double           | 100.0                  | Width and height of the indicator               |  
| backgroundColor     | Color            | Color(0xFFE0E0E0)      | Background color of the pie                     |  
| progressColor       | Color            | Colors.blue            | Color of the progress arc                       |  
| progressGradient    | Gradient?        | null                   | Gradient for progress (overrides progressColor) |
| strokeWidth         | double           | 10.0                   | Stroke width for ring-style progress            |
| isFilled            | bool             | true                   | Whether to draw filled pie or ring              |
| animationType       | PieAnimationType | PieAnimationType.sweep | Type of animation effect                        |
| duration            | Duration         | 800ms                  | Animation duration                              |
| curve               | Curve            | Curves.easeInOut       | Animation curve for sweep type                  |
| startAngle          | double           | -pi/2 (top)            | Starting angle in radians                       |
| reverse             | bool             | false                  | Animate in reverse direction                    |
| animate             | bool             | true                   | Whether to show animation                       |
| child               | Widget?          | null                   | Widget to display in center                     |
| onAnimationComplete | VoidCallback?    | null                   | Callback when animation completes               |

## PieAnimationType Values
| Value   | Description                       | Curve Used         |
|---------|-----------------------------------|--------------------|
| sweep   | Smooth sweep animation (default)  | Custom curve       |
| bounce  | Bounce effect at the end          | Curves.bounceOut   |
| elastic | Elastic overshoot effect          | Curves.elasticOut  |
| fill    | Fill from center outward          | Curves.easeInCubic |

## Quick Constructors
| Constructor                       | Description                 | Example                                                          |
|-----------------------------------|-----------------------------|------------------------------------------------------------------|
| PieProgressIndicator.circular()   | Ring-style progress bar     | PieProgressIndicator.circular(value: 0.7, size: 60)              |
| PieProgressIndicator.percentage() | Percentage with center text | PieProgressIndicator.percentage(value: 0.8)                      |
| PieProgressIndicator.gradient()   | Gradient progress indicator | PieProgressIndicator.gradient(value: 0.6, gradient: myGradient)  |


<table>
<td>
<img src="https://raw.githubusercontent.com/abqamar/circular_progress_pie/refs/heads/main/screenshot/sample_video.gif", alt="", height="1280px", width="720px"/>
</td>
</table>