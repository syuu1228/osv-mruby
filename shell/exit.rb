
module MrubyShell::Exit
  def self.included(klass)
    command = ExitCommand.new
    MrubyShell.register("quit", command)
    MrubyShell.register("exit", command)
  end

  class ExitCommand < ::MrubyShell::CommandBase
    def exec(*args)
      exit
    end
  end
end

