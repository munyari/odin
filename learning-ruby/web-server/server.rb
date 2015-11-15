#!/usr/bin/env ruby

require "socket"
require "uri"
require "json"

# Files will be served from this directory
WEB_ROOT = "/home/nash/code/odin/learning-ruby/web-server"

# Map extensions to their content type
CONTENT_TYPE_MAPPING = {
  "html" => "text/html",
  "txt" => "text/plain",
  "png" => "image/png",
  "jpg" => "image/jpeg"
}

# Treat as binary data if content type cannot be found
DEFAULT_CONTENT_TYPE = "application/octet-stream"

# This helper function parses the extension of the
# requested file and then looks up its content type.
#
def content_type(path)
  ext = File.extname(path).split(".").last
  CONTENT_TYPE_MAPPING.fetch(ext, DEFAULT_CONTENT_TYPE)
end

# Takes a request line (e.g. "GET /path?foo=bar HTTP/1.1")
# and extracts the path from it, scrubbing out parameters
# and unescaping URI-encoding
#
# This cleaned up path (e.g. "/path") is then converted into a relative path 
# to a file in the server"s public folder by joining it with the WEB_ROOT and
# sanitized to keep the path strictly in the public folder
def requested_file(request)
  request_uri = request.split(" ")[1]
  path = URI.unescape(URI(request_uri).path)

  clean = []

  # Split the path into components
  parts = path.split("/")

  parts.each do |part|
    # skip any empty or current current directory (".") path components
    next if part.empty? || part == "."
    # If the path component goes up one directory level (".."),
    # remove the last clean component
    # Otherwise, add the component to the Array of clean components
    part == ".." ? clean.pop : clean << part
  end

  # return the web root joined to the client path

  File.join(WEB_ROOT, *clean)
end

server = TCPServer.new("localhost", 2000)

loop do
  socket = server.accept

  request = socket.gets

  STDERR.puts request
  # GET or POST
  req_type = /(?:^|(?:[.!?]\s))(\w+)/.match(request)[0]

  if req_type == "GET"
    path = requested_file(request)
    path = File.join(path, "index.html") if File.directory?(path)

    if File.exist?(path) && !File.directory?(path)
      File.open(path, "rb") do |file|
        socket.print "HTTP/1.1 200 OK\r\n" +
          "Content-Type: #{content_type(file)}\r\n" +
        "Content-Length: #{file.size}\r\n" +
        "Connection: close\r\n"

        socket.print "\r\n"

        IO.copy_stream(file, socket)
      end
    else
      message = "File not found\n"

      socket.print "HTTP/1.1 404 Not Found\r\n" +
        "Content-Type: text/plain\r\n" +
        "Content-Length: #{message.size}\r\n" +
      "Connection: close\r\n"

      socket.print "\r\n"

      socket.print message
    end
  elsif req_type == "POST"
    path = requested_file(request)
    path = File.join(path, "index.html") if File.directory?(path)
    file = File.open(path)
    # VERY hackish way to get the JSON line
    5.times { socket.gets }
    form_json = socket.gets
    form_hash = JSON.parse(form_json)
    html_str = ""
    form_hash.each_pair do |k, v|
      v.each_pair do |attribute, value|
        html_str += "<li>#{attribute}: #{value}</li>"
      end
    end
    socket.puts file.read.gsub("<%= yield %>", html_str)
    file.close

  end

  socket.close

end
