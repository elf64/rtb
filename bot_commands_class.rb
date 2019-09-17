require 'net/http'

class Commands
    attr_reader :message, :op, :op_list
    attr_writer :message, :op, :op_list
    def initialize(m, u)
        # m -> Message
        # u -> User who sent the message
        @message = m
        @op = u
        @op_list = ["void277", "pukapy"]
    end

    def check
        # This is where all the commands go!
        ["Hello!", "Hello there!", "Hi!! PogChamp"].sample if message == "!hello\r\n"
    end

    def follow_age
        # TO BE CODED
        # Net::HTTP.get('example.com', '/index.html')
    end

    def new_follower_alert
        # TO BE CODED
    end

    def test
        h = {
            :key => "xD",
            :key2 => "xD2"
        }
    end
end