const String githubApiUrl =
    'https://api.github.com/repos/TonyGnk/algorithms/releases/latest';

//Urls
final codeUrl = Uri(
  scheme: 'https',
  host: 'github.com',
  path: 'TonyGnk/algorithms',
);

final webUrl = Uri(
  scheme: 'https',
  host: 'tonygnk.github.io',
  path: 'algorithms',
);

final flutterUrl = Uri(
  scheme: 'https',
  host: 'flutter.dev',
);

final tonyGnkUrl = Uri(
  scheme: 'https',
  host: 'github.com',
  path: 'TonyGnk',
);

const aboutText = [
  'Node Odyssey',
  'Overview',
  'This Flutter app is designed to tackle problems through advanced algorithms, employing techniques like Breadth-First Search, Depth-First Search, Best First, and A*. It provides a versatile solution by taking a starting value, a target value, and allowing users to select the algorithm that best suits their needs.',
  'Functionality',
  'The core functionality revolves around exploring a path from the specified starting value to the target value. The app supports a variety of algorithms, each offering a unique approach to problem-solving. The allowed calculations include addition (+1), subtraction (-1), multiplication (*2), division (/2), and exponentiation (^2). This ensures flexibility in addressing different scenarios.',
  'Graphical User Interface (GUI)',
  "One of the standout features of this app is its intuitive Graphical User Interface (GUI). The GUI provides a visually appealing representation of the progress made by each algorithm during the search process. Users can observe and analyze the algorithm's steps, gaining insights into its decision-making process.",
  'Key Features',
  'Algorithm Selection: Choose from a range of algorithms, including Breadth-First Search, Depth-First Search, Best First, and A*.',
  'Input Flexibility: Input a starting value and a target value, allowing for a customizable problem-solving experience.',
  'Allowed Calculations: Define the rules of the exploration with permitted calculations (+1, -1, *2, /2, ^2).',
  "Visual Progress: The GUI visually illustrates the algorithm's progress, enhancing user understanding.272215",
];

enum AboutTextSize { small, medium, large }

double findFontSize(AboutTextSize type) {
  switch (type) {
    case AboutTextSize.small:
      return 15;
    case AboutTextSize.medium:
      return 22;
    case AboutTextSize.large:
      return 27;
    default:
      return 22;
  }
}
