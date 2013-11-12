
ls = Proc.new do |dir|
	dir = "." if dir == nil
	p Dir.entries(dir)
end

run = Proc.new do |fn|
	if fn == nil
		puts "run requires more argument"
		return
	end
	f = File.open(fn)
	prog = f.read
	eval(prog)
end

_exit = Proc.new do ||
	exit
end

help = Proc.new do ||
	puts "ls <dir>"
	puts "run <file>"
	puts "exit"
end

funcs = {"ls" => ls, "run" => run, "exit" => _exit, "help" => help}

puts "OSv/mruby shell"

loop do
	print "$ "
	line = gets.split(/ /)
	line[line.length - 1].chop!
	if funcs.key? line[0]
		begin
			func = funcs[line[0]]
			func.call line[1]
		rescue => e
			p e
		rescue SyntaxError => e
			p e
		end
	else
		help.call
	end
end
