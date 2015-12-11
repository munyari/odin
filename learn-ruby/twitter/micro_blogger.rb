require 'jumpstart_auth'

class MicroBlogger
  attr_reader :client

  def initialize
    puts "Initializing..."
    @client = JumpstartAuth.twitter
  end

  def tweet(message)
    if message.size <= 140
      @client.update(message)
    else
      puts "Error, the message is too long!"
    end
  end

  def dm(target, message)
    screen_names = followers_list
    if screen_names.include?(target)
      puts "Trying to send #{target} this direct message:"
      puts message
      message = "d @#{target} #{message}"
      tweet(message)
    else
      puts "Error. You may only DM people who follow you."
    end
  end

  def followers_list
    @client.followers.collect do |follower|
      @client.user(follower).screen_name
    end
  end

  def spam_my_followers(message)
    followers_list.each { |follower| dm(follower, message) }
  end

  def everyones_last_tweet
    #p @client.methods - Object.methods
    puts @client.class
    #puts @client.friends.attrs
    #friends = @client.friends
    #friends.each do |friend|
      #puts friend.class
      #puts friend.screen_name
      ##puts friend.status.text
      #uts friend.status.created_at
      #puts ""
    #end
  end

  def run
    puts "Welcome to the JSL Twitter Client!"
    input = ""
    while input != "q"
      print "enter input: "
      input = gets.chomp
      parts = input.split(/\s+/)
      command = parts[0]

      case command
      when 'q' then puts "Goodbye!"
      when 't' then tweet(parts[1..-1].join(" "))
      when 'dm' then dm(parts[1], parts[2..-1].join(" "))
      when 'sp' then spam_my_followers(parts[1..-1].join(" "))
      when 'e' then everyones_last_tweet
      else
        puts "Sorry, I don't know how to #{input}"
      end
    end
  end
end

blogger = MicroBlogger.new
message = "Here's another one!"
blogger.run



