require './bot_commands_class.rb'
require 'date'

class Twitch_Bot
    attr_reader :running, :socket

    def initialize
        # Initialize variables
        @running = false
        @socket  = nil
    end

    def send(m)
        # This function sends a message :^)
        socket.puts(m)
        #puts ">>> #{m}"
    end

    def send_message(m, c)
        #send "PRIVMSG ##{channel_name} :test"
        send "PRIVMSG ##{c} :#{m}"
    end

    def run token, bot_name, channel_name
        # Make a connection to twitch and do running=true
        @socket = TCPSocket.new("irc.chat.twitch.tv", 6667)
        @running = true
        
        socket.puts("PASS #{token}")
        socket.puts("NICK #{bot_name}")
        socket.puts("JOIN ##{channel_name}")

        while (running) do
            buffer = IO.select([socket])
            buffer[0].each do |s|
                # Main "Loop"
                line = s.gets
                # This is where we do the ping pong
                if line == "PING :tmi.twitch.tv\r\n"
                    send "PONG :tmi.twitch.tv"
                end
                # Split
                t_line = line.split("tmi.twitch.tv PRIVMSG ##{channel_name} ")
                # Reason why t_line.size is 1 is because we only get
                # "PRIVMSG" When someone sends a message :^)
                # So we only want to do the shit if we actually got a message
                if t_line.size > 1
                    user = t_line[0].split("!")[0].gsub(":", "")
                    message = t_line[1].to_s.sub(":", "")
                    commands = Commands.new(message, user)
                    logs(channel_name,user,message)
                    if user == ("puka_" or "void277") && message == "!die\r\n"
                        send_message("Im Dead!", channel_name) 
                        stop
                    end
                    send_message(commands.check, channel_name)
                    puts "#{user} -> #{message}"
                end
            end
        end
    end
    
    def logs channel_name, user, message
        # Write LOGS!
        # Folder_exists returns true or false :)
        folder_exists = system 'mkdir', '-p', channel_name
        unless folder_exists
            Dir.mkdir channel_name
        end
        File.open("#{channel_name}/LOGS", "a") do |line|
            line.print "\r#{DateTime.now}[#{channel_name}]#{user} -> #{message}"
        end
        # END LOGS
    end

    def stop
        # Stop the bot
        @running = false
    end

end
