# OCR parser

Parser for parsing OCR text. It takes a file path as input and prints all the data extracted in structured format i.e. json.

# Input format
Refer to file [pan-outputs.txt](https://github.com/Khusbu/ocr_parser/blob/master/pan-outputs.txt) as a sample file.

# Output format
JSON structure with name, father's name, pan no., date of birth(dob) as fields.

## Dependencies

- ruby 2.3.1p112
- Ruby gem - [json](https://rubygems.org/gems/json/versions/1.8.3)

## Usage

```
ruby ocr_parser.py [file_path]
```

For example,
```
ruby ocr_parser.py pan-output.txt
```
