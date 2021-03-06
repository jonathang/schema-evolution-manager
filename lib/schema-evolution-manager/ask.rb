module SchemaEvolutionManager
  require 'io/console'
  # Simple library to ask user for input, with easy mocakability for
  # testing
  class Ask

    TRUE_STRINGS = ['y', 'yes'] unless defined?(TRUE_STRINGS)

    # Asks the user a question. Expects a string back.
    def Ask.for_string(message, opts={})
      default = opts.delete(:default)
      Preconditions.assert_empty_opts(opts)

      final_message = message.dup
      if default
        final_message << " [%s] " % default
      end

      value = nil
      while value.to_s == ""
        print final_message
        value = get_input.strip
        if value.to_s == "" && default
          value = default.to_s.strip
        end
      end
      value
    end

    # Asks the user a question. Returns a boolean. Boolean is defined as
    # matching the strings 'y' or 'yes', case insensitive
    def Ask.for_boolean(message)
      value = Ask.for_string("%s (y/n) " % message)
      TRUE_STRINGS.include?(value.downcase)
    end

    def Ask.for_password()
      password =  STDIN.noecho(&:gets)
    end

    # here to help with tests
    def Ask.get_input
      STDIN.gets
    end

  end

end
