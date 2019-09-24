require 'rails_helper'

RSpec.describe TabFilter do
  context 'when no config is provided' do
    it 'raises an exception' do
      input = <<~HEREDOC
        ```tabbed_examples
        ```
      HEREDOC

      expect do
        described_class.new.call(input)
      end.to raise_error('Source or tabs must be present in this tabbed_example config')
    end
  end

  context 'when an invalid config is provided' do
    it 'raises an exception' do
      input = <<~HEREDOC
        ```tabbed_examples
        foo: 'bar'
        ```
      HEREDOC

      expect do
        described_class.new.call(input)
      end.to raise_error('Source or tabs must be present in this tabbed_example config')
    end
  end

  it 'when content is not a tab filter, nothing happens' do
    input = 'test content is ignored'
    actual = described_class.new.call(input)
    expect(actual).to eq(input)
  end

  context 'when input is a directory' do
    it 'raises an exception if tabbed parameter is not set to true' do
      expect(File).to receive(:directory?).with('/path/to/a/directory').and_return(true)
      expect(File).to receive(:read).with('/path/to/a/directory/.config.yml').and_return(config_tabbed_false)
      input = <<~HEREDOC
        ```tabbed_folder
        source: /path/to/a/directory
        ```
      HEREDOC
      expect do
        described_class.new.call(input)
      end.to raise_error('Tabbed must be set to true in the folder config YAML file')
    end

    it 'raises an exception if source path is not a directory' do
      expect(File).to receive(:directory?).with('/path/to/a/directory').and_return(false)
      input = <<~HEREDOC
        ```tabbed_folder
        source: /path/to/a/directory
        ```
      HEREDOC
      expect do
        described_class.new.call(input)
      end.to raise_error('/path/to/a/directory is not a directory')
    end

    it 'raises an error if there are no files in input directory' do
      expect(File).to receive(:directory?).with('/path/to/a/directory').and_return(true)
      expect(File).to receive(:read).with('/path/to/a/directory/.config.yml').and_return(config_tabbed_true)

      input = <<~HEREDOC
        ```tabbed_folder
        source: /path/to/a/directory
        ```
      HEREDOC
      expect do
        described_class.new.call(input)
      end.to raise_error('Empty content_from_source file list in /path/to/a/directory/*.md')
    end

    it 'does something with one markdown file in input' do
      expect(File).to receive(:directory?).with('/path/to/a/directory').and_return(true)
      expect(File).to receive(:read).with('/path/to/a/directory/.config.yml').and_return(config_tabbed_true)
      expect(Dir).to receive(:glob).with('/path/to/a/directory/*.md').and_return([first_sample_markdown])
      expect(Dir).to receive(:empty?).with('/path/to/a/directory/*.md').and_return(false)
      
      input = <<~HEREDOC
      ```tabbed_folder
      source: /path/to/a/directory
      ```
      HEREDOC

      puts described_class.new.call(input)
    end
  end

  def config_tabbed_false
    <<~HEREDOC
      ---
      tabbed: false
    HEREDOC
  end

  def config_tabbed_true
    <<~HEREDOC
      ---
      tabbed: true
    HEREDOC
  end

  def first_sample_markdown
    <<~HEREDOC
    ---
    title: First Sample Markdown
    language: javascript
    ---

    ## Heading

    Sample content
    HEREDOC
  end

  def second_sample_markdown
    <<~HEREDOC
    ---
    title: Second Sample Markdown
    language: javascript
    ---

    ## Heading

    Sample content
    HEREDOC
  end

  def third_sample_markdown
    <<~HEREDOC
    ---
    title: Third Sample Markdown
    language: javascript
    ---

    ## Heading

    Sample content
    HEREDOC
  end
end
