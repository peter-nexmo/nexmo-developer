require 'rails_helper'

RSpec.describe Redirector do
  it 'returns a redirected path' do
    request = OpenStruct.new(path: '/sms')
    expect(Redirector.find(request)).to eq('/messaging/sms/overview')
  end

  context 'when a URL is provided in the environment' do
    before do
      allow(ENV).to receive(:[]).with('ENVIRONMENT_REDIRECTS').and_return(<<~HEREDOC
        '^\/foo\/bar\.*?': 'https://google.com'
      HEREDOC
                                                                         )

      stub_const('ENVIRONMENT_REDIRECTS', YAML.safe_load(ENV['ENVIRONMENT_REDIRECTS'] || ''))
    end

    it 'returns a redirected path' do
      request = OpenStruct.new(path: '/foo/bar')
      expect(Redirector.find(request)).to eq('https://google.com')

      request = OpenStruct.new(path: '/baz/foo/bar')
      expect(Redirector.find(request)).to eq(false)
    end
  end
end
