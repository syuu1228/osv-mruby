
module MrubyShell
  class CommandBase
    def exec(*args)
    end

    def help
    end
  end

  def self.register(name, klass)
    @commands ||= {}
    @commands[name] = klass
  end

  def self.help
    @commands.each do |name, command|
      if command.is_a? MrubyShell::CommandBase
        command.help
      end
    end
  end

  def self.run
    puts "OSv/mruby shell"

    @commands ||= {}

    loop do
      print "$ "

      begin
        args = gets.chop.split(/ /)
      rescue Interrupt => e
        print "\nbye!\n"
        exit
      rescue NoMethodError => e # Catch NilClass NoMethodError on press Ctrl+D.
        print "\n"
        next
      end

      name = args.shift # $0

      if @commands.key? name
        begin
          command = @commands[name]
          if command.is_a? MrubyShell::CommandBase
            func = command.method(:exec)
            func.call *args
          end
        rescue => e
          p e
        rescue SyntaxError => e
          p e
        end
      else
        help
      end
    end
  end
end

require_relative "shell/_loader"

MrubyShell.run

