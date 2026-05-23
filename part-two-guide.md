# Introduction to Flutter (Part 2)

## What we will be doing

-   Coding in a maintainable, scalable way
-   Configure multiple screens with router
-   Integrate 3rd party libraries
-   Using RESTful APIs

## Coding in a maintainable, scalable way

<!-- ### Break components down into smaller components -->

### Folder structure

```
.
└── lib/
    ├── constants/
    ├── models/
    ├── screens/
    ├── views/
    ├── services/
    └── widgets/
```

-   `constants` - files that store constant values that are used across the code base. Eg.  API endpoints.
-   `models` - data classes representing objects in your app.
-   `screens` - this is where you put design your screen components, think of it like a different page, similar to a webpage.
-   `views` - this is where you put design your view components. A screen can be made up of multiple views.
-   `widgets` -  generally contains widgets that are **reusable** across the whole app. Eg. our custom`BusStopWidget`.
-   `services` - codes that talk to external APIs or databases. 

### Abstract away reusable components

Without doing so, it will likely lead to any of the two issues, or both:

1. You get inconsistent UI
2. You violate the Don't Repeat Yourself (DRY) SWE principle. There will be unecessary code duplications, and changing anything requires you to change everything.

For instance, here is an example of a reusable button component where you can pass in the necessary type of button and a title. You can then use this button across your app, and it will ensure that the UI is consistent and you are not repeating yourself.:

```dart
import 'package:flutter/material.dart';

class AlertButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final ButtonType type; // Assume enum ButtonType { primary, secondary, danger }

  AlertButton({
    required this.title,
    required this.onPressed,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    // Implementation for the custom button
  }
}
```

Other parts of the code can just import this `AlertButton` and use it. To them, they do not have to know the implementation details of the `AlertButton`.

```dart
import 'package:bus_app/widgets/alert_button.dart';

// ...
AlertButton(
  type: ButtonType.danger,
  title: 'Logout',
  onPressed: () {
    print('Delete Account');
  },
),
AlertButton(
  type: ButtonType.primary,
  title: 'Do Something',
  onPressed: () {
    print('Do something');
  },
),
```

This ensures that the UI is consistent. If you happen to want to change the style of the Button, the changes will apply to all other places in your app. You will start to notice the benefits when your project starts to scale in size.

This is especially useful when you are working as a group. Your orbital partner does not need to create and style a new button every time a button is needed. Instead, he/she can treat the reusable button as a black box and just in the necessary properties.

This example allows users to create different types of button by passing in `type` and `title`. You can choose to implement your reusable components however you want. It is up to you to make it more restrictive or more customisable.

## Integrate 3rd party libraries

### How to install 3rd party libraries

There will be times where you need specific functionalities that might be too time consuming to create on your own. Fortunately, other people in other parts of the world have done it for you, and you just need to install them to use it. 

You can find Flutter and Dart packages on [pub.dev](https://pub.dev/), the official package repository. 

For instance, `google_cloud`, `google_maps_flutter`, `firebase_core`, ...

Since these libraries are created by other people, you can treat them as a black box, and use it based on the interfaces defined in their documentation. You trust that the people who worked on them have made them usable, which might not always be the case.

### What to look out for when choosing libraries

There could be many libraries that solve the same problem. When deciding which libraries to use, take note of the following:

1. Documentation: Since the implementation details are black boxed away, you mainly rely on the documentation to interact with the components. Make sure that the have proper documentation and their functionalities are what you are looking for.
2. Platform Compatibility: Ensure the package supports the platforms you intend to build for (e.g. Android, iOS, Web). `pub.dev` prominently displays supported platforms for each package.
3. Popularity & Pub Points: Check the package's "likes", Pub Points, and popularity percentile on `pub.dev`. Packages with higher metrics and a "Flutter Favorite" badge are usually well-maintained.

### How to manage dependencies

The `pubspec.yaml` file in your root directory keeps track of the dependencies (or packages) that you have installed. So every time you install a new library, commit your `pubspec.yaml` (and `pubspec.lock`) to GitHub.

When you pull changes from GitHub, you might run into errors when trying to start the app. One common reason is because your partner has probably introduced new dependencies which you have not downloaded.

Make sure to run `flutter pub get` on your terminal to install any new dependencies. You will be surprised by how many errors can be solved by just running this command.

VS Code makes it a lot easier by prompting you to run `flutter pub get` whenever you pull changes that have new dependencies. You can just click on the prompt and it will run the command for you.

### Downsides of 3rd party libraries

Using libraries allow you to focus on the business logic of your application, but do not over rely on them.

1. Lack of control: You are at the mercy of whatever interface is provided by the library. What if in the future, you want a new functionality that is not provided by the library?
2. Maintainance: You cannot be certain that the libraries will continue to be maintained. What if there is a bug for your use case and the it is not being addressed? What if they contain other dependencies that are being deprecated?

## Using RESTful APIs

### Getting NTU Bus Details

Refer to this [video](https://www.youtube.com/watch?v=-mN3VyJuCjM) for an overview of RESTful API.

In simple terms, it is an interface that allows computer to exchange information with one another.

In order to do so, you need to know the URL of the computer (or server) that you want to talk to.

For our example, since the NUS bus API is not public, we will be using the [NTU Bus Api](https://github.com/yeukfei02/ntu-shuttle-bus-api).

In this example, the URL is `https://n784k2f6s0.execute-api.ap-southeast-1.amazonaws.com/prod`, and this [documentation](https://documenter.getpostman.com/view/3827865/UVsHV8qv) tells us the interfaces.

By looking at the documentation, we konw that we need to send a `GET` request to the `/bus-stop-details` endpoint to get the bus stop details. We can then create a function as such:

```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> getBusStopDetails() async {
  try {
    final url = Uri.parse("https://n784k2f6s0.execute-api.ap-southeast-1.amazonaws.com/prod/bus-stop-details");
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
    } else {
      print("Server returned an error: ${response.statusCode}");
    }
  } catch (error) {
    print("Error getting details: $error");
  }
}
```

Notice the use of `async` and `await`. Since we are sending information over the internet, it takes time for the response to come. The `async` makes the function return a `Future` (which represents an asynchronous operation in Dart), and the `await` pauses the execution of the function until the Future is resolved.

You would then get a json response containing the data:

```json
[
    { "busStopId": "378225", "name": "NIE, Opp. LWN Library" },
    { "busStopId": "382999", "name": "Opp. Hall 3 & 16" },
    { "busStopId": "378203", "name": "Opp. Hall 14 & 15" },
    { "busStopId": "383048", "name": "Opp. Saraca Hall" },
    { "busStopId": "378222", "name": "Opposite Hall 11, bus stop" },
    { "busStopId": "383003", "name": "Nanyang Height, Opposite Hall 8 bus stop" },
    { "busStopId": "378234", "name": "Hall 6, Opp. Hall 2" },
    { "busStopId": "383004", "name": "Opp. Hall 4" },
    { "busStopId": "383006", "name": "Opp. Yunnan Gardens" },
    { "busStopId": "383009", "name": "Opp. SPMS" },
    { "busStopId": "383010", "name": "Opp. WKWSCI" },
    { "busStopId": "378226", "name": "Opp. CEE" },
    { "busStopId": "378224", "name": "LWN Library, Opp. NIE" },
    { "busStopId": "382995", "name": "SBS" },
    { "busStopId": "378227", "name": "WKWSCI" },
    { "busStopId": "378228", "name": "Hall 7" },
    { "busStopId": "378229", "name": "Yunnan Gardens" },
    { "busStopId": "378230", "name": "Hall 4" },
    { "busStopId": "378233", "name": "Hall 1 (Blk 18)" },
    { "busStopId": "378237", "name": "Canteen 2" },
    { "busStopId": "382998", "name": "Nanyang Height, Opposite Hall 8 bus stop" },
    { "busStopId": "383049", "name": "Opposite Hall 11, bus stop" },
    { "busStopId": "378202", "name": "Grad Hall 1 & 2" },
    { "busStopId": "383050", "name": "Saraca Hall" },
    { "busStopId": "378204", "name": "Hall 12 &13" },
    { "busStopId": "383091", "name": "Campus Clubhouse, NEC" },
    { "busStopId": "383090", "name": "Blk 96, Staircase 3" },
    { "busStopId": "383093", "name": "Child Care Centre" },
    { "busStopId": "378222", "name": "Opposite Hall 11, bus stop" },
    { "busStopId": "383003", "name": "Nanyang Height, Opposite Hall 8 bus stop" },
    { "busStopId": "383011", "name": "University Health Services(SSC bus stop)" },
    { "busStopId": "383013", "name": "Opposite Administration Building" },
    { "busStopId": "377906", "name": "Pioneer MRT Station Exit B at Blk 649A" },
    { "busStopId": "378233", "name": "Hall 1 (Blk 18)" },
    { "busStopId": "378237", "name": "Canteen 2" },
    { "busStopId": "383011", "name": "University Health Services(SSC bus stop)" },
    { "busStopId": "383013", "name": "Opposite Administration Building" },
    { "busStopId": "383014", "name": "Opposite Food court 2" },
    { "busStopId": "377906", "name": "Pioneer MRT Station Exit B at Blk 649A" },
    { "busStopId": "378233", "name": "Hall 1 (Blk 18)" },
    { "busStopId": "378237", "name": "Canteen 2" },
    { "busStopId": "383011", "name": "University Health Services(SSC bus stop)" },
    { "busStopId": "383013", "name": "Opposite Administration Building" },
    { "busStopId": "378207", "name": "ADM, Hall 8" },
    { "busStopId": "378224", "name": "LWN Library, Opp. NIE" },
    { "busStopId": "383015", "name": "School of CEE" },
    { "busStopId": "382995", "name": "SBS" },
    { "busStopId": "378227", "name": "WKWSCI" },
    { "busStopId": "378228", "name": "Hall 7" },
    { "busStopId": "378229", "name": "Yunnan Gardens" },
    { "busStopId": "378230", "name": "Hall 4" },
    { "busStopId": "383018", "name": "Hall 5" }
]
```

### RESTful APIs with API keys

In some cases, the API provider might require you to use an API key, either to track your usage or for other reasons. One such example is when you are using [OpenAI's API](https://openai.com/index/openai-api/).

An API key is needed for you to make a request. This adds one more layer of complexity (literally). You cannot (more like should not) attach your API key directly in your application code, and these are frontend code that will be accessed by the users.

To use OpenAI's API, you have to setup your own backend server (which stores the APIs key). Instead of making a request to OpenAI directly from your React Native application, you will now make a request to your backend server, your backend server will then attach the API key and make a request to OpenAI. Once your backend server gets a response, it will then return it to the application.

However, this requires you to host your own backend server. One alternative is to use cloud functions like the one provided by [Firebase](https://firebase.google.com/docs/functions).

### Free public API resources

You can get a list of [free public APIs](https://github.com/public-apis/public-apis) here.

## Error handling

It is important for you to handle errors to prevent crashes and improve user experiences. When you are dealing with sending requests over the internet (using RESTful APIs, or database etc.), errors are prone to happen. The users internet might be cut off, your requests might be invalid, the server might be down etc.

## Useful resources

-   [Flutter Documentation](https://docs.flutter.dev/)
-   Free public APIs (https://github.com/public-apis/public-apis)
-   Dribbble, Behance, Pinterest (UI inspirations)
