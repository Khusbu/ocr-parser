require 'json'

# constants
INVALID_NAME_PATTERN = /(COME|DEPARTMENT|TAX|GOVT|DEPkRTYEhT|DEPARNENT|[0-9.-]|File)/
PAN_NO_PATTERN = /(?:[a-z]\s*){3}\s*[cphfatblj]\s*[a-z]\s*(?:\d\s*){4}\s*[a-z]\s*/i
DOB_PATTERN = /(?:0?[1-9]|[1-2]\d|3[01])\/(?:0?[1-9]|1[0-2])\/\d{4}/

# get_name extracts name from a line using regex
def get_name(line)
  line.split('\n').each do |l|
    if l !~ INVALID_NAME_PATTERN
      return l.gsub(/(\\r|\\)/,"").strip
    end
  end
  return ""
end

# get_father_name extracts father name from a line using regex
def get_father_name(line)
  k = 1
  line.split('\n').each do |l|
    if l !~ INVALID_NAME_PATTERN
      if k==2
        return l.gsub(/(\\r|\\)/,"").strip
      end
      k = k + 1
    end
  end
  return ""
end

# get_pan_no extracts PAN number from a line using regex.
# PAN number containing spaces extracted and rectified.
def get_pan_no(line)
  line.match(PAN_NO_PATTERN).to_s.gsub(/\s+/, "")
end

# pan_present returns true if pan is non-empty else false
def pan_present(pan)
  pan.nil? || pan.empty? ? false : true
end

# get_dob extracts date of birth (dob) from a line using regex
# DOB in dd/mm/yyyy are only considered valid
def get_dob(line)
  line.match(DOB_PATTERN)
end

# extract_data extracts a data from a line and returns a hash
def extract_data(line)
  hash = {}

  hash['name'] = get_name(line)
  hash['father_name'] = get_father_name(line)
  hash['pan_no'] = get_pan_no(line)
  hash['pan_present'] = pan_present(hash['pan_no'])
  hash['dob'] = get_dob(line)

  hash
end

# takes a file path as input
begin
  File.open(ARGV[0], "r") do |f|
    count = 0
    f.each_line do |line|
      if !line.chomp.empty?
        puts JSON.pretty_generate(extract_data(line))
      end
    end
  end
rescue TypeError => e
  puts "usage: ruby ocr_parser.rb [file_path]"
rescue Exception => e
  puts "Exception: ", e
end
