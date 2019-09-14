require "socket"
require "pry"

=begin
port = ARGV[0] || 80

host = ARGV[1] || "localhost"

ARGV.each do |arg|

  if arg.match(/\d/) == arg
    port = arg
  elsif arg.match(/\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}/) == arg
    host = arg
  end

end
=end

def scan_port(host, port)

  begin

    socket = TCPSocket.new(host, port)

    status = "open"
    puts "Port: #{port}  #{status}"

  rescue

    Errno::ECONNREFUSED
    Errno::ETIMEDOUT

    status = "closed"

  end

  # puts "Port: #{port}  #{status}"

end



def scan(host, ports)

  is_port_range = false

  if ports.include?("-")
    start_port = ports.split("-")[0].to_i
    end_port = ports.split("-")[1].to_i
    is_port_range = true
  else
    ports = ports.to_i
  end

  #binding.pry

  if is_port_range

    (start_port..end_port).each do |port|
      scan_port(host, port)
    end

  else
    scan_port(host, ports)

  end

end


scan("localhost", "1-1000")
