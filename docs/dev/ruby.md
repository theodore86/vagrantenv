# What is Ruby?

Ruby is a pure Object-Oriented language developed by Yukihiro Matsumoto (also known as Matz in the Ruby community) in the mid 1990’s in Japan. Everything in Ruby is an object except the blocks but there are replacements too for it i.e procs and lambda. The objective of Ruby’s development was to make it act as a sensible buffer between human programmers and the underlying computing machinery. Ruby has similar syntax to that of many programming languages like C and Java, so it is easy for Java and C programmers to learn. It supports mostly all the platforms like Windows, Mac, Linux.

# What can you do with Ruby?

You can use Ruby just like you would use any other general-purpose scripting language. A few examples would be web applications, web servers, system utilities, database work, backups, parsing.

So you can use Ruby to do a lot of things. It’s not going to be good at all of them but at least it will allow you to get started, test some ideas and help you figure out if you need a more specialized language or not.

# What are the Prons and Cons?

*Prons:*

- The code written in Ruby has a fewer number of lines of code.
- This language allows simple and fast creation of Web application which results in much fewer efforts.
- It is an open source programming language which allows the programmers to modify the code as needed.
- Ruby is a dynamic programming language. It is also very close to spoken languages.

*Cons:*

- It is fairly new and has its own unique coding language which makes it difficult for the programmers to learn it. After much practice, it gets easy.
- The code written in Ruby is harder to debug as most of the time it generates the errors at runtime.
- When compared to other languages, Ruby has very less informational resources to learn the language.
- It is slower than other languages as it is an interpreted scripting language and the scripting languages are slower than the compiled languages.

# Why Ruby in this project?

Vagrant tool is purely written in Ruby programming language. A Vagrantfile is just Ruby! Writing Vagrantfiles is tedious, especially when you're setting up multi-VM environments. Typically people copy/paste blocks that define hosts but that becomes unwieldy. When the complexity of your environment grows, this becomes harder and harder to maintain.

To solve this problem this project introduced an *universal Vagrantfile* where each vagrant configuration option maps to an single method. Each method belongs to an single Ruby module. Properties of the virtual/guest machine are stored in a separate YAML file known as ```vagrant.yaml```.The Vagrantfile will parse the YAML file and apply the settings to the virtual machine.

Example:

```yaml
# Proxy properties
# https://github.com/tmatilai/vagrant-proxyconf
:proxy:
    :http:
        :address: &addr '10.144.1.10'
        :port: &port 8080
    :https:
        :address: *addr
        :port: *port
    :enabled: true
    :no_proxy: '127.0.0.1,localhost'
```

The Vagrantfile will parse the YAML and convert it to a Ruby data structure, specifically a Hash of Hashes:

```ruby
PROJECT_PATH = File.dirname(File.expand_path(__FILE__))
CONFIG = YAML.load_file(File.join(PROJECT_PATH, 'vagrant.yaml'))
PROXY = CONFIG[:proxy]
```

Then inside the Vagrantfile the respective Ruby module is *required* and the appropriate method is called having as argument values the appropriate vagrant configuration option and the properties from the YAML file:

```ruby
require_relative 'lib/vagrant-proxy'

#-- Proxy Settings --#
if Vagrant.has_plugin?("vagrant-proxyconf")
    Proxy.conf(config, PROXY)
end
```

# Cool Ruby Projects

- [Vagrant](https://github.com/hashicorp/vagrant) - a tool for building and distributing development environments.
- [Homebrew](https://brew.sh/) - the missing package manager for macOS.
- [Rails](https://rubyonrails.org/) - the most popular web framework for Ruby.
- [Chef](https://www.chef.io/chef/) - configuration management tool written in Ruby.

# References

- [Ruby For Beginners](http://ruby-for-beginners.rubymonstas.org/index.html)
- [Ruby Basic Tutorial](http://www.troubleshooters.com/codecorn/ruby/basictutorial.htm)
- [Ruby Programming Language](https://www.tutorialspoint.com/ruby/)
