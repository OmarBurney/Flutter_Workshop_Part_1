# Flutter Workshop Part 1

## Create The Starter Flutter App

### Create The App

1. Invoke View > Command Palette.

    ![open command palette][create-app-step-1]

2. Type “flutter”, and select the Flutter: New Project.

    ![create new project][create-app-step-2]

3. Enter a project name, such as mystartup_namer, and press Enter.

    ![create new project][create-app-step-3]

4. Create or select the parent directory for the new project folder.

5. Wait for project creation to complete and the main.dart file to appear.

    ![create new project][create-app-step-4]

### Run The App

1. Locate the Blue bar at the bottom of VS Code. Make sure that the device is Chrome (at the far right of the blue bar). If it does not say Chrome, Click on it and a pop up will open at the top of the screen. Select the ‘chrome’ option. 
    
    ![check device][create-app-step-5]

2. On the left side of the vscode, click on the run and debug button.

3. On the newly opened panel click the blue button labeled ‘run and debug’

4. Wait for the app to boot up on a new chrome window

## Create Your Own App

### Use an External Package

1. In pubspec.yaml add the dependencies for the english_words package

        dependencies:
            flutter:
                sdk: flutter

            cupertino_icons: ^0.1.2
            english_words: ^3.1.0   # add this line

2. In the terminal in VS Code get the packages for english_words

        flutter packages get
        Running "flutter packages get" in startup_namer...
        Process finished with exit code 0

3. Replace main.dart with the following code. This includes the newly imported package as well as a randomly generated pair of words

        import 'package:flutter/material.dart';
        import 'package:english_words/english_words.dart';

        void main() => runApp(MyApp());

        class MyApp extends StatelessWidget {
            @override
            Widget build(BuildContext context) {
                final wordPair = WordPair.random();
                return MaterialApp(
                    title: 'Welcome to Flutter',
                    home: Scaffold(
                        appBar: AppBar(
                            title: Text('Welcome to Flutter'),
                        ),
                        body: Center(
                            child: Text(wordPair.asPascalCase),
                        ),
                    ),
                );
            }
        }

4.  Refresh chrome app/ Hot Reload it/ Rerun the app to see the changes

### Add a Stateful Widget

1. Create the following class outside of MyApp.

        class RandomWordsState extends State<RandomWords> {
            // TODO Add build method
        }

2. Create the RandomWords class. This class holds the state of the word

        class RandomWords extends StatefulWidget {
            @override
            RandomWordsState createState() => RandomWordsState();
        }
 
3. Add the build() method to RandomWordsState:
  
        class RandomWordsState extends State<RandomWords> {
            @override                              // Add from this line ... 
            Widget build(BuildContext context) {
                final WordPair wordPair = WordPair.random();
                return Text(wordPair.asPascalCase);
            }                                      // ... to this line.
        }

4. Remove the word-generation code from MyApp:

        class MyApp extends StatelessWidget {
            @override
            Widget build(BuildContext context) {
                final WordPair wordPair = WordPair.random();       // Delete this line.

                return MaterialApp(
                    title: 'Welcome to Flutter',
                    home: Scaffold(
                        appBar: AppBar(
                            title: Text('Welcome to Flutter'),
                        ),
                        body: Center(
                            //child: Text(wordPair.asPascalCase), // Change this line
                            child: RandomWords(),                 // ... with this line.
                        ),
                    ),
                );
            }
        }

5. Refresh chrome app/ Hot Reload it/ Rerun the app to see the changes. We should see the same thing as last time

### Create an Infinite Scrolling ListView 

1. We’re going to add two lines of code right below our class RandomWordsState

        class RandomWordsState extends State<RandomWords> {
            // Add the next two lines.
            final List<WordPair> _suggestions = <WordPair>[];
            final TextStyle _biggerFont = const TextStyle(fontSize: 18); 
            ...
        }

2. Add this _buildSuggestions() function to the RandomWordsState class.

        Widget _buildSuggestions() {
            return ListView.builder(
                padding: const EdgeInsets.all(16),
                // The itemBuilder callback is called once per suggested 
                // word pairing, and places each suggestion into a ListTile
                // row. For even rows, the function adds a ListTile row for
                // the word pairing. For odd rows, the function adds a 
                // Divider widget to visually separate the entries. Note that
                // the divider may be difficult to see on smaller devices.
                itemBuilder: (BuildContext _context, int i) {
                    // Add a one-pixel-high divider widget before each row 
                    // in the ListView.
                    if (i.isOdd) {
                        return Divider();
                    }

                    // The syntax "i ~/ 2" divides i by 2 and returns an 
                    // integer result.
                    // For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
                    // This calculates the actual number of word pairings 
                    // in the ListView,minus the divider widgets.
                    final int index = i ~/ 2;
                    // If you've reached the end of the available word
                    // pairings...
                    if (index >= _suggestions.length) {
                        // ...then generate 10 more and add them to the 
                        // suggestions list.
                        _suggestions.addAll(generateWordPairs().take(10));
                    }
                    return _buildRow(_suggestions[index]);
                }
            );
        }

3. Below our _buildSuggestions() widget, we’re going to add another widget called _buildRow (ps. check to make sure that all of this is within your RandomWordsState class!)

        Widget _buildRow(WordPair pair) {
            return ListTile(
                title: Text(
                    pair.asPascalCase,
                    style: _biggerFont,
                ),
            );
        }

4. Then, update the build method for RandomWordsState to use _buildSuggestions()

        @override
        Widget build(BuildContext context) {
            //final wordPair = WordPair.random(); // Delete these... 
            //return Text(wordPair.asPascalCase); // ... two lines.

            return Scaffold (                     // Add from here... 
                appBar: AppBar(
                    title: Text('Startup Name Generator'),
                ),
                body: _buildSuggestions(),
            );                                    // ... to here.
        }

5. Scroll up to your class MyApp and change the title and the home property to a RandomWords Widget.

        @override
        Widget build(BuildContext context) {
            return MaterialApp(
                title: 'Startup Name Generator',
                home: RandomWords(), // check and make sure this is correct!
            );
        }

 6. Refresh chrome app/ Hot Reload it/ Rerun the app to see the changes. This time you should see a list of startup names.

## Next Steps

- TBA


[create-app-step-1]: ./Flutter_Workshop_Part_1/images/create-starter-app-img-01.png "Open Command Palette"
[create-app-step-2]: ./Flutter_Workshop_Part_1/images/create-starter-app-img-02.png "Select New Flutter Project"
[create-app-step-3]: ./Flutter_Workshop_Part_1/images/create-starter-app-img-03.png "Enter Project Name"
[create-app-step-4]: ./Flutter_Workshop_Part_1/images/create-starter-app-img-04.png "Wait for Project Creation"
[create-app-step-5]: ./Flutter_Workshop_Part_1/images/create-starter-app-img-05.png "Set Device to Chrome"