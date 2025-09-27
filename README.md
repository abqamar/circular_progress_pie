# Circular Progress Pie

A highly customizable, animated pie chart progress indicator for Flutter with smooth animations, gradients, and multiple animation types.

![Demo](https://via.placeholder.com/400x200?text=Pie+Progress+Indicator)

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

Property	Type	Default	Description
value	double	required	Progress value (0.0 to 1.0)
size	double	100.0	Width and height of the indicator
progressColor	Color	Colors.blue	Color of the progress arc
backgroundColor	Color	Color(0xFFE0E0E0)	Background color
strokeWidth	double	10.0	Stroke width for ring style
isFilled	bool	true	Whether to draw filled pie or ring
animationType	PieAnimationType	sweep	Type of animation
duration	Duration	800ms	Animation duration
curve	Curve	Curves.easeInOut	Animation curve
startAngle	double	-pi/2	Starting angle (top)
reverse	bool	false	Animate in reverse direction
child	Widget?	null	Center widget


