# convex_bottom_app_bar

customisable bottom app bar

## Usage
```yaml
convex_bottom_app_bar: ^1.0.1
```

```dart
import 'package:convex_bottom_app_bar/convex_bottom_app_bar.dart';
```

## Param Usage
```dart
ConvexBottomAppBar(
  /// onClick for all BottomSheet items
  onClickParent: onBottomIconPressed,
  isUseTitle: true,
  selectedColor: Colors.red,
  unselectedColor: Colors.blue,
  titleTextStyle: TextStyle(
    color: Colors.white,
  ),
  convexBottomAppBarItems: [
    ConvexBottomAppBarItem(
      Icons.home,
      title: "Home",
    ),
    ConvexBottomAppBarItem(
      Icons.search,
      title: "Search",
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.lightGreen,
      ),
      selectedColor: Colors.green,
    ),
    ConvexBottomAppBarItem(
      Icons.card_travel,
    ),
    ConvexBottomAppBarItem(
      Icons.favorite_border,
      title: "Fav",
      /// override onClick for only one items
      overrideOnClick: (index) { },
    ),
  ],
)
```

# ConvexBottomAppBar

Param Name        | Type        | Description        
:-------------------------|-------------------------|-------------------------
| onClickParent           | Function(int)?      | OnClick for all bottom navigator item
| bottomNavigationIcons   | List<BottomNavigationIcon>?         | List Item bottom navigator
| bottomNavigationBackground | Color?       | Background bottom app bar
| isUseTitle | bool     | is bottom navigator item using title
| selectedColor | Color?    | selected color bottom navigator item
| unselectedColor | Color?    | unselected color bottom navigator item

# BottomNavigationIcon

Param Name        | Type        | Description
:-------------------------|-------------------------|-------------------------
| icon           | IconData | Icon of the bottom navigator item
| title | String?   | title of bottom navigator item
| titleTextStyle | TextStyle?   | title text style
| overrideOnClick | Function(int)?  | overriding parent onClick 
| selectedColor | Color?    | override selected color bottom navigator item
| unselectedColor | Color?    | override unselected color bottom navigator item


## Created & Maintained By

[Dwiky Hardiansah](https://github.com/dwikyhardi/) ([Twitter](https://twitter.com/dwikyhardi)) ([Insta](https://www.instagram.com/dwikyhardi_/)) 