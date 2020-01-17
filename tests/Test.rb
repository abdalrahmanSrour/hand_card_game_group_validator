#!/usr/bin/ruby -w

class SR_CheckError < StandardError
    def initialize(msg="Check failed")
        super
    end # initialize
end # class

class SR_Test
    def initialize(name, tests)
        raise ArgumentError, '\'name\' argument is not a string' unless name.is_a? String
        raise ArgumentError, '\'tests\' argument is not a hash' unless tests.is_a? Hash

        @name = name;
        @num_of_tests = tests.count;
        @num_of_pass = 0;
        @num_of_checks = 0;
        @tests = tests;
    end # def initialize

    def addTestMethod(name, method)
        raise ArgumentError, '\'name\' argument is not a string' unless name.is_a? String

        if @tests.key?(name)
            raise ArgumentError, '\'name\' test already exits!'
        end # if

        @tests[:name] = method
        @num_of_tests = tests.count;
    end # def addTest

    def checkIf(op, line = __LINE__, file = __FILE__)
        if !op
            puts "Check if fail in #{file}:#{line}"
            puts "operation is false"
            puts "# of passed checks is #{@num_of_checks}"
            raise SR_CheckError, "checkIf failed"
        end # if
        @num_of_checks += 1;
    end # def test

    def checkIfIntEQ(a, b, line = __LINE__, file = __FILE__)
        raise ArgumentError, '\'a\' argument is not an Integer' unless a.is_a? Integer
        raise ArgumentError, '\'b\' argument is not an Integer' unless b.is_a? Integer

        if a != b
            puts "Check if Integer equal fail in #{file}:#{line}"
            puts "first arg = #{a}, while second arg = #{b}"
            puts "# of passed checks is #{@num_of_checks}"
            raise SR_CheckError, "checkIfNumEQ failed"
        end # if
        @num_of_checks += 1;
    end # def checkIfIntEQ

    def checkIfIntNE(a, b, line = __LINE__, file = __FILE__)
        raise ArgumentError, '\'a\' argument is not an Integer' unless a.is_a? Integer
        raise ArgumentError, '\'b\' argument is not an Integer' unless b.is_a? Integer

        if a == b
            puts "Check if Integer not equal fail in #{file}:#{line}"
            puts "both args = #{a}"
            puts "# of passed checks is #{@num_of_checks}"
            raise SR_CheckError, "checkIfNumEQ failed"
        end # if
        @num_of_checks += 1;
    end # def checkIfIntNE

    def checkIfStrEQ(a, b, line = __LINE__, file = __FILE__)
        raise ArgumentError, '\'a\' argument is not a String' unless a.is_a? String
        raise ArgumentError, '\'b\' argument is not a String' unless b.is_a? String

        if a != b
            puts "Check if String equal fail in #{file}:#{line}"
            puts "first arg = #{a}, while second arg = #{b}"
            puts "# of passed checks is #{@num_of_checks}"
            raise SR_CheckError, "checkIfNumEQ failed"
        end # if
        @num_of_checks += 1;
    end # def checkIfStrEQ

    def checkIfStrNE(a, b, line = __LINE__, file = __FILE__)
        raise ArgumentError, '\'a\' argument is not a String' unless a.is_a? String
        raise ArgumentError, '\'b\' argument is not a String' unless b.is_a? String

        if a == b
            puts "Check if String not equal fail in #{file}:#{line}"
            puts "both args = #{a}"
            puts "# of passed checks is #{@num_of_checks}"
            raise SR_CheckError, "checkIfNumEQ failed"
        end # if
        @num_of_checks += 1;
    end # def checkIfStrNE

    def run()
        puts "SR Start test group >> '#{@name}'\n\n"
        if @tests.count == 0
            puts "No tests added!\n\n";
            return false;
        end

        i = 0
        @tests.each do |name, cb|
            i += 1;
            puts "Test ##{i}: '#{name}'";
            begin
                @num_of_checks = 0;
                cb.call(self)
                puts "Test pass, total # of passed tests is #{@num_of_checks}\n\n";
                @num_of_pass += 1;
            rescue SR_CheckError => e
                puts "Test fail, total # of passed tests is #{@num_of_checks}\n\n";
            rescue => e
                puts "Unhandled error while running test #{name}:"
                puts "#{e.class}: #{e.message}"
                puts e.backtrace.join("\n")
                puts "\n\n"
            end # begin
        end # each

        self.finishTest();
        return @num_of_pass == @num_of_tests;
    end # def run

    def finishTest()
        puts "\nSR End test group >> '#{@name}'"
        if @num_of_pass < @num_of_tests
            puts "failed! :("
        else
            puts "finished successfuly! Hooray :D"
        end # if
        puts "Tests passed #{@num_of_pass} of total #{@num_of_tests} tests"
    end # def finishTest
end # class SR_Test