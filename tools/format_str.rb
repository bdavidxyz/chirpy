def format_str(str)
  str
  # Most effective way to remove numbers from string, see https://stackoverflow.com/a/50753455/2595513
  .delete('^0-9')
  # ".scan" returns everything that matches the Regex, see https://ruby-doc.org/core-3.1.0/String.html#method-i-scan
  .scan(/.{1,3}/)
  # Rebuild a string
  .join("-")
  # Swap chars (if needed) so that ABC-D becomes AB-CD
  .tap { |s| s[-2] == '-' ? (s[-2], s[-3] = s[-3], s[-2]) : s }
end

p format_str("AB43 è$ù33''LEMER")
p format_str("555 123 1234")
p format_str("(+1) 888 33x19")
p format_str("aaa")
p format_str("aaa1")
p format_str("a3aa1")
p format_str("a33aa1")
p format_str("a33aa1 #4")
