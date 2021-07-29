# convex_bottom_app_bar

customisable bottom app bar

## Usage
```yaml
convex_bottom_app_bar: ^1.0.0
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
      bottomNavigationIcons: [
        BottomNavigationIcon(
          Icons.home,
          index: 0,
          title: "Home",
          selectedColor: Colors.red,
        ),
        BottomNavigationIcon(
          Icons.search,
          index: 1,
          title: "Search",
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.lightGreen),
          selectedColor: Colors.green,
        ),
        BottomNavigationIcon(
          Icons.card_travel,
          index: 2,
          selectedColor: Colors.blue,
        ),
        BottomNavigationIcon(
          Icons.favorite_border,
          index: 3,
          title: "Fav",
          /// override onClick for only one items
          overrideOnClick: (index) {
            setState(() {
              currentPage = index;
            });
          },
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

# BottomNavigationIcon

Param Name        | Type        | Description
:-------------------------|-------------------------|-------------------------
| icon           | IconData | Icon of the bottom navigator item
| isEnable   | bool?    | is bottom navigator item enabled
| index | int   | index of bottom navigator item
| title | String?   | title of bottom navigator item
| titleTextStyle | TextStyle?   | tittle text style
| overrideOnClick | Function(int)?  | overriding parent onClick 
| selectedColor | Color?    | color of selected bottom navigator item
| disabledColor | Color?    | disabled color bottom navigator item


## Created & Maintained By

[Dwiky Hardiansah](https://github.com/dwikyhardi/) ([Twitter](https://twitter.com/dwikyhardi)) ([Insta](https://www.instagram.com/dwikyhardi_/)) 