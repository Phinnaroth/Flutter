final List<Map<String, String>> jokes = List.generate(20, (index) {
  return {
    'title': 'Joke ${index + 1}',
    'description': 'Description ${index + 1}',
  };
});
