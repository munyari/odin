#!/usr/bin/env ruby

require "socket"
require "json"

#host = "www.google.com" # The web server
host = "localhost"                # The web server
port = 2000                       # Default HTTP port

req_type = nil
until [1, 2].include?(req_type)
  puts "Would you like to send a GET [1] or a POST [2] request?"
  req_type = gets.to_i
end

if req_type == 1
  path = "/index.html"             # The file we want

  # This is the HTTP request we send to fetch the file
  request = "GET #{path} HTTP/1.1\r\n\r\n"


else
  puts "Hello loyal viking brother! Before embarking on your first raid, you\n
  must enlist by providing your name and email address"
  print "name: "
  name = gets.chomp
  print "email: "
  email = gets.chomp
  form_data = {:viking => {:name=>name, :email=>email}}
  json = form_data.to_json
  request = "POST /thanks.html HTTP/1.1\n"
  request += "From: user@example.com\n"
  request += "User-Agent: OdinBrowser/1.0\n"
  request += "Content-Type: application/x-www-urlencoded\n"
  request += "Content-Length: #{json.bytesize}\r\n\r\n"
  request += "#{json}\r\n\r\n"
end

socket = TCPSocket.open(host, port) # Connect to server
socket.print(request)               # Send request
response = socket.read              # Read complete response

# Split response at first blank line into headers and body
headers, body = response.split("\r\n\r\n", 2)
#puts body
puts response
