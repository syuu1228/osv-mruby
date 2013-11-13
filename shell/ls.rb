
module MrubyShell::Ls
  def self.included(klass)
    MrubyShell.register("ls", LsCommand.new)
  end

  class LsCommand < ::MrubyShell::CommandBase
    def exec(*args)
      dir = args[0]
      dir = "." if dir == nil
      p Dir.entries(dir)
    end

    def help
      puts "ls <dir>"
    end
  end
end

