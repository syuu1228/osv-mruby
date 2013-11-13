
require_relative "ls"
require_relative "run"
require_relative "exit"

module MrubyShell
  include MrubyShell::Ls
  include MrubyShell::Run
  include MrubyShell::Exit
end

