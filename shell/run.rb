
module MrubyShell::Run
  def self.included(klass)
    MrubyShell.register("run", RunCommand.new)
  end

  class RunCommand < ::MrubyShell::CommandBase
    def exec(*args)
      fn = args[0]
      unless fn
        puts "run requires more argument"
        return
      end
      f = File.open(fn)
      prog = f.read
      eval(prog)
    end

    def help
      puts "run <file>"
    end
  end
end

