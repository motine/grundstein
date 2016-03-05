## Code Style

We are using this [Rubocop](https://github.com/bbatsov/rubocop) to enforce coding style.

```bash
rake rubocop # Run before each commit/push
rake rubocop:auto_correct # auto-corrects issues where it can

rubocop --only Style/TrailingBlankLines --auto-correct # correct only a single offense type
```

If you are a hundred percent sure you are doing the right thing, you can disable checking. Either

- disable them for a particular line/method/class with: `# rubocop:disable Metrics/LineLength, Style/StringLiterals`
- or disable rubocop for the full file: `# rubocop:disable all`
