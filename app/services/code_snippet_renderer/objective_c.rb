module CodeSnippetRenderer
  class ObjectiveC
    def self.dependencies(_deps)
      {
        'text' => 'See <a href="https://developer.nexmo.com/tutorials/client-sdk-ios-add-sdk-to-your-app">How to Add the Nexmo Client SDK to your iOS App</a>',
      }
    end

    def self.run_command(_command, _filename, _file_path)
      nil
    end

    def self.create_instructions(filename)
      "Create a file named `#{filename}` and add the following code:"
    end

    def self.add_instructions(_filename)
      'Add the following to your code:'
    end
  end
end
